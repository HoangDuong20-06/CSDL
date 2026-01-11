SET SQL_SAFE_UPDATES = 0;
USE social_network_pro;
-- Truy vấn tìm các bài viết năm 2026 của user_id = 1 (CHƯA CÓ INDEX)
EXPLAIN ANALYZE
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
  AND created_at BETWEEN '2026-01-01' AND '2026-12-31';

-- Tạo chỉ mục phức hợp
CREATE INDEX idx_created_at_user_id
ON posts (created_at, user_id);
-- Truy vấn lại sau khi có INDEX
EXPLAIN ANALYZE
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
  AND created_at BETWEEN '2026-01-01' AND '2026-12-31';
-- Truy vấn tìm user theo email (CHƯA CÓ INDEX)
EXPLAIN ANALYZE
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';
-- Tạo chỉ mục duy nhất
CREATE UNIQUE INDEX idx_email
ON users (email);
-- Truy vấn lại sau khi có UNIQUE INDEX
EXPLAIN ANALYZE
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';
DROP INDEX idx_created_at_user_id ON posts;
DROP INDEX idx_email ON users;
SET SQL_SAFE_UPDATES = 1;