'''
Contains all endpoint paths used in the application
'''

# User-related endpoints
USER_ROLE = "/user_role/"

# Patient-related endpoints
PATIENTS_LIST = "/patients_list/{idDoctor}/"
PATIENT_DETAILS = "/patient_details/{idPatient}/"
PATIENT_MEASUREMENTS = "/patient_measurements/{idPatient}/"

# Doctor-related endpoints
DOCTOR_LIST = "/doctor_list/{idPatient}/"
DOCTOR_CONNECTION_REQUEST = "/doctor_connection_request/"
DOCTOR_CONNECTION_REQUESTS = "/doctor_connection_requests/{idDoctor}/"
ACCEPT_DOCTOR_CONNECTION_REQUEST = "/accept_doctor_connection_request/{idDoctorPatientConnection}/"
REJECT_DOCTOR_CONNECTION_REQUEST = "/reject_doctor_connection_request/{idDoctorPatientConnection}/"
DELETE_DOCTOR_CONNECTION_REQUEST = "/delete_doctor_connection_request/{idDoctorPatientConnection}/"
SEARCH_DOCTOR = "/search_doctor/{doctorLicense}/"

# Measurement-related endpoints
CREATE_MEASUREMENT = "/measurements/"
DELETE_MEASUREMENT = "/delete_measurement/{idPatientMeasurement}/"

# File-related endpoints
PATIENT_FILES = "/patient_files/{idPatient}/"
CREATE_FILE = "/files/"
FILE_TYPES = "/fileTypes/"
GET_FILE = "/file/{idFile}/"
DELETE_FILE = "/delete_file/{idFile}/"

# Miscellaneous endpoints
SERVER_TIME = "/api/time"
