CREATE DATABASE Bai5;
USE Bai5;
CREATE TABLE Student (
        student_id INT primary key,
        full_name VARCHAR(100) NOT NULL,
        date_of_birth DATE,
        email VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Subject(
       subject_id INT PRIMARY KEY,
       subject_name VARCHAR(100),
       credit INT CHECK(credit > 0)
);
CREATE TABLE Score (
    student_id INT,
    subject_id INT,
    mid_score FLOAT CHECK (mid_score BETWEEN 0 AND 10),
    final_score FLOAT CHECK (final_score BETWEEN 0 AND 10),

    PRIMARY KEY (student_id, subject_id),

    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);
INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES
(1, 'Nguyen Van A', '2004-05-10', 'a@gmail.com'),
(2, 'Tran Thi B', '2003-08-20', 'b@gmail.com');

INSERT INTO Subject (subject_id, subject_name, credit)
VALUES
(101, 'Co so du lieu', 3),
(102, 'Lap trinh C', 4),
(103, 'Toan roi rac', 3);
INSERT INTO Score (student_id, subject_id, mid_score, final_score)
VALUES
(1, 101, 7.5, 8.0),
(1, 102, 6.0, 7.0),
(2, 101, 8.0, 9.0);
UPDATE Score
SET final_score = 8.5
WHERE student_id = 1 AND subject_id = 101;

SELECT * FROM Score;
SELECT *
FROM Score
WHERE final_score >= 8;