SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS Bai2ss5;
CREATE DATABASE Bai2ss5;
USE Bai2ss5;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    city VARCHAR(255),
    status ENUM('active', 'inactive') NOT NULL
);
INSERT INTO customers (full_name, email, city, status) VALUES
('Nguyễn Văn An', 'an@gmail.com', 'TP.HCM', 'active'),
('Trần Thị Bình', 'binh@gmail.com', 'Hà Nội', 'active'),
('Lê Minh Cường', 'cuong@gmail.com', 'Đà Nẵng', 'inactive'),
('Phạm Thu Dung', 'dung@gmail.com', 'TP.HCM', 'inactive'),
('Hoàng Quốc Huy', 'huy@gmail.com', 'Hà Nội', 'active'),
('Vũ Thị Lan', 'lan@gmail.com', 'Cần Thơ', 'active');
SELECT * FROM customers;
SELECT * FROM customers WHERE city = 'TP.HCM';
SELECT * FROM customers WHERE status = 'active'AND city = 'Hà Nội';
SELECT * FROM customers ORDER BY full_name ASC;
SET SQL_SAFE_UPDATES = 1;