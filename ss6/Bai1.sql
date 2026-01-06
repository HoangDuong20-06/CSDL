SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS Bai1ss6;
CREATE DATABASE Bai1ss6;
USE Bai1ss6;
CREATE TABLE Customers (
      customer_id INT UNIQUE PRIMARY KEY,
      full_name VARCHAR(255),
      city VARCHAR(225)
);
CREATE TABLE Orders (
      customer_id INT,
      order_id INT,
      order_date DATE,
      status ENUM("pending","completed","cancelled") NOT NULL,
      FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyễn Văn An', 'Hà Nội'),
(2, 'Trần Thị Bình', 'Hồ Chí Minh'),
(3, 'Lê Văn Cường', 'Đà Nẵng'),
(4, 'Phạm Thị Dung', 'Hải Phòng'),
(5, 'Hoàng Văn Em', 'Cần Thơ');
INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(101, 1, '2024-08-01', 'completed'),
(102, 1, '2024-08-03', 'pending'),
(103, 2, '2024-08-02', 'completed'),
(104, 3, '2024-08-04', 'cancelled'),
(105, 3, '2024-08-05', 'completed'),
(106, 5, '2024-08-06', 'pending');
SELECT 
    o.order_id,
    c.full_name,
    o.order_date,
    o.status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;
SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;
SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 1;
SET SQL_SAFE_UPDATES = 1;