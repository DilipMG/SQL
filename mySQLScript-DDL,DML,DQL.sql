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
-- Constraints  ---
-- ---------------------------------------------------------------------------------------------------------------------------
CREATE TABLE if not exists emp
(
id int,
name varchar(50),
address varchar (50),
city varchar(50)
);

insert into emp values(1, 'Dilip','KR Pura','Bengaluru');

-- Adding new column DOB
ALTER TABLE EMP
ADD DOB DATE;

select * from emp;

-- drop a column
ALTER TABLE EMP
DROP COLUMN CITY;

SELECT * FROM EMP;

-- Changing the column name
ALTER TABLE EMP
RENAME COLUMN NAME TO FULL_NAME;

SELECT * FROM EMP;

-- Creating new table
CREATE TABLE if not exists emp_new
(
id int,
name varchar(50),
age int,
hiring_date date,
salary int,
city varchar(50)
);

insert into emp_new values (1,'Dilip', 35, '2020-05-20', 20000, 'Bengaluru');
insert into emp_new values (2,'Aman', 26, '2022-01-02', 12000, 'Pune');
insert into emp_new values (3,'Satish', 25, '2021-02-15', 30000, 'Hyderabad');
insert into emp_new values (4,'Ravi', 30, '2020-08-10', 45000, 'Bengaluru');

select * from emp_new;

-- Altering and add constraint
ALTER TABLE EMP_NEW
ADD constraint id_unique UNIQUE(ID);

insert into emp_new values (4,'Ravi', 30, '2020-08-10', 45000, 'Bengaluru');  -- Error Code: 1062. Duplicate entry '4' for key 'emp_new.id_unique'

-- Altering and drop constraint
ALTER TABLE EMP_NEW
drop constraint id_unique;

-- ---------------------------------------------------------------------------------------------------------------------------
-- primary and foreign keys  ---
-- ---------------------------------------------------------------------------------------------------------------------------
DROP TABLE  if exists guests;
CREATE TABLE guests
(
id int,
name varchar(50),
age int,
constraint pk Primary Key (id)
);

insert into guests values (1, 'Dilip',32);
insert into guests values (1, 'Dilip',32);   -- Error Code: 1062. Duplicate entry '1' for key 'guests.PRIMARY'
insert into guests values (null, 'Dilip',32);-- Error Code: 1048. Column 'id' cannot be null  

select * from guests;
-- --------------------------------------------------------------
create table customer
(
cust_id int,
name varchar(50),
age int,
constraint pk primary key(cust_id)
);

create table orders
(
order_id int,
amount int,
customer_id int, 
constraint pk primary key(order_id),
constraint fk foreign key(customer_id) references customer(cust_id)
);

insert into customer values (1,'Dilip',32),(2,'Aman',26);
insert into orders values (1001,2000,1),(1002,2500,2);

select * from orders;

insert into orders values (1004,3000,5); -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`dilip_db`.`orders`, CONSTRAINT `fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`cust_id`))

-- Truncate and Drop 
truncate table guests;   -- Deletes all the data in the table but keeps the schema
drop table orders;       -- Deletes all the data in the table and delete the table as well

-- -----------------------------------------------------------------------------------------------------
select * from emp_new;

select count(*) from emp_new;
select count(1) from emp_new;    -- Returns 4 since 4 entries in the table
select count(100) from emp_new;  -- Returns 4 since 4 entries in the table

select * from emp_new; 

update emp_new
set salary = salary * 1.2
where age < 50;

select * from emp_new; 

update emp_new set salary= 60000 where hiring_date = '2020-08-10';
select * from emp_new; 

-- AUTO Increment Table --
create table auto_inc_exmp
(
id int auto_increment,
name varchar(20),
primary key(id)
);

insert into auto_inc_exmp(name) values ('Dilip'),('Aman'),('Ravi');  -- INserts id as 1,2,3
select * from auto_inc_exmp;

insert into auto_inc_exmp values (6,'Satish');  -- inserts entry with id as 6
insert into auto_inc_exmp(name) values ('Shaman');  -- auto increments from 6 i.e., to 7
select * from auto_inc_exmp;

-- -----------------------------------------------------
select * from emp_new limit 2;

select * from emp_new order by salary desc limit 2;






