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
-- manager_id INT REFERENCES employees(employees_id) : also self difined

CREATE Table employees (
    employees_id  SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    bio TEXT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL CHECK ( salary > 0 ),
    is_active BOOLEAN NOT NULL DEFAULT TRUE ,
    hire_data DATE NOT NULL ,
    last_login TIMESTAMP,
    employee_status  VARCHAR(20) NOT NULL DEFAULT 'active' 
                        CHECK (
                            employee_status IN ('active', 'on_leave', 'terminated')
                        ),
    create_at TIMESTAMP NOT NULL DEFAULT now(),
    department_id INT REFERENCES departments(department_id),
    manager_id INT REFERENCES employees(employees_id)
)

-- insert values on table
INSERT INTO employees (
    first_name ,
    last_name ,
    email ,
    job_title ,
    salary ,
    hire_data  
) VALUES (
        'laxman' , 'shinde', 'laxman@gmail.com', 'IT', 2430, '2014-10-2'
);

SELECT * FROM products;


INSERT INTO employees (first_name, last_name, email, department_id, job_title, salary, manager_id, hire_date) VALUES
    ('Priya',  'Nair',      'priya.nair@techbazaar.com',      3, 'Sales Representative', 62000.00, 3,    '2020-06-15'),
    ('Fake',   'Robert',    'robert.chen@techbazaar.com',     2, 'Rep',                  50000.00, 3,    '2024-01-01'),
    ('Marcus', 'Webb',      'marcus.webb@techbazaar.com',     1, 'Sales Representative', 58000.00, 3,    '2021-09-01'),
    ('Elena',  'Garcia',    'elena.garcia@techbazaar.com',    1, 'Senior Sales Rep',     68000.00, 3,    '2019-11-20'),
    ('James',  'Okafor',    'james.okafor@techbazaar.com',    2, 'Support Lead',         72000.00, NULL, '2018-05-10'),
    ('Lily',   'Zhang',     'lily.zhang@techbazaar.com',      2, 'Support Agent',        48000.00, 3,    '2022-02-14'),
    ('Diego',  'Fernandez', 'diego.fernandez@techbazaar.com', 2, 'Support Agent',        46000.00, 3,    '2023-01-09'),
    ('Sara',   'Osei',      'sara.osei@techbazaar.com',       3, 'Warehouse Lead',       55000.00, NULL, '2020-08-23');

-- !DDL ( Data Defination Language )

-- add a column on table
ALTER TABLE employees
ADD COLUMN internal_note VARCHAR(100) NOT NULL DEFAULT 'N/A'

-- rename the column
ALTER TABLE employees
RENAME COLUMN internal_note TO hr_note;

ALTER TABLE employees RENAME COLUMN employees_id TO employee_id

ALTER TABLE employees RENAME COLUMN hire_data TO hire_date

-- delete the column
ALTER TABLE employees
DROP COLUMN hr_note;

