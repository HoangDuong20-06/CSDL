CREATE DATABASE Bai6ss3;
USE Bai6ss3;

CREATE TABLE Subject(
	subject_id INT PRIMARY KEY,
	subject_name VARCHAR(100),
	credit INT CHECK (credit > 0)
);

CREATE TABLE Student (
	student_id INT PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	date_of_birth DATE,
	email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Enrollment (
	student_id INT,
	subject_id INT,
	enroll_date DATE,
	PRIMARY KEY (student_id, subject_id),
	FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

CREATE TABLE Score (
	student_id INT,
	subject_id INT,
	score FLOAT,
	PRIMARY KEY (student_id, subject_id),
	FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

INSERT INTO Subject (subject_id, subject_name, credit) VALUES
(1, 'Co so du lieu', 3),
(2, 'Lap trinh C', 4);

INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES (4, 'Pham Van D', '2004-08-20', 'd@gmail.com');

INSERT INTO Enrollment (student_id, subject_id, enroll_date) VALUES
(4, 1, '2024-09-03'),
(4, 2, '2024-09-03');

INSERT INTO Score (student_id, subject_id, score) VALUES
(4, 1, 7.5),
(4, 2, 8.0);

UPDATE Score
SET score = 8.5
WHERE student_id = 4 AND subject_id = 1;

DELETE FROM Enrollment
WHERE student_id = 4 AND subject_id = 2;

SELECT * FROM Subject;
SELECT * FROM Student WHERE student_id = 4;
SELECT * FROM Enrollment;
SELECT * FROM Score WHERE student_id = 4;