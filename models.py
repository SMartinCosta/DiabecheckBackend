'''
Contains Models that program can get from database
'''
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from pydantic import BaseModel
from database import Base

class DbUser(Base):
    '''
    User model from database
    '''
    __tablename__ = "User"
    IdUser = Column(Integer, primary_key=True, index=True)
    Name = Column(String)
    LastName = Column(String)
    DocumentNumber = Column(String, unique=True, index=True)
    Email = Column(String, unique=True)
    BirthDate = Column(String)
    PicturePath = Column(String, unique=True)
    IdRole = Column(Integer, ForeignKey('Role.IdRole'))
    Active= Column(Integer, default=1)
    AdditionalInfoDoctor = relationship("DbAdditionalInfoDoctor")
    AdditionalInfoPatient = relationship("DbAdditionalInfoPatient")
    Role= relationship("DbRole")
class DbRole(Base):
    '''
    Role model from database
    '''
    __tablename__= "Role"
    IdRole = Column(Integer, primary_key=True, index=True)
    Description = Column(String)
    Active= Column(Integer, default=1)
class DbHealthcare(Base):
    '''
    Healthcare model from database
    '''
    __tablename__= "Healthcare"
    IdHealthcare = Column(Integer, primary_key=True, index=True)
    Description = Column(String)
    Active= Column(Integer, default=1)
class DbDiagnosis(Base):
    '''
    Diagnostic model from database
    '''
    __tablename__= "Diagnosis"
    IdDiagnosis = Column(Integer, primary_key=True, index=True)
    Description = Column(String)
    Active= Column(Integer, default=1)
class DbDoctorLicense(Base):
    '''
    License model from database
    '''
    __tablename__= "DoctorLicense"
    IdDoctorLicense = Column(Integer, primary_key=True, index=True)
    DoctorLicense = Column(String)
    DocumentNumber = Column(String)
    Active= Column(Integer, default=1)
class DbAdditionalInfoDoctor(Base):
    '''
    Doctor additional information model from database
    '''
    __tablename__="AdditionalInfoDoctor"
    IdAdditionalInfoDoctor = Column(Integer, primary_key=True, index=True)
    IdUser = Column(Integer, ForeignKey('User.IdUser'))
    Speciality = Column(String)
    IdDoctorLicense = Column(Integer, ForeignKey('DoctorLicense.IdDoctorLicense'))
    Active= Column(Integer, default=1)
    DoctorLicense = relationship("DbDoctorLicense")
class DbAdditionalInfoPatient(Base):
    '''
    Patient additional information model from database
    '''
    __tablename__ = "AdditionalInfoPatient"
    IdAdditionalInfoPatient = Column(Integer, primary_key=True, index=True)
    IdUser = Column(Integer, ForeignKey('User.IdUser'))
    IdHealthcare = Column(Integer, ForeignKey('Healthcare.IdHealthcare'))
    IdDiagnosis = Column(Integer, ForeignKey('Diagnosis.IdDiagnosis'))
    Weight = Column(Integer)
    Height = Column(Integer)
    DateLastCheckUp = Column(DateTime)
    Active= Column(Integer, default=1)
    Healthcare = relationship("DbHealthcare")
    Diagnosis = relationship("DbDiagnosis")
class DbDoctorPatientConnection(Base):
    '''
    Connection model from database
    '''
    __tablename__ = "DoctorPatientConnection"
    IdDoctorPatientConnection = Column(Integer, primary_key=True, index=True)
    IdDoctor = Column(Integer, ForeignKey('User.IdUser'))
    IdPatient = Column(Integer, ForeignKey('User.IdUser'))
    Status = Column(String, default="pendiente")
    # medico = relationship("User")
    # paciente = relationship("User")
    Active= Column(Integer, default=1)
class DbPatientMeasure(Base):
    '''
    Measurement model from database
    '''
    __tablename__ ="PatientMeasure"
    IdPatientMeasure = Column(Integer, primary_key=True, index=True)
    IdPatient = Column(Integer, ForeignKey('User.IdUser'))
    MeasureDate = Column(DateTime)
    Glucose = Column(Integer)
    Insulin = Column(Integer)
    Carbohidrates = Column(Integer)
    Active= Column(Integer, default=1)
class DbFile(Base):
    '''
    File model from database
    '''
    __tablename__ ="File"
    IdFile = Column(Integer, primary_key=True, index=True)
    IdPatient = Column(Integer, ForeignKey('User.IdUser'))
    Name = Column(String)
    FilePath = Column(String)
    PublishDate = Column(DateTime)
    IdUser = Column(Integer, ForeignKey('User.IdUser'))
    FileType = Column(Integer, ForeignKey('FileType.IdFileType'))
    Active= Column(Integer, default=1)
class DbFileType(Base):
    '''
    File type model from database
    '''
    __tablename__ ="FileType"
    IdFileType = Column(Integer, primary_key=True, index=True)
    Description = Column(String)
    Active= Column(Integer, default=1)
class DoctorConnectionRequest(BaseModel):
    '''
    Request model
    '''
    DoctorLicense: int
    IdPatient: int
class FileBase(BaseModel):
    '''
    File model
    '''
    IdPatient: int
    Name: str
    FilePath: str
    PublishDate: datetime
    IdUser: int
    IdFileType: int
