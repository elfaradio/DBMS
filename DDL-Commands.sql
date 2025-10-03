/*
1. CREATE
2. TRUNCATE
3. DROP
*/


Create database if not exists Farhad -- Create database

-- drop database farhad

create table users( -- create table
id int,
name varchar(50),
    email varchar(50),
    pass varchar(50)
)

-- Insert
insert into users (id,name,email,pass) values('18','frad','gg','hehe')
-- Truncate truncate table users  
-- drop drop table if exists users


-- DATA INTEGRITY
/*Data integrity in databases refers to the accuracy, completeness, and consistency
of the data stored in a database. It is a measure of the reliability and
trustworthiness of the data and ensures that the data in a database is protected
from errors, corruption, or unauthorized changes.
There are various methods used to ensure data integrity, including:
Constraints:
Constraints in databases are rules or conditions that must be met for data to be
inserted, updated, or deleted in a database table. They are used to enforce the
integrity of the data stored in a database and to prevent data from becoming
inconsistent or corrupted.
Transactions: a sequence of database operations that are treated as a single unit
of work.
Normalization: a design technique that minimizes data redundancy and ensures
data consistency by organizing data into separate tables.*/



-- COnstraints

/*Constraints in databases are rules or conditions that must be met for data to be
inserted, updated, or deleted in a database table. They are used to enforce the
integrity of the data stored in a database and to prevent data from becoming
inconsistent or corrupted.
1. NOT NULL
2. UNIQUE(combo)
-> Another way of creating constraint
3. PRIMARY KEY
4. AUTO INCREMENT
5. CHECK
6. DEFAULT
7. FOREIGN KEY
Referential Actions
1. RESTRICT
2. CASCADE
3. SET NULL
4. SET DEFAULT*/

--using contraints

CREATE TABLE us2(
   id int not null primary key AUTO_INCREMENT,
   name varchar(50) not null,
    email varchar(50) unique  ,
    pass varchar(50) not null,
    age int check(age >18 and age <25)
    date datetime default current_timestamp  -- 

  /*
  another way
  constraint hola unique(name,email)  name and email combination unique hobena
  constraint pk primary key(id)
  
  */
)

-- Foreign key
-- Departments table
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (dept_id)
);

-- Employees table with foreign key
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    PRIMARY KEY (emp_id),

    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Referencial action

-- Drop old tables if they exist
DROP TABLE IF EXISTS employees_restrict;
DROP TABLE IF EXISTS employees_cascade;
DROP TABLE IF EXISTS employees_setnull;
DROP TABLE IF EXISTS departments;

-- Parent table
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (dept_id)
);

-- Insert some departments
INSERT INTO departments (dept_name) VALUES ('HR'), ('IT');

-- Child table with RESTRICT
CREATE TABLE employees_restrict (
    emp_id INT AUTO_INCREMENT,
    emp_name VARCHAR(50),
    dept_id INT,
    PRIMARY KEY (emp_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE RESTRICT
);

-- Child table with CASCADE
CREATE TABLE employees_cascade (
    emp_id INT AUTO_INCREMENT,
    emp_name VARCHAR(50),
    dept_id INT,
    PRIMARY KEY (emp_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE CASCADE
);

-- Child table with SET NULL
CREATE TABLE employees_setnull (
    emp_id INT AUTO_INCREMENT,
    emp_name VARCHAR(50),
    dept_id INT NULL,
    PRIMARY KEY (emp_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE SET NULL
);

-- Insert employees
INSERT INTO employees_restrict (emp_name, dept_id) VALUES ('Alice', 1), ('Bob', 2);
INSERT INTO employees_cascade (emp_name, dept_id) VALUES ('Charlie', 1), ('David', 2);
INSERT INTO employees_setnull (emp_name, dept_id) VALUES ('Eve', 1), ('Frank', 2);


-- Try deleting HR department (dept_id = 1)
-- DELETE FROM departments WHERE dept_id = 1;
--
-- employees_restrict -> will block deletion 
-- employees_cascade  -> will delete Charlie automatically 
-- employees_setnull  -> will set Eve's dept_id to NULL 

/*
The "ALTER TABLE" statement in SQL is used to modify the structure of an
existing table. Some of the things that can be done using the ALTER TABLE
statement include

1. Add columns
2. Delete columns
3. Modify columns
*/

-- Drop table if exists
DROP TABLE IF EXISTS students;

-- 1️⃣ Create base table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);


INSERT INTO students (name) VALUES ('Alice'), ('Bob');

--  Add multiple columns at once
ALTER TABLE students
ADD COLUMN age INT,
ADD COLUMN email VARCHAR(100);

--  Add a column at the beginning
ALTER TABLE students
ADD COLUMN roll_no INT FIRST;

-- Add a column after a specific column
ALTER TABLE students
ADD COLUMN phone VARCHAR(20) AFTER age;

-- Modify multiple columns (change type)
ALTER TABLE students
MODIFY COLUMN age SMALLINT,
MODIFY COLUMN phone VARCHAR(25);

--  Rename a column
ALTER TABLE students
CHANGE COLUMN email student_email VARCHAR(120);

--  Drop multiple columns
ALTER TABLE students
DROP COLUMN phone,
DROP COLUMN student_email;


-- add,drop,edit constraint

-- Drop tables if they exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

--  Create parent table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    customer_name VARCHAR(50),
    PRIMARY KEY (customer_id)
);

--  Create child table without constraints
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- ADD CONSTRAINTS


-- Add primary key to orders
ALTER TABLE orders
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

-- Add foreign key to orders
ALTER TABLE orders
ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) 
REFERENCES customers(customer_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Add unique constraint
ALTER TABLE orders
ADD CONSTRAINT uq_customer_order UNIQUE (customer_id, order_date);

-- DELETE CONSTRAINTS


-- Drop foreign key
ALTER TABLE orders
DROP FOREIGN KEY fk_customer;

-- Drop primary key
ALTER TABLE orders
DROP PRIMARY KEY;

-- Drop unique constraint
ALTER TABLE orders
DROP INDEX uq_customer_order;


-- EDIT CONSTRAINTS (modify foreign key)


-- First, drop the old foreign key if exists
ALTER TABLE orders
DROP FOREIGN KEY fk_customer;

-- Then add a new foreign key with different rules
ALTER TABLE orders
ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE SET NULL
ON UPDATE CASCADE;









