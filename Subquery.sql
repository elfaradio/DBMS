-- Drop table if exists
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Create tables
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    experience INT
);

-- Insert sample data
INSERT INTO departments (dept_name) VALUES
('HR'),('IT'),('Sales');

INSERT INTO employees (name, dept_id, salary, experience) VALUES
('Alice', 1, 5000, 5),
('Bob', 2, 7000, 6),
('Charlie', 2, 6000, 3),
('David', 3, 5500, 4),
('Eve', 3, 7200, 7),
('Frank', 1, 4800, 2);


-- Scalar Subquery (returns a single value)

-- Example: Highest salary
SELECT name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);


-- Row Subquery (returns a row)

-- Example: Employee with salary and experience matching subquery
SELECT *
FROM employees
WHERE (salary, experience) = (SELECT salary, experience 
                              FROM employees 
                              WHERE name = 'Charlie');


-- Table Subquery (returns multiple rows & columns)

-- Example: Employees in departments that have more than 1 employee
SELECT *
FROM employees
WHERE dept_id IN (SELECT dept_id
                  FROM employees
                  GROUP BY dept_id
                  HAVING COUNT(*) > 1);

-- Correlated Subquery

-- Example: Employees earning more than the average salary of their department
SELECT e1.name, e1.salary, e1.dept_id
FROM employees e1
WHERE e1.salary > (SELECT AVG(e2.salary)
                   FROM employees e2
                   WHERE e2.dept_id = e1.dept_id);

-- Subquery in SELECT

-- Example: Show employee name and department name
SELECT name, 
       (SELECT dept_name 
        FROM departments 
        WHERE dept_id = employees.dept_id) AS department
FROM employees;


-- Subquery in FROM
-- Example: Average salary per department
SELECT dept_id, AVG(salary) AS avg_salary
FROM (SELECT * FROM employees) AS sub
GROUP BY dept_id;

-- Subquery in HAVING

-- Example: Departments with avg salary above overall avg
SELECT dept_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

-- Subquery in INSERT

-- Example: Insert employee(s) into a new table based on subquery
DROP TABLE IF EXISTS high_salary_employees;
CREATE TABLE high_salary_employees AS
SELECT * 
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


-- Subquery in UPDATE

-- Example: Give a 10% raise to employees earning below department average
UPDATE employees e1
SET salary = salary * 1.1
WHERE salary < (SELECT AVG(salary)
                FROM employees e2
                WHERE e2.dept_id = e1.dept_id);


-- Subquery in DELETE

-- Example: Delete employees with salary below overall average
DELETE FROM employees
WHERE salary < (SELECT AVG(salary) FROM (SELECT salary FROM employees) AS temp);


