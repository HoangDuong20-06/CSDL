CREATE DATABASE Bai1;
USE Bai1;
CREATE TABLE Class (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    school_year VARCHAR(20) NOT NULL
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
SHOW tables;