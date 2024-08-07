from fastapi import FastAPI, Depends, HTTPException, Query
from pydantic import BaseModel
from datetime import datetime
from sqlalchemy.orm import Session
import models
import database
import schemas
import requests
import bcrypt

models.Base.metadata.create_all(bind=database.engine)

def check_password(stored_password_hash: str, provided_password: str) -> bool:

  return bcrypt.checkpw(provided_password.encode('utf-8'), stored_password_hash.encode('utf-8'))

app = FastAPI()

def get_db():
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/mediciones/", response_model=schemas.Medicion)
def create_medicion(medicion: schemas.MedicionCreate, db: Session = Depends(get_db)):
    if medicion.glucosa is None and medicion.insulina is None and medicion.carbohidratos is None:
        raise HTTPException(status_code=400, detail="Debe completar al menos uno de los campos de medición")
    db_medicion = models.Medicion(fecha=medicion.fecha, glucosa=medicion.glucosa, insulina=medicion.insulina, carbohidratos=medicion.carbohidratos, idPaciente=medicion.idPaciente)
    db.add(db_medicion)
    db.commit()
    db.refresh(db_medicion)
    return db_medicion

@app.post("/signIn/")
async def login(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if db_user is None or not check_password(user.password, db_user.password):
        raise HTTPException(status_code=400, detail="Invalid credentials")

    if db_user.role == 'medico':
        medico = db.query(models.Medico).filter(models.Medico.idUser == db_user.id).first()
        if not medico:
            raise HTTPException(status_code=404, detail="Medico not found")
        return {"token": "your_jwt_token", "role": db_user.role, "medico_id": medico.id}
    
    return {"token": "your_jwt_token", "role": db_user.role}


@app.get("/user-role/")
async def get_user_role(email: str = Query(...), db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.email == email).first()
    if user:
        response = {"role": user.role}
        if user.role == 'medico':
            medico = db.query(models.Medico).filter(models.Medico.idUser == user.id).first()
            print(db.query(models.Medico))
            if not medico:
                raise HTTPException(status_code=404, detail="Medico not found")
            response["medico_id"] = medico.id
        else:
            paciente = db.query(models.Paciente).filter(models.Paciente.idUser == user.id).first()
            response["paciente_id"] = paciente.id
        return response
    else:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")



@app.get("/pacientes/{medico_id}/")
async def get_patients_for_medico(medico_id: int, search_query: str = "", db: Session = Depends(get_db)):
    query = db.query(models.Paciente).filter(models.Paciente.idMedico == medico_id)
    
    if search_query:
        query = query.filter(
            (models.Paciente.nombre.ilike(f"%{search_query}%")) |
            (models.Paciente.apellido.ilike(f"%{search_query}%")) |
            (models.Paciente.documento.ilike(f"%{search_query}%"))
        )
        
    patients = query.all()
    
    if not patients:
        raise HTTPException(status_code=404, detail="No patients found for this medico")
    
    return patients
