
-- Task 1: Create a database called "lab2"
CREATE DATABASE lab2;

-- Task 2: Create a simple table "countries"
CREATE TABLE countries (
    country_id SERIAL,
    country_name VARCHAR(255),
    region_id INT,
    population INT
);

-- Task 3: Insert a row with any data into the table "countries"
INSERT INTO countries (country_name, region_id, population)
VALUES ('Russia', 1, 144000000);

-- Task 4: Insert one row into the table "countries" against the column "country_id" and "country_name"
INSERT INTO countries (country_name)
VALUES ('Uzbekistan');

-- Task 5: Insert NULL value to "region_id" column for a row of "countries" table
INSERT INTO countries (country_name, region_id, population)
VALUES ('Kyrgyzstan', NULL, 7000000);

-- Task 6: Insert 3 rows by a single insert statement
INSERT INTO countries (country_name, region_id, population)
VALUES 
('China', 2, 1500000000),
('Turkey', 3, 85000000),
('France', 4, 68000000);

-- Task 7: Set default value ‘Kazakhstan’ to "country_name" column
ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

-- Task 8: Insert default value to "country_name" column for a row of "countries" table
INSERT INTO countries (region_id, population)
VALUES (5, 19000000);

-- Task 9: Insert only default values against each column of "countries" table
INSERT INTO countries DEFAULT VALUES;

-- Task 10: Create duplicate of "countries" table named "countries_new" with all structure using LIKE keyword
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

-- Task 11: Insert all rows from "countries" table to "countries_new" table
INSERT INTO countries_new
SELECT * FROM countries;

-- Task 12: Change "region_id" of country to "1" if it equals NULL
UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

-- Task 13: Increase population of each country by 10% and return updated population as "New Population"
SELECT country_name, population * 1.1 AS "New Population"
FROM countries;

-- Task 14: Remove all rows from "countries" table which has less than 100k population
DELETE FROM countries
WHERE population < 10000000;

-- Task 15: Remove all rows from "countries_new" table if "country_id" exists in "countries" table
-- Statement should return all deleted data
DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

-- Task 16: Remove all rows from "countries" table
-- Statement should return all deleted data
DELETE FROM countries
RETURNING *;

select * from countries;
select * from countries_new;