--1. creating database
create database lab8;

--2. creating tables salesman, customers and orders
-- Create the 'salesman' table
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4, 2)
);

-- Create the 'customer' table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Create the 'orders' table
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Insert data into the 'salesman' table
INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

-- Insert data into the 'customer' table
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

-- Insert data into the 'orders' table
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);

--3. creating role junior_dev
CREATE ROLE junior_dev WITH LOGIN;

--4. creating veiw for salesman
CREATE VIEW salesman_NY AS 
SELECT * FROM salesman WHERE city = 'New York';

--5.creating view that shows fro each order the salesman
CREATE VIEW orders_view AS
SELECT o.ord_no, s.name AS salesman_name, c.cust_name AS customer_name
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;

GRANT ALL PRIVILEGES ON orders_view TO junior_dev;

--6. creating view grant all privulegea to junior_dev
CREATE VIEW highest_grade_customer AS
SELECT cust_name FROM customer
WHERE grade = (SELECT MAX(grade) FROM customer);

--7. Grant only select statements to junoir_dev
CREATE VIEW city_salesman AS
SELECT city, COUNT(salesman_id) AS salesman_counted
FROM salesman
GROUP BY city;

--8. Creating views that shows thr number of salesman in each city 
CREATE VIEW top_salesman AS
SELECT s.name AS salesman_name, COUNT(c.customer_id) AS customers_counted
FROM salesman s
JOIN customer c ON c.salesman_id = s.salesman_id
GROUP BY s.name
HAVING COUNT(customer_id) > 1;

--9. creating role intern and give all privilges of junior_dev
CREATE ROLE intern;
GRANT junior_dev TO intern;