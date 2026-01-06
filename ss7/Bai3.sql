SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE Bai3ss7;
USE Bai3ss7;
CREATE TABLE Orders(
   id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
   customer_id INT,
   order_date DATE,
   total_amount DECIMAL(10,0) 
);
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-01-01', 500000),
(2, '2025-01-02', 1200000),
(3, '2025-01-03', 800000),
(4, '2025-01-04', 2000000),
(5, '2025-01-05', 600000);
SELECT * FROM orders WHERE total_amount > ( SELECT AVG(total_amount) FROM orders);
SET SQL_SAFE_UPDATES = 1;