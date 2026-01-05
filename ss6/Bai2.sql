SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS Bai2ss6;
CREATE DATABASE Bai2ss6;
USE Bai2ss6;
CREATE TABLE Customers (
      customer_id INT UNIQUE,
      full_name VARCHAR(255),
      city VARCHAR(225)
);
CREATE TABLE Orders (
      customer_id INT,
      order_id INT,
      order_date DATE,
      total_amount DECIMAL(10,2),
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
(102, 1, '2024-08-03', 'completed'),
(103, 2, '2024-08-02', 'completed'),
(104, 3, '2024-08-04', 'completed'),
(105, 3, '2024-08-05', 'completed'),
(106, 5, '2024-08-06', 'completed');
UPDATE orders SET total_amount = 1500000 WHERE order_id = 101;
UPDATE orders SET total_amount = 800000  WHERE order_id = 102;
UPDATE orders SET total_amount = 2300000 WHERE order_id = 103;
UPDATE orders SET total_amount = 1200000 WHERE order_id = 104;
UPDATE orders SET total_amount = 1800000 WHERE order_id = 105;
UPDATE orders SET total_amount = 950000  WHERE order_id = 106;
SELECT
    c.customer_id,
    c.full_name,
    ROUND(SUM(o.total_amount)) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.full_name;
SELECT
    c.customer_id,
    c.full_name,
    ROUND(MAX(o.total_amount)) AS max_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;
SELECT
    c.customer_id,
    c.full_name,
    ROUND(SUM(o.total_amount)) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC;
SET SQL_SAFE_UPDATES = 1;