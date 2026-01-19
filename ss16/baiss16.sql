DROP DATABASE IF EXISTS quanlybanhang;
CREATE DATABASE quanlybanhang;
USE quanlybanhang;
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(255),
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    category VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    revenue DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers (customer_name, phone, address, email) VALUES
('Nguyễn Văn An', '0901234567', 'Hà Nội', 'an@gmail.com'),
('Trần Thị Bình', '0912345678', 'TP HCM', 'binh@gmail.com'),
('Lê Văn Cường', '0923456789', 'Đà Nẵng', 'cuong@gmail.com'),
('Phạm Thị Dung', '0934567890', 'Hải Phòng', 'dung@gmail.com'),
('Hoàng Văn Em', '0945678901', 'Cần Thơ', 'em@gmail.com');
INSERT INTO Products (product_name, price, quantity, category) VALUES
('Laptop Dell', 15000000, 10, 'Điện tử'),
('Chuột Logitech', 500000, 50, 'Phụ kiện'),
('Bàn phím cơ', 1200000, 30, 'Phụ kiện'),
('Tai nghe Sony', 2000000, 20, 'Âm thanh'),
('Màn hình LG', 4500000, 15, 'Điện tử');
INSERT INTO Employees (employee_name, position, salary, revenue) VALUES
('Nguyễn Văn Minh', 'Nhân viên bán hàng', 8000000, 0),
('Trần Thị Hoa', 'Nhân viên bán hàng', 8500000, 0),
('Lê Văn Nam', 'Quản lý', 15000000, 0),
('Phạm Thị Lan', 'Thu ngân', 7000000, 0),
('Hoàng Văn Long', 'Nhân viên kho', 7500000, 0);
INSERT INTO Orders (customer_id, employee_id, total_amount) VALUES
(1, 1, 15500000),
(2, 2, 2500000),
(3, 1, 6200000),
(4, 3, 4500000),
(5, 2, 2000000);
INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 15000000),
(1, 2, 1, 500000),
(2, 4, 1, 2000000),
(2, 2, 1, 500000),
(3, 5, 1, 4500000);
SELECT * FROM Customers;
UPDATE Products
SET product_name= "Laptop Dell XPS",price = 99.99
WHERE product_id = 1 ;
SELECT * FROM Products;
SELECT 
    o.order_id,
    c.customer_name,
    e.employee_name,
    FORMAT(o.total_amount, 0) AS total_amount,
    o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Employees e ON o.employee_id = e.employee_id;
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
SELECT 
    e.employee_id,
    e.employee_name,
    FORMAT(SUM(o.total_amount), 0) AS revenue
FROM Employees e
JOIN Orders o ON e.employee_id = o.employee_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY e.employee_id, e.employee_name;
SELECT 
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_quantity
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
WHERE MONTH(o.order_date) = MONTH(CURDATE())
  AND YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY p.product_id, p.product_name
HAVING SUM(od.quantity) > 100
ORDER BY total_quantity DESC;
SELECT 
    c.customer_id,
    c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
SELECT 
    product_id,
    product_name,
    FORMAT(price, 0) AS price
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);
SELECT 
    c.customer_id,
    c.customer_name,
    FORMAT(SUM(o.total_amount), 0) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(total_spent)
    FROM (
        SELECT SUM(total_amount) AS total_spent
        FROM Orders
        GROUP BY customer_id
    ) t
);
CREATE VIEW view_order_list AS
SELECT 
    o.order_id,
    c.customer_name,
    e.employee_name,
    o.total_amount,
    o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date DESC;
CREATE VIEW view_order_detail_product AS
SELECT 
    od.order_detail_id,
    p.product_name,
    od.quantity,
    od.unit_price
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
ORDER BY od.quantity DESC;
DELIMITER $$

CREATE PROCEDURE proc_insert_employee(
    IN p_name VARCHAR(100),
    IN p_position VARCHAR(50),
    IN p_salary DECIMAL(10,2),
    OUT new_employee_id INT
)
BEGIN
    INSERT INTO Employees (employee_name, position, salary)
    VALUES (p_name, p_position, p_salary);

    SET new_employee_id = LAST_INSERT_ID();
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE proc_get_orderdetails(IN p_order_id INT)
BEGIN
    SELECT *
    FROM OrderDetails
    WHERE order_id = p_order_id;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE proc_cal_total_amount_by_order(
    IN p_order_id INT,
    OUT total_products INT
)
BEGIN
    SELECT COUNT(DISTINCT product_id)
    INTO total_products
    FROM OrderDetails
    WHERE order_id = p_order_id;
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER trigger_after_insert_order_details
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE stock INT;

    SELECT quantity INTO stock
    FROM Products
    WHERE product_id = NEW.product_id;

    IF stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng sản phẩm trong kho không đủ';
    ELSE
        UPDATE Products
        SET quantity = quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE proc_insert_order_details(
    IN p_order_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_unit_price DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO OrderDetails(order_id, product_id, quantity, unit_price)
    VALUES (p_order_id, p_product_id, p_quantity, p_unit_price);

    UPDATE Orders
    SET total_amount = total_amount + (p_quantity * p_unit_price)
    WHERE order_id = p_order_id;

    COMMIT;
END $$

DELIMITER ;
