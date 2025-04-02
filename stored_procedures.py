'''
Contains the names of all stored procedures and SQL queries used in the application
'''

# Stored Procedures
GET_PATIENTS_BY_DOCTOR = "GetPatientsByDoctor"
GET_PATIENT_DETAILS = "GetPatientDetails"
GET_DOCTORS = "diabecheckv2.GetDoctors"
GET_DOCTOR_BY_LICENSE = "GetDoctorByDoctorLicense"
GET_CONNECTION_REQUESTS_BY_DOCTOR = "diabecheckv2.GetConnectionRequestsByDoctor"
GET_PATIENT_FILES = "diabecheckv2.GetPatientFiles"
GET_DOCTOR_CONNECTIONS = "diabecheckv2.GetDoctorConnections"
GET_PATIENT_CONNECTIONS = "diabecheckv2.GetPatientConnections"
GET_PATIENT_DOCUMENTS = "diabecheckv2.GetPatientDocuments"
GET_DOCTOR_DOCUMENTS = "diabecheckv2.GetDoctorDocuments"

# SQL Queries
SELECT_PATIENT_MEASUREMENTS = '''
    SELECT * FROM patientmeasure 
    WHERE MONTH(MeasureDate) = :month 
    AND YEAR(MeasureDate) = :year 
    AND IdPatient = :idPatient 
    AND Active = 1 
    ORDER BY MeasureDate ASC
'''

SELECT_FILE_TYPES = '''
    SELECT * FROM FileType 
    WHERE Active = 1
'''

SELECT_FILE_BY_ID = '''
    SELECT * FROM File 
    WHERE IdFile = :idFile 
    AND Active = 1
'''

DELETE_FILE_LOGICAL = '''
    UPDATE File 
    SET Active = 0 
    WHERE IdArchivo = :idFile
'''