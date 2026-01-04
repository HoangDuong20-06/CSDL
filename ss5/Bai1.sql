SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS Bai1ss5;
CREATE DATABASE Bai1ss5;
USE Bai1ss5;
CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    status ENUM('active', 'inactive') NOT NULL
);
INSERT INTO Product (product_name, price, stock, status) VALUES
('Laptop Dell Inspiron', 15000000, 10, 'active'),
('Chuột Logitech M331', 350000, 50, 'active'),
('Bàn phím cơ DareU', 1200000, 30, 'active'),
('Tai nghe Sony WH-1000XM5', 8500000, 5, 'inactive'),
('Màn hình LG 24 inch', 4200000, 15, 'active'),
('USB Kingston 64GB', 180000, 100, 'active'),
('Ổ cứng SSD Samsung 1TB', 2800000, 20, 'inactive');

SELECT * FROM Product;
SELECT * FROM Product
WHERE status = 'active';
SELECT * FROM Product
WHERE price > 1000000;
SELECT * FROM Product WHERE status = 'active'
ORDER BY price ASC;
SET SQL_SAFE_UPDATES = 1;