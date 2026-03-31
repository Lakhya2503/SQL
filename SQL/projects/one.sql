-- Active: 1774897613985@@localhost@5432@bankdb@public

--  ----------------------- CREATE DATABASE -----------------------

-- CREATE DATABASE Bankdb;

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

--  ----------------------- CREATE TABLE -----------------------

-- CREATE TABLE employees(
--     emp_id  SERIAL PRIMARY KEY,  -- UNIQUE and serial wise id
--     fname varchar(20) NOT NULL, -- fname is not null means not empty
--     lname varchar(20) NOT NULL, -- lname is not null means not empty
--     email VARCHAR(100) NOT NULL UNIQUE, -- email is not null means not empty and also unique
--     dept VARCHAR(20), -- depart are might be null
--     salary DECIMAL(10,2) DEFAULT 30000.00, -- default salary was 30000
--     hire_date DATE NOT NULL DEFAULT CURRENT_DATE  -- not null and also when user didn't add the hire_date then it's  use been current date
-- )

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

--  ----------------------- ADD VALUES IN TABLE -----------------------


-- INSERT INTO employees (emp_id, fname, lname, email, dept, salary, hire_date) VALUES
-- (101, 'Amit', 'Sharma', 'amit.sharma@gmail.com', 'Finance', 55000, '2021-03-15'),
-- (102, 'Priya', 'Patel', 'priya.patel@yahoo.com', 'HR', 48000, '2020-07-22'),
-- (103, 'Rahul', 'Verma', 'rahul.verma@outlook.com', 'IT', 62000, '2019-11-10'),
-- (104, 'Sneha', 'Iyer', 'sneha.iyer@gmail.com', 'Marketing', 50000, '2022-01-05'),
-- (105, 'Arjun', 'Singh', 'arjun.singh@gmail.com', 'Operations', 58000, '2021-06-18'),
-- (106, 'Neha', 'Gupta', 'neha.gupta@yahoo.com', 'Finance', 53000, '2020-09-30'),
-- (107, 'Vikram', 'Mehta', 'vikram.mehta@outlook.com', 'IT', 67000, '2018-12-12'),
-- (108, 'Kavita', 'Nair', 'kavita.nair@gmail.com', 'HR', 46000, '2023-02-25'),
-- (109, 'Rohan', 'Das', 'rohan.das@gmail.com', 'Marketing', 51000, '2021-08-14'),
-- (110, 'Pooja', 'Kulkarni', 'pooja.kulkarni@yahoo.com', 'Operations', 59000, '2019-04-09');


-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

--  ----------------------- SEE TABLE VALUES -----------------------

-- SELECT * FROM employees;


-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

--  ----------------------- DELETE VALUES IN TABLE -----------------------

-- DELETE FROM employees WHERE hire_date='2019-11-10'















--
