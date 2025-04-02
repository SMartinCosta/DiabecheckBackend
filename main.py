'''
Contains business logic for the application
'''

from typing import Optional
from datetime import datetime, timedelta, timezone
from fastapi import FastAPI, Depends, HTTPException, Query, Request
from sqlalchemy.orm import Session
from sqlalchemy import text
import bcrypt
import uvicorn
import models
import database
import stored_procedures as sp  # Import stored procedure names
import endpoints as ep  # Import endpoint paths

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


@app.post(ep.CREATE_MEASUREMENT)
async def create_measurement(measurement: dict, request: Request, db: Session = Depends(get_db)):
    '''
    Creates a new measurement record in the database
    '''
    body = await request.json()
    glucose = body.get("Glucose")
    insulin = body.get("Insulin")
    carbohidrates = body.get("Carbohidrates")
    measureDate = body.get("MeasurementDate")
    idPatient = body.get("IdPatient")

    if not glucose and not insulin and not carbohidrates:
        raise HTTPException(status_code=400, detail="Debe completar al menos uno de los campos de medición")
    measureDate = datetime.fromisoformat(measurement['MeasurementDate'].replace("Z", "+00:00"))
    glucose = glucose or 0
    insulin = insulin or 0
    carbohidrates = carbohidrates or 0

    db_measurement = models.DbPatientMeasure(
        MeasureDate=measureDate,
        Glucose=glucose,
        Insulin=insulin,
        Carbohidrates=carbohidrates,
        IdPatient=idPatient
    )
    db.add(db_measurement)
    db.commit()
    db.refresh(db_measurement)
    return db_measurement


@app.delete(ep.DELETE_MEASUREMENT, status_code=200)
def delete_measurement(idPatientMeasurement: int, db: Session = Depends(get_db)):
    '''
    Logically eliminates a measurement record from the database
    '''
    patientMeasurement = db.query(models.DbPatientMeasure).filter(models.DbPatientMeasure.IdPatientMeasure == idPatientMeasurement).first()
    if not patientMeasurement:
        raise HTTPException(status_code=404, detail="Medición no encontrada")
    patientMeasurement.Active = 0
    db.commit()
    return {"mensaje": f"Medición {idPatientMeasurement} desactivada correctamente"}


@app.get(ep.USER_ROLE)
async def get_user_role(
    email: str = Query(None),
    idUser: int = Query(None),
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


@app.get(ep.PATIENTS_LIST)
async def get_patients_list_by_doctor(idDoctor: int, search_query: str = "", db: Session = Depends(get_db)):
    '''
    Gets a list of patients for a given doctor
    '''
    stmt = text(f'CALL `{sp.GET_PATIENTS_BY_DOCTOR}`(:idDoctor)')
    result = db.execute(stmt, {"idDoctor": idDoctor})
    patients = result.fetchall()
    if not patients:
        raise HTTPException(status_code=404, detail="No patients found for this medico")
    result_list = [dict(row._mapping) for row in patients]
    if search_query:
        result_list = [patient for patient in result_list if search_query.lower() in patient['LastName'].lower()
                       or search_query.lower() in str(patient['DocumentNumber'])]
    return result_list


@app.get(ep.PATIENT_DETAILS)
async def get_patient_details(idPatient: int, db: Session = Depends(get_db)):
    '''
    Gets a patient's details by ID
    '''
    try:
        stmt = text(f'CALL {sp.GET_PATIENT_DETAILS}(:idPatient)')
        result = db.execute(stmt, {"idPatient": idPatient})
        patient_details = result.fetchone()
        if not patient_details:
            raise HTTPException(status_code=404, detail="Paciente no encontrado")
        return dict(patient_details._mapping)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f'Error al obtener los detalles del paciente: {str(e)}') from e


@app.get(ep.PATIENT_MEASUREMENTS)
async def get_patient_measurements(idPatient: int, month: int, year: int, db: Session = Depends(get_db)):
    '''
    Gets a patient's measurements for a given month and year
    '''
    stmt = text(sp.SELECT_PATIENT_MEASUREMENTS)
    result = db.execute(stmt, {'month': month, 'year': year, 'idPatient': idPatient})
    measurements = result.fetchall()
    return [dict(row._mapping) for row in measurements]


@app.get(ep.DOCTOR_LIST)
async def get_doctor_by_id_patient(idPatient: int, db: Session = Depends(get_db)):
    '''
    Gets a list of doctors for a given patient
    '''
    stmt = text(f'CALL {sp.GET_DOCTORS}(:idPatient)')
    result = db.execute(stmt, {"idPatient": idPatient})
    doctors = result.fetchall()
    return [dict(row._mapping) for row in doctors]


@app.post(ep.DOCTOR_CONNECTION_REQUEST)
async def create_connection_request(request: models.DoctorConnectionRequest, db: Session = Depends(get_db)):
    '''
    Creates a new connection request between a patient and a doctor
    '''
    DoctorLicense = request.DoctorLicense
    IdPatient = request.IdPatient
    stmt = text('CALL GetDoctorByDoctorLicense(:DoctorLicense)')
    result = db.execute(stmt, {"DoctorLicense": DoctorLicense})
    doctor = result.fetchone()
    if not doctor:
        raise HTTPException(status_code=404, detail="Médico no encontrado")
    result_list = dict(doctor._mapping)
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


@app.get(ep.DOCTOR_CONNECTION_REQUESTS)
async def get_requests(idDoctor: int, db: Session = Depends(get_db)):
    '''
    Gets a list of connection requests for a given doctor
    '''
    stmt = text(f'CALL {sp.GET_CONNECTION_REQUESTS_BY_DOCTOR}(:idDoctor)')
    result = db.execute(stmt, {"idDoctor": idDoctor})
    requests = result.fetchall()
    result_list = [dict(row._mapping) for row in requests]
    return result_list


@app.post(ep.ACCEPT_DOCTOR_CONNECTION_REQUEST)
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


@app.post(ep.REJECT_DOCTOR_CONNECTION_REQUEST)
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


@app.delete(ep.DELETE_DOCTOR_CONNECTION_REQUEST, status_code=200)
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


@app.get(ep.SEARCH_DOCTOR)
async def get_doctor_by_license(DoctorLicense: int, db: Session = Depends(get_db)):
    '''
    Gets doctor by a DoctorLicense
    '''
    stmt = text(f'CALL {sp.GET_DOCTOR_BY_LICENSE}(:DoctorLicense)')
    result = db.execute(stmt, {"DoctorLicense": DoctorLicense})
    doctors = result.fetchall()
    if not doctors:
        raise HTTPException(status_code=404, detail="No medico found for this patient")
    result_list = [dict(row._mapping) for row in doctors]
    return result_list


@app.get(ep.PATIENT_FILES)
async def get_patient_files(idPatient: int, db: Session = Depends(get_db)):
    '''
    Gets files for a given patient
    '''
    stmt = text(f'CALL {sp.GET_PATIENT_FILES}(:idPatient)')
    result = db.execute(stmt, {"idPatient": idPatient})
    files = result.fetchall()
    result_list = [dict(row._mapping) for row in files]
    return result_list


@app.post(ep.CREATE_FILE)
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


@app.get(ep.FILE_TYPES)
async def get_file_types(db: Session = Depends(get_db)):
    '''
    Gets a list of available file types
    '''
    stmt = text(sp.SELECT_FILE_TYPES)
    result = db.execute(stmt)
    types = result.fetchall()
    return [dict(row._mapping) for row in types]


@app.get(ep.GET_FILE)
async def get_file(idFile: int, db: Session = Depends(get_db)):
    '''
    Gets details for a specific file
    '''
    stmt = text(sp.SELECT_FILE_BY_ID)
    result = db.execute(stmt, {'idFile': idFile})
    file = result.fetchone()
    if not file:
        raise HTTPException(status_code=404, detail="Archivo no encontrado")
    return dict(file._mapping)


@app.post(ep.DELETE_FILE)
async def delete_file(idFile: int, db: Session = Depends(get_db)):
    '''
    Deletes a file from DB
    '''
    stmt = text(sp.DELETE_FILE_LOGICAL)
    result = db.execute(stmt, {'idFile': idFile})
    db.commit()
    return {"msg": "Archivo borrado exitosamente"}


@app.get(ep.SERVER_TIME)
async def get_server_time():
    '''
    Gets server time
    '''
    # Obtén la fecha y hora actual con zona horaria UTC
    server_time = datetime.now(timezone(timedelta(hours=-3))).isoformat()
    return {"serverTime": server_time}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
