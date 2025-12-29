CREATE DATABASE Bai2ss3;
USE Bai2ss3;
CREATE TABLE Student (
        student_id INT primary key,
        full_name VARCHAR(100) NOT NULL,
        date_of_birth DATE,
        email VARCHAR(100) NOT NULL UNIQUE
        );
INSERT INTO Student (student_id, full_name, date_of_birth, email) VALUES
(1, 'Nguyen Van A', '2004-05-10', 'a@gmail.com'),
(2, 'Tran Thi B', '2003-09-22', 'b@gmail.com'),
(3, 'Le Van C', '2005-01-15', 'c@gmail.com'),
(4, 'Tran Thi D', '2003-09-22', 'd@gmail.com'),
(5, 'Tran Thi E', '2003-09-22', 'e@gmail.com');
UPDATE Student
SET email = 'newemail3@gmail.com'
WHERE student_id = 3;

UPDATE Student
SET date_of_birth = '2003-12-01'
WHERE student_id = 2;

DELETE FROM Student
WHERE student_id = 5;

SELECT * FROM Student;
