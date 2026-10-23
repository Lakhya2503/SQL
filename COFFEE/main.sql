-- Active: 1792772116333@@127.0.0.1@5432@sample_data

    -- SERIAL: Increment the serial in postgres use also denoting is INTERGER TYPE SERIAL and SQL in use AUTOINCREMENT ,  
    -- PRIMARY KEY : value cannot be NULL and it must be unique,
    -- VARCHAR(50) : varible character characters 0 - 50
    -- NOT NULL : value not be null


CREATE TABLE departments (
    department_id SERIAL  PRIMARY KEY, 
    department_name VARCHAR(50) NOT NULL
);

INSERt INTO departments (department_name)
VALUES
('Sales'),
('Support'),
('Warehouse');

INSERT INTO departments (department_id, department_name)
VALUES
(4, 'Tech');

SELECT * FROM departments;

