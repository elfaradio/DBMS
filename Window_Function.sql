
CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51)




-- Aggregate Function with OVER()
-- Example #1: Avg marks of all students
SELECT name, branch, marks, AVG(marks) OVER(PARTITION BY branch) AS avg_marks_overall
FROM marks;

-- Example #2: Total marks in branch
SELECT name, branch, marks, SUM(marks) OVER(PARTITION BY branch) AS total_marks_branch
FROM marks;

-- Example #3: Max marks per branch
SELECT name, branch, marks, MAX(marks) OVER(PARTITION BY branch) AS max_marks_branch
FROM marks;



-- RANK(), DENSE_RANK(), ROW_NUMBER()
-- Rank students within each branch based on marks descending
SELECT 
    name, --- rank 90-1 90-1 89-3 
          --- dense_rank() 90-1 90-1 89-2
    branch,
    marks,
    RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS rank_in_branch,
    DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS dense_rank_in_branch,
    ROW_NUMBER() OVER(PARTITION BY branch ORDER BY marks DESC) AS row_number_in_branch
FROM marks;

/*  frame valo kore porte hobe*/

-- NTH_VALUE()
-- Get the 2nd highest marks in each branch

---ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING means first row to current row subgroup
SELECT
    name,
    branch,
    marks,
    NTH_VALUE(marks, 2) OVER(PARTITION BY branch ORDER BY marks DESC 
                              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS second_highest_branch
FROM marks;


-- FIRST_VALUE() and LAST_VALUE()
-- Find top and bottom marks in each branch
SELECT
    name,
    branch,
    marks,
    FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS first_marks_branch,
    LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC 
                          ) AS last_marks_branch
FROM marks;

-- LAG() and LEAD()
-- Previous and next marks within branch
SELECT
    name,
    branch,
    marks,
    LAG(marks,1) OVER(PARTITION BY branch ORDER BY marks DESC) AS previous_marks,
    LEAD(marks,1) OVER(PARTITION BY branch ORDER BY marks DESC) AS next_marks
FROM marks;
