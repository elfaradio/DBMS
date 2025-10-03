create database ifty_cp_kore


  /*
insert into us2 values(1,....),(2.....),(3....) for multiple row
  
  */

-- Drop table if exists
DROP TABLE IF EXISTS students;

-- Create table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

-- Basic INSERT
INSERT INTO students (name, age, email)
VALUES ('Alice', 20, 'alice@example.com');

--  INSERT variation: specify only some columns
INSERT INTO students (name, age)
VALUES ('Bob', 22);  -- email will be NULL

--  INSERT multiple rows in a single query
INSERT INTO students (name, age, email)
VALUES 
('Charlie', 21, 'charlie@example.com'),
('David', 23, 'david@example.com'),
('Eve', 20, 'eve@example.com');

--  INSERT using SELECT (insert from another table)

DROP TABLE IF EXISTS students_backup;

CREATE TABLE students_backup LIKE students;

-- Copy all data from students to students_backup
INSERT INTO students_backup (name, age, email)
SELECT name, age, email FROM students;




--Select query

select * from us2 
select id,name from us2
select name as 'Full_name' from us2 --alias
select id*age as hola from us2 -- * operator
select distinct id,age from us2 --- id-age combination


-- Drop table if exists
DROP TABLE IF EXISTS students;

-- Create table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    grade CHAR(1),
    city VARCHAR(50)
);

-- Insert sample data
INSERT INTO students (name, age, grade, city) VALUES
('Alice', 20, 'A', 'Dhaka'),
('Bob', 22, 'B', 'Chittagong'),
('Charlie', 21, 'A', 'Dhaka'),
('David', 23, 'C', 'Sylhet'),
('Eve', 20, 'B', 'Dhaka'),
('Frank', 22, 'A', 'Chittagong');

--  SELECT all columns
SELECT * FROM students;

--  SELECT specific columns
SELECT name, age FROM students;

--  Alias / Rename columns
SELECT name AS student_name, age AS student_age FROM students;

--  Create expression using columns
SELECT name, age, age + 1 AS next_year_age FROM students;

--  Constant value in SELECT
SELECT name, 'Bangladesh' AS country FROM students;

--  DISTINCT values from a column
SELECT DISTINCT grade FROM students;

--  DISTINCT combinations
SELECT DISTINCT grade, city FROM students;

--  Filter rows using WHERE clause
SELECT * FROM students WHERE age > 21;

-- Operator examples
-- Example 1: equality
SELECT * FROM students WHERE grade = 'A';

-- Example 2: BETWEEN
SELECT * FROM students WHERE age BETWEEN 21 AND 23;

-- Example 3: comparison
SELECT * FROM students WHERE age >= 22 AND grade = 'B';

-- Example 4: LIKE operator
SELECT * FROM students WHERE name LIKE 'A%';

-- Example 5: NOT equal
SELECT * FROM students WHERE grade <> 'C';

-- Example 6: AND / OR operators
SELECT * FROM students WHERE city = 'Dhaka' AND grade = 'A';

-- IN and NOT IN
SELECT * FROM students WHERE city IN ('Dhaka', 'Sylhet');
SELECT * FROM students WHERE city NOT IN ('Chittagong');

-- Update query

--  Update single column
-- Update Alice's age to 21
UPDATE students
SET age = 21
WHERE name = 'Alice';

--  Update multiple columns
-- Update Bob's age and city
UPDATE students
SET age = 23, city = 'Dhaka'
WHERE name = 'Bob';

--  Update all rows
-- Increase everyone's age by 1
UPDATE students
SET age = age + 1;


-- delete

--  Delete a single row
-- Delete student named 'David'
DELETE FROM students
WHERE name = 'David';

--  Delete rows based on multiple conditions
-- Delete students aged 21 in Dhaka
DELETE FROM students
WHERE age = 21 AND city = 'Dhaka';



-- FUnctions


-- Drop table if exists
DROP TABLE IF EXISTS students;

-- Create table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    grade CHAR(1),
    marks DECIMAL(5,2)
);

-- Insert sample data
INSERT INTO students (name, age, grade, marks) VALUES
('Alice', 21, 'A', 85.5),
('Bob', 23, 'B', 72.3),
('Charlie', 22, 'A', 90.0),
('David', 24, 'C', 68.7),
('Eve', 21, 'B', 79.4);

-- AGGREGATE FUNCTIONS


--  MAX() & MIN()
SELECT MAX(marks) AS highest_marks, MIN(marks) AS lowest_marks FROM students;

--  AVG()
SELECT AVG(marks) AS average_marks FROM students;

--  SUM()
SELECT SUM(marks) AS total_marks FROM students;

--  COUNT()
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(grade) AS grade_count FROM students;

--  STD() & VARIANCE()
SELECT STD(marks) AS std_dev_marks, VARIANCE(marks) AS variance_marks FROM students;


-- SCALAR FUNCTIONS


--  ABS() - absolute value
SELECT marks, ABS(marks - 75) AS diff_from_75 FROM students;

--  ROUND() - round to nearest integer
SELECT marks, ROUND(marks) AS rounded_marks, ROUND(marks, 1) AS rounded_one_decimal FROM students;

--  CEIL() & FLOOR() - ceiling and floor
SELECT marks, CEIL(marks) AS ceil_marks, FLOOR(marks) AS floor_marks FROM students;





