SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE Bai2ss7;
USE Bai2ss7;
CREATE TABLE Products(
   id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(200),
   price DECIMAL(10,0)
);
CREATE TABLE Orders_items(
   order_id INT ,
   product_id INT,
   quantity INT
);
INSERT INTO Products (name, price) VALUES
('Laptop', 15000000),
('Chuột', 300000),
('Bàn phím', 700000),
('Tai nghe', 500000),
('Màn hình', 3500000),
('USB', 200000),
('Ổ cứng', 2500000);
INSERT INTO Orders_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(2, 5, 1),
(3, 1, 1),
(3, 4, 2),
(4, 6, 3);
SELECT *
FROM Products
WHERE id IN (
    SELECT product_id FROM Orders_items
);
SET SQL_SAFE_UPDATES = 1;