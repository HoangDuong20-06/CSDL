SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE Bai5ss7;
USE Bai5ss7;
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);
INSERT INTO customers VALUES
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com'),
(5, 'Hoang Van E', 'e@gmail.com');
INSERT INTO orders VALUES
(1, 1, '2024-01-01', 500000),
(2, 1, '2024-01-05', 700000),
(3, 2, '2024-01-03', 1200000),
(4, 3, '2024-01-10', 300000),
(5, 3, '2024-01-15', 400000),
(6, 4, '2024-01-20', 2000000),
(7, 5, '2024-01-25', 800000);
SELECT *
FROM customers
WHERE id = (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) = (
        SELECT MAX(total_spent)
        FROM (
            SELECT SUM(total_amount) AS total_spent
            FROM orders
            GROUP BY customer_id
        ) AS temp
    )
);
SET SQL_SAFE_UPDATES = 1;