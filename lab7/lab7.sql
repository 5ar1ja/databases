drop table if exists countries;
drop table if exists employees;
drop table if exists departments;


-- creating tables
CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT REFERENCES departments(department_id)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    budget DECIMAL(15, 2)
);

--inserting data
INSERT INTO countries (name) VALUES 
('Kazakhstan'),
('USA'),
('Japan'),
('Germany'),
('France');

INSERT INTO departments (name, budget) VALUES 
('Human Resources', 50000),
('Engineering', 200000),
('Sales', 100000),
('Marketing', 80000),
('Finance', 120000);

INSERT INTO employees (name, surname, salary, department_id) VALUES
('Alice', 'Johnson', 70000, 2),    -- Engineering
('Bob', 'Smith', 60000, 3),        -- Sales
('Carol', 'White', 50000, 1),      -- Human Resources
('Dave', 'Brown', 90000, 2),       -- Engineering
('Eve', 'Davis', 75000, 4),        -- Marketing
('Frank', 'Miller', 85000, 5),     -- Finance
('Grace', 'Wilson', 40000, 3),     -- Sales
('Henry', 'Moore', 45000, 1);      -- Human Resources

--1. creating index
create index country_name_index
on countries (name);

--2. creating index
create index employees_name_surname_index
on employees (name, surname);

--3. creating unique index
create unique index employees_salary_index
on employees (salary);

--4. creating index
CREATE INDEX idx_employees_name_substr
ON employees ((substring(name from 1 for 4)));

--5. creating index
CREATE INDEX employees_department_id_index ON employees (department_id);
CREATE INDEX departments_budget_index ON departments (budget);

--6. select's analyze
SELECT * FROM countries;
SELECT * FROM employees;
SELECT * FROM departments;

EXPLAIN ANALYZE
SELECT * FROM countries WHERE name = 'USA';

EXPLAIN ANALYZE
SELECT * FROM employees WHERE name = 'Alice' AND surname = 'Johnson';

EXPLAIN ANALYZE
SELECT * FROM employees WHERE salary < 80000 AND salary > 60000;

EXPLAIN ANALYZE
SELECT * FROM employees WHERE substring(name from 1 for 4) = 'Alic';

EXPLAIN ANALYZE
SELECT * 
FROM employees e 
JOIN departments d ON d.department_id = e.department_id 
WHERE d.budget > 80000 AND e.salary < 70000;
