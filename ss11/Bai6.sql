USE social_network_pro;

DELIMITER $$

CREATE PROCEDURE NotifyFriendsOnNewPost(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    DECLARE v_post_id INT;
    DECLARE v_full_name VARCHAR(255);

    -- Lấy tên người đăng bài
    SELECT full_name
    INTO v_full_name
    FROM users
    WHERE user_id = p_user_id;

    -- Thêm bài viết mới
    INSERT INTO posts(user_id, content, created_at)
    VALUES (p_user_id, p_content, NOW());

    -- Lấy post_id vừa thêm
    SET v_post_id = LAST_INSERT_ID();

    -- Gửi thông báo cho bạn bè (chiều user -> friend)
    INSERT INTO notifications(user_id, type, content, created_at)
    SELECT
        f.friend_id,
        'new_post',
        CONCAT(v_full_name, ' đã đăng một bài viết mới'),
        NOW()
    FROM friends f
    WHERE f.user_id = p_user_id
      AND f.status = 'accepted'
      AND f.friend_id <> p_user_id;

    -- Gửi thông báo cho bạn bè (chiều friend -> user)
    INSERT INTO notifications(user_id, type, content, created_at)
    SELECT
        f.user_id,
        'new_post',
        CONCAT(v_full_name, ' đã đăng một bài viết mới'),
        NOW()
    FROM friends f
    WHERE f.friend_id = p_user_id
      AND f.status = 'accepted'
      AND f.user_id <> p_user_id;
END$$

DELIMITER ;

CALL NotifyFriendsOnNewPost(
    1,
    'Hôm nay tôi vừa đăng một bài viết mới!'
);
SELECT *
FROM notifications
WHERE type = 'new_post'
ORDER BY created_at DESC;
DROP PROCEDURE IF EXISTS NotifyFriendsOnNewPost;
