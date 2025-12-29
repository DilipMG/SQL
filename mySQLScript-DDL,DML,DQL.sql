-- command to create database
create database dilip_db;

-- command to see list of databses
show databases;

-- command to create database
create database temp_db;

-- command to drop database
drop database temp_db;

-- command to get inside database
use dilip_db;

-- create the tabel EMPLOYEE
CREATE TABLE if not EXISTS EMPLOYEE
(
id int,
emp_name VARCHAR(20)
);

-- command to list tables
show tables;

-- command to see table definition 
show create table employee;

-- creating new EMPLOYEE table. 
Create TABLE EMPLOYEE_v1
( id int, 
  name varchar(20),
  salary  DOUBLE,
  hiring_date date
);


-- inserting the record(s) into EMPLOYEE_V1
INSERT INTO EMPLOYEE_v1 values (172158, 'Dilip', 75000, '2020-05-20');

-- inserting the record(s) into EMPLOYEE_V1 for specific columns
INSERT INTO EMPLOYEE_v1(id, name, salary) values (223344, 'Rahul', 75000 );

-- inserting multiple rows
INSERT INTO EMPLOYEE_v1 values (223345, 'Aman', 15000, '2023-05-20'),
                               (223346, 'Satish', 25000, '2022-03-15'),
                               (223347, 'Ravi', 45000, '2021-02-10');

-- Reading the data from EMPLOYEE_v1
SELECT * from EMPLOYEE_v1;

-- creating new EMPLOYEE_with_constraints table. 
Create TABLE EMPLOYEE_with_constraints
( id int, 
  name varchar(20) NOT NULL,
  salary  DOUBLE,
  hiring_date date default '2021-01-01',
  unique(id),
  check (salary>1000)
);

INSERT INTO EMPLOYEE_with_constraints values (172158, 'Dilip', 75000, '2020-05-20');
INSERT INTO EMPLOYEE_with_constraints (id, name, salary) values (223344, 'Rahul', 75000 );
INSERT INTO EMPLOYEE_with_constraints values (223345, 'Aman', 15000, '2023-05-20'),
                               (223346, 'Satish', 25000, '2022-03-15'),
                               (223347, 'Ravi', 45000, '2021-02-10');
                               
INSERT INTO EMPLOYEE_with_constraints values (172158, 'Dilip', 75000, '2020-05-20');  -- Error Code: 1062. Duplicate entry '172158' for key 'employee_with_constraints.id'
INSERT INTO EMPLOYEE_with_constraints values (172151, null , 75000, '2020-05-20');    -- Error Code: 1048. Column 'name' cannot be null                           
INSERT INTO EMPLOYEE_with_constraints values (172151, 'Raj' , 500, '2020-05-20');     -- Error Code: 3819. Check constraint 'employee_with_constraints_chk_1' is violated.
                          
select * from EMPLOYEE_with_constraints;

-- creating new EMPLOYEE_with_constraints table. 
Create TABLE EMPLOYEE_with_constraints_tmp
( id int, 
  name varchar(20) NOT NULL,
  salary  DOUBLE,
  hiring_date date default '2021-01-01',
  constraint unique_emp_id unique(id),
  constraint salary_check check (salary>1000)
);

INSERT INTO EMPLOYEE_with_constraints_tmp values (172158, 'Dilip', 75000, '2020-05-20');
INSERT INTO EMPLOYEE_with_constraints_tmp (id, name, salary) values (223344, 'Rahul', 75000 );
INSERT INTO EMPLOYEE_with_constraints_tmp values (223345, 'Aman', 15000, '2023-05-20'),
                               (223346, 'Satish', 25000, '2022-03-15'),
                               (223347, 'Ravi', 45000, '2021-02-10');

INSERT INTO EMPLOYEE_with_constraints_tmp values (172151, 'Raj' , 500, '2020-05-20');     -- Error Code: 3819. Check constraint 'salary_check' is violated.

-- ---------------------------------------------------------------------------------------------------------------------------
