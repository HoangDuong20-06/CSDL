SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE Bai5ss6;
USE Bai5ss6;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(12,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
INSERT INTO customers VALUES
(1, 'Nguyen Van A'),
(2, 'Tran Thi B'),
(3, 'Le Van C'),
(4, 'Pham Thi D'),
(5, 'Hoang Van E');

INSERT INTO orders VALUES
(101, 1, 3000000),
(102, 1, 4000000),
(103, 1, 5000000),

(104, 2, 2000000),
(105, 2, 2500000),

(106, 3, 6000000),
(107, 3, 5500000),
(108, 3, 5000000),

(109, 4, 1000000),

(110, 5, 4000000),
(111, 5, 4500000),
(112, 5, 3000000);
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount)) AS total_spent,
    ROUND(AVG(o.total_amount)) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING
    COUNT(o.order_id) >= 3
    AND SUM(o.total_amount) > 10000000
ORDER BY total_spent DESC;
SET SQL_SAFE_UPDATES = 1;