/*
	Griffen Fox, CS204 
	Homework 9: Part One 
*/

/*
Contents
~~~~~~~~~~ 
	I. 	Part a
			-Table Creation
			-Tuple Insertion
	II.	Part b
			-Brown Grade Update
			-Retrival from Textbook Exercise 7.6a
			-Retrival from Textbook Exercise 7.6b
			
			
			
			
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~			
-- I. Part A


/*
   Table Creation
~~~~~~~~~~~~~~~~~~~~~
*/ 

--Student Table
	CREATE TABLE STUDENT 
	(
		Name varchar(60),
		Student_num numeric,
		Class_num numeric,
		Major varchar(60),
		PRIMARY KEY(Student_num)
	);

--Course Table
	CREATE TABLE COURSES
	(
		Course_name varchar(90),
		Course_num varchar(30),
		Credit_hrs numeric,
		Department varchar(60),
		PRIMARY KEY(Course_num)
	);	
	
--Section Table
	CREATE TABLE SECTIONS 
	(
		Section_id numeric,
		Course_num2 varchar(30),
		Semester varchar(30),
		Years numeric,
		Instructor varchar(60),
		PRIMARY KEY (Section_id)
	);

--Grade Report Table 
	CREATE TABLE GRADE_REPORT
	(
		Student_num2 numeric,	 
		Section_id2 numeric,
		Grade varchar(1),
		FOREIGN KEY(Student_num2) REFERENCES STUDENT(Student_num),
		FOREIGN KEY(Section_id2) REFERENCES SECTIONS(Section_id)
	);
	
--Prerequisite TABLE
	CREATE TABLE PREREQUISITE
	(
		Course_num3 varchar(30),
		Prereq_num varchar(30),
		PRIMARY KEY(Prereq_num),
		FOREIGN KEY (Course_num3) REFERENCES COURSES(Course_num)
	);
--Commit Tables	
	COMMIT;


	
/*
	Tuple Insertion
~~~~~~~~~~~~~~~~~~~~~~~~
*/

--Fill Student Table 
	INSERT INTO STUDENT VALUES ('Smith', 17, 1, 'CS');
	INSERT INTO STUDENT VALUES ('Brown', 8, 2, 'CS');

--Fill Course Table
	INSERT INTO COURSES VALUES ('Intro to Computer Science', 'CS1310', 4, 'CS');
	INSERT INTO COURSES VALUES ('Data Structures', 'CS3320', 4, 'CS');
	INSERT INTO COURSES VALUES ('Discrete Mathematics', 'MATH2410', 3, 'MATH');
	INSERT INTO COURSES VALUES ('Database', 'CS3380', 3, 'CS');
	
--Fill Section Table
	INSERT INTO SECTIONS VALUES (85, 'MATH2410', 'Fall', '07', 'King');
	INSERT INTO SECTIONS VALUES (92, 'CS1310', 'Fall', '07', 'Anderson');
	INSERT INTO SECTIONS VALUES (102, 'CS3320', 'Spring', '08', 'Knuth');
	INSERT INTO SECTIONS VALUES (112, 'MATH2410', 'Fall', '08', 'Chang');
	INSERT INTO SECTIONS VALUES (119, 'CS1310', 'Fall', '08', 'Anderson');
	INSERT INTO SECTIONS VALUES (135, 'CS2280', 'Fall', '08', 'Stone');
	
--Fill Grade Report Table 
	INSERT INTO GRADE_REPORT VALUES (17, 112, 'B');
	INSERT INTO GRADE_REPORT VALUES (17, 119, 'C');
	INSERT INTO GRADE_REPORT VALUES (8, 85, 'A');
	INSERT INTO GRADE_REPORT VALUES (8, 92, 'A');
	INSERT INTO GRADE_REPORT VALUES (8, 102, 'B');
	INSERT INTO GRADE_REPORT VALUES (8, 135, 'A');
	
--Fill Prerequisite Table 
	INSERT INTO PREREQUISITE VALUES ('CS3380', 'CS3320');
	INSERT INTO PREREQUISITE VALUES ('CS3380', 'MATH2410');
	INSERT INTO PREREQUISITE VALUES ('CS3320', 'CS1310');


--Commit Tuples
	commit;	

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

--II. Part b	

/*
	Brown Grade Update
~~~~~~~~~~~~~~~~~~~~~~~~~
*/	

	UPDATE GRADE_REPORT
	SET Grade= 'A'
	WHERE Student_num2= 8 AND Section_id2= 102;
	
	
/*
	Retrival from Textbook Exercise 7.6a
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
	
	SELECT Name, Major
	FROM STUDENT
	WHERE NOT EXISTS ( 
		SELECT *
		FROM GRADE_REPORT
		WHERE Student_num2 = STUDENT.Student_num AND NOT(Grade='A')
	);
	
/*
	Retrival from Textbook Exercise 7.6b
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

	SELECT Name, Major
	FROM STUDENT
	WHERE NOT EXISTS ( SELECT *
	FROM GRADE_REPORT
	WHERE Student_num2= STUDENT.Student_num AND Grade='A' );


/* 
	Drop All Tables 
~~~~~~~~~~~~~~~~~~~~~~~~
*/
	DROP TABLE PREREQUISITE;
	DROP TABLE GRADE_REPORT;
	DROP TABLE SECTIONS;
	DROP TABLE COURSES;
	DROP TABLE STUDENT;
	commit;
	
 	
	
	
	
	