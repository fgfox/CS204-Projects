/*
	Griffen Fox, CS204 
	Homework 12: Part One 
*/
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- I.Create Tables
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	create table Employee 
	(
		Fname 			varchar(15)		not null,
		Minit 			char,
		Lname 			varchar(15)		not null,
		Ssn 			char(9)			primary key,
		Bdate 			date,
		Address 		varchar(30), 
		Sex 			char			check (Sex in ('M', 'F')),
		Salary 			decimal(10,2)	check (Salary > 20000), 
		Super_ssn 		char(9)			references Employee,
		Dno 			int 					
	);

	create table audit_trail 
	(
		message varchar(500)
	);

	commit;

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- II.Insert Tuples
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	insert into Employee values ('James', 'E', 'Borg', 888665555,'10-Nov-27', '450 Stone, Houston, TX', 'M', 55000, null, null);

	insert into Employee values ('Jennifer', 'S', 'Wallace', 987654321,'20-Jun-31', '291 Berry, Bellaire, TX', 'F', 43000, 888665555, null);

	insert into Employee values ('Ahmad', 'V', 'Jabbar', 987987987,'29-Mar-59', '980 Dallas, Houston, TX', 'M', 25000, 987654321, null);

	insert into Employee values ('Alicia', 'J', 'Zelaya', 999887777,'19-Jul-58', '3321 Castle, Spring, TX', 'F', 25000, 987654321, null);

	insert into Employee values ('Franklin', 'T', 'Wong', 333445555,'08-Dec-45', '638 Voss, Houston, TX', 'M', 40000, 888665555, null);

	insert into Employee values ('Joyce', 'A', 'English', 453453453,'31-Jul-62', '5631 Rice, Houston, TX', 'F', 25000, 333445555, null);

	insert into Employee values ('Ramesh', 'K', 'Narayan', 666884444,'15-Sep-52', '975 Fire Oak, Humble, TX', 'M', 38000, 333445555, null);  

	insert into Employee values ('John', 'B', 'Smith', 123456789,'09-Jan-55', '731 Fondren, Houston, TX', 'M', 30000, 333445555, null);

	commit;

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- III.Create Triggers
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	create trigger before_table before update of Salary on Employee
		begin
			insert into audit_trail values ('Before_table trigger fired');
		end;
	/

	create trigger before_row before update of Salary on Employee for each row
		begin
			insert into audit_trail values ('Before_row trigger fired');
		end;
	/

	create trigger after_row after update of Salary on Employee for each row
		begin
			insert into audit_trail values ('After_row trigger fired');
		end;
	/

	create trigger after_table after update of Salary on Employee
		begin
			insert into audit_trail values ('After_table trigger fired');
		end;
	/

	commit;
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- IV.Show Compilation Errors
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	show error trigger before_table;
	
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- V.Increase All Salaries by 10%
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	update Employee set Salary = Salary * 1.10;
	
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- VI.Show Contents of Audit Trail Table\
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	select * from audit_trail;

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Drop Tables and Triggers
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	drop trigger before_table;
	drop trigger before_row;
	drop trigger after_row;
	drop trigger after_table;

	drop table Employee;
	drop table audit_trail;

	commit;