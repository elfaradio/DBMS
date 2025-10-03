-- Drop table if exists
DROP TABLE IF EXISTS smartphones;

-- Create table
CREATE TABLE smartphones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(50),
    model VARCHAR(50),
    price DECIMAL(10,2),
    rating DECIMAL(3,2),
    nfc BOOLEAN,
    is_5g BOOLEAN,
    fast_charging BOOLEAN,
    extended_memory BOOLEAN,
    processor_brand VARCHAR(50),
    primary_camera INT,   -- rear camera resolution in MP
    screen_size DECIMAL(4,2),
    ir_blaster BOOLEAN,
    ram INT,
    refresh_rate INT      -- in Hz
);

-- Insert sample data
INSERT INTO smartphones (brand, model, price, rating, nfc, is_5g, fast_charging, extended_memory, processor_brand, primary_camera, screen_size, ir_blaster, ram, refresh_rate) VALUES
('Samsung','Galaxy S21',899,4.5,TRUE,TRUE,TRUE,FALSE,'Exynos',64,6.5,FALSE,8,120),
('Samsung','Galaxy S20',999,4.6,TRUE,TRUE,TRUE,FALSE,'Exynos',64,6.2,FALSE,8,120),
('Apple','iPhone 12',799,4.3,FALSE,TRUE,TRUE,FALSE,'Apple',12,6.1,FALSE,4,60),
('Apple','iPhone SE',399,3.5,FALSE,FALSE,FALSE,FALSE,'Apple',12,4.7,FALSE,3,60),
('Xiaomi','Mi 11',749,4.2,TRUE,TRUE,TRUE,TRUE,'Snapdragon',108,6.8,FALSE,8,120),
('OnePlus','9 Pro',969,4.4,TRUE,TRUE,TRUE,FALSE,'Snapdragon',48,6.7,FALSE,12,120),
('Samsung','Galaxy Note20',1199,4.4,TRUE,TRUE,TRUE,FALSE,'Exynos',108,6.7,FALSE,12,120),
('OnePlus','Nord 2',399,4.0,FALSE,TRUE,TRUE,FALSE,'MediaTek',50,6.4,FALSE,8,90),
('Xiaomi','Redmi Note 10',199,3.8,FALSE,FALSE,TRUE,TRUE,'MediaTek',48,6.5,FALSE,6,60),
('Samsung','Galaxy A12',179,3.9,FALSE,FALSE,FALSE,TRUE,'Exynos',48,6.5,TRUE,4,60);

--  Group smartphones by NFC and get avg price & rating
SELECT nfc, AVG(price) AS avg_price, AVG(rating) AS avg_rating
FROM smartphones
GROUP BY nfc;

-- Avg price of 5G vs non-5G phones
SELECT is_5g, AVG(price) AS avg_price
FROM smartphones
GROUP BY is_5g;

--  Group by fast charging availability
SELECT fast_charging, AVG(price) AS avg_price
FROM smartphones
GROUP BY fast_charging;

--  Group by extended memory availability
SELECT extended_memory, AVG(price) AS avg_price
FROM smartphones
GROUP BY extended_memory;

--  Group by multiple columns: brand & processor, count models & avg primary camera
SELECT brand, processor_brand, COUNT(*) AS num_models, AVG(primary_camera) AS avg_camera
FROM smartphones
GROUP BY brand, processor_brand;

--  Top 5 most costly phone brands
SELECT brand, AVG(price) AS avg_price
FROM smartphones
GROUP BY brand
ORDER BY avg_price DESC
LIMIT 5;

--  Brand with smallest-screen smartphones
SELECT brand, MIN(screen_size) AS smallest_screen
FROM smartphones
GROUP BY brand
ORDER BY smallest_screen ASC
LIMIT 1;

-- Brand with highest number of models having both NFC & IR blaster
SELECT brand, COUNT(*) AS num_models
FROM smartphones
WHERE nfc = TRUE AND ir_blaster = TRUE
GROUP BY brand
ORDER BY num_models DESC
LIMIT 1;

--  Samsung 5G phones: avg price for NFC and non-NFC
SELECT nfc, AVG(price) AS avg_price
FROM smartphones
WHERE brand = 'Samsung' AND is_5g = TRUE
GROUP BY nfc;

-- COUNT(*) example
SELECT brand, COUNT(*) AS num_phones
FROM smartphones
GROUP BY brand;

--  HAVING clause examples

-- Costliest brand with at least 2 phones (adjust number based on sample)
SELECT brand, AVG(price) AS avg_price, COUNT(*) AS num_phones
FROM smartphones
GROUP BY brand
HAVING COUNT(*) >= 2
ORDER BY avg_price DESC
LIMIT 1;

-- Avg rating of brands with more than 2 phones
SELECT brand, AVG(rating) AS avg_rating, COUNT(*) AS num_phones
FROM smartphones
GROUP BY brand
HAVING COUNT(*) > 2;

-- Top 3 brands with highest avg RAM, refresh_rate >=90Hz, fast charging TRUE, brands wi_
SELECT brand, AVG(ram) AS avg_ram, COUNT(*) AS num_phones
FROM smartphones
WHERE refresh_rate >= 90 AND fast_charging = TRUE
GROUP BY brand
HAVING COUNT(*) >= 2
ORDER BY avg_ram DESC
LIMIT 3;

-- Avg price of 5G-enabled phones with avg rating >= 4.0 and num_phones > 1 per brand
SELECT brand, AVG(price) AS avg_price, AVG(rating) AS avg_rating, COUNT(*) AS num_phones
FROM smartphones
WHERE is_5g = TRUE
GROUP BY brand
HAVING AVG(rating) >= 4.0 AND COUNT(*) > 1
