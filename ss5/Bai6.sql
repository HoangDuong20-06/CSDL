SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS Bai6ss5;
CREATE DATABASE Bai6ss5;
USE Bai6ss5;
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    status ENUM('active', 'inactive') NOT NULL
);
INSERT INTO products (product_name, price, stock, status) VALUES
('Laptop Dell', 15000000, 10, 'active'),
('Chuột Logitech', 350000, 80, 'active'),
('Bàn phím cơ', 1200000, 50, 'active'),
('Tai nghe Sony', 2500000, 15, 'active'),
('Màn hình LG', 2800000, 20, 'active'),
('USB Kingston', 180000, 200, 'active'),
('SSD Samsung 512GB', 2200000, 30, 'active'),
('Webcam Logitech', 1900000, 25, 'active'),
('Loa Bluetooth JBL', 1600000, 40, 'active'),
('Sạc dự phòng Xiaomi', 1300000, 70, 'active'),

('Tai nghe Gaming', 1100000, 60, 'active'),
('Chuột Gaming', 1400000, 90, 'active'),
('Bàn phím văn phòng', 1000000, 100, 'active'),
('Ổ cứng HDD 1TB', 3000000, 35, 'active'),
('Tai nghe Bluetooth', 2700000, 45, 'active'),
('Laptop HP', 14000000, 8, 'inactive'),
('Chuột cũ', 500000, 20, 'inactive'),
('Loa mini', 900000, 30, 'inactive');
SELECT *
FROM products
WHERE status = 'active'
  AND price BETWEEN 1000000 AND 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 0;
SELECT *
FROM products
WHERE status = 'active'
  AND price BETWEEN 1000000 AND 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 10;
SET SQL_SAFE_UPDATES = 1;