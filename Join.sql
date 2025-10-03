-- Drop tables if they exist
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS category;

-- Create Users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50)
);

-- Create Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    profit DECIMAL(10,2)
);

-- Create Category table
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50)
);

-- Create Order_Details table
CREATE TABLE order_details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    category_id INT,
    amount DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO users (name, city, state) VALUES
('Alice','Pune','Maharashtra'),
('Bob','Mumbai','Maharashtra'),
('Charlie','Bangalore','Karnataka');

INSERT INTO orders (user_id, order_date, profit) VALUES
(1,'2025-09-01',2000),
(1,'2025-09-03',1500),
(2,'2025-09-05',3000),
(3,'2025-09-07',500);

INSERT INTO category (category_name) VALUES
('Chairs'),
('Tables'),
('Electronics');

INSERT INTO order_details (order_id, category_id, amount) VALUES
(1,1,500),
(1,2,1500),
(2,1,1500),
(3,3,3000),
(4,2,500);


-- CROSS JOIN (Cartesian Product)

SELECT u.name, c.category_name
FROM users u
CROSS JOIN category c;


-- INNER JOIN

SELECT o.order_id, u.name, u.city
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id;


-- LEFT JOIN

SELECT u.name, o.order_id, o.profit
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id;


-- RIGHT JOIN

SELECT u.name, o.order_id, o.profit
FROM users u
RIGHT JOIN orders o ON u.user_id = o.user_id;

-- FULL OUTER JOIN (simulate in MySQL using UNION)

SELECT u.name, o.order_id
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
UNION
SELECT u.name, o.order_id
FROM users u
RIGHT JOIN orders o ON u.user_id = o.user_id;


-- SELF JOIN
-- Example: find pairs of users from same city

SELECT a.name AS user1, b.name AS user2, a.city
FROM users a
INNER JOIN users b ON a.city = b.city AND a.user_id < b.user_id;


-- Join on multiple columns
-- Example: join orders and order_details

SELECT o.order_id, od.amount, c.category_name
FROM orders o
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN category c ON od.category_id = c.category_id;


-- Filtering Columns & Rows

-- 1. order_id, name, city by joining users and orders
SELECT o.order_id, u.name, u.city
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id;

-- 2. order_id and product category
SELECT od.order_id, c.category_name
FROM order_details od
INNER JOIN category c ON od.category_id = c.category_id;

-- 3. All orders placed in Pune
SELECT o.order_id, u.name, u.city
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
WHERE u.city = 'Pune';

-- 4. All orders under the Chairs category
SELECT o.order_id, c.category_name
FROM orders o
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN category c ON od.category_id = c.category_id
WHERE c.category_name = 'Chairs';


-- Practice Questions

-- 1. Find all profitable orders (profit > 0)
SELECT * FROM orders WHERE profit > 0;

-- 2. Customer who placed max number of orders
SELECT u.name, COUNT(*) AS num_orders
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id
ORDER BY num_orders DESC
LIMIT 1;

-- 3. Most profitable category
SELECT c.category_name, SUM(od.amount) AS total_amount
FROM order_details od
INNER JOIN category c ON od.category_id = c.category_id
GROUP BY c.category_id
ORDER BY total_amount DESC
LIMIT 1;

-- 4. Most profitable state
SELECT u.state, SUM(o.profit) AS total_profit
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
GROUP BY u.state
ORDER BY total_profit DESC
LIMIT 1;

-- 5. Categories with profits higher than 5000
SELECT c.category_name, SUM(od.amount) AS total_amount
FROM order_details od
INNER JOIN category c ON od.category_id = c.category_id
GROUP BY c.category_id
HAVING SUM(od.amount) > 5000;
