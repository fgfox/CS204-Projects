-- I. Part a

/*
   Table Creation
~~~~~~~~~~~~~~~~~~~~~
*/ 

--Employee Table
	CREATE TABLE EMPLOYEE
	(	
		Fname varchar(255),
		Minit varchar(255),
		Lname varchar(255),
		Ssn number(9),
		Bdate varchar(255),
		Address varchar(255),
		Sex char(1),
		Salary number(15),
		Super_ssn number(9),
		Dno number(15),
		CONSTRAINT PK_EMPLOYEE PRIMARY KEY (Ssn),
		CONSTRAINT FK_Super_ssn FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
		CONSTRAINT Check_E_gender CHECK (Sex IN ('F','M')),
		CONSTRAINT Check_salary CHECK (Salary > 20000)
	);
	
--Department Table
	CREATE TABLE DEPARTMENT
	(	
		Dname varchar(255),
		Dnumber number(15),
		Mgr_ssn number(9),
		Mgr_start_date varchar(255),
		CONSTRAINT PK_DEPARTMENT PRIMARY KEY (Dnumber),
		CONSTRAINT FK_Manager FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn)
	);
	
--Department Locations Table
	CREATE TABLE DEPT_LOCATIONS
	(	
		Dnumber number(15),
		Dlocation varchar(11),
		CONSTRAINT PK_DEPT_LOCATIONS PRIMARY KEY (Dnumber, Dlocation),
		CONSTRAINT FK_Location_Dnumber FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber),
		CONSTRAINT Check_Department_location CHECK (Dlocation IN ('Bellaire', 'Sugarland', 'Houston', 'Stafford'))	
	);
	
--Project Table
	CREATE TABLE PROJECT
	(
		Pname varchar(255),
		Pnumber number(10),
		Plocation varchar(11),
		Dnum number(15),
		CONSTRAINT PK_PROJECT PRIMARY KEY (Pnumber),
		CONSTRAINT FK_Project_Dnumber FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber),
		CONSTRAINT Check_Project_location CHECK (Plocation IN ('Bellaire', 'Sugarland', 'Houston', 'Stafford'))
	);

--Works On Table
	CREATE TABLE WORKS_ON
	(
		Essn number(9),
		Pno number(10),
		Hours number(5),
		CONSTRAINT PK_WORKS_ON PRIMARY KEY (Essn, Pno),
		CONSTRAINT FK_W_O_Essn FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
		CONSTRAINT FK_W_O_Pno FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber),
		CONSTRAINT Check_Hours CHECK (Hours BETWEEN 5 AND 40)
	);
	
--Dependent Table
	CREATE TABLE DEPENDENT
	(
		Essn number(9),
		Dependent_name varchar(255),
		Sex char(1),
		Bdate varchar(255),
		Relationship varchar(255),
		CONSTRAINT PK_DEPENDENT PRIMARY KEY (Essn, Dependent_name),
		CONSTRAINT FK_DEPENDENT_Essn FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
		CONSTRAINT Check_Dependent_Relationship CHECK (Relationship IN ('Spouse', 'Son', 'Daughter')),
		CONSTRAINT Check_D_gender CHECK (Sex IN ('F','M'))
	);

-- Because of circular constraint with foreign keys, add contratint after table creation
	ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_Employee_Dno FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber); 

	COMMIT;	
	
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~			

/*
	Tuple Insertion
~~~~~~~~~~~~~~~~~~~~~~~~
*/

--Drop Constraints to Insert
	ALTER TABLE EMPLOYEE DROP CONSTRAINT FK_Employee_Dno;
	ALTER TABLE EMPLOYEE DROP CONSTRAINT FK_Super_ssn;

--Tuple Insertion into Employee	
	INSERT INTO Employee VALUES ('James', 'E', 'Borg', 888665555,'10-Nov-27', '450 Stone, Houston, TX', 'M', 55000, null, 1);
	INSERT INTO Employee VALUES ('Jennifer', 'S', 'Wallace', 987654321,'20-Jun-31', '291 Berry, Bellaire, TX', 'F', 43000, 888665555, 4);
	INSERT INTO Employee VALUES ('Ahmad', 'V', 'Jabbar', 987987987,'29-Mar-59', '980 Dallas, Houston, TX', 'M', 25000, 987654321, 4);
	INSERT INTO Employee VALUES ('Alicia', 'J', 'Zelaya', 999887777,'19-Jul-58', '3321 Castle, Spring, TX', 'F', 25000, 987654321, 4);
	INSERT INTO Employee VALUES ('Franklin', 'T', 'Wong', 333445555,'08-Dec-45', '638 Voss, Houston, TX', 'M', 40000, 888665555, 5);
	INSERT INTO Employee VALUES ('Joyce', 'A', 'English', 453453453,'31-Jul-62', '5631 Rice, Houston, TX', 'F', 25000, 333445555, 5);
	INSERT INTO Employee VALUES ('Ramesh', 'K', 'Narayan', 666884444,'15-Sep-52', '975 Fire Oak, Humble, TX', 'M', 38000, 333445555, 5);  
	INSERT INTO Employee VALUES ('John', 'B', 'Smith', 123456789,'09-Jan-55', '731 Fondren, Houston, TX', 'M', 30000, 333445555, 5);

--Tuple Insertion into Department	
	INSERT INTO Department VALUES ('Research', 5, 333445555, '22-May-78'); 
	INSERT INTO Department VALUES ('Administration', 4, 987654321, '01-Jan-85');
	INSERT INTO Department VALUES ('Headquarters', 1, 888665555, '19-Jun-71'); 

--Tuple Insertion into Dependent	
	INSERT INTO Dependent VALUES (333445555, 'Alice', 'F', '05-Apr-76', 'Daughter');
	INSERT INTO Dependent VALUES (333445555, 'Theodore', 'M', '25-Oct-73', 'Son');
	INSERT INTO Dependent VALUES (333445555, 'Joy', 'F', '03-May-48', 'Spouse');
	INSERT INTO Dependent VALUES (987654321, 'Abner', 'M', '29-Feb-32', 'Spouse');
	INSERT INTO Dependent VALUES (123456789, 'Michael', 'M', '01-Jan-78', 'Son');
	INSERT INTO Dependent VALUES (123456789, 'Alice', 'F', '31-Dec-78', 'Daughter');
	INSERT INTO Dependent VALUES (123456789, 'Elizabeth', 'F', '05-May-57', 'Spouse');

--Tuple Insertion into Project
	INSERT INTO Project VALUES ('ProductX', 1, 'Bellaire', 5);
	INSERT INTO Project VALUES ('ProductY', 2, 'Sugarland', 5);
	INSERT INTO Project VALUES ('ProductZ', 3, 'Houston', 5);
	INSERT INTO Project VALUES ('Computerization', 10, 'Stafford', 4);
	INSERT INTO Project VALUES ('Reorganization', 20, 'Houston', 1);
	INSERT INTO Project VALUES ('Newbenefits', 30, 'Stafford', 4);

--Tuple Insertion into Deptartment Locations	
	INSERT INTO Dept_locations VALUES (1, 'Houston');
	INSERT INTO Dept_locations VALUES (4, 'Stafford');
	INSERT INTO Dept_locations VALUES (5, 'Bellaire');
	INSERT INTO Dept_locations VALUES (5, 'Sugarland');
	INSERT INTO Dept_locations VALUES (5, 'Houston');

--Tuple Insertion into Works On	
	INSERT INTO Works_on VALUES (123456789, 1, 32.5);
	INSERT INTO Works_on VALUES (123456789, 2, 7.5);
	INSERT INTO Works_on VALUES (666884444, 3, 40.0);
	INSERT INTO Works_on VALUES (453453453, 1, 20.0);
	INSERT INTO Works_on VALUES (453453453, 2, 20.0);
	INSERT INTO Works_on VALUES (333445555, 2, 10.0);
	INSERT INTO Works_on VALUES (333445555, 3, 10.0);
	INSERT INTO Works_on VALUES (333445555, 10, 10.0);
	INSERT INTO Works_on VALUES (333445555, 20, 10.0);
	INSERT INTO Works_on VALUES (999887777, 30, 30.0);
	INSERT INTO Works_on VALUES (999887777, 10, 10.0);
	INSERT INTO Works_on VALUES (987987987, 10, 35.0);
	INSERT INTO Works_on VALUES (987987987, 30, 5.0);
	INSERT INTO Works_on VALUES (987654321, 30, 20.0);
	INSERT INTO Works_on VALUES (987654321, 20, 15.0);
	INSERT INTO Works_on VALUES (888665555, 20, null);

--Re-Add Constraints	
	ADD CONSTRAINT FK_Employee_Dno FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber); 
	ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_Super_ssn FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);
	SELECT CONSTRAINT_NAME FROM user_cons_columns WHERE table_name = 'EMPLOYEE';

	COMMIT;

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~			

-- Part B: Textbook Exercise 

CREATE VIEW DEPT_SUMMARY (D, C, TOTAL_S, AVERAGE_S) AS SELECT Dno, COUNT(*), SUM(Salary), AVG (Salary) FROM EMPLOYEE GROUP BY Dno;
	--A
	SELECT * FROM DEPT_SUMMARY;
	--B
	SELECT D,C FROM DEPT_SUMMARY WHERE TOTAL_S > 100000;
	--C
	SELECT D, AVERAGE_S FROM DEPT_SUMMARY WHERE C > (SELECT C FROM DEPT_SUMMARY WHERE D = 4);
	--D
	UPDATE DEPT_SUMMARY SET D = 3 WHERE D = 4;
			--Not allowed because update on aggregate functions is not evaluated
	--E
	DELETE FROM DEPT_SUMMARY WHERE C > 4;
			--Not allowed because there can be multiple meanings of the query
DROP VIEW DEPT_SUMMARY;


CREATE PROCEDURE COMPLEXPROC
	BEGIN
		SELECT Fname, Minit, Lname, Salary, COUNT(DEPENDENT), Hours
		IF (SELECT COUNT(*) FROM Dependent WHERE ssn=essn) >=2 AND (Salary >= AVG(Salary));
	END



--DROP EVERYTHING

ALTER TABLE EMPLOYEE DROP CONSTRAINT FK_Employee_Dno;
	ALTER TABLE EMPLOYEE DROP CONSTRAINT FK_Super_ssn;
	DROP TABLE DEPENDENT; 
	DROP TABLE WORKS_ON; 
	DROP TABLE PROJECT;
	DROP TABLE DEPT_LOCATIONS; 
	DROP TABLE DEPARTMENT; 
	DROP TABLE EMPLOYEE;
	DROP PROCEDURE COMPLEXPROC;

	COMMIT;
