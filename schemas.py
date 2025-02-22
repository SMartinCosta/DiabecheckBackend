# from pydantic import BaseModel
# from datetime import datetime, date
# from enum import Enum
# from typing import List
# from typing import Optional

# class Config:
#     orm_mode = True
    
# class MedicionCreate(BaseModel):
#     Fecha: datetime
#     Glucosa: Optional[float] = None
#     Insulina: Optional[float] = None
#     Carbohidratos: Optional[float] = None
#     IdPatient: int

# class Mediciones(MedicionCreate):
#     IdPatientMeasure: int

# class UserRole(str, Enum):
#     MEDICO = "medico"
#     PACIENTE = "paciente"

# class UserBase(BaseModel):
#     Email: str
#     Role: UserRole

# class UserCreate(UserBase):
#     password: str

# class User(UserBase):
#     id: int

# class MedicoBase(BaseModel):
#     Name: str
#     LastName: str

# class MedicoCreate(MedicoBase):
#     IdPatient: int
#     idUser: int

# class Medico(MedicoBase):
#     id: int
#     IdPatient: int
#     idUser: int
#     pacientes: List['Paciente'] = []

# class PacienteBase(BaseModel):
#     Name: str
#     LastName: str
#     documento: int
#     BirthDate: date
#     Weight: int
#     Height: int
#     Diagnosis: str
#     Healthcare: str

# class PacienteCreate(PacienteBase):
#     IdDoctor: int
#     idUser: int

# class Paciente(PacienteBase):
#     id: int
#     IdDoctor: int
#     idUser: int
