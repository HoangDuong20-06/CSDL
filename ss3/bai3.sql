CREATE DATABASE Bai3ss3;
USE Bai3ss3;
CREATE TABLE Subject(
       subject_id INT PRIMARY KEY,
       subject_name VARCHAR(100),
       credit INT CHECK(credit > 0)
       );
INSERT INTO Subject (subject_id, subject_name, credit) VALUES
(1, 'Co so du lieu', 3),
(2, 'Lap trinh C', 4),
(3, 'Cau truc du lieu', 3);

UPDATE Subject
SET credit = 5
WHERE subject_id = 2;

UPDATE Subject
SET subject_name = 'Cau truc du lieu va giai thuat'
WHERE subject_id = 3;

SELECT * FROM Subject;