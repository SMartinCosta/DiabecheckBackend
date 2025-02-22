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



@app.post("/mediciones/")
async def create_medicion(medicion: dict, request: Request, db: Session = Depends(get_db)):
    '''
    Creates a new measurement record in the database
    '''
    body = await request.json()  # Obtener datos del cuerpo de la solicitud
    # Obtener los valores específicos del cuerpo de la solicitud
    glucosa = body.get("Glucosa")
    insulina = body.get("Insulina")
    carbohidratos = body.get("Carbohidratos")
    fecha = body.get("Fecha")
    id_paciente = body.get("IdPatient")
    # Validación: al menos uno de los campos debe estar presente
    if not glucosa and not insulina and not carbohidratos:
        raise HTTPException(status_code=400,
                            detail="Debe completar al menos uno de los campos de medición")
    fecha = datetime.fromisoformat(medicion['Fecha'].replace("Z", "+00:00"))
    if not glucosa:
        glucosa=0
    if not insulina:
        insulina=0
    if not carbohidratos:
        carbohidratos=0
    # Crear nueva medición
    db_medicion = models.Mediciones(
        Fecha=fecha,
        Glucosa=glucosa,
        Insulina=insulina,
        Carbohidratos=carbohidratos,
        IdPatient=id_paciente
    )
    # Guardar en la base de datos
    db.add(db_medicion)
    db.commit()
    db.refresh(db_medicion)
    return db_medicion

@app.delete("/mediciones/{medicion_id}/", status_code=200)
def desactivar_medicion(medicion_id: int, db: Session = Depends(get_db)):
    '''
    Logically eliminates a measurement record from the database
    '''
    # Buscar la medición en la base de datos
    medicion = db.query(models.Mediciones).filter(models.Mediciones.IdPatientMeasure == medicion_id).first()
    if not medicion:
        raise HTTPException(status_code=404, detail="Medición no encontrada")
    # Actualizar el campo 'Active' a 0 (borrado lógico)
    medicion.Active = 0
    db.commit()
    return {"mensaje": f"Medición {medicion_id} desactivada correctamente"}

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
async def get_user_Role(
    Email: str = Query(None),  # Email ahora es opcional
    user_id: int = Query(None),  # IdUser también es opcional
    db: Session = Depends(get_db)):
    '''
    Gets User Role by Email or IdUser
    '''
    user_query_patient = db.query(models.DbUser)
    if Email:
        user = db.query(models.DbUser).filter(models.DbUser.Email == Email and models.DbUser.Active == 1).first()
    elif user_id:
        user = user_query_patient.filter(models.DbUser.IdUser == user_id and models.DbUser.Active == 1).first()
    else:
        raise HTTPException(status_code=400, detail="Debe proporcionar Email o IdUser")
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    Role = {"IdUser": user.IdUser, "Role": user.Role.Description}
    return Role

@app.get("/listado_pacientes/{medico_id}/")
async def get_patients_for_medico(medico_id: int, search_query: str = "", db: Session = Depends(get_db)):
    '''
    Gets a list of patients for a given doctor
    '''
    stmt = text('CALL `diabecheckv2`.`GetPatientsByDoctor`('+str(medico_id)+')')
    result = db.execute(stmt)
    pacientes = result.fetchall()
    if not pacientes:
        raise HTTPException(status_code=404, detail="No patients found for this medico")
    result_list = [dict(row._mapping) for row in pacientes]
    if search_query:
        result_list = [paciente for paciente in result_list if search_query.lower() in paciente['LastName'].lower()
                       or search_query.lower() in str(paciente['DocumentNumber'])]
    return result_list

# Endpoint para obtener detalles de un paciente por ID
@app.get("/detalles_pacientes/{IdPatient}/")
async def get_paciente_details(IdPatient: int, db: Session = Depends(get_db)):
    '''
    Gets a patient's details by ID
    '''
    try:
        # Llamar al procedure almacenado en la base de datos
        stmt = text('CALL GetPatientDetails(:idPatient)')
        result = db.execute(stmt, {"idPatient": IdPatient})
        paciente_details = result.fetchone()
        # Verificar si se encontraron datos
        if not paciente_details:
            raise HTTPException(status_code=404, detail="Paciente no encontrado")
        # Convertir los resultados en un diccionario
        paciente_dict = dict(paciente_details._mapping)
        return paciente_dict
    except Exception as e:
        raise HTTPException(status_code=500,
                            detail=f'Error al obtener los detalles del paciente: {str(e)}') from e

@app.get("/pacientes/{patient_id}/mediciones")
async def get_mediciones(patient_id: int, month: int, year: int, db: Session = Depends(get_db)):
    '''
    Gets a patient's measurements for a given month and year
    '''
    stmt = text('SELECT * FROM mediciones WHERE MONTH(Fecha) = :month AND YEAR(Fecha) = :year AND IdPatient = :patient_id AND Active = 1 ORDER BY Fecha ASC')
    #Cambiar el query para que llame al procedure almacenado
    result = db.execute(stmt, {'month': month, 'year': year, 'patient_id': patient_id})
    mediciones = result.fetchall()
    return [dict(row._mapping) for row in mediciones]

@app.get("/listado_medicos/{IdPatient}/")
async def get_doctor_by_patient_id(IdPatient: int, db: Session = Depends(get_db)):
    '''
    Gets a list of doctors for a given patient
    '''
    stmt = text('CALL `diabecheckv2`.`GetMedicos`('+str(IdPatient)+')')
    result = db.execute(stmt)
    medicos = result.fetchall()
    result_list = [dict(row._mapping) for row in medicos]
    return result_list

@app.post("/solicitud-medico/")
async def crear_solicitud_medico(solicitud: models.DoctorConnectionRequest, db: Session = Depends(get_db)):
    '''
    Creates a new connection request between a patient and a doctor
    '''
    DoctorLicense = solicitud.DoctorLicense
    IdPatient = solicitud.IdPatient
    # Buscar al médico por su matrícula
    stmt = text('CALL GetMedicoByDoctorLicense(:DoctorLicense)')
    result = db.execute(stmt, {"DoctorLicense": DoctorLicense})
    medico = result.fetchone()
    result_list = dict(medico._mapping)
    if not medico:
        raise HTTPException(status_code=404, detail="Médico no encontrado")
    # Verificar si ya existe una solicitud o conexión
    conexion_existente = db.query(models.Conexiones).filter(
        models.Conexiones.IdDoctor == result_list.get('IdUser'),
        models.Conexiones.IdPatient == IdPatient,
        models.Conexiones.Status.in_(["aceptada", "pendiente"]),
        models.Conexiones.Active == 1
    ).first()
    if conexion_existente:
        raise HTTPException(status_code=404,
                            detail="Ya existe una solicitud o conexión con este médico")
    # Crear la solicitud pendiente
    nueva_conexion = models.Conexiones(
        IdDoctor=result_list.get('IdUser'),
        IdPatient=IdPatient,
        Status="pendiente"
    )
    db.add(nueva_conexion)
    db.commit()
    db.refresh(nueva_conexion)
    return nueva_conexion

#obtener las solicitudes de un medico
@app.get("/medico/solicitudes/{medico_id}/")
async def get_solicitudes(medico_id: int, db: Session = Depends(get_db)):
    '''
    Gets a list of connection requests for a given doctor
    '''
    stmt = text('CALL `diabecheckv2`.`GetSolicitudesByMedico`(:medico_id)')
    result = db.execute(stmt, {"medico_id": medico_id})
    solicitudes = result.fetchall()
    result_list = [dict(row._mapping) for row in solicitudes]
    return result_list

@app.post("/medico/solicitudes/aceptar/{id_solicitud}/")
async def aceptar_solicitud(id_solicitud: int, db: Session = Depends(get_db)):
    '''
    Accepts a connection request
    '''
    solicitud = db.query(models.Conexiones).filter(models.Conexiones.IdDoctorPatientConnection == id_solicitud and models.Conexiones == 1).first()
    if not solicitud:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    if solicitud.Status != "pendiente":
        raise HTTPException(status_code=400, detail="La solicitud ya fue procesada")
    solicitud.Status = "aceptada"
    db.commit()
    return {"msg": "Solicitud aceptada exitosamente"}

@app.post("/medico/solicitudes/rechazar/{id_solicitud}/")
async def rechazar_solicitud(id_solicitud: int, db: Session = Depends(get_db)):
    '''
    Rejects a connection request
    '''
    solicitud = db.query(models.Conexiones).filter(models.Conexiones.IdDoctorPatientConnection == id_solicitud and models.Conexiones.Active == 1).first()
    if not solicitud:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    if solicitud.Status != "pendiente":
        raise HTTPException(status_code=400, detail="La solicitud ya fue procesada")
    # Actualizar Status a "rechazada"
    solicitud.Status = "rechazada"
    db.commit()
    return {"msg": "Solicitud rechazada exitosamente"}

@app.delete("/solicitudes/{solicitud_id}/", status_code=200)
def desactivar_conexion(solicitud_id: int, db: Session = Depends(get_db)):
    '''
    Eliminates a connection
    '''
    # Buscar la solicitud en la base de datos
    solicitud = db.query(models.Conexiones).filter(models.Conexiones.IdDoctorPatientConnection == solicitud_id).first()
    if not solicitud:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    # Actualizar el campo 'Active' a 0 (borrado lógico)
    solicitud.Active = 0
    db.commit()
    return {"mensaje": f"Solicitud {solicitud_id} desactivada correctamente"}

@app.get("/buscar_medico/{DoctorLicense}/")
async def get_doctor_by_license(DoctorLicense: int, db: Session = Depends(get_db)):
    '''
    Gets doctor by a DoctorLicense
    '''
    stmt = text('CALL GetMedicoByDoctorLicense(:DoctorLicense)')
    result = db.execute(stmt, {"DoctorLicense": DoctorLicense})
    medicos = result.fetchall()
    if not medicos:
        raise HTTPException(status_code=404, detail="No medico found for this patient")
    result_list = [dict(row._mapping) for row in medicos]
    return result_list

@app.get("/pacientes/{IdPatient}/archivos")
async def get_archivos_paciente(id_paciente: int, db: Session = Depends(get_db)):
    '''
    Gets files for a given patient
    '''
    stmt = text('CALL `diabecheckv2`.`GetArchivosPaciente`('+str(id_paciente)+')')
    result = db.execute(stmt)
    archivos = result.fetchall()
    result_list = [dict(row._mapping) for row in archivos]
    return result_list


@app.post("/archivos/")
async def create_archivo(archivo: models.FileBase, db: Session = Depends(get_db)):
    '''
    Uploads a new file to the database
    '''
    nuevo_archivo = models.Archivos(
        IdPatient=archivo.id_paciente,
        Name=archivo.Name,
        FilePath=archivo.ruta_archivo,
        PublishDate=archivo.fecha_publicacion,
        IdUser=archivo.id_usuario,
        FileType=archivo.id_FileType
    )
    db.add(nuevo_archivo)
    db.commit()
    db.refresh(nuevo_archivo)
    return {"message": "Archivo registrado exitosamente", "archivo": nuevo_archivo}

@app.get("/FileType")
async def get_tiposarchivo(db: Session = Depends(get_db)):
    '''
    Gets a list of available file types
    '''
    stmt = text('SELECT * FROM FileType WHERE Active =1')
    result = db.execute(stmt)
    tipos = result.fetchall()
    return [dict(row._mapping) for row in tipos]

# Endpoint para filtrado de archivos
@app.get("/archivos/{IdPatient}")
async def get_archivos_bytipo(id_paciente: int, tipo: Optional[int] = Query(None), sort_date: Optional[str] = Query(None), db: Session = Depends(get_db)):
    '''
    Gets a list of files for a given patient, optionally filtered by file type
    '''
    if tipo != 0:
        stmt = text(
            'SELECT * FROM archivos WHERE IdPatient = :patient_id AND FileType = :tipo AND Active = 1'
        )
        params = {'tipo': tipo, 'patient_id': id_paciente}
    else:
        stmt = text(
            'SELECT * FROM archivos WHERE IdPatient = :patient_id AND Active = 1'
        )
        params = {'patient_id': id_paciente}
    #Cambiar el query para que llame al procedure almacenado
    if sort_date == 'asc':
        stmt = text(str(stmt) + ' ORDER BY PublishDate ASC')
    elif sort_date == 'desc':
        stmt = text(str(stmt) + ' ORDER BY PublishDate DESC')
    result = db.execute(stmt, params)
    archivos = result.fetchall()
    result_list = [dict(row._mapping) for row in archivos]
    return result_list

# Endpoint para descarga de archivos
@app.get("/archivo/{idArchivo}")
async def get_archivo_detalles(id_archivo: int, db: Session = Depends(get_db)):
    '''
    Gets details for a specific file
    '''
    stmt = text('SELECT * FROM archivos WHERE IdArchivo = :archivo_id AND Active = 1')
    result = db.execute(stmt, {'archivo_id': id_archivo})
    archivo = result.fetchone()
    if not archivo:
        raise HTTPException(status_code=404, detail="Archivo no encontrado")
    return dict(archivo._mapping)

@app.post("/archivos/borrar/{idArchivo}")
async def delete_archivo(id_archivo: int, db: Session = Depends(get_db)):
    '''
    Deletes a file from DB
    '''
    archivo = db.query(models.Archivos).filter(models.Archivos.IdArchivo == id_archivo and models.Archivos.Active==1).first()
    if not archivo:
        raise HTTPException(status_code=404, detail="Archivo no encontrada")
    if archivo.Active != 1:
        raise HTTPException(status_code=400, detail="El archivo ya fue eliminado")
    # Actualizar Status a "rechazada"
    archivo.Active = 0
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
