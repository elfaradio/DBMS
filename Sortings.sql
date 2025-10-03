create database proxyalam



-- Drop table if exists
DROP TABLE IF EXISTS phones;

-- Create table
CREATE TABLE phones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(50),
    model VARCHAR(50),
    screen_size DECIMAL(4,2),   -- in inches
    total_cameras INT,
    ppi INT,
    battery INT,                 -- in mAh
    rating DECIMAL(3,2),        -- out of 5
    price DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO phones (brand, model, screen_size, total_cameras, ppi, battery, rating, price) VALUES
('Samsung', 'Galaxy S20', 6.2, 4, 563, 4000, 4.5, 999),
('Samsung', 'Galaxy S21', 6.5, 4, 421, 4000, 4.6, 899),
('Samsung', 'Galaxy Note20', 6.7, 5, 393, 4300, 4.4, 1199),
('Apple', 'iPhone 12', 6.1, 2, 460, 2815, 4.3, 799),
('Apple', 'iPhone 12 Pro', 6.1, 3, 460, 2815, 4.0, 999),
('Apple', 'iPhone SE', 4.7, 1, 326, 1821, 3.5, 399),
('Xiaomi', 'Mi 11', 6.81, 5, 515, 4600, 4.2, 749),
('OnePlus', '9 Pro', 6.7, 4, 525, 4500, 4.4, 969);

--  Find the top 5 Samsung phones with the biggest screen size
SELECT * FROM phones
WHERE brand = 'Samsung'
ORDER BY screen_size DESC
LIMIT 5;

--  Sort all phones in descending order of the number of total cameras
SELECT * FROM phones
ORDER BY total_cameras DESC;

--  Sort data on the basis of PPI in decreasing order
SELECT * FROM phones
ORDER BY ppi DESC;

--  Find the phone with 2nd largest battery
SELECT * FROM phones
ORDER BY battery DESC
LIMIT 1 OFFSET 1;  -- skip the largest, get second largest

--  Find the name and rating of the worst rated Apple phone
SELECT model, rating FROM phones
WHERE brand = 'Apple'
ORDER BY rating ASC
LIMIT 1;

--  Sort phones alphabetically and then on the basis of rating in descending order
SELECT * FROM phones
ORDER BY brand ASC, rating DESC;

--  Sort phones alphabetically and then on the basis of price in ascending order
SELECT * FROM phones
ORDER BY brand ASC, price ASC;

-- order of execution

SELECT grade, COUNT(*) AS student_count
FROM students
WHERE age > 20
GROUP BY grade
HAVING COUNT(*) > 1
ORDER BY student_count DESC
LIMIT 3;

