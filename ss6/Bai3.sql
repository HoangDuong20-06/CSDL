SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS Bai3ss6;
CREATE DATABASE Bai3ss6;
USE Bai3ss6;
CREATE TABLE Customers (
    customer_id INT UNIQUE PRIMARY KEY,
    full_name VARCHAR(255),
    city VARCHAR(225)
);
CREATE TABLE Orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status ENUM('pending','completed','cancelled') NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyễn Văn An', 'Hà Nội'),
(2, 'Trần Thị Bình', 'Hồ Chí Minh'),
(3, 'Lê Văn Cường', 'Đà Nẵng'),
(4, 'Phạm Thị Dung', 'Hải Phòng'),
(5, 'Hoàng Văn Em', 'Cần Thơ');
INSERT INTO orders (order_id, customer_id, order_date, total_amount, status) VALUES
(101, 1, '2024-08-01', 1500000,  'completed'),
(102, 1, '2024-08-01', 800000,   'completed'),
(103, 2, '2024-08-02', 20300000, 'completed'),
(104, 3, '2024-08-03', 10200000, 'completed'),
(105, 3, '2024-08-03', 10800000, 'completed'),
(106, 5, '2024-08-04', 950000,   'completed');
SELECT
    order_date,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_date;
SELECT
    order_date,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date;
SELECT
    order_date,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_date
HAVING SUM(total_amount) > 10000000;
SET SQL_SAFE_UPDATES = 1;