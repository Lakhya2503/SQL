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

-- UNIQUE : not be duplicate
-- TEXT : not be confirm the length
-- INT : integer
-- DEAFULT : when specifiecilly not to be assign not creation time
-- DATE : date data type
-- CHECK (employee_status IN 'active', 'on_leave', 'terminate') : check the employe on three state only 
--  DEFAULT now() : which means current time
-- REFERENCES departments(department_id) : refrence from deparment table department_id

CREATE Table employees (
    employees_id  SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    bio TEXT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL ( salary > 0 ),
    is_active BOOLEAN NOT NULL DEFAULT TRUE ,
    hire_data DATE NOT NULL ,
    last_login TIMESTAMP,
    employee_status  VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (employee_status IN 'active', 'on_leave', 'terminate'),
    create_at TIMESTAMP NOT NULL DEFAULT now(),
    department_id INT REFERENCES departments(department_id)
)