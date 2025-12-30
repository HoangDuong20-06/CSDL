SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS miniproject;
CREATE DATABASE miniproject;
USE miniproject;

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    description VARCHAR(255),
    total_sessions INT CHECK (total_sessions > 0),
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

CREATE TABLE Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATE DEFAULT (CURRENT_DATE),
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Result (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    mid_score DECIMAL(3,1) CHECK (mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(3,1) CHECK (final_score BETWEEN 0 AND 10),
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);


INSERT INTO Student (full_name, birth_date, email) VALUES
('Nguyen Van A', '2003-01-15', 'a@gmail.com'),
('Tran Thi B', '2003-05-20', 'b@gmail.com'),
('Le Van C', '2002-09-10', 'c@gmail.com'),
('Pham Thi D', '2004-03-08', 'd@gmail.com'),
('Hoang Van E', '2003-12-25', 'e@gmail.com');

INSERT INTO Instructor (full_name, email) VALUES
('Thay Minh', 'minh@edu.vn'),
('Co Lan', 'lan@edu.vn'),
('Thay Hung', 'hung@edu.vn'),
('Co Hoa', 'hoa@edu.vn'),
('Thay Nam', 'nam@edu.vn');

INSERT INTO Course (course_name, description, total_sessions, instructor_id) VALUES
('SQL Co Ban', 'Hoc SQL tu co ban', 20, 1),
('Lap trinh C', 'Ngon ngu C', 25, 2),
('Cau truc du lieu', 'Stack Queue List', 30, 3),
('Lap trinh Web', 'HTML CSS JS', 22, 4),
('Co so du lieu', 'Thiet ke CSDL', 28, 5);

INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
(1, 1, '2025-01-05'),
(1, 2, '2025-01-06'),
(2, 1, '2025-01-05'),
(3, 3, '2025-01-07'),
(4, 4, '2025-01-08');

INSERT INTO Result (student_id, course_id, mid_score, final_score) VALUES
(1, 1, 7.5, 8.0),
(1, 2, 6.5, 7.0),
(2, 1, 8.0, 8.5),
(3, 3, 7.0, 7.5),
(4, 4, 9.0, 9.2);


UPDATE Student
SET email = 'newa@gmail.com'
WHERE student_id = 1;

UPDATE Course
SET description = 'Hoc SQL co ban, thuc hanh'
WHERE course_id = 1;

UPDATE Result
SET final_score = 9.0
WHERE student_id = 1 AND course_id = 1;


DELETE FROM Enrollment
WHERE student_id = 4 AND course_id = 4;

DELETE FROM Result
WHERE student_id = 4 AND course_id = 4;

SELECT * FROM Student;
SELECT * FROM Instructor;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Result;
SET SQL_SAFE_UPDATES = 1;