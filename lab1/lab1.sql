
-- 1. Create database called «lab1»
CREATE DATABASE lab1;

-- 2. Create table «users» with fields:
CREATE TABLE users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

-- 3. Add integer column (0 or 1) «isadmin» to «users» table
ALTER TABLE users ADD COLUMN isadmin INT;

-- 4. Change type of «isadmin» column to boolean
ALTER TABLE users ALTER COLUMN isadmin TYPE BOOLEAN USING (isadmin::BOOLEAN);

-- 5. Set default value as false to «isadmin» column
ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT FALSE;

-- 6. Add primary key constraint to id column
ALTER TABLE users ADD CONSTRAINT users_pkey PRIMARY KEY (id);

-- 7. Create table «tasks» with fields:
CREATE TABLE tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INT
);

-- 8. Delete «tasks» table
DROP TABLE IF EXISTS tasks;

-- 9. Delete «lab1» database
DROP DATABASE IF EXISTS lab1;