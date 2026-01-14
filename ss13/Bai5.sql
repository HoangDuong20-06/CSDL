SET SQL_SAFE_UPDATES = 0;

CREATE DATABASE IF NOT EXISTS Bai5ss13;
USE Bai5ss13;

DROP TRIGGER IF EXISTS trg_before_insert_user;
DROP PROCEDURE IF EXISTS add_user;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATE,
    follower_count INT DEFAULT 0,
    post_count INT DEFAULT 0
);

DELIMITER $$

CREATE TRIGGER trg_before_insert_user
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email khong hop le';
    END IF;

    IF NEW.username REGEXP '[^a-zA-Z0-9_]' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username chi duoc chua chu cai, so va dau gach duoi';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE add_user(
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_created_at DATE
)
BEGIN
    INSERT INTO users (username, email, created_at)
    VALUES (p_username, p_email, p_created_at);
END $$

DELIMITER ;

CALL add_user('alice_01', 'alice01@example.com', '2025-01-01');
CALL add_user('bob_user', 'bob.user@mail.com', '2025-01-02');

CALL add_user('charlie123', 'charlie123@mail.com', '2025-01-03');
CALL add_user('david_user', 'david@mail.com', '2025-01-04');

SELECT * FROM users;

SET SQL_SAFE_UPDATES = 1;
