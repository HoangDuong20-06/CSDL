SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS Bai4ss5;
CREATE DATABASE Bai4ss5;
USE Bai4ss5;

-- Tạo bảng products (KHÔNG có status)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    sold_quantity INT NOT NULL
);

-- Thêm dữ liệu mẫu
INSERT INTO products (product_name, price, stock, sold_quantity) VALUES
('Laptop Dell', 15000000, 10, 120),
('Chuột Logitech', 350000, 80, 540),
('Bàn phím cơ', 1200000, 50, 320),
('Tai nghe Sony', 8500000, 15, 210),
('Màn hình LG', 4200000, 20, 180),
('USB Kingston', 180000, 200, 760),
('SSD Samsung 1TB', 2800000, 30, 410),
('Webcam Logitech', 950000, 25, 290),
('Loa Bluetooth JBL', 1600000, 40, 360),
('Sạc dự phòng Xiaomi', 650000, 70, 490),
('Tai nghe Gaming', 890000, 60, 275),
('Chuột Gaming', 450000, 90, 310);

SELECT *
FROM products
ORDER BY sold_quantity DESC
LIMIT 10;

SELECT *
FROM products
ORDER BY sold_quantity DESC
LIMIT 5 OFFSET 10;

SELECT *
FROM products
WHERE price < 2000000
ORDER BY sold_quantity DESC;
SET SQL_SAFE_UPDATES = 1;
