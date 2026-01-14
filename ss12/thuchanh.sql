DROP DATABASE IF EXISTS thuchanhss12;
CREATE DATABASE thuchanhss12;
USE thuchanhss12;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE friends (
    user_id INT,
    friend_id INT,
    status VARCHAR(20) CHECK (status IN ('pending','accepted')),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (friend_id) REFERENCES users(user_id)
);

CREATE TABLE likes (
    user_id INT,
    post_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);
INSERT INTO users(username,password,email) VALUES
('an123','123','an@gmail.com'),
('binh456','123','binh@gmail.com'),
('cuong789','123','cuong@gmail.com'),
('dung111','123','dung@gmail.com');

INSERT INTO posts(user_id,content) VALUES
(1,'Hoc database rat thu vi'),
(1,'Hom nay hoc SQL'),
(2,'Lap trinh Java'),
(3,'Database va MySQL'),
(4,'Hoc backend');

INSERT INTO comments(user_id,post_id,content) VALUES
(2,1,'Hay lam'),
(3,1,'Dung vay'),
(4,2,'Toi cung hoc');

INSERT INTO friends VALUES
(1,2,'accepted'),
(2,1,'accepted'),
(1,3,'accepted'),
(3,1,'accepted');

INSERT INTO likes VALUES
(2,1),(3,1),(4,1),(1,4),(2,4);
INSERT INTO users(username,password,email)
VALUES ('hoa999','123','hoa@gmail.com');

SELECT * FROM users;
CREATE VIEW vw_public_users AS
SELECT user_id, username, created_at
FROM users;

SELECT * FROM vw_public_users;
SELECT * FROM users;
CREATE INDEX idx_users_username ON users(username);

SELECT * FROM users WHERE username = 'an123';
DELIMITER $$

CREATE PROCEDURE sp_create_post(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE user_id = p_user_id) THEN
        INSERT INTO posts(user_id, content)
        VALUES (p_user_id, p_content);
    END IF;
END$$

DELIMITER ;

CALL sp_create_post(1,'Bai viet moi');
CREATE VIEW vw_recent_posts AS
SELECT *
FROM posts
WHERE created_at >= NOW() - INTERVAL 7 DAY;

SELECT * FROM vw_recent_posts;
CREATE INDEX idx_posts_user ON posts(user_id);
CREATE INDEX idx_posts_user_created ON posts(user_id, created_at);

SELECT * FROM posts
WHERE user_id = 1
ORDER BY created_at DESC;
DELIMITER $$

CREATE PROCEDURE sp_count_posts(
    IN p_user_id INT,
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total
    FROM posts
    WHERE user_id = p_user_id;
END$$

DELIMITER ;

CALL sp_count_posts(1,@total);
SELECT @total;
CREATE VIEW vw_active_users AS
SELECT *
FROM users
WHERE username IS NOT NULL
WITH CHECK OPTION;
DELIMITER $$

CREATE PROCEDURE sp_add_friend(
    IN p_user_id INT,
    IN p_friend_id INT
)
BEGIN
    IF p_user_id <> p_friend_id THEN
        INSERT INTO friends VALUES (p_user_id,p_friend_id,'pending');
    END IF;
END$$

DELIMITER ;

CALL sp_add_friend(2,3);
DELIMITER $$

CREATE PROCEDURE sp_suggest_friends(
    IN p_user_id INT,
    INOUT p_limit INT
)
BEGIN
    WHILE p_limit > 0 DO
        SELECT user_id, username
        FROM users
        WHERE user_id <> p_user_id
        LIMIT 1;
        SET p_limit = p_limit - 1;
    END WHILE;
END$$

DELIMITER ;

SET @lim = 2;
CALL sp_suggest_friends(1,@lim);
CREATE INDEX idx_likes_post ON likes(post_id);

CREATE VIEW vw_top_posts AS
SELECT p.post_id, COUNT(l.post_id) AS total_likes
FROM posts p
JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY total_likes DESC
LIMIT 5;

SELECT * FROM vw_top_posts;
DELIMITER $$

CREATE PROCEDURE sp_add_comment(
    IN p_user_id INT,
    IN p_post_id INT,
    IN p_content TEXT
)
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE user_id=p_user_id)
       AND EXISTS (SELECT 1 FROM posts WHERE post_id=p_post_id) THEN
        INSERT INTO comments(user_id,post_id,content)
        VALUES (p_user_id,p_post_id,p_content);
    END IF;
END$$

DELIMITER ;

CALL sp_add_comment(1,1,'Binh luan moi');
CREATE VIEW vw_post_comments AS
SELECT c.content, u.username, c.created_at
FROM comments c
JOIN users u ON c.user_id = u.user_id;
DELIMITER $$

CREATE PROCEDURE sp_like_post(
    IN p_user_id INT,
    IN p_post_id INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM likes
        WHERE user_id=p_user_id AND post_id=p_post_id
    ) THEN
        INSERT INTO likes VALUES(p_user_id,p_post_id);
    END IF;
END$$

DELIMITER ;

CALL sp_like_post(1,2);
CREATE VIEW vw_post_likes AS
SELECT post_id, COUNT(*) total_likes
FROM likes
GROUP BY post_id;
DELIMITER $$

CREATE PROCEDURE sp_search_social(
    IN p_option INT,
    IN p_keyword VARCHAR(100)
)
BEGIN
    IF p_option = 1 THEN
        SELECT * FROM users
        WHERE username LIKE CONCAT('%',p_keyword,'%');
    ELSEIF p_option = 2 THEN
        SELECT * FROM posts
        WHERE content LIKE CONCAT('%',p_keyword,'%');
    ELSE
        SELECT 'Lua chon khong hop le' AS message;
    END IF;
END$$

DELIMITER ;

CALL sp_search_social(1,'an');
CALL sp_search_social(2,'database');
