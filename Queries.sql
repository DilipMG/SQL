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




