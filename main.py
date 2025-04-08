'''
Contains business logic for the application
'''

from datetime import datetime, timedelta, timezone
from fastapi import FastAPI, Depends, HTTPException, Query, Request
from sqlalchemy.orm import Session
from sqlalchemy import text
import uvicorn
import models
import database
import stored_procedures as sp  # Import stored procedure names
import endpoints as ep  # Import endpoint paths

models.Base.metadata.create_all(bind=database.engine)

app = FastAPI()

def GetDb():
    '''
    Gets the database session
    '''
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.post(ep.CREATE_MEASUREMENT)
async def CreateMeasurement(measurement: dict, request: Request, db: Session = Depends(GetDb)):
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
        raise HTTPException(status_code=400,
                            detail="Debe completar al menos uno de los campos de medición")
    measureDate = datetime.fromisoformat(measurement['MeasurementDate'].replace("Z", "+00:00"))
    glucose = glucose or 0
    insulin = insulin or 0
    carbohidrates = carbohidrates or 0

    dbMeasurement = models.DbPatientMeasure(
        MeasureDate=measureDate,
        Glucose=glucose,
        Insulin=insulin,
        Carbohidrates=carbohidrates,
        IdPatient=idPatient
    )
    db.add(dbMeasurement)
    db.commit()
    db.refresh(dbMeasurement)
    return dbMeasurement


@app.delete(ep.DELETE_MEASUREMENT, status_code=200)
def DeleteMeasurement(idPatientMeasurement: int, db: Session = Depends(GetDb)):
    '''
    Logically eliminates a measurement record from the database
    '''
    patientMeasurement = (
        db.query(models.DbPatientMeasure)
        .filter(models.DbPatientMeasure.IdPatientMeasure == idPatientMeasurement)
        .first()
    )
    if not patientMeasurement:
        raise HTTPException(status_code=404, detail="Medición no encontrada")
    patientMeasurement.Active = 0
    db.commit()
    return {"mensaje": f"Medición {idPatientMeasurement} desactivada correctamente"}


@app.get(ep.USER_ROLE)
async def GetUserRole(
    email: str = Query(None),
    idUser: int = Query(None),
    db: Session = Depends(GetDb)):
    '''
    Gets User Role by Email or IdUser
    '''
    userQueryPatient = db.query(models.DbUser)
    if email:
        user = (
            db.query(models.DbUser)
            .filter(models.DbUser.Email == email and models.DbUser.Active == 1)
            .first()
        )
    elif idUser:
        user = (
            userQueryPatient
            .filter(models.DbUser.IdUser == idUser and models.DbUser.Active == 1)
            .first()
        )
    else:
        raise HTTPException(status_code=400, detail="Debe proporcionar Email o IdUser")
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    role = {"IdUser": user.IdUser, "Role": user.Role.Description}
    return role


@app.get(ep.PATIENTS_LIST)
async def GetPatientsListByDoctor(
    idDoctor: int,
    searchQuery: str = "",
    db: Session = Depends(GetDb)):
    '''
    Gets a list of patients for a given doctor
    '''
    stmt = text(f'CALL `{sp.GET_PATIENTS_BY_DOCTOR}`(:idDoctor)')
    result = db.execute(stmt, {"idDoctor": idDoctor})
    patients = result.fetchall()
    if not patients:
        raise HTTPException(status_code=404, detail="No patients found for this medico")
    resultList = [row._asdict() for row in patients]
    if searchQuery:
        resultList = [patient for patient in resultList if searchQuery.lower()
                       in patient['LastName'].lower()
                       or searchQuery.lower() in str(patient['DocumentNumber'])]
    return resultList


@app.get(ep.PATIENT_DETAILS)
async def GetPatientDetails(idPatient: int, db: Session = Depends(GetDb)):
    '''
    Gets a patient's details by ID
    '''
    try:
        stmt = text(f'CALL {sp.GET_PATIENT_DETAILS}(:idPatient)')
        result = db.execute(stmt, {"idPatient": idPatient})
        patientDetails = result.fetchone()
        if not patientDetails:
            raise HTTPException(status_code=404, detail="Paciente no encontrado")
        return patientDetails._asdict()
    except Exception as e:
        raise HTTPException(status_code=500,
                            detail=f'Error al obtener los detalles del paciente: {str(e)}') from e


@app.get(ep.PATIENT_MEASUREMENTS)
async def GetPatientMeasurements(
    idPatient: int,
    month: int,
    year: int,
    db: Session = Depends(GetDb)):
    '''
    Gets a patient's measurements for a given month and year
    '''
    stmt = text(sp.SELECT_PATIENT_MEASUREMENTS)
    result = db.execute(stmt, {'month': month, 'year': year, 'idPatient': idPatient})
    measurements = result.fetchall()
    return [row._asdict() for row in measurements]


@app.get(ep.DOCTOR_LIST)
async def GetDoctorByIdPatient(idPatient: int, db: Session = Depends(GetDb)):
    '''
    Gets a list of doctors for a given patient
    '''
    stmt = text(f'CALL {sp.GET_DOCTORS}(:idPatient)')
    result = db.execute(stmt, {"idPatient": idPatient})
    doctors = result.fetchall()
    return [row._asdict() for row in doctors]


@app.post(ep.DOCTOR_CONNECTION_REQUEST)
async def CreateConnectionRequest(
    request: models.DoctorConnectionRequest,
    db: Session = Depends(GetDb)):
    '''
    Creates a new connection request between a patient and a doctor
    '''
    doctorLicense = request.DoctorLicense
    idPatient = request.IdPatient
    stmt = text('CALL GetDoctorByDoctorLicense(:DoctorLicense)')
    result = db.execute(stmt, {"DoctorLicense": doctorLicense})
    doctor = result.fetchone()
    if not doctor:
        raise HTTPException(status_code=404, detail="Médico no encontrado")
    resultList = doctor._asdict()
    # Verificar si ya existe una solicitud o conexión
    existentConnection = db.query(models.DbDoctorPatientConnection).filter(
        models.DbDoctorPatientConnection.IdDoctor == resultList.get('IdUser'),
        models.DbDoctorPatientConnection.IdPatient == idPatient,
        models.DbDoctorPatientConnection.Status.in_(["aceptada", "pendiente"]),
        models.DbDoctorPatientConnection.Active == 1
    ).first()
    if existentConnection:
        raise HTTPException(status_code=404,
                            detail="Ya existe una solicitud o conexión con este médico")
    # Crear la solicitud pendiente
    newConnection = models.DbDoctorPatientConnection(
        IdDoctor=resultList.get('IdUser'),
        IdPatient=idPatient,
        Status="pendiente"
    )
    db.add(newConnection)
    db.commit()
    db.refresh(newConnection)
    return newConnection


@app.get(ep.DOCTOR_CONNECTION_REQUESTS)
async def GetRequests(idDoctor: int, db: Session = Depends(GetDb)):
    '''
    Gets a list of connection requests for a given doctor
    '''
    stmt = text(f'CALL {sp.GET_CONNECTION_REQUESTS_BY_DOCTOR}(:idDoctor)')
    result = db.execute(stmt, {"idDoctor": idDoctor})
    requests = result.fetchall()
    resultList = [row._asdict() for row in requests]
    return resultList


@app.post(ep.ACCEPT_DOCTOR_CONNECTION_REQUEST)
async def AcceptRequest(idDoctorPatientConnection: int, db: Session = Depends(GetDb)):
    '''
    Accepts a connection request
    '''
    connenction = (
        db.query(models.DbDoctorPatientConnection)
        .filter(models.DbDoctorPatientConnection.IdDoctorPatientConnection
                == idDoctorPatientConnection
                and models.DbDoctorPatientConnection.Active == 1)
        .first()
    )
    if not connenction:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    if connenction.Status != "pendiente":
        raise HTTPException(status_code=400, detail="La solicitud ya fue procesada")
    connenction.Status = "aceptada"
    db.commit()
    return {"msg": "Solicitud aceptada exitosamente"}


@app.post(ep.REJECT_DOCTOR_CONNECTION_REQUEST)
async def RejectConnection(idDoctorPatientConnection: int, db: Session = Depends(GetDb)):
    '''
    Rejects a connection request
    '''
    request = (
        db.query(models.DbDoctorPatientConnection)
        .filter(models.DbDoctorPatientConnection.IdDoctorPatientConnection
                == idDoctorPatientConnection
                and models.DbDoctorPatientConnection.Active == 1)
        .first()
    )
    if not request:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    if request.Status != "pendiente":
        raise HTTPException(status_code=400, detail="La solicitud ya fue procesada")
    # Actualizar Status a "rechazada"
    request.Status = "rechazada"
    db.commit()
    return {"msg": "Solicitud rechazada exitosamente"}


@app.delete(ep.DELETE_DOCTOR_CONNECTION_REQUEST, status_code=200)
def DeleteConnection(idDoctorPatientConnection: int, db: Session = Depends(GetDb)):
    '''
    Eliminates a connection
    '''
    # Buscar la solicitud en la base de datos
    request = (
        db.query(models.DbDoctorPatientConnection)
        .filter(models.DbDoctorPatientConnection.IdDoctorPatientConnection
                == idDoctorPatientConnection)
        .first()
    )
    if not request:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    # Actualizar el campo 'Active' a 0 (borrado lógico)
    request.Active = 0
    db.commit()
    return {"mensaje": f"Solicitud {idDoctorPatientConnection} desactivada correctamente"}


@app.get(ep.SEARCH_DOCTOR)
async def GetDoctorByLicense(doctorLicense: int, db: Session = Depends(GetDb)):
    '''
    Gets doctor by a DoctorLicense
    '''
    stmt = text(f'CALL {sp.GET_DOCTOR_BY_LICENSE}(:DoctorLicense)')
    result = db.execute(stmt, {"DoctorLicense": doctorLicense})
    doctors = result.fetchall()
    if not doctors:
        raise HTTPException(status_code=404, detail="No medico found for this patient")
    resultList = [row._asdict() for row in doctors]
    return resultList


@app.get(ep.PATIENT_FILES)
async def GetPatientFiles(idPatient: int, db: Session = Depends(GetDb)):
    '''
    Gets files for a given patient
    '''
    stmt = text(f'CALL {sp.GET_PATIENT_FILES}(:idPatient)')
    result = db.execute(stmt, {"idPatient": idPatient})
    files = result.fetchall()
    resultList = [row._asdict() for row in files]
    return resultList


@app.post(ep.CREATE_FILE)
async def CreateFile(file: models.FileBase, db: Session = Depends(GetDb)):
    '''
    Uploads a new file to the database
    '''
    newFile = models.DbFile(
        IdPatient=file.IdPatient,
        Name=file.Name,
        FilePath=file.FilePath,
        PublishDate=file.PublishDate,
        IdUser=file.IdUser,
        FileType=file.IdFileType
    )
    db.add(newFile)
    db.commit()
    db.refresh(newFile)
    return {"message": "Archivo registrado exitosamente", "file": newFile}


@app.get(ep.FILE_TYPES)
async def GetFileTypes(db: Session = Depends(GetDb)):
    '''
    Gets a list of available file types
    '''
    stmt = text(sp.SELECT_FILE_TYPES)
    result = db.execute(stmt)
    types = result.fetchall()
    return [row._asdict() for row in types]


@app.get(ep.GET_FILE)
async def GetFile(idFile: int, db: Session = Depends(GetDb)):
    '''
    Gets details for a specific file
    '''
    stmt = text(sp.SELECT_FILE_BY_ID)
    result = db.execute(stmt, {'idFile': idFile})
    file = result.fetchone()
    if not file:
        raise HTTPException(status_code=404, detail="Archivo no encontrado")
    return file._asdict()


@app.post(ep.DELETE_FILE)
async def DeleteFile(idFile: int, db: Session = Depends(GetDb)):
    '''
    Deletes a file from DB
    '''
    stmt = text(sp.DELETE_FILE_LOGICAL)
    _ = db.execute(stmt, {'idFile': idFile})
    db.commit()
    return {"msg": "Archivo borrado exitosamente"}


@app.get(ep.SERVER_TIME)
async def GetServerTime():
    '''
    Gets server time
    '''
    # Obtén la fecha y hora actual con zona horaria UTC
    serverTime = datetime.now(timezone(timedelta(hours=-3))).isoformat()
    return {"serverTime": serverTime}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
