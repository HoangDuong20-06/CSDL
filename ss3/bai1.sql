CREATE DATABASE Bai1ss3;
USE Bai1ss3;
CREATE TABLE Student (
        student_id INT primary key,
        full_name VARCHAR(100) NOT NULL,
        date_of_birth DATE,
        email VARCHAR(100) NOT NULL UNIQUE
        );
INSERT INTO Student (student_id, full_name, date_of_birth, email) VALUES
(1, 'Nguyen Van A', '2004-05-10', 'a@gmail.com'),
(2, 'Tran Thi B', '2003-09-22', 'b@gmail.com'),
(3, 'Le Van C', '2005-01-15', 'c@gmail.com');

SELECT * FROM Student;

SELECT student_id, full_name FROM Student;
SHOW TABLES;