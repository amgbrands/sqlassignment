-- Create new database
CREATE DATABASE clinic_db;
USE clinic_db;

-- 1. Patients
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100),
    date_registered TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Doctors
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100),
    hired_date DATE
);

-- 3. Appointments
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 4. Prescriptions
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication TEXT NOT NULL,
    dosage VARCHAR(100),
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- 5. Billing
CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    payment_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Optional: Indexes for faster search
CREATE INDEX idx_patient_name ON patients(full_name);
CREATE INDEX idx_doctor_name ON doctors(full_name);
