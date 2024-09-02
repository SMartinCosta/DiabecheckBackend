from pydantic import BaseModel
from datetime import datetime, date
from enum import Enum
from typing import List
from typing import Optional

class MedicionCreate(BaseModel):
    Fecha: datetime
    Glucosa: Optional[float] = None
    Insulina: Optional[float] = None
    Carbohidratos: Optional[float] = None
    IdPaciente: int

class Mediciones(MedicionCreate):
    IdMedicion: int

class Config:
    orm_mode = True

class UserRole(str, Enum):
    medico = "medico"
    paciente = "paciente"

class UserBase(BaseModel):
    email: str
    role: UserRole

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int

    class Config:
        orm_mode = True

class MedicoBase(BaseModel):
    nombre: str
    apellido: str

class MedicoCreate(MedicoBase):
    idPaciente: int
    idUser: int

class Medico(MedicoBase):
    id: int
    idPaciente: int
    idUser: int
    pacientes: List['Paciente'] = []

    class Config:
        orm_mode = True

class PacienteBase(BaseModel):
    nombre: str
    apellido: str
    documento: int
    fechaNacimiento: date
    peso: int
    altura: int
    diagnostico: str
    coberturaMedica: str

class PacienteCreate(PacienteBase):
    idMedico: int
    idUser: int

class Paciente(PacienteBase):
    id: int
    idMedico: int
    idUser: int

class Config:
    orm_mode = True
