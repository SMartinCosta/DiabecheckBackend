from urllib import response
from fastapi import FastAPI, Depends, HTTPException, Query, Form, Request
from pydantic import BaseModel
from datetime import datetime
from sqlalchemy.orm import Session
from sqlalchemy import text
from cryptography import *
import models
import database
import schemas
import requests
import bcrypt
import uvicorn
models.Base.metadata.create_all(bind=database.engine)

app = FastAPI()
def get_db():
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()


def check_password(stored_password_hash: str, provided_password: str) -> bool:

  return bcrypt.checkpw(provided_password.encode('utf-8'), stored_password_hash.encode('utf-8'))

class SolicitudMedicoRequest(BaseModel):
    matricula: int
    paciente_id: int

@app.post("/mediciones/")
async def create_medicion(medicion: dict, request: Request, db: Session = Depends(get_db)):
    body = await request.json()  # Obtener datos del cuerpo de la solicitud
    
    # Obtener los valores específicos del cuerpo de la solicitud
    glucosa = body.get("Glucosa")
    insulina = body.get("Insulina")
    carbohidratos = body.get("Carbohidratos")
    fecha = body.get("Fecha")
    id_paciente = body.get("IdPaciente")
    
    # Validación: al menos uno de los campos debe estar presente
    if not glucosa and not insulina and not carbohidratos:
        raise HTTPException(status_code=400, detail="Debe completar al menos uno de los campos de medición")
    
    fecha = datetime.fromisoformat(medicion['Fecha'].replace("Z", "+00:00"))

    # Crear nueva medición
    db_medicion = models.Mediciones(
        Fecha=fecha,
        Glucosa=glucosa,
        Insulina=insulina,
        Carbohidratos=carbohidratos,
        IdPaciente=id_paciente
    )
    
    # Guardar en la base de datos
    db.add(db_medicion)
    db.commit()
    db.refresh(db_medicion)
    
    return db_medicion

@app.post("/signIn/")
async def login(email: str = Form(), db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == email).first()
    if db_user.role == 'medico':
        medico = db.query(models.Medico).filter(models.Medico.idUser == db_user.id).first()
        if not medico:
            raise HTTPException(status_code=404, detail="Medico not found")
        return {"token": "your_jwt_token", "role": db_user.role, "medico_id": medico.id}
    
    return {"token": "your_jwt_token", "role": db_user.role}


@app.get("/user-role/")
async def get_user_role( 
    email: str = Query(None),  # Email ahora es opcional
    user_id: int = Query(None),  # IdUsuario también es opcional
    db: Session = Depends(get_db)):

    user_query_patient = db.query(models.User).outerjoin(models.PacientesInfoAdicional, models.User.IdUsuario == models.PacientesInfoAdicional.IdUsuario)
    
    if email:
        user = db.query(models.User).filter(models.User.email == email).first()
    elif user_id:
        user = user_query_patient.filter(models.PacientesInfoAdicional.IdPacientesInfoAdicional == user_id).first()
    else:
        raise HTTPException(status_code=400, detail="Debe proporcionar email o IdUsuario")
    
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    response = {"IdUsuario": user.IdUsuario, "Rol": user.rol.Descripcion}

    if user.rol.Descripcion == "Medico":
        medico = db.query(models.MedicosInfoAdicional).filter(models.MedicosInfoAdicional.IdUsuario == user.IdUsuario).first()
        response["medicoId"] = medico.IdMedicoInfoAdicional if medico else None

    if user.rol.Descripcion == "Paciente":
        paciente = db.query(models.PacientesInfoAdicional).filter(models.PacientesInfoAdicional.IdUsuario == user.IdUsuario).first()
        response["IdPaciente"] = paciente.IdPacientesInfoAdicional if paciente else None

    return response


@app.get("/listado_pacientes/{medico_id}/")
async def get_patients_for_medico(medico_id: int, search_query: str = "", db: Session = Depends(get_db)):
    stmt = text('CALL `diabecheckv2`.`GetPacientes`('+str(medico_id)+')')
    result = db.execute(stmt)
    pacientes = result.fetchall()
    if not pacientes:
        raise HTTPException(status_code=404, detail="No patients found for this medico")
    result_list = [dict(row._mapping) for row in pacientes]

    if search_query:
        result_list = [paciente for paciente in result_list if search_query.lower() in paciente['Apellido'].lower() or search_query.lower() in str(paciente['NroDocumento'])]
  
    return result_list


# Endpoint para obtener detalles de un paciente por ID
@app.get("/detalles_pacientes/{paciente_id}/")
async def get_paciente_details(paciente_id: int, db: Session = Depends(get_db)):
    try:
        # Llamar al procedure almacenado en la base de datos
        stmt = text('CALL GetPacienteDetails(:pacienteId)')
        result = db.execute(stmt, {"pacienteId": paciente_id})
        paciente_details = result.fetchone()
        
        # Verificar si se encontraron datos
        if not paciente_details:
            raise HTTPException(status_code=404, detail="Paciente no encontrado")

        # Convertir los resultados en un diccionario
        paciente_dict = dict(paciente_details._mapping)

        return paciente_dict

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al obtener los detalles del paciente: {str(e)}")


@app.get("/pacientes/{patient_id}/mediciones")
async def get_mediciones(patient_id: int, month: int, year: int, db: Session = Depends(get_db)):
    stmt = text('SELECT * FROM mediciones WHERE MONTH(Fecha) = :month AND YEAR(Fecha) = :year AND IdPaciente = :patient_id ORDER BY Fecha ASC')
    result = db.execute(stmt, {'month': month, 'year': year, 'patient_id': patient_id})
    mediciones = result.fetchall()
    return [dict(row._mapping) for row in mediciones]

@app.get("/listado_medicos/{paciente_id}/")
async def get_medico_for_patients(paciente_id: int, db: Session = Depends(get_db)):
    stmt = text('CALL `diabecheckv2`.`GetMedicos`('+str(paciente_id)+')')
    result = db.execute(stmt)
    medicos = result.fetchall()
    if not medicos:
        raise HTTPException(status_code=404, detail="No medico found for this patient")
    result_list = [dict(row._mapping) for row in medicos]
  
    return result_list

@app.post("/solicitud-medico/")
async def crear_solicitud_medico(solicitud: SolicitudMedicoRequest, db: Session = Depends(get_db)):

    matricula = solicitud.matricula
    paciente_id = solicitud.paciente_id

    relacion = db.query(models.PacientesInfoAdicional).filter(models.PacientesInfoAdicional.IdPacientesInfoAdicional == paciente_id).first()
    paciente_id = relacion.IdUsuario

    # Buscar al médico por su matrícula
    stmt = text('CALL GetMedicoByMatricula(:matricula)')
    result = db.execute(stmt, {"matricula": matricula})
    medico = result.fetchone()
    result_list = dict(medico._mapping)

    if not medico:
        raise HTTPException(status_code=404, detail="Médico no encontrado")

    # Verificar si ya existe una solicitud o conexión
    conexion_existente = db.query(models.Conexiones).filter(
        models.Conexiones.IdMedico == result_list.get('IdUsuario'),
        models.Conexiones.IdPaciente == paciente_id
    ).first()

    if conexion_existente:
        raise HTTPException(status_code=404, detail="Ya existe una solicitud o conexión con este médico")

    # Crear la solicitud pendiente
    nueva_conexion = models.Conexiones(
        IdMedico=result_list.get('IdUsuario'),
        IdPaciente=paciente_id,
        estado="pendiente" 
    )
    db.add(nueva_conexion)
    db.commit()
    db.refresh(nueva_conexion)

    return {"msg": "Solicitud enviada con éxito", "conexion": nueva_conexion}


@app.put("/solicitud-medico/{conexion_id}/")
async def gestionar_solicitud(conexion_id: int, aceptar: bool, db: Session = Depends(get_db)):
    conexion = db.query(models.Conexiones).filter(models.Conexiones.IdConexionMedicoPaciente == conexion_id).first()

    if not conexion:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")

    # Actualizar estado según la decisión del médico
    conexion.estado = "aceptada" if aceptar else "rechazada"
    db.commit()
    db.refresh(conexion)

    return {"msg": "Solicitud gestionada", "estado": conexion.estado}



def activate(self, db: Session = Depends(get_db)):
    self.Roles = db.query(models.Rol)
    
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
    activate(get_db())



