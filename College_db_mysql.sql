-- DROP DATABASE college_db;
CREATE DATABASE college_db;
use college_db;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
-- TABLE structure for department
create table department (
	ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NAME varchar(30) NOT NULL,
    HOD_ID int(10) DEFAULT NULL
);
 
INSERT INTO department (ID, NAME, HOD_ID) VALUES
(1, 'Computer', 1),
(3, 'Information Technology', 5);

-- Table structure for Faculty
CREATE TABLE faculty (
  ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  FIRST_NAME varchar(25) NOT NULL,
  LAST_NAME varchar(25) NOT NULL,
  DEPARTMENT_ID int(11) NOT NULL,
  PHONE varchar(10) DEFAULT NULL
);

INSERT INTO faculty (ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID, PHONE) VALUES
(1, 'Josh', 'Danes', 1, '7652340892'),
(2, 'Emily', 'Gilmore', 1, '7785461895'),
(3, 'Michael', 'Choi', 1, '8983547891'),
(4, 'Eda', 'Pierce', 1, '9890451786'),
(5, 'Aditya', 'Salvi', 3, '9422185769'),
(6, 'Xavier', 'DeLuca', 3, '7704159854');

CREATE TABLE marks (
  ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  STUDENT_ROLL_NO int(11) NOT NULL DEFAULT 1,
  SUBJECT_ID int(11) NOT NULL DEFAULT 1,
  MARKS int(11) NOT NULL
) ;

INSERT INTO MARKS (ID, STUDENT_ROLL_NO, SUBJECT_ID, MARKS) VALUES
(1, 170101, 1, 80),
(2, 170101, 6, 70),
(3, 170101, 4, 90),
(4, 170101, 2, 80),
(5, 170102, 1, 80),
(6, 170102, 6, 80),
(7, 170102, 5, 90),
(8, 170102, 2, 80),
(9, 180101, 3, 70),
(10, 180102, 3, 73),
(11, 180103, 3, 80);

SELECT * FROM MARKS;

-- Table Structure for students
CREATE TABLE students (
  ROLL_NO int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  FIRST_NAME varchar(25) NOT NULL,
  LAST_NAME varchar(25) NOT NULL,
  DEPT_ID int(11) DEFAULT NULL,
  PHONE varchar(10) DEFAULT NULL,
  ADMISSION_DATE date NOT NULL,
  SAT_MARKS int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO STUDENTS (ROLL_NO, FIRST_NAME, LAST_NAME, DEPT_ID, PHONE, ADMISSION_DATE, SAT_MARKS) VALUES
(170101, 'Josh', 'Robert', 1, '7474986413', '2019-08-01', 107),
(170102, 'Tuhina', 'Prasad', 1, '8862451783', '2019-08-01', 113),
(170103, 'Adrian', 'Adams', 1, '9029742685', '2019-08-21', 140),
(170104, 'Nicole', 'Danes', 1, '7093458923', '2019-08-21', 132),
(170301, 'Chris', 'Evans', 3, '9552514865', '2019-08-01', 125),
(180101, 'Tony', 'Stark', 1, '7415487529', '2019-08-21', 141),
(180102, 'Rachel', 'Green', 1, '9423165742', '2019-08-21', 130),
(180103, 'Chandler', 'Bing', 1, '9545791532', '2019-08-21', 150),
(180104, 'Ross', 'Geller', 1, '7093458923', '2019-08-21', 131);

-- TRIGGERS STUDENT
-- DELIMITER $$
-- 	CREATE TRIGGER delete_student BEFORE DELETE ON students FOR EACH ROW DELETE FROM marks WHERE STUDENT_ROLL_NO = OLD.ROLL_NO
-- $$
-- DELIMITER ;

-- Table structure for table `subjects`

CREATE TABLE subjects (
  ID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  DEPT_ID int(11) NOT NULL,
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  NAME varchar(50) NOT NULL,
  FACULTY_ID int(11) NOT NULL DEFAULT 1
);

INSERT INTO subjects (ID, DEPT_ID, START_DATE, END_DATE, NAME, FACULTY_ID) VALUES
(1, 3, '2019-09-01', '2020-06-21', 'Object Oriented Programming', 1),
(2, 3, '2019-09-01', '2020-05-15', 'Discrete Mathematics', 2),
(3, 1, '2019-09-01', '2020-08-21', 'Computer Graphics', 2),
(4, 1, '2019-09-10', '2020-02-01', 'Database Management Systems', 3),
(5, 3, '2019-09-21', '2020-01-20', 'Digital Electronics And Login Design', 4),
(6, 1, '2019-09-15', '2020-09-23', 'Computer Organization and Architecture', 4);

select * from subjects;

--
-- Indexes for table `department`
--
ALTER TABLE department
  ADD KEY DEPT_HOD_ID (HOD_ID);

--
-- Indexes for table `faculty`
--
ALTER TABLE faculty
  ADD KEY FACULTY_DEPT_ID (DEPARTMENT_ID);

--
-- Indexes for table `marks`
--
-- ALTER TABLE marks
--  ADD KEY MARKS_STUDENT_ROLL_NO (STUDENT_ROLL_NO),
--  ADD KEY MARKS_SUBJECT_ID (SUBJECT_ID);
  
ALTER TABLE marks
ADD CONSTRAINT uni_marks UNIQUE (STUDENT_ROLL_NO, SUBJECT_ID);
--
-- Indexes for table `students`
--
ALTER TABLE students
  ADD KEY STUDENT_DEPT_ID (DEPT_ID);

--
-- Indexes for table `subjects`
--
ALTER TABLE subjects
  ADD KEY SUBJECT_DEPT_ID (DEPT_ID),
  ADD KEY SUBJECT_FACULTY_ID (FACULTY_ID);

--
-- Constraints for table `departments`
--
ALTER TABLE department
  ADD CONSTRAINT DEPT_HOD_ID FOREIGN KEY (HOD_ID) REFERENCES faculty (ID) ON UPDATE NO ACTION;

--
-- Constraints for table `faculty`
--
ALTER TABLE faculty
  ADD CONSTRAINT FACULTY_DEPARTMENT_ID FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT (ID) ON UPDATE NO ACTION;

--
-- Constraints for table `marks`
--
ALTER TABLE marks
  ADD CONSTRAINT MARKS_STUDENT_ROLL_NO FOREIGN KEY (STUDENT_ROLL_NO) REFERENCES STUDENTS (ROLL_NO) ON UPDATE NO ACTION,
  ADD CONSTRAINT MARKS_SUBJECT_ID FOREIGN KEY (SUBJECT_ID) REFERENCES SUBJECTS (ID) ON UPDATE NO ACTION;

--
-- Constraints for table `students`
--
ALTER TABLE students
  ADD CONSTRAINT STUDENT_DEPT_ID FOREIGN KEY (DEPT_ID) REFERENCES department (ID) ON UPDATE NO ACTION;

--
-- Constraints for table `subjects`
--
ALTER TABLE subjects
  ADD CONSTRAINT SUBJECT_DEPT_ID FOREIGN KEY (DEPT_ID) REFERENCES department (ID) ON UPDATE NO ACTION,
  ADD CONSTRAINT SUBJECT_FACULTY_ID FOREIGN KEY (FACULTY_ID) REFERENCES faculty (ID) ON UPDATE NO ACTION;
COMMIT;

-- calculate_pointer PROCEDURE
DELIMITER $$
CREATE PROCEDURE calculate_pointer(IN roll_no INT, OUT pointer INT)
BEGIN
	SELECT AVG(marks.marks) INTO pointer
	FROM marks
	JOIN subjects ON marks.subject_id = subjects.id
	WHERE marks.student_roll_no = roll_no
	AND EXISTS (
		SELECT 1
		FROM subjects
		JOIN students ON subjects.dept_id = students.dept_id
		WHERE students.roll_no = roll_no
		AND subjects.id = marks.subject_id
	);
END $$
DELIMITER ;

CALL calculate_pointer(180102, @result);
SELECT @result;

-- PROCEDURE
DELIMITER $$
CREATE PROCEDURE insert_marks(
    IN  s_roll_no INT,
    IN  s_id INT,
    IN  m INT)
BEGIN
    INSERT INTO marks(STUDENT_ROLL_NO, SUBJECT_ID, MARKS)
    VALUES (s_roll_no, s_id, m)
    ON DUPLICATE KEY UPDATE marks = m;
END $$
DELIMITER ;

CALL insert_marks(180101, 2, 85);
select * from marks;

