SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE Bai4ss7;
USE Bai4ss7;
CREATE TABLE Customers(
   id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(200),
   email VARCHAR(200)
);
CREATE TABLE Orders(
   id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
   customer_id INT,
   order_date DATE,
   total_amount DECIMAL(10,2)
);
INSERT INTO customers (name, email) VALUES
('Nguyen Van A', 'a@gmail.com'),
('Tran Thi B', 'b@gmail.com'),
('Le Van C', 'c@gmail.com'),
('Pham Thi D', 'd@gmail.com'),
('Hoang Van E', 'e@gmail.com'),
('Vu Thi F', 'f@gmail.com'),
('Do Van G', 'g@gmail.com');
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-01-01', 500000),
(2, '2025-01-02', 750000),
(1, '2025-01-03', 300000),
(3, '2025-01-04', 900000),
(5, '2025-01-05', 450000),
(2, '2025-01-06', 1200000),
(6, '2025-01-07', 650000);
SELECT name AS customers_name, ( 
  SELECT COUNT(*)
  FROM Orders
  WHERE Orders.customer_id = Customers.id
  ) AS total_orders
FROM Customers;
SET SQL_SAFE_UPDATES = 1;