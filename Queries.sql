-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------
CREATE TABLE CITY
(
ID int, 
NAME VARCHAR(17) NOT NULL,
COUNTRYCODE VARCHAR(3),
DISTRICT VARCHAR(30),
POPULATION int,
constraint unique_city_id unique(id)
);

CREATE TABLE STATION
(
ID int, 
CITY VARCHAR(21) NOT NULL,
STATE VARCHAR(2),
LAT_N INT,
LONG_W int,
constraint unique_state_id unique(id)
);

-- Query all columns for all American cities in theCITY table with populations larger than 100000.The CountryCode for America is USA.
SELECT * FROM CITY
WHERE POPULATION > 100000
AND COUNTRYCODE = 'USA';

-- Query the NAME field for all American cities inthe CITY table with populations larger than 120000.The CountryCode for America is USA.
SELECT NAME FROM CITY 
WHERE COUNTRYCODE = 'USA' AND 
      POPULATION > 120000;

-- Query all columns (attributes) for every row in the CITY table.
SELECT * FROM CITY;

-- Query all columns for a city in CITY with theID 1661.
SELECT * FROM CITY WHERE ID = 1661;

-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan isJPN.
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Query a list of CITY and STATE from the STATIONtable.
SELECT CITY, STATE FROM STATION;

-- Query a list of CITY names from STATION for citiesthat have an even ID number. Print the results
-- in any order, but exclude duplicates from the answer.
SELECT DISTINCT(CITY) FROM STATION 
where (ID % 2 = 0)
order by city;

-- Find the difference between the total number of CITY entries in
-- the table and the number of distinct CITY entries in the table.
SELECT COUNT(CITY) AS TOTAL_NUMBER, COUNT(DISTINCT(CITY)) AS DISTINCT_CITY, (COUNT(CITY) -COUNT(DISTINCT(CITY))) AS DIFFERENCE   FROM STATION;

-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of
-- characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

SELECT * FROM STATION  ORDER BY LENGTH(CITY) asc LIMIT 1;
SELECT * FROM STATION  ORDER BY LENGTH(CITY) desc LIMIT 1;

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT CITY FROM STATION 
WHERE lcase (CITY) like 'a%' or 
      lcase (CITY) like 'e%' or 
      lcase (CITY) like 'i%' or 
      lcase (CITY) like 'o%' or 
      lcase (CITY) like 'u%'
order by CITY;

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT distinct(city) FROM STATION 
WHERE lcase (CITY) like '%a' or 
      lcase (CITY) like '%e' or 
      lcase (CITY) like '%i' or 
      lcase (CITY) like '%o' or 
      lcase (CITY) like '%u'
order by CITY;

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct(city) from station 
where lcase(city) not like 'a%' and 
      lcase(city) not like 'e%' and 
      lcase(city) not like 'i%' and 
      lcase(city) not like 'o%' and 
      lcase(city) not like 'u%';
      
-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.  
  select distinct(city) from station 
where lcase(city) not like '%a' and 
      lcase(city) not like '%e' and 
      lcase(city) not like '%i' and 
      lcase(city) not like '%o' and 
      lcase(city) not like '%u';  

-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
-- Your result cannot contain duplicates.
  select distinct(city) from station 
where lcase(city) not regexp '^[aeiou]' or lcase(city) not regexp '[aeiou]$';
      
-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
  select distinct(city) from station 
where lcase(city) not regexp '^[aeiou]' and lcase(city) not regexp '[aeiou]$';

-- Table: Product
-- product_id is the primary key of this table.
-- Each row of this table indicates the name and the price of each product.

create table if not exists Product
(
product_id int,
product_name varchar(40),
unit_price int,
constraint pk primary key(product_id)
);

insert into Product values(1,'S8',1000);
insert into Product values(2,'G4',800);
insert into Product values(3,'iPhone',1400);

select * from Product;

-- Table: Sales
create table if not exists Sales
(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int,
constraint fk FOREIGN KEY (product_id) REFERENCES
Product(product_id)
);

insert into Sales values(1,1,1,'2019-01-21',2,2000);
insert into Sales values(1,2,2,'2019-02-17',1,800);
insert into Sales values(2,2,3,'2019-06-02',1,800);
insert into Sales values(3,3,4,'2019-05-13',2,2800);
select * from Sales;

-- Write an SQL query that reports the products that were only sold in the first quarter of 2019. 
-- i.e., between 2019-01-01 and 2019-03-31 inclusive. Return the result table in any order.

SELECT product_id, product_name, unit_price from Product;
select * from Sales;

select seller_id, p.product_id, buyer_id, sale_date, quantity, price
from Product p join Sales s
on p.product_id = s.product_id
where p.product_id not in (select product_id from sales 
                          where sale_date not between '2019-01-01' and '2019-03-31');
                          

-- Table: Views
-- Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order. The query result format is in the following example.					

create table views
(
article int,
author_id int,
viewer_id int, 
view_date date
);

insert into Views VALUES (1,3,5,'2019-08-01'),
(1,3,6,'2019-08-02'),(2,7,7,'2019-08-01'),(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'), (3,4,4,'2019-07-21'),(3,4,4,'2019-07-21');
select * from Views;

select distinct author_id from views
where author_id = viewer_id
order by author_id;

-- table: Delivery
create table Delivery
(
delivery_id int primary key, 
customer_id int,
order_date date, 
customer_pref_delivery_date date
);

insert into Delivery values
(1,1,'2019-08-01','2019-08-02'),(2,5,'2019-08-02','2019-08-02'),(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),(5,4,'2019-08-21','2019-08-22'),(6,2,'2019-08-11','2019-08-13');

select * from delivery;

-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
select round(((select count(*) from delivery where order_date = customer_pref_delivery_date)/
       (count(*))*100),2) as immediate_perc
from delivery; 

-- Table: Ads
-- Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.

create table if not exists ads
(
ad_id int, 
user_id int,
action enum('Clicked', 'Viewed', 'Ignored'),
constraint pk PRIMARY KEY (ad_id, user_id)
);

insert into Ads VALUES
(1,1,'Clicked'),(2,2,'Clicked'),(3,3,'Viewed'),(5,5,'Ignored'),(1,7,'Ignored'),
(2,7,'Viewed'),(3,5,'Clicked'),(1,4,'Viewed'),(2,11,'Viewed'),(1,2,'Clicked');
select * from Ads;

-- Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.
select ad_id,
ifnull(
    round(
	    avg(case
                 when action = "Clicked" then 1
			     when action = "Viewed" then 0
             else null
             end) * 100,2),0)
as ctr
from Ads
group by ad_id
order by ctr desc, ad_id asc;

-- table: Employee_assignment
-- Write an SQL query to find the team size of each of the employees. Return result table in any order.
create table employee_assignment
(
employee_id int primary key, 
team_id int
);

insert into employee_assignment VALUES(1,8),(2,8),(3,8),(4,7),(5,9),(6,9);

select * from employee_assignment;

select employee_id, tcount
from employee_assignment e1, (select e2.team_id, count(*) as tcount from employee_assignment e2 group by e2.team_id) as e2
where e1.team_id = e2.team_id;

select employee_id,
count(*) over(partition by team_id) as team_size
from employee_assignment order by employee_id ;

-- table: Countries
create table countries
(country_id int,
 country_name varchar(25),
 constraint pk primary key (country_id)
);

insert into Countries VALUES
(2,'USA'),(3,'Australia'),(7,'Peru'),(5,'China'),(8,'Morocco'),(9,'Spain');

select * from countries;

-- Table: Weather
create table if not exists Weather
(
country_id int,
weather_state int,
day date,
constraint pk PRIMARY KEY (country_id, day)
);

insert into Weather VALUES
(2,15,'2019-11-01'),(2,12,'2019-10-28'),(2,12,'2019-10-27'),(3,-2,'2019-11-10'),
(3,0,'2019-11-11'),(3,3,'2019-11-12'),(5,16,'2019-11-07'),(5,18,'2019-11-09'),
(5,21,'2019-11-23'),(7,25,'2019-11-28'),(7,22,'2019-12-01'),(7,20,'2019-12-02'),
(8,25,'2019-11-05'),(8,27,'2019-11-15'),(8,31,'2019-11-25'),(9,7,'2019-10-23'),(9,3,'2019-12-23');

select * from Weather;

-- Write an SQL query to find the type of weather in each country for November 2019.
-- The type of weather is:
-- 1. Cold if the average weather_state is less than or equal 15,
-- 2. Hot if the average weather_state is greater than or equal to 25, and
-- 3. Warm otherwise.

select c.country_name, 
	   case
         when avg(w.weather_state) <=15 then 'Cold'
         when avg(w.weather_state) >= 25 then 'Hot'
         else 'Warm'
       end as weather_type
from weather w inner join countries c
on c.country_id = w.country_id
where day between '2019-11-01' and '2019-11-30'
group by c.country_id
order by weather_type;

-- Write an SQL query to find the average selling price for each product. 
-- average_price should be rounded to 2 decimal places.

Create table prices
(
product_id int,
start_date date,
end_date date,
price int,
constraint pk primary key(product_id, start_date, end_date)
);

create table unitssold
(
product_id int,
purchase_date date,
units int
);

insert into Prices VALUES
(1,'2019-02-17','2019-02-28',5),(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),(2,'2019-02-21','2019-03-31',30);

insert into unitssold VALUES
(1,'2019-02-25',100),(1,'2019-03-01',15),(2,'2019-02-10',200),(2,'2019-03-22',30);

SELECT a.product_id
, round(SUM(a.units * b.price) / SUM(a.units), 2) AS
average_price
FROM UnitsSold a
JOIN Prices b
ON (a.product_id = b.product_id)
where (a.purchase_date >= b.start_date
AND a.purchase_date <= b.end_date)
GROUP BY product_id;

-- Write an SQL query to report the first login date for each player.
create table activity
(
player_id int,
device_id int,
event_date date,
games_played int,
constraint pk primary key(player_id, event_date)
);

INSERT into Activity values
(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

select player_id, min(event_date) as first_login
from activity
group by player_id
order by player_id;

select
tmp.player_id,tmp.event_date as first_login
from (select *,
row_number() over(partition by player_id ) as row_num
from Activity) tmp
where tmp.row_num = 1;

-- This query assigns the row number based on the event_date ascneding order. 
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS row_num
FROM activity;

-- select the 3rd highest salary taker. 
create table salary
(
emp_name varchar(20),
salary int
);

insert into salary values ('Dilip',20000),('Aman',10000),('Ravi',25000),('Satish',99000),('Kiran',1000),
						  ('Pritvi',98000),('Raki',31000),('Suraj',99000),('Rajesh',87000),('Nagesh',35000);   
                          
with ranked as	
  (select *, 
    dense_rank() over (order by salary desc) as salary_sorted
  from salary)
  select emp_name, salary from ranked where salary_sorted = 3;
 
select  emp_name, salary
from
(select *, dense_rank() over(order by salary desc) as salary_sorted from salary) as tmp
where tmp.salary_sorted = 3;
   
select * from salary order by salary desc limit 1 offset 2;   -- offset = SKIP
     
-- Write an SQL query to report the device that is first logged in for each player.     
select player_id, device_id
from (select *,
       row_number() over (partition by player_id order by device_id) as first_device
from activity) as tmp
where tmp.first_device = 1;

-- Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
create table if not exists Products
(
product_id int,
product_name VARCHAR(50),
product_category VARCHAR(50),
constraint pk PRIMARY KEY (product_id)
);
insert into Products values (1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology','Book'),
                            (3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit','T-shirt');

-- Table: Orders
create table if not exists Orders
(
product_id int,
order_date date,
unit int,
constraint fk1 FOREIGN KEY (product_id) REFERENCES
Products(product_id)
);
insert into Orders values
(1,'2020-02-05',60),(1,'2020-02-10',70),(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),(4,'2020-03-01',20),(4,'2020-03-04',30),
(4,'2020-03-04',60),(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select * from Orders;
select * from Products;

-- Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.

select p.product_id, product_name, product_category, tmp.total_units_sold
from products p inner join 
  (select product_id, sum(unit) as total_units_sold
    from orders o
    where  
      o.order_date >= '2020-02-01' and
      o.order_date <= '2020-02-29'
    group by o.product_id) as tmp
on tmp.product_id = p.product_id;

-- Write an SQL query to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- The prefix name is a string that may contain letters (upper or lower case), digits, underscore 
-- '_', period '.', and/or dash '-'. The prefix name must start with a letter. The domain ● is '@leetcode.com'.    

-- Table: Users
create table if not exists Users
(
user_id int,
name varchar(50),
mail varchar(50),
constraint pk PRIMARY KEY (user_id)
);
insert into Users VALUES
(1,'Winston','winston@leetcode.com'),(2,'Jonathan','jonathanisgreat'),
(3,'Annabelle','bella-@leetcode.com'),(4,'Sally','sally.come@leetcode.com'),
(5,'Marwan','quarz#2020@leetcode.com'),(6,'David','david69@gmail.com'),
(7,'Shapiro','.shapo@leetcode.com');
select * from Users;
       
SELECT *
FROM Users
WHERE REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode.com');       

-- Write an SQL query to report the customer_id and customer_name of customers who have spent at
-- least $100 in each month of June and July 2020.
-- Table: Customers
create table if not exists Customers1
(
customer_id int,
name varchar(50),
country varchar(50),
constraint pk PRIMARY KEY (customer_id)
);

insert into Customers1 VALUES
(1,'Winston','USA'),(2,'Jonathan','Peru'),(3,'Moustafa','Egypt');
select * from Customers1;

-- Table: Product
create table if not exists Product1
(
product_id int,
description varchar(255),
price int,
constraint pk PRIMARY KEY (product_id)
);

insert into Product1 values (10,'LC Phone',300),(20,'LC T-Shirt',10),(30,'LC Book',45),(40,'LC Keychain',2);

-- Table: Orders1
create table if not exists Orders1
(
order_id int,
customer_id int,
product_id int,
order_date DATE,
quantity int,
constraint pk PRIMARY KEY (order_id)
-- constraint fk FOREIGN KEY (customer_id) REFERENCES Customers1(customer_id),
-- constraint fk1 FOREIGN KEY (product_id) REFERENCES Product1(product_id)
);
insert into Orders1 VALUES
(1,1,10,'2020-06-10',1),(2,1,20,'2020-07-01',1),(3,1,30,'2020-07-08',2),
(4,2,10,'2020-06-15',2),(5,2,40,'2020-07-01',10),(6,3,20,'2020-06-24',2),
(7,3,30,'2020-06-25',2),(9,3,30,'2020-05-08',3);

select * from customers1;
select * from product1;
select * from Orders1;

select o.customer_id, c.name
from Customers1 c, Product1 p, Orders1 o
where c.customer_id = o.customer_id and p.product_id = o.product_id
group by o.customer_id
having
(
sum(case 
      when o.order_date like '2020-06%' then o.quantity*p.price
      else 0 
	 end) >= 100
and
sum(case 
      when o.order_date like '2020-07%' then o.quantity*p.price
      else 0 
	end) >= 100
);

-- User Defined Functions (UDF) ---------------------------
-----------------------------------------------------------------------------------
create table sales_udf
(sales_id int auto_increment primary key,
sales_person varchar(50),
product varchar(50),
quantity int, 
price_per_unit decimal(10,2),
sale_date date
);

insert into sales_udf(sales_person, product, quantity, price_per_unit, sale_date) values
  ('Dilip', 'Laptop', 2, 91000.00, '2024-01-03'),
  ('Aman', 'Samrtphone', 11, 41000.00, '2024-02-19'),
  ('Dilip', 'Tablet', 10, 1000.00, '2024-03-18'),
  ('Praveen', 'Laptop', 17, 62000.00, '2024-04-17'),
  ('Aman', 'Smartphone', 6, 24000.00, '2024-05-11'),
  ('Satish', 'Tablet', 3, 4000.00, '2024-06-23');
  
DROP FUNCTION calculate_total_revenue
DELIMITER $$
CREATE FUNCTION calculate_total_revenue(salesperson_name varchar(100))
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
	DECLARE total_revenue DECIMAL(10,2);
    
    SELECT SUM(Quantity * price_per_unit) into total_revenue
    FROM sales_udf
    WHERE sales_person = salesperson_name;
    
    RETURN ifnull(total_revenue,0);
END $$
DELIMITER ; 

select * from sales_udf;

SELECT DISTINCT sales_person, calculate_total_revenue (sales_person) as total_revenue from sales_udf;
-- --------------------------------------------------------------------------------
-- ---------   CONCAT   -----------------------------------------------------------
CREATE TABLE employee_names
(first_name varchar(20),
 last_name varchar(20)
);

insert into employee_names values ('Dilip','MG'),('Aman','Saiful'),('Satish','Teddu');

select *, concat(first_name,' ', last_name) as full_name from employee_names;
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------

