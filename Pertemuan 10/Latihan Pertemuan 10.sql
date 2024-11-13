CREATE DATABASE Normalisasi;
USE Normalisasi;

-- 1NF - First Normal Form
CREATE TABLE Employee_Project_1NF (
    Employee_ID INT,
    Employee_Name VARCHAR(100),
    Project_ID INT,
    Project_Name VARCHAR(100),
    PRIMARY KEY (Employee_ID, Project_ID)
);

-- 2NF - Second Normal Form
-- Tabel untuk menyimpan data karyawan
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100)
);

-- Tabel untuk menyimpan data proyek
CREATE TABLE Project (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100)
);

-- Tabel hubungan antara karyawan dan proyek
CREATE TABLE Employee_Project_2NF (
    Employee_ID INT,
    Project_ID INT,
    PRIMARY KEY (Employee_ID, Project_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
);

-- Insert data ke tabel Employee
INSERT INTO Employee (Employee_ID, Employee_Name)
VALUES (1, 'John Doe'), (2, 'Jane Smith');

-- Insert data ke tabel Project
INSERT INTO Project (Project_ID, Project_Name)
VALUES (101, 'Website Redesign'), (102, 'Mobile App Dev'), (103, 'Data Migration');

-- Insert data ke tabel relasi Employee_Project_2NF
INSERT INTO Employee_Project_2NF (Employee_ID, Project_ID)
VALUES (1, 101), (2, 102), (1, 103);

-- 3NF - Third Normal Form
-- Tabel untuk menyimpan data departemen
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100)
);

-- Update tabel Employee dengan referensi ke Department
ALTER TABLE Employee
ADD Department_ID INT,
ADD FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID);

-- Insert data ke tabel Department
INSERT INTO Department (Department_ID, Department_Name)
VALUES (1, 'IT'), (2, 'HR');

-- Update data di tabel Employee dengan Department_ID
UPDATE Employee SET Department_ID = 1 WHERE Employee_ID = 1;
UPDATE Employee SET Department_ID = 2 WHERE Employee_ID = 2;

-- BCNF - Boyce-Codd Normal Form
-- Tabel untuk menyimpan data Project Manager
CREATE TABLE Project_Manager (
    Project_ID INT PRIMARY KEY,
    Manager_Name VARCHAR(100),
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
);

-- Insert data Project_Manager
INSERT INTO Project_Manager (Project_ID, Manager_Name)
VALUES (101, 'Alice'), (102, 'Bob'), (103, 'Charlie');
