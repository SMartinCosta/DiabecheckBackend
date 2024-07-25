from sqlalchemy import Column, Integer, String, Float, DateTime, Enum, ForeignKey, Date
from sqlalchemy.orm import relationship
import database
from database import Base
import enum

class Medicion(Base):
    __tablename__ = 'mediciones'

    id = Column(Integer, primary_key=True, index=True)
    fecha = Column(DateTime, nullable=False)
    glucosa = Column(Float, nullable=True)
    insulina = Column(Float, nullable=True)
    carbohidratos = Column(Float, nullable=True)
    idPaciente = Column(Integer, ForeignKey('pacientes.id')) 

    paciente = relationship("Paciente", back_populates="mediciones")

class UserRole(str, enum.Enum):
    medico = "medico"
    paciente = "paciente"

class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    password = Column(String)
    role = Column(Enum(UserRole))
    
    medico = relationship("Medico", back_populates="user", uselist=False)
    paciente = relationship("Paciente", back_populates="user", uselist=False)

class Medico(Base):
    __tablename__ = 'medicos'

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String)
    apellido = Column(String)
    idPaciente = Column(Integer, ForeignKey('paciente.id'))
    idUser = Column(Integer, ForeignKey('users.id'))

    user = relationship("User", back_populates="medico")
    pacientes = relationship("Paciente", back_populates="medico")

class Paciente(Base):
    __tablename__ = 'pacientes'

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String)
    apellido = Column(String)
    documento = Column(Integer)
    fechaNacimiento = Column(Date)
    peso = Column(Integer)
    altura = Column(Integer)
    diagnostico = Column(String)
    coberturaMedica = Column(String)
    idMedico = Column(Integer, ForeignKey('medicos.id'))
    idUser = Column(Integer, ForeignKey('users.id'))

    medico = relationship("Medico", back_populates="pacientes")
    user = relationship("User", back_populates="paciente")
    mediciones = relationship("Medicion", back_populates="paciente")
