'''
Contains business logic for the application
'''

from typing import Optional
from datetime import datetime, timezone
from fastapi import FastAPI, Depends, HTTPException, Query, Request
from sqlalchemy.orm import Session
from sqlalchemy import text
import bcrypt
import uvicorn
import models
import database

models.Base.metadata.create_all(bind=database.engine)

app = FastAPI()
def get_db():
    '''
    Gets the database session
    '''
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()


def check_password(stored_password_hash: str, provided_password: str) -> bool:
    '''
    Checks if the provided password matches the stored password hash 
    '''
    return bcrypt.checkpw(provided_password.encode('utf-8'), stored_password_hash.encode('utf-8'))



@app.post("/measurements/")
async def create_measurement(measurement: dict, request: Request, db: Session = Depends(get_db)):
    '''
    Creates a new measurement record in the database
    '''
    body = await request.json()  # Obtener datos del cuerpo de la solicitud
    # Obtener los valores específicos del cuerpo de la solicitud
    glucose = body.get("Glucose")
    insulin = body.get("Insulin")
    carbohidrates = body.get("Carbohidrates")
    measureDate = body.get("MeasureDate")
    idPatient = body.get("IdPatient")
    # Validación: al menos uno de los campos debe estar presente
    if not glucose and not insulin and not carbohidrates:
        raise HTTPException(status_code=400,
                            detail="Debe completar al menos uno de los campos de medición")
    measureDate = datetime.fromisoformat(measurement['MeasureDate'].replace("Z", "+00:00"))
    if not glucose:
        glucose=0
    if not insulin:
        insulin=0
    if not carbohidrates:
        carbohidrates=0
    # Crear nueva medición
    db_measurement = models.DbPatientMeasure(
        MeasureDate=measureDate,
        Glucose=glucose,
        Insulin=insulin,
        Carbohidrates=carbohidrates,
        IdPatient=idPatient
    )
    # Guardar en la base de datos
    db.add(db_measurement)
    db.commit()
    db.refresh(db_measurement)
    return db_measurement

@app.delete("/delete_measurement/{idPatientMeasurement}/", status_code=200)
def delete_measurement(idPatientMeasurement: int, db: Session = Depends(get_db)):
    '''
    Logically eliminates a measurement record from the database
    '''
    # Buscar la medición en la base de datos
    patientMeasurement = db.query(models.DbPatientMeasure).filter(models.DbPatientMeasure.IdPatientMeasure == idPatientMeasurement).first()
    if not patientMeasurement:
        raise HTTPException(status_code=404, detail="Medición no encontrada")
    # Actualizar el campo 'Active' a 0 (borrado lógico)
    patientMeasurement.Active = 0
    db.commit()
    return {"mensaje": f"Medición {idPatientMeasurement} desactivada correctamente"}

# @app.post("/signIn/")
# async def login(Email: str = Form(), db: Session = Depends(get_db)):
#     '''
#     Logs in a user
#     '''
#     db_user = db.query(models.DbUser).filter(models.DbUser.Email == Email and models.DbUser.Active == 1).first()
#     if db_user.Role == 'medico':
#         medico = db.query(models.Medico).filter(models.Medico.idUser == db_user.id).first()
#         if not medico:
#             raise HTTPException(status_code=404, detail="Medico not found")
#         return {"token": "your_jwt_token", "Role": db_user.Role, "medico_id": medico.id}
#     return {"token": "your_jwt_token", "Role": db_user.Role}

@app.get("/user_role/")
async def get_user_role(
    email: str = Query(None),  # Email ahora es opcional
    idUser: int = Query(None),  # IdUser también es opcional
    db: Session = Depends(get_db)):
    '''
    Gets User Role by Email or IdUser
    '''
    user_query_patient = db.query(models.DbUser)
    if email:
        user = db.query(models.DbUser).filter(models.DbUser.Email == email and models.DbUser.Active == 1).first()
    elif idUser:
        user = user_query_patient.filter(models.DbUser.IdUser == idUser and models.DbUser.Active == 1).first()
    else:
        raise HTTPException(status_code=400, detail="Debe proporcionar Email o IdUser")
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    Role = {"IdUser": user.IdUser, "Role": user.Role.Description}
    return Role

@app.get("/patients_list/{idDoctor}/")
async def get_patients_list_by_doctor(idDoctor: int, search_query: str = "", db: Session = Depends(get_db)):
    '''
    Gets a list of patients for a given doctor
    '''
    stmt = text('CALL `diabecheckv2`.`GetPatientsByDoctor`('+str(idDoctor)+')')
    result = db.execute(stmt)
    patients = result.fetchall()
    if not patients:
        raise HTTPException(status_code=404, detail="No patients found for this medico")
    result_list = [dict(row._mapping) for row in patients]
    if search_query:
        result_list = [patient for patient in result_list if search_query.lower() in patient['LastName'].lower()
                       or search_query.lower() in str(patient['DocumentNumber'])]
    return result_list

# Endpoint para obtener detalles de un paciente por ID
@app.get("/patient_details/{idPatient}/")
async def get_patients_list(idPatient: int, db: Session = Depends(get_db)):
    '''
    Gets a patient's details by ID
    '''
    try:
        # Llamar al procedure almacenado en la base de datos
        stmt = text('CALL GetPatientDetails(:idPatient)')
        result = db.execute(stmt, {"idPatient": idPatient})
        patient_details = result.fetchone()
        # Verificar si se encontraron datos
        if not patient_details:
            raise HTTPException(status_code=404, detail="Paciente no encontrado")
        # Convertir los resultados en un diccionario
        patient_dict = dict(patient_details._mapping)
        return patient_dict
    except Exception as e:
        raise HTTPException(status_code=500,
                            detail=f'Error al obtener los detalles del paciente: {str(e)}') from e

@app.get("/patient_measurements/{idPatient}/")
async def get_patient_measurements(idPatient: int, month: int, year: int, db: Session = Depends(get_db)):
    '''
    Gets a patient's measurements for a given month and year
    '''
    stmt = text('SELECT * FROM patientmeasure WHERE MONTH(MeasureDate) = :month AND YEAR(MeasureDate) = :year AND IdPatient = :idPatient AND Active = 1 ORDER BY MeasureDate ASC')
    #Cambiar el query para que llame al procedure almacenado
    result = db.execute(stmt, {'month': month, 'year': year, 'idPatient': idPatient})
    measurements = result.fetchall()
    return [dict(row._mapping) for row in measurements]

@app.get("/doctor_list/{idPatient}/")
async def get_doctor_by_id_patient(IdPatient: int, db: Session = Depends(get_db)):
    '''
    Gets a list of doctors for a given patient
    '''
    stmt = text('CALL `diabecheckv2`.`GetDoctors`('+str(IdPatient)+')')
    result = db.execute(stmt)
    doctors = result.fetchall()
    result_list = [dict(row._mapping) for row in doctors]
    return result_list

@app.post("/doctor_connection_request/")
async def create_connection_request(request: models.DoctorConnectionRequest, db: Session = Depends(get_db)):
    '''
    Creates a new connection request between a patient and a doctor
    '''
    DoctorLicense = request.DoctorLicense
    IdPatient = request.IdPatient
    # Buscar al médico por su matrícula
    stmt = text('CALL GetDoctorByDoctorLicense(:DoctorLicense)')
    result = db.execute(stmt, {"DoctorLicense": DoctorLicense})
    doctor = result.fetchone()
    result_list = dict(doctor._mapping)
    if not doctor:
        raise HTTPException(status_code=404, detail="Médico no encontrado")
    # Verificar si ya existe una solicitud o conexión
    existent_connection = db.query(models.DbDoctorPatientConnection).filter(
        models.DbDoctorPatientConnection.IdDoctor == result_list.get('IdUser'),
        models.DbDoctorPatientConnection.IdPatient == IdPatient,
        models.DbDoctorPatientConnection.Status.in_(["aceptada", "pendiente"]),
        models.DbDoctorPatientConnection.Active == 1
    ).first()
    if existent_connection:
        raise HTTPException(status_code=404,
                            detail="Ya existe una solicitud o conexión con este médico")
    # Crear la solicitud pendiente
    new_connection = models.DbDoctorPatientConnection(
        IdDoctor=result_list.get('IdUser'),
        IdPatient=IdPatient,
        Status="pendiente"
    )
    db.add(new_connection)
    db.commit()
    db.refresh(new_connection)
    return new_connection

#obtener las solicitudes de un medico
@app.get("/doctor_connection_requests/{idDoctor}/")
async def get_requests(idDoctor: int, db: Session = Depends(get_db)):
    '''
    Gets a list of connection requests for a given doctor
    '''
    stmt = text('CALL `diabecheckv2`.`GetConnectionRequestsByDoctor`(:idDoctor)')
    result = db.execute(stmt, {"idDoctor": idDoctor})
    requests = result.fetchall()
    result_list = [dict(row._mapping) for row in requests]
    return result_list

@app.post("/accept_doctor_connection_request/{idDoctorPatientConnection}/")
async def accept_request(idDoctorPatientConnection: int, db: Session = Depends(get_db)):
    '''
    Accepts a connection request
    '''
    connenction = db.query(models.DbDoctorPatientConnection).filter(models.DbDoctorPatientConnection.IdDoctorPatientConnection == idDoctorPatientConnection and models.DbDoctorPatientConnection.Active == 1).first()
    if not connenction:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    if connenction.Status != "pendiente":
        raise HTTPException(status_code=400, detail="La solicitud ya fue procesada")
    connenction.Status = "aceptada"
    db.commit()
    return {"msg": "Solicitud aceptada exitosamente"}

@app.post("/reject_doctor_connection_request/{idDoctorPatientConnection}/")
async def reject_connection(idDoctorPatientConnection: int, db: Session = Depends(get_db)):
    '''
    Rejects a connection request
    '''
    request = db.query(models.DbDoctorPatientConnection).filter(models.DbDoctorPatientConnection.IdDoctorPatientConnection == idDoctorPatientConnection and models.DbDoctorPatientConnection.Active == 1).first()
    if not request:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    if request.Status != "pendiente":
        raise HTTPException(status_code=400, detail="La solicitud ya fue procesada")
    # Actualizar Status a "rechazada"
    request.Status = "rechazada"
    db.commit()
    return {"msg": "Solicitud rechazada exitosamente"}

@app.delete("/doctor_connection_requests/{idDoctorPatientConnection}/", status_code=200)
def delete_connection(idDoctorPatientConnection: int, db: Session = Depends(get_db)):
    '''
    Eliminates a connection
    '''
    # Buscar la solicitud en la base de datos
    request = db.query(models.DbDoctorPatientConnection).filter(models.DbDoctorPatientConnection.IdDoctorPatientConnection == idDoctorPatientConnection).first()
    if not request:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    # Actualizar el campo 'Active' a 0 (borrado lógico)
    request.Active = 0
    db.commit()
    return {"mensaje": f"Solicitud {idDoctorPatientConnection} desactivada correctamente"}

@app.get("/search_doctor/{DoctorLicense}/")
async def get_doctor_by_license(DoctorLicense: int, db: Session = Depends(get_db)):
    '''
    Gets doctor by a DoctorLicense
    '''
    stmt = text('CALL GetDoctorByDoctorLicense(:DoctorLicense)')
    result = db.execute(stmt, {"DoctorLicense": DoctorLicense})
    doctors = result.fetchall()
    if not doctors:
        raise HTTPException(status_code=404, detail="No medico found for this patient")
    result_list = [dict(row._mapping) for row in doctors]
    return result_list

@app.get("/patient_files/{idPatient}/")
async def get_patient_files(idPatient: int, db: Session = Depends(get_db)):
    '''
    Gets files for a given patient
    '''
    stmt = text('CALL `diabecheckv2`.`GetPatientFiles`('+str(idPatient)+')')
    result = db.execute(stmt)
    files = result.fetchall()
    result_list = [dict(row._mapping) for row in files]
    return result_list


@app.post("/files/")
async def create_file(file: models.FileBase, db: Session = Depends(get_db)):
    '''
    Uploads a new file to the database
    '''
    new_file = models.DbFile(
        IdPatient=file.IdPatient,
        Name=file.Name,
        FilePath=file.FilePath,
        PublishDate=file.PublishDate,
        IdUser=file.IdUser,
        FileType=file.IdFileType
    )
    db.add(new_file)
    db.commit()
    db.refresh(new_file)
    return {"message": "Archivo registrado exitosamente", "file": new_file}

@app.get("/fileTypes/")
async def get_file_types(db: Session = Depends(get_db)):
    '''
    Gets a list of available file types
    '''
    stmt = text('SELECT * FROM FileType WHERE Active =1')
    result = db.execute(stmt)
    types = result.fetchall()
    return [dict(row._mapping) for row in types]

# Endpoint para filtrado de archivos
@app.get("/patient_files/{idPatient}/")
async def get_patient_files(idPatient: int, fileType: Optional[int] = Query(None), sort_date: Optional[str] = Query(None), db: Session = Depends(get_db)):
    '''
    Gets a list of files for a given patient, optionally filtered by file type
    '''
    if fileType != 0:
        stmt = text(
            'SELECT * FROM archivos WHERE IdPatient = :idPatient AND FileType = :fileType AND Active = 1'
        )
        params = {'fileType': fileType, 'idPatient': idPatient}
    else:
        stmt = text(
            'SELECT * FROM archivos WHERE IdPatient = :idPatient AND Active = 1'
        )
        params = {'idPatient': idPatient}
    #Cambiar el query para que llame al procedure almacenado
    if sort_date == 'asc':
        stmt = text(str(stmt) + ' ORDER BY PublishDate ASC')
    elif sort_date == 'desc':
        stmt = text(str(stmt) + ' ORDER BY PublishDate DESC')
    result = db.execute(stmt, params)
    files = result.fetchall()
    result_list = [dict(row._mapping) for row in files]
    return result_list

# Endpoint para descarga de archivos
@app.get("/file/{idFile}/")
async def get_file(idFile: int, db: Session = Depends(get_db)):
    '''
    Gets details for a specific file
    '''
    stmt = text('SELECT * FROM File WHERE IdFile = :idFile AND Active = 1')
    result = db.execute(stmt, {'idFile': idFile})
    file = result.fetchone()
    if not file:
        raise HTTPException(status_code=404, detail="Archivo no encontrado")
    return dict(file._mapping)

@app.post("/delete_file/{idFile}/")
async def delete_file(idFile: int, db: Session = Depends(get_db)):
    '''
    Deletes a file from DB
    '''
    file = db.query(models.DbFile).filter(models.DbFile.IdArchivo == idFile and models.DbFile.Active==1).first()
    if not file:
        raise HTTPException(status_code=404, detail="Archivo no encontrada")
    if file.Active != 1:
        raise HTTPException(status_code=400, detail="El archivo ya fue eliminado")
    # Actualizar Status a "rechazada"
    file.Active = 0
    db.commit()
    return {"msg": "Archivo borrado exitosamente"}

@app.get("/api/time")
async def get_server_time():
    '''
    Gets server time
    '''
    # Obtén la fecha y hora actual con zona horaria UTC
    server_time = datetime.now(timezone.utc).isoformat()
    return {"serverTime": server_time}

def activate(self, db: Session = Depends(get_db)):
    '''
    Activate the server
    '''
    self.Roles = db.query(models.DbRole)
    
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
    activate(get_db())
