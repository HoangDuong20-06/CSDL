SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE IF NOT EXISTS Bai3ss13;
USE Bai3ss13;

DROP VIEW IF EXISTS user_statistics;
DROP TRIGGER IF EXISTS trg_before_insert_like;
DROP TRIGGER IF EXISTS trg_before_update_like;
DROP TRIGGER IF EXISTS trg_after_insert_like;
DROP TRIGGER IF EXISTS trg_after_delete_like;
DROP TRIGGER IF EXISTS trg_after_update_like;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATE,
    follower_count INT DEFAULT 0,
    post_count INT DEFAULT 0
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at DATETIME,
    like_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    post_id INT,
    liked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

INSERT INTO users (username, email, created_at) VALUES
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

INSERT INTO posts (user_id, content, created_at) VALUES
(1, 'Alice post 1', '2025-01-10 10:00:00'),
(1, 'Alice post 2', '2025-01-10 12:00:00'),
(2, 'Bob post 1', '2025-01-11 09:00:00'),
(3, 'Charlie post 1', '2025-01-12 15:00:00');

UPDATE users u
SET post_count = (
    SELECT COUNT(*) FROM posts p WHERE p.user_id = u.user_id
);

CREATE OR REPLACE VIEW user_statistics AS
SELECT 
    u.user_id,
    u.username,
    u.post_count,
    COALESCE(SUM(p.like_count), 0) AS total_likes
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_id, u.username, u.post_count;

DELIMITER $$

CREATE TRIGGER trg_before_insert_like
BEFORE INSERT ON likes
FOR EACH ROW
BEGIN
    DECLARE owner_id INT;
    SELECT user_id INTO owner_id FROM posts WHERE post_id = NEW.post_id;
    IF owner_id = NEW.user_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khong duoc like bai dang cua chinh minh';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_before_update_like
BEFORE UPDATE ON likes
FOR EACH ROW
BEGIN
    DECLARE owner_id INT;
    SELECT user_id INTO owner_id FROM posts WHERE post_id = NEW.post_id;
    IF owner_id = NEW.user_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khong duoc like bai dang cua chinh minh';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_after_insert_like
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    UPDATE posts
    SET like_count = like_count + 1
    WHERE post_id = NEW.post_id;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_after_delete_like
AFTER DELETE ON likes
FOR EACH ROW
BEGIN
    UPDATE posts
    SET like_count = like_count - 1
    WHERE post_id = OLD.post_id;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_after_update_like
AFTER UPDATE ON likes
FOR EACH ROW
BEGIN
    IF OLD.post_id <> NEW.post_id THEN
        UPDATE posts
        SET like_count = like_count - 1
        WHERE post_id = OLD.post_id;

        UPDATE posts
        SET like_count = like_count + 1
        WHERE post_id = NEW.post_id;
    END IF;
END $$

DELIMITER ;

INSERT INTO likes (user_id, post_id) VALUES (2, 1);
INSERT INTO likes (user_id, post_id) VALUES (3, 1);

UPDATE likes
SET post_id = 4
WHERE user_id = 2 AND post_id = 3
LIMIT 1;

DELETE FROM likes
WHERE user_id = 2 AND post_id = 4
LIMIT 1;

SELECT * FROM posts;
SELECT * FROM user_statistics;
SET SQL_SAFE_UPDATES = 1;