from sqlalchemy import Column, Integer, String, Float, DateTime, Enum, ForeignKey, Date, null
from sqlalchemy.orm import relationship
import database
from database import Base
import enum

class User(Base):
    __tablename__ = "usuarios"
    
    IdUsuario = Column(Integer, primary_key=True, index=True)
    Nombre = Column(String)
    Apellido = Column(String)
    NroDocumento = Column(String, unique=True, index=True)
    email = Column(String, unique=True)
    FechaNacimiento = Column(String)
    RutaFoto = Column(String, unique=True)
    IdRol = Column(Integer, ForeignKey('roles.IdRol'))
    
    medicoInfoAdicional = relationship("MedicosInfoAdicional")
    pacienteInfoAdicional = relationship("PacientesInfoAdicional")
    rol = relationship("Rol")
   
class Rol(Base):
    __tablename__= "roles"
    IdRol = Column(Integer, primary_key=True, index=True)
    Descripcion = Column(String)
    
class CoberturaMedica(Base):
    __tablename__= "coberturamedica"
    IdCoberturaMedica = Column(Integer, primary_key=True, index=True)
    Descripcion = Column(String)
   
class Diagnostico(Base):
    __tablename__= "diagnosticos"
    IdDiagnostico = Column(Integer, primary_key=True, index=True)
    Descripcion = Column(String)
    
class Matricula(Base):
    __tablename__= "matriculas"
    IdMatricula = Column(Integer, primary_key=True, index=True)
    NumeroMatricula = Column(String)
    NroDocumento = Column(String)
    
class MedicosInfoAdicional(Base):
    __tablename__="medicosinfoadicional"
    IdMedicoInfoAdicional = Column(Integer, primary_key=True, index=True)
    IdUsuario = Column(Integer, ForeignKey('usuarios.IdUsuario'))
    Especialidad = Column(String)
    IdMatricula = Column(Integer, ForeignKey('matriculas.IdMatricula'))

    matricula = relationship("Matricula")
    
class PacientesInfoAdicional(Base):
    __tablename__ = "pacientesInfoAdicional"
    IdPacientesInfoAdicional = Column(Integer, primary_key=True, index=True)
    IdUsuario = Column(Integer, ForeignKey('usuarios.IdUsuario'))
    IdCoberturaMedica = Column(Integer, ForeignKey('coberturamedica.IdCoberturaMedica'))
    IdDiagnostico = Column(Integer, ForeignKey('diagnosticos.IdDiagnostico'))
    Peso = Column(Integer)
    Altura = Column(Integer)
    FechaUltimaConsulta = Column(DateTime)
    
    cobertura = relationship("CoberturaMedica")
    diagnostico = relationship("Diagnostico")

class Conexiones(Base):
    __tablename__ = "conexionesmedicopaciente"
    IdConexionMedicoPaciente = Column(Integer, primary_key=True, index=True)
    IdMedico = Column(Integer, ForeignKey('usuarios.IdUsuario'))
    IdPaciente = Column(Integer, ForeignKey('usuarios.IdUsuario'))
    estado = Column(String, default="pendiente") 
    # medico = relationship("User")
    # paciente = relationship("User")
    
class Mediciones(Base):
    __tablename__ ="mediciones"
    IdMedicion = Column(Integer, primary_key=True, index=True)
    IdPaciente = Column(Integer, ForeignKey('usuarios.IdUsuario'))
    Fecha = Column(DateTime)
    Glucosa = Column(Integer)
    Insulina = Column(Integer)
    Carbohidratos = Column(Integer)
 
class Archivos(Base):
    __tablename__ ="archivos"
    IdArchivo = Column(Integer, primary_key=True, index=True)
    IdPaciente = Column(Integer, ForeignKey('usuarios.IdUsuario'))
    Nombre = Column(String)
    RutaArchivo = Column(String)
    FechaPublicacion = Column(DateTime)
    IdUsuario = Column(Integer, ForeignKey('usuarios.IdUsuario'))
    tipoArchivo = Column(Integer, ForeignKey('tipoArchivo.idtipoArchivo'))


class TiposDeArchivo(Base):
    __tablename__ ="tipoArchivo"
    idtipoArchivo = Column(Integer, primary_key=True, index=True)
    descripcion = Column(String)

