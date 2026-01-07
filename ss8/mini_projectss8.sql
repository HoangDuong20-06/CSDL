SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS mini_projectss8;
CREATE DATABASE mini_projectss8;
USE mini_projectss8;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending','Completed','Cancel') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers (customer_name, email, phone) VALUES
('Nguyen Van A','a@gmail.com','0900000001'),
('Tran Thi B','b@gmail.com','0900000002'),
('Le Van C','c@gmail.com','0900000003');

INSERT INTO categories (category_name) VALUES
('Dien thoai'),
('Laptop'),
('Phu kien');

INSERT INTO products (product_name, price, category_id) VALUES
('iPhone 15',25000000,1),
('Samsung S23',20000000,1),
('Macbook Air M2',30000000,2),
('Dell XPS 13',28000000,2),
('Tai nghe Bluetooth',2000000,3),
('Chuot khong day',1000000,3),
('Ban phim co',1500000,3);

INSERT INTO orders (customer_id, status) VALUES
(1,'Completed'),
(1,'Completed'),
(2,'Pending'),
(3,'Completed');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1,1,1),
(1,5,2),
(2,2,1),
(2,6,1),
(3,3,1),
(4,4,1),
(4,7,2);

SELECT * FROM categories;
SELECT * 
FROM orders
WHERE status = 'Completed';
SELECT * 
FROM products
ORDER BY price DESC;
SELECT * 
FROM products
ORDER BY price DESC
LIMIT 5 OFFSET 2;
SELECT p.product_id, p.product_name, p.price, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;
SELECT o.order_id, o.order_date, c.customer_name, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
SELECT order_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY order_id;
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2;
SELECT c.category_name,
       AVG(p.price) AS avg_price,
       MIN(p.price) AS min_price,
       MAX(p.price) AS max_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM orders
);
SELECT order_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY order_id
ORDER BY total_quantity DESC
LIMIT 1;
SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.category_id = (
    SELECT category_id
    FROM products
    GROUP BY category_id
    ORDER BY AVG(price) DESC
    LIMIT 1
);
SELECT customer_id, SUM(total_quantity) AS total_products
FROM (
    SELECT o.customer_id, SUM(oi.quantity) AS total_quantity
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.customer_id
) AS temp
GROUP BY customer_id;
SELECT *
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);
SET SQL_SAFE_UPDATES = 1;