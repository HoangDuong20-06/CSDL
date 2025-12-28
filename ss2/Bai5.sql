CREATE DATABASE Bai5;
USE Bai5;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL
);

CREATE TABLE Score (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,

    process_score DECIMAL(3,1) NOT NULL CHECK (process_score BETWEEN 0 AND 10),
    final_score   DECIMAL(3,1) NOT NULL CHECK (final_score BETWEEN 0 AND 10),

    PRIMARY KEY (student_id, subject_id),

    FOREIGN KEY (student_id)
        REFERENCES Student(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (subject_id)
        REFERENCES Subject(subject_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

SHOW TABLES;
