SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS mini_project_ss08;
CREATE DATABASE mini_project_ss08;
USE mini_project_ss08;

-- Xóa bảng nếu đã tồn tại (để chạy lại nhiều lần)
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

-- Bảng khách hàng
CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Bảng phòng
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10,0)
);

-- Bảng đặt phòng
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO guests (guest_name, phone) VALUES
('Nguyễn Văn An', '0901111111'),
('Trần Thị Bình', '0902222222'),
('Lê Văn Cường', '0903333333'),
('Phạm Thị Dung', '0904444444'),
('Hoàng Văn Em', '0905555555');

INSERT INTO rooms (room_type, price_per_day) VALUES
('Standard', 500000),
('Standard', 500000),
('Deluxe', 800000),
('Deluxe', 800000),
('VIP', 1500000),
('VIP', 2000000);

INSERT INTO bookings (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2024-01-10', '2024-01-12'), -- 2 ngày
(1, 3, '2024-03-05', '2024-03-10'), -- 5 ngày
(2, 2, '2024-02-01', '2024-02-03'), -- 2 ngày
(2, 5, '2024-04-15', '2024-04-18'), -- 3 ngày
(3, 4, '2023-12-20', '2023-12-25'), -- 5 ngày
(3, 6, '2024-05-01', '2024-05-06'), -- 5 ngày
(4, 1, '2024-06-10', '2024-06-11'); -- 1 ngày
-- Phân truy vấn cơ bản
-- Liệt kê danh sách khách hàng và thông tin khách hàng
SELECT * FROM guests;
-- Liệt kê danh sách các loại phòng
SELECT room_type FROM rooms;
-- Liệt kê danh sách các phòng và sắp xếp theo giá tăng dần
SELECT * FROM rooms ORDER BY price_per_day ASC;
-- Liệt kê các phòng có giá lớn hơn 1m
SELECT * FROM rooms WHERE price_per_day > 1000000;
-- Liệt kê các phòng có lượt check in diễn ra trong 2024
SELECT * FROM bookings WHERE YEAR(check_in) = 2024 ;
-- Liệt kê số lượng phòng của từng loại phòng
SELECT room_type, COUNT(*) FROM rooms GROUP BY room_type;
-- Phần Truy vấn nâng cao
-- Liệt kê mỗi khách đặt phòng bao nhiêu lần
SELECT g.guest_name, COUNT(b.booking_id) AS so_lan_dat 
FROM bookings b
LEFT JOIN guests g ON g.guest_id = b.guest_id
GROUP BY g.guest_id;
-- LIệt kê danh sách các lần dặt phòng với thông tin chi tiết
SELECT g.guest_name, r.room_type, b.check_in FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r ON b.room_id = r.room_id;
-- Hiển thị tổng doanh thu của mỗi phòng
SELECT r.room_id, SUM((b.check_out - b.check_in) * r.price_per_day) AS doanh_thu
FROM rooms r
JOIN bookings b ON r.room_id = b.room_id
GROUP BY r.room_id, r.price_per_day;
-- Hiện thị doanh thu của từng loại phòng
SELECT r.room_type, SUM((b.check_out - b.check_in) * r.price_per_day) AS doanh_thu
FROM rooms r
JOIN bookings b ON r.room_id = b.room_id
GROUP BY r.room_type;
-- Tìm những khách hàng có 2 lần đặt phòng trở lên
SELECT g.guest_name, COUNT(b.booking_id) AS so_lan_dat
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_name
HAVING COUNT(b.booking_id) >= 2;
-- Tìm loại phòng có số lượt đặt phòng nhiều nhất
SELECT room_type, COUNT(b.booking_id) AS so_lan_dat
FROM rooms r
JOIN bookings b ON r.room_id = b.room_id
GROUP BY room_type;
-- Phân truy vấn lồng
-- Hiển thị những phòng có giá thuê cao hơn giá trung bình của tất cả các phòng
SELECT * FROM rooms WHERE price_per_day > ( SELECT AVG(price_per_day) FROM rooms);
-- Hiển thị những khách hàng chưa từng đặt phòng
SELECT * FROM guests WHERE guest_id NOT IN (SELECT guest_id FROM bookings);
-- Tìm được phòng đặt nhiều lần nhất
SELECT r.room_id, r.room_type, COUNT(b.booking_id) AS so_lan_dat
FROM rooms r
JOIN bookings b ON r.room_id = b.room_id
GROUP BY r.room_id, r.room_type
ORDER BY so_lan_dat DESC
LIMIT 1;
SET SQL_SAFE_UPDATES = 1;