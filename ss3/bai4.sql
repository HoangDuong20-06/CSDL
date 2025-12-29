CREATE DATABASE Bai4;
USE Bai4;
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
CREATE TABLE Enrollment (
	student_id INT,
	subject_id INT,
	enroll_date DATE,
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

INSERT INTO Enrollment (student_id, subject_id, enroll_date)
VALUES
(1, 101, '2025-01-05'),
(1, 102, '2025-01-06'),
(2, 101, '2025-01-07');

SELECT * FROM Enrollment;

SELECT *
FROM Enrollment
WHERE student_id = 1;
