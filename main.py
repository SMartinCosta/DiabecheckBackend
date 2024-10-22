from urllib import response
from fastapi import FastAPI, Depends, HTTPException, Query, Form, Request
from pydantic import BaseModel
from datetime import datetime
from sqlalchemy.orm import Session
from sqlalchemy import text
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

class ArchivoBase(BaseModel):
    id_paciente: int
    nombre: str
    ruta_archivo: str
    fecha_publicacion: datetime
    id_usuario: int
    id_tipoarchivo: int


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
    if not glucosa:
        glucosa=0;
    if not insulina:
        insulina=0;
    if not carbohidratos:
        carbohidratos=0;
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
    db_user = db.query(models.User).filter(models.User.email == email and models.User.Active == 1).first()
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

    user_query_patient = db.query(models.User)
    
    if email:
        user = db.query(models.User).filter(models.User.email == email and models.User.Active == 1).first()
    elif user_id:
        user = user_query_patient.filter(models.User.IdUsuario == user_id and models.User.Active == 1).first()
    else:
        raise HTTPException(status_code=400, detail="Debe proporcionar email o IdUsuario")
    
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    response = {"IdUsuario": user.IdUsuario, "Rol": user.rol.Descripcion}

    # if user.rol.Descripcion == "Medico":
    #     medico = db.query(models.MedicosInfoAdicional).filter(models.MedicosInfoAdicional.IdUsuario == user.IdUsuario).first()
    #     response["medicoId"] = medico.IdMedicoInfoAdicional if medico else None

    # if user.rol.Descripcion == "Paciente":
    #     paciente = db.query(models.PacientesInfoAdicional).filter(models.PacientesInfoAdicional.IdUsuario == user.IdUsuario).first()
    #     response["IdPaciente"] = paciente.IdPacientesInfoAdicional if paciente else None

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
    stmt = text('SELECT * FROM mediciones WHERE MONTH(Fecha) = :month AND YEAR(Fecha) = :year AND IdPaciente = :patient_id AND Activo = 1 ORDER BY Fecha ASC')
    result = db.execute(stmt, {'month': month, 'year': year, 'patient_id': patient_id})
    mediciones = result.fetchall()
    return [dict(row._mapping) for row in mediciones]

@app.get("/listado_medicos/{paciente_id}/")
async def get_medico_for_patients(paciente_id: int, db: Session = Depends(get_db)):
    stmt = text('CALL `diabecheckv2`.`GetMedicos`('+str(paciente_id)+')')
    result = db.execute(stmt)
    medicos = result.fetchall()
    result_list = [dict(row._mapping) for row in medicos]
  
    return result_list

@app.post("/solicitud-medico/")
async def crear_solicitud_medico(solicitud: SolicitudMedicoRequest, db: Session = Depends(get_db)):

    matricula = solicitud.matricula
    paciente_id = solicitud.paciente_id

    relacion = db.query(models.PacientesInfoAdicional).filter(models.PacientesInfoAdicional.IdPacientesInfoAdicional == paciente_id and models.PacientesInfoAdicional.Activo == 1).first()
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
        models.Conexiones.IdPaciente == paciente_id,
        models.Conexiones.estado == "aceptada"
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


#obtener las solicitudes de un medico
@app.get("/medico/solicitudes/{medico_id}/")
async def get_solicitudes(medico_id: int, db: Session = Depends(get_db)): 
    stmt = text('CALL `diabecheckv2`.`GetSolicitudesByMedico`(:medico_id)')
    result = db.execute(stmt, {"medico_id": medico_id})
    solicitudes = result.fetchall()

    result_list = [dict(row._mapping) for row in solicitudes]
  
    return result_list

@app.post("/medico/solicitudes/aceptar/{id_solicitud}/")
async def aceptar_solicitud(id_solicitud: int, db: Session = Depends(get_db)):
    solicitud = db.query(models.Conexiones).filter(models.Conexiones.IdConexionMedicoPaciente == id_solicitud and models.Conexiones == 1).first()

    if not solicitud:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")

    if solicitud.estado != "pendiente":
        raise HTTPException(status_code=400, detail="La solicitud ya fue procesada")

    solicitud.estado = "aceptada"
    db.commit()

    return {"msg": "Solicitud aceptada exitosamente"}

@app.post("/medico/solicitudes/rechazar/{id_solicitud}/")
async def rechazar_solicitud(id_solicitud: int, db: Session = Depends(get_db)):
    solicitud = db.query(models.Conexiones).filter(models.Conexiones.IdConexionMedicoPaciente == id_solicitud and models.Conexiones.Activo == 1).first()

    if not solicitud:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")

    if solicitud.estado != "pendiente":
        raise HTTPException(status_code=400, detail="La solicitud ya fue procesada")

    # Actualizar estado a "rechazada"
    solicitud.estado = "rechazada"
    db.commit()

    return {"msg": "Solicitud rechazada exitosamente"}

@app.get("/buscar_medico/{matricula}/")
async def get_medico_for_patients(matricula: int, db: Session = Depends(get_db)):
    stmt = text('CALL GetMedicoByMatricula(:matricula)')
    result = db.execute(stmt, {"matricula": matricula})
    medicos = result.fetchall()
    if not medicos:
        raise HTTPException(status_code=404, detail="No medico found for this patient")
    result_list = [dict(row._mapping) for row in medicos]
  
    return result_list

@app.get("/pacientes/{idPaciente}/archivos")
async def get_archivos_paciente(idPaciente: int, db: Session = Depends(get_db)):
    stmt = text('CALL `diabecheckv2`.`GetArchivosPaciente`('+str(idPaciente)+')')
    result = db.execute(stmt)
    archivos = result.fetchall()
    result_list = [dict(row._mapping) for row in archivos]
  
    return result_list


@app.post("/archivos/")
async def create_archivo(archivo: ArchivoBase, db: Session = Depends(get_db)):
    nuevo_archivo = models.Archivos(
        IdPaciente=archivo.id_paciente,
        Nombre=archivo.nombre,
        RutaArchivo=archivo.ruta_archivo,
        FechaPublicacion=archivo.fecha_publicacion,
        IdUsuario=archivo.id_usuario,
        tipoArchivo=archivo.id_tipoarchivo
    )
    
    db.add(nuevo_archivo)
    db.commit()
    db.refresh(nuevo_archivo)
    
    return {"message": "Archivo registrado exitosamente", "archivo": nuevo_archivo}


@app.get("/tipoarchivo")
async def get_tiposarchivo(db: Session = Depends(get_db)):
    stmt = text('SELECT * FROM tipoArchivo WHERE Activo =1')
    result = db.execute(stmt)
    tipos = result.fetchall()
    return [dict(row._mapping) for row in tipos]

@app.post("/archivos/borrar/{idArchivo}")
async def delete_archivo(idArchivo: int, db: Session = Depends(get_db)):
    archivo = db.query(models.Archivos).filter(models.Archivos.IdArchivo == idArchivo and models.Archivos.Activo==1).first()

    if not archivo:
        raise HTTPException(status_code=404, detail="Archivo no encontrada")

    if archivo.Activo != 1:
        raise HTTPException(status_code=400, detail="El archivo ya fue eliminado")

    # Actualizar estado a "rechazada"
    archivo.Activo = 0
    db.commit()

    return {"msg": "Solicitud rechazada exitosamente"}
def activate(self, db: Session = Depends(get_db)):
    self.Roles = db.query(models.Rol)
    
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
    activate(get_db())



