SET SQL_SAFE_UPDATES = 0;
USE social_network_pro;

INSERT INTO users (user_id, username, full_name, email, password, hometown)
VALUES
(1, 'an', 'An Nguyễn', 'an@gmail.com', '123456', 'Hà Nội'),
(2, 'binh', 'Bình Trần', 'binh@gmail.com', '123456', 'Hà Nội'),
(3, 'cuong', 'Cường Lê', 'cuong@gmail.com', '123456', 'Hải Phòng'),
(4, 'duong', 'Dương Phạm', 'duong@gmail.com', '123456', 'Hà Nội'),
(5, 'em', 'Em Võ', 'em@gmail.com', '123456', 'Đà Nẵng')
ON DUPLICATE KEY UPDATE
full_name = VALUES(full_name),
email = VALUES(email),
password = VALUES(password),
hometown = VALUES(hometown);

INSERT INTO posts (post_id, user_id, content, created_at) VALUES
(1, 1, 'Bài viết 1 của An', NOW()),
(2, 1, 'Bài viết 2 của An', NOW()),
(3, 1, 'Bài viết 3 của An', NOW()),
(4, 1, 'Bài viết 4 của An', NOW()),
(5, 1, 'Bài viết 5 của An', NOW()),
(6, 1, 'Bài viết 6 của An', NOW()),

(7, 2, 'Bài viết 1 của Bình', NOW()),
(8, 2, 'Bài viết 2 của Bình', NOW()),
(9, 2, 'Bài viết 3 của Bình', NOW()),

(10, 4, 'Bài viết 1 của Dương', NOW()),
(11, 4, 'Bài viết 2 của Dương', NOW()),
(12, 4, 'Bài viết 3 của Dương', NOW()),
(13, 4, 'Bài viết 4 của Dương', NOW()),
(14, 4, 'Bài viết 5 của Dương', NOW()),
(15, 4, 'Bài viết 6 của Dương', NOW()),
(16, 4, 'Bài viết 7 của Dương', NOW())
ON DUPLICATE KEY UPDATE
post_id = VALUES(post_id),
user_id = VALUES(user_id),
content = VALUES(content),
created_at = VALUES(created_at);

CREATE OR REPLACE VIEW view_users_summary AS
SELECT 
    u.user_id,
    u.username,
    u.full_name,
    COUNT(p.post_id) AS total_posts
FROM users u
LEFT JOIN posts p 
    ON u.user_id = p.user_id
GROUP BY u.user_id, u.username, u.full_name;

SELECT 
    user_id,
    username,
    full_name,
    full_name,
    total_posts
FROM view_users_summary
WHERE total_posts > 5;
SET SQL_SAFE_UPDATES = 1;
