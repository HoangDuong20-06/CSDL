SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS Bai3ss5;
CREATE DATABASE Bai3ss5;
USE Bai3ss5;
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('pending', 'completed', 'cancelled') NOT NULL
);
INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
(1, 3200000, '2024-08-01', 'completed'),
(2, 7800000, '2024-08-03', 'completed'),
(3, 1500000, '2024-08-05', 'pending'),
(4, 9200000, '2024-08-06', 'completed'),
(2, 4500000, '2024-08-07', 'cancelled'),
(5, 12000000, '2024-08-08', 'completed'),
(1, 2600000, '2024-08-09', 'pending');
SELECT * FROM orders WHERE status = 'completed';
SELECT * FROM orders WHERE total_amount > 5000000;
SELECT * FROM orders ORDER BY order_date DESC LIMIT 5;
SELECT * FROM orders WHERE status = 'completed'ORDER BY total_amount DESC;
SET SQL_SAFE_UPDATES = 1;