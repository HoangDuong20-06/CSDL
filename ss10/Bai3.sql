USE social_network_pro;

-- =====================================================
-- 2) Truy vấn tìm tất cả User ở Hà Nội (TRƯỚC khi tạo index)
-- =====================================================
EXPLAIN
SELECT *
FROM users
WHERE hometown = 'Hà Nội';


-- =====================================================
-- 3) Tạo chỉ mục idx_hometown cho cột hometown
-- =====================================================
CREATE INDEX idx_hometown
ON users(hometown);


-- =====================================================
-- 4) Chạy lại truy vấn với EXPLAIN (SAU khi tạo index)
-- =====================================================
EXPLAIN ANALYZE 
SELECT *
FROM users
WHERE hometown = 'Hà Nội';


-- =====================================================
-- 6) Xóa chỉ mục idx_hometown
-- (đề ghi customers là sai → xóa trên bảng users)
-- =====================================================
DROP INDEX idx_hometown ON users;
