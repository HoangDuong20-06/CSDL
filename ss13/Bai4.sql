SET SQL_SAFE_UPDATES = 0;

CREATE DATABASE IF NOT EXISTS Bai4ss13;
USE Bai4ss13;

DROP VIEW IF EXISTS user_statistics;
DROP TRIGGER IF EXISTS trg_before_update_post;
DROP TRIGGER IF EXISTS trg_after_insert_like;
DROP TRIGGER IF EXISTS trg_after_delete_like;
DROP TABLE IF EXISTS post_history;
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

CREATE TABLE post_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    old_content TEXT,
    new_content TEXT,
    changed_at DATETIME,
    changed_by_user_id INT,
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

INSERT INTO likes (user_id, post_id) VALUES
(2, 1),
(3, 1),
(1, 3),
(3, 4);

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

CREATE TRIGGER trg_before_update_post
BEFORE UPDATE ON posts
FOR EACH ROW
BEGIN
    IF OLD.content <> NEW.content THEN
        INSERT INTO post_history (
            post_id,
            old_content,
            new_content,
            changed_at,
            changed_by_user_id
        )
        VALUES (
            OLD.post_id,
            OLD.content,
            NEW.content,
            NOW(),
            OLD.user_id
        );
    END IF;
END $$

DELIMITER ;

UPDATE posts
SET content = 'Alice post 1 (edited)'
WHERE post_id = 1;

UPDATE posts
SET content = 'Bob post 1 (updated content)'
WHERE post_id = 3;

DELETE FROM likes
WHERE post_id = 1
LIMIT 1;

SELECT * FROM posts;
SELECT * FROM post_history;

SET SQL_SAFE_UPDATES = 1;
