CREATE DATABASE Bai6;
USE Bai6;

CREATE TABLE Class (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    class_id INT NOT NULL,

    FOREIGN KEY (class_id)
        REFERENCES Class(class_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Subject (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    credit INT NOT NULL CHECK (credit > 0),
    teacher_id INT NOT NULL,

    FOREIGN KEY (teacher_id)
        REFERENCES Teacher(teacher_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Enrollment (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    enroll_date DATE NOT NULL,

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

CREATE TABLE Score (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,

    process_score DECIMAL(3,1) NOT NULL CHECK (process_score BETWEEN 0 AND 10),
    final_score   DECIMAL(3,1) NOT NULL CHECK (final_score BETWEEN 0 AND 10),

    PRIMARY KEY (student_id, subject_id),

    FOREIGN KEY (student_id, subject_id)
        REFERENCES Enrollment(student_id, subject_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
SHOW TABLES;
