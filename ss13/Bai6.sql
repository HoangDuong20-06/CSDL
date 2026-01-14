SET SQL_SAFE_UPDATES = 0;

CREATE DATABASE IF NOT EXISTS Bai6ss13;
USE Bai6ss13;

DROP VIEW IF EXISTS user_profile;
DROP TRIGGER IF EXISTS trg_after_insert_friendship;
DROP TRIGGER IF EXISTS trg_after_delete_friendship;
DROP PROCEDURE IF EXISTS follow_user;
DROP TABLE IF EXISTS friendships;
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

CREATE TABLE friendships (
    follower_id INT,
    followee_id INT,
    status ENUM('pending', 'accepted') DEFAULT 'accepted',
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (followee_id) REFERENCES users(user_id) ON DELETE CASCADE
);

INSERT INTO users (username, email, created_at) VALUES
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

INSERT INTO posts (user_id, content, created_at) VALUES
(1, 'Alice post 1', '2025-01-10 10:00:00'),
(1, 'Alice post 2', '2025-01-11 11:00:00'),
(2, 'Bob post 1', '2025-01-12 12:00:00'),
(3, 'Charlie post 1', '2025-01-13 13:00:00');

UPDATE users u
SET post_count = (
    SELECT COUNT(*) FROM posts p WHERE p.user_id = u.user_id
);

INSERT INTO likes (user_id, post_id) VALUES
(2, 1),
(3, 1),
(1, 3),
(3, 2);

DELIMITER $$

CREATE TRIGGER trg_after_insert_friendship
AFTER INSERT ON friendships
FOR EACH ROW
BEGIN
    IF NEW.status = 'accepted' THEN
        UPDATE users
        SET follower_count = follower_count + 1
        WHERE user_id = NEW.followee_id;
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_after_delete_friendship
AFTER DELETE ON friendships
FOR EACH ROW
BEGIN
    IF OLD.status = 'accepted' THEN
        UPDATE users
        SET follower_count = follower_count - 1
        WHERE user_id = OLD.followee_id;
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE follow_user(
    IN p_follower_id INT,
    IN p_followee_id INT,
    IN p_status ENUM('pending','accepted')
)
BEGIN
    IF p_follower_id = p_followee_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khong duoc tu follow chinh minh';
    END IF;

    IF EXISTS (
        SELECT 1 FROM friendships
        WHERE follower_id = p_follower_id
          AND followee_id = p_followee_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Da ton tai quan he follow';
    END IF;

    INSERT INTO friendships (follower_id, followee_id, status)
    VALUES (p_follower_id, p_followee_id, p_status);
END $$

DELIMITER ;

CREATE OR REPLACE VIEW user_profile AS
SELECT 
    u.user_id,
    u.username,
    u.follower_count,
    u.post_count,
    COALESCE(SUM(p.like_count), 0) AS total_likes,
    GROUP_CONCAT(p.content ORDER BY p.created_at DESC SEPARATOR ' | ') AS recent_posts
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_id, u.username, u.follower_count, u.post_count;

CALL follow_user(2, 1, 'accepted');
CALL follow_user(3, 1, 'accepted');
CALL follow_user(1, 2, 'accepted');

DELETE FROM friendships
WHERE follower_id = 3 AND followee_id = 1;

SELECT * FROM users;
SELECT * FROM friendships;
SELECT * FROM user_profile;

SET SQL_SAFE_UPDATES = 1;
