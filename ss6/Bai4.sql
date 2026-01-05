SET SQL_SAFE_UPDATES = 0;
DROP DATABASE Bai4ss6;
CREATE DATABASE Bai4ss6;
USE Bai4ss6;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,

    FOREIGN KEY (product_id) 
        REFERENCES products(product_id)
);
INSERT INTO products (product_id, product_name, price) VALUES
(1, 'iPhone 15', 25000000),
(2, 'Samsung S23', 20000000),
(3, 'Xiaomi 13', 15000000),
(4, 'iPad Air', 18000000),
(5, 'AirPods Pro', 600000);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 2),
(102, 1, 1),
(103, 2, 3),
(104, 3, 4),
(105, 4, 2),
(106, 5, 1),
(107, 5, 0);
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi 
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;
SELECT 
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.quantity * p.price)) AS revenue
FROM products p
JOIN order_items oi 
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;
SELECT 
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.quantity * p.price)) AS revenue
FROM products p
JOIN order_items oi 
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * p.price) > 5000000;
SET SQL_SAFE_UPDATES = 1;