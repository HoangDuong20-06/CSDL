SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE Bai6ss6;
USE Bai6ss6;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(12,2)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
INSERT INTO products VALUES
(1, 'iPhone 15', 25000000),
(2, 'Samsung S23', 20000000),
(3, 'Xiaomi 13', 15000000),
(4, 'iPad Air', 18000000),
(5, 'AirPods Pro', 6000000),
(6, 'Apple Watch', 9000000);
INSERT INTO order_items VALUES
(101, 1, 3),
(102, 1, 4),
(103, 1, 5),
(104, 2, 4),
(105, 2, 6),
(106, 3, 5),
(107, 3, 6),
(108, 4, 2),
(109, 4, 3),
(110, 4, 5),
(111, 5, 6),
(112, 5, 5),
(113, 6, 4),
(114, 6, 7);
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.quantity * p.price)) AS total_revenue,
    ROUND(AVG(p.price)) AS avg_price
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) >= 10
ORDER BY total_revenue DESC
LIMIT 5;
SET SQL_SAFE_UPDATES = 1;