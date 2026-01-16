-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------
CREATE TABLE CITY (
    ID INT,
    NAME VARCHAR(17) NOT NULL,
    COUNTRYCODE VARCHAR(3),
    DISTRICT VARCHAR(30),
    POPULATION INT,
    CONSTRAINT unique_city_id UNIQUE (id)
);

CREATE TABLE STATION (
    ID INT,
    CITY VARCHAR(21) NOT NULL,
    STATE VARCHAR(2),
    LAT_N INT,
    LONG_W INT,
    CONSTRAINT unique_state_id UNIQUE (id)
);

-- Query all columns for all American cities in theCITY table with populations larger than 100000.The CountryCode for America is USA.
SELECT 
    *
FROM
    CITY
WHERE
    POPULATION > 100000
        AND COUNTRYCODE = 'USA';

-- Query the NAME field for all American cities inthe CITY table with populations larger than 120000.The CountryCode for America is USA.
SELECT 
    NAME
FROM
    CITY
WHERE
    COUNTRYCODE = 'USA'
        AND POPULATION > 120000;

-- Query all columns (attributes) for every row in the CITY table.
SELECT 
    *
FROM
    CITY;

-- Query all columns for a city in CITY with theID 1661.
SELECT 
    *
FROM
    CITY
WHERE
    ID = 1661;

-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan isJPN.
SELECT 
    *
FROM
    CITY
WHERE
    COUNTRYCODE = 'JPN';

-- Query a list of CITY and STATE from the STATIONtable.
SELECT 
    CITY, STATE
FROM
    STATION;

-- Query a list of CITY names from STATION for citiesthat have an even ID number. Print the results
-- in any order, but exclude duplicates from the answer.
SELECT DISTINCT
    (CITY)
FROM
    STATION
WHERE
    (ID % 2 = 0)
ORDER BY city;

-- Find the difference between the total number of CITY entries in
-- the table and the number of distinct CITY entries in the table.
SELECT 
    COUNT(CITY) AS TOTAL_NUMBER,
    COUNT(DISTINCT (CITY)) AS DISTINCT_CITY,
    (COUNT(CITY) - COUNT(DISTINCT (CITY))) AS DIFFERENCE
FROM
    STATION;

-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of
-- characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

SELECT 
    *
FROM
    STATION
ORDER BY LENGTH(CITY) ASC
LIMIT 1;
SELECT 
    *
FROM
    STATION
ORDER BY LENGTH(CITY) DESC
LIMIT 1;

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT 
    CITY
FROM
    STATION
WHERE
    LCASE(CITY) LIKE 'a%'
        OR LCASE(CITY) LIKE 'e%'
        OR LCASE(CITY) LIKE 'i%'
        OR LCASE(CITY) LIKE 'o%'
        OR LCASE(CITY) LIKE 'u%'
ORDER BY CITY;

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT
    (city)
FROM
    STATION
WHERE
    LCASE(CITY) LIKE '%a'
        OR LCASE(CITY) LIKE '%e'
        OR LCASE(CITY) LIKE '%i'
        OR LCASE(CITY) LIKE '%o'
        OR LCASE(CITY) LIKE '%u'
ORDER BY CITY;

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT
    (city)
FROM
    station
WHERE
    LCASE(city) NOT LIKE 'a%'
        AND LCASE(city) NOT LIKE 'e%'
        AND LCASE(city) NOT LIKE 'i%'
        AND LCASE(city) NOT LIKE 'o%'
        AND LCASE(city) NOT LIKE 'u%';
      
-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.  
SELECT DISTINCT
    (city)
FROM
    station
WHERE
    LCASE(city) NOT LIKE '%a'
        AND LCASE(city) NOT LIKE '%e'
        AND LCASE(city) NOT LIKE '%i'
        AND LCASE(city) NOT LIKE '%o'
        AND LCASE(city) NOT LIKE '%u';

-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
-- Your result cannot contain duplicates.
SELECT DISTINCT
    (city)
FROM
    station
WHERE
    LCASE(city) NOT REGEXP '^[aeiou]'
        OR LCASE(city) NOT REGEXP '[aeiou]$';
      
-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
SELECT DISTINCT
    (city)
FROM
    station
WHERE
    LCASE(city) NOT REGEXP '^[aeiou]'
        AND LCASE(city) NOT REGEXP '[aeiou]$';

-- Table: Product
-- product_id is the primary key of this table.
-- Each row of this table indicates the name and the price of each product.

CREATE TABLE IF NOT EXISTS Product (
    product_id INT,
    product_name VARCHAR(40),
    unit_price INT,
    CONSTRAINT pk PRIMARY KEY (product_id)
);

insert into Product values(1,'S8',1000);
insert into Product values(2,'G4',800);
insert into Product values(3,'iPhone',1400);

SELECT 
    *
FROM
    Product;

-- Table: Sales
CREATE TABLE IF NOT EXISTS Sales (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT,
    CONSTRAINT fk FOREIGN KEY (product_id)
        REFERENCES Product (product_id)
);

insert into Sales values(1,1,1,'2019-01-21',2,2000);
insert into Sales values(1,2,2,'2019-02-17',1,800);
insert into Sales values(2,2,3,'2019-06-02',1,800);
insert into Sales values(3,3,4,'2019-05-13',2,2800);
SELECT 
    *
FROM
    Sales;

-- Write an SQL query that reports the products that were only sold in the first quarter of 2019. 
-- i.e., between 2019-01-01 and 2019-03-31 inclusive. Return the result table in any order.

SELECT 
    product_id, product_name, unit_price
FROM
    Product;
SELECT 
    *
FROM
    Sales;

SELECT 
    seller_id,
    p.product_id,
    buyer_id,
    sale_date,
    quantity,
    price
FROM
    Product p
        JOIN
    Sales s ON p.product_id = s.product_id
WHERE
    p.product_id NOT IN (SELECT 
            product_id
        FROM
            sales
        WHERE
            sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31');
                          

-- Table: Views
-- Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order. The query result format is in the following example.					

CREATE TABLE views (
    article INT,
    author_id INT,
    viewer_id INT,
    view_date DATE
);

insert into Views VALUES (1,3,5,'2019-08-01'),
(1,3,6,'2019-08-02'),(2,7,7,'2019-08-01'),(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'), (3,4,4,'2019-07-21'),(3,4,4,'2019-07-21');
SELECT 
    *
FROM
    Views;

SELECT DISTINCT
    author_id
FROM
    views
WHERE
    author_id = viewer_id
ORDER BY author_id;

-- table: Delivery
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

insert into Delivery values
(1,1,'2019-08-01','2019-08-02'),(2,5,'2019-08-02','2019-08-02'),(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),(5,4,'2019-08-21','2019-08-22'),(6,2,'2019-08-11','2019-08-13');

SELECT 
    *
FROM
    delivery;

-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
SELECT 
    ROUND(((SELECT 
                    COUNT(*)
                FROM
                    delivery
                WHERE
                    order_date = customer_pref_delivery_date) / (COUNT(*)) * 100),
            2) AS immediate_perc
FROM
    delivery;

-- Table: Ads
-- Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.

CREATE TABLE IF NOT EXISTS ads (
    ad_id INT,
    user_id INT,
    action ENUM('Clicked', 'Viewed', 'Ignored'),
    CONSTRAINT pk PRIMARY KEY (ad_id , user_id)
);

insert into Ads VALUES
(1,1,'Clicked'),(2,2,'Clicked'),(3,3,'Viewed'),(5,5,'Ignored'),(1,7,'Ignored'),
(2,7,'Viewed'),(3,5,'Clicked'),(1,4,'Viewed'),(2,11,'Viewed'),(1,2,'Clicked');
SELECT 
    *
FROM
    Ads;

-- Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.
SELECT 
    ad_id,
    IFNULL(ROUND(AVG(CASE
                        WHEN action = 'Clicked' THEN 1
                        WHEN action = 'Viewed' THEN 0
                        ELSE NULL
                    END) * 100,
                    2),
            0) AS ctr
FROM
    Ads
GROUP BY ad_id
ORDER BY ctr DESC , ad_id ASC;

-- table: Employee_assignment
-- Write an SQL query to find the team size of each of the employees. Return result table in any order.
CREATE TABLE employee_assignment (
    employee_id INT PRIMARY KEY,
    team_id INT
);

insert into employee_assignment VALUES(1,8),(2,8),(3,8),(4,7),(5,9),(6,9);

SELECT 
    *
FROM
    employee_assignment;

SELECT 
    employee_id, tcount
FROM
    employee_assignment e1,
    (SELECT 
        e2.team_id, COUNT(*) AS tcount
    FROM
        employee_assignment e2
    GROUP BY e2.team_id) AS e2
WHERE
    e1.team_id = e2.team_id;

select employee_id,
count(*) over(partition by team_id) as team_size
from employee_assignment order by employee_id ;

-- table: Countries
CREATE TABLE countries (
    country_id INT,
    country_name VARCHAR(25),
    CONSTRAINT pk PRIMARY KEY (country_id)
);

insert into Countries VALUES
(2,'USA'),(3,'Australia'),(7,'Peru'),(5,'China'),(8,'Morocco'),(9,'Spain');

SELECT 
    *
FROM
    countries;

-- Table: Weather
CREATE TABLE IF NOT EXISTS Weather (
    country_id INT,
    weather_state INT,
    day DATE,
    CONSTRAINT pk PRIMARY KEY (country_id , day)
);

insert into Weather VALUES
(2,15,'2019-11-01'),(2,12,'2019-10-28'),(2,12,'2019-10-27'),(3,-2,'2019-11-10'),
(3,0,'2019-11-11'),(3,3,'2019-11-12'),(5,16,'2019-11-07'),(5,18,'2019-11-09'),
(5,21,'2019-11-23'),(7,25,'2019-11-28'),(7,22,'2019-12-01'),(7,20,'2019-12-02'),
(8,25,'2019-11-05'),(8,27,'2019-11-15'),(8,31,'2019-11-25'),(9,7,'2019-10-23'),(9,3,'2019-12-23');

SELECT 
    *
FROM
    Weather;

-- Write an SQL query to find the type of weather in each country for November 2019.
-- The type of weather is:
-- 1. Cold if the average weather_state is less than or equal 15,
-- 2. Hot if the average weather_state is greater than or equal to 25, and
-- 3. Warm otherwise.

SELECT 
    c.country_name,
    CASE
        WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
        WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
        ELSE 'Warm'
    END AS weather_type
FROM
    weather w
        INNER JOIN
    countries c ON c.country_id = w.country_id
WHERE
    day BETWEEN '2019-11-01' AND '2019-11-30'
GROUP BY c.country_id
ORDER BY weather_type;

-- Write an SQL query to find the average selling price for each product. 
-- average_price should be rounded to 2 decimal places.

CREATE TABLE prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    CONSTRAINT pk PRIMARY KEY (product_id , start_date , end_date)
);

CREATE TABLE unitssold (
    product_id INT,
    purchase_date DATE,
    units INT
);

insert into Prices VALUES
(1,'2019-02-17','2019-02-28',5),(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),(2,'2019-02-21','2019-03-31',30);

insert into unitssold VALUES
(1,'2019-02-25',100),(1,'2019-03-01',15),(2,'2019-02-10',200),(2,'2019-03-22',30);

SELECT 
    a.product_id,
    ROUND(SUM(a.units * b.price) / SUM(a.units), 2) AS average_price
FROM
    UnitsSold a
        JOIN
    Prices b ON (a.product_id = b.product_id)
WHERE
    (a.purchase_date >= b.start_date
        AND a.purchase_date <= b.end_date)
GROUP BY product_id;

-- Write an SQL query to report the first login date for each player.
CREATE TABLE activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    CONSTRAINT pk PRIMARY KEY (player_id , event_date)
);

INSERT into Activity values
(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

SELECT 
    player_id, MIN(event_date) AS first_login
FROM
    activity
GROUP BY player_id
ORDER BY player_id;

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
CREATE TABLE salary (
    emp_name VARCHAR(20),
    salary INT
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
   
SELECT 
    *
FROM
    salary
ORDER BY salary DESC
LIMIT 1 OFFSET 2;   -- offset = SKIP
     
-- Write an SQL query to report the device that is first logged in for each player.     
select player_id, device_id
from (select *,
       row_number() over (partition by player_id order by device_id) as first_device
from activity) as tmp
where tmp.first_device = 1;

-- Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
CREATE TABLE IF NOT EXISTS Products (
    product_id INT,
    product_name VARCHAR(50),
    product_category VARCHAR(50),
    CONSTRAINT pk PRIMARY KEY (product_id)
);
insert into Products values (1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology','Book'),
                            (3,'HP','Laptop'),(4,'Lenovo','Laptop'),(5,'Leetcode Kit','T-shirt');

-- Table: Orders
CREATE TABLE IF NOT EXISTS Orders (
    product_id INT,
    order_date DATE,
    unit INT,
    CONSTRAINT fk1 FOREIGN KEY (product_id)
        REFERENCES Products (product_id)
);
insert into Orders values
(1,'2020-02-05',60),(1,'2020-02-10',70),(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),(4,'2020-03-01',20),(4,'2020-03-04',30),
(4,'2020-03-04',60),(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

SELECT 
    *
FROM
    Orders;
SELECT 
    *
FROM
    Products;

-- Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.

SELECT 
    p.product_id,
    product_name,
    product_category,
    tmp.total_units_sold
FROM
    products p
        INNER JOIN
    (SELECT 
        product_id, SUM(unit) AS total_units_sold
    FROM
        orders o
    WHERE
        o.order_date >= '2020-02-01'
            AND o.order_date <= '2020-02-29'
    GROUP BY o.product_id) AS tmp ON tmp.product_id = p.product_id;

-- Write an SQL query to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- The prefix name is a string that may contain letters (upper or lower case), digits, underscore 
-- '_', period '.', and/or dash '-'. The prefix name must start with a letter. The domain ● is '@leetcode.com'.    

CREATE TABLE IF NOT EXISTS Users (
    user_id INT,
    name VARCHAR(50),
    mail VARCHAR(50),
    CONSTRAINT pk PRIMARY KEY (user_id)
)
insert into Users VALUES
(1,'Winston','winston@leetcode.com'),(2,'Jonathan','jonathanisgreat'),
(3,'Annabelle','bella-@leetcode.com'),(4,'Sally','sally.come@leetcode.com'),
(5,'Marwan','quarz#2020@leetcode.com'),(6,'David','david69@gmail.com'),
(7,'Shapiro','.shapo@leetcode.com');
select * from Users;
 
SELECT 
    *
FROM
    Users
WHERE
    REGEXP_LIKE(mail,
            '^[a-zA-Z][a-zA-Z0-9\_.-]*@leetcode.com') 

-- Write an SQL query to report the customer_id and customer_name of customers who have spent at
-- least $100 in each month of June and July 2020.
-- Table: Customers
CREATE TABLE IF NOT EXISTS Customers1 (
    customer_id INT,
    name VARCHAR(50),
    country VARCHAR(50),
    CONSTRAINT pk PRIMARY KEY (customer_id)
)

insert into Customers1 VALUES
(1,'Winston','USA'),(2,'Jonathan','Peru'),(3,'Moustafa','Egypt');
select * from Customers1;

-- Table: Product
CREATE TABLE IF NOT EXISTS Product1 (
    product_id INT,
    description VARCHAR(255),
    price INT,
    CONSTRAINT pk PRIMARY KEY (product_id)
)

insert into Product1 values (10,'LC Phone',300),(20,'LC T-Shirt',10),(30,'LC Book',45),(40,'LC Keychain',2);

-- Table: Orders1
CREATE TABLE IF NOT EXISTS Orders1 (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    CONSTRAINT pk PRIMARY KEY (order_id)
)
insert into Orders1 VALUES
(1,1,10,'2020-06-10',1),(2,1,20,'2020-07-01',1),(3,1,30,'2020-07-08',2),
(4,2,10,'2020-06-15',2),(5,2,40,'2020-07-01',10),(6,3,20,'2020-06-24',2),
(7,3,30,'2020-06-25',2),(9,3,30,'2020-05-08',3);

SELECT 
    *
FROM
    customers1
select * from product1;
select * from Orders1;

SELECT 
    o.customer_id, c.name
FROM
    Customers1 c,
    Product1 p,
    Orders1 o
WHERE
    c.customer_id = o.customer_id
        AND p.product_id = o.product_id
GROUP BY o.customer_id
HAVING (SUM(CASE
    WHEN o.order_date LIKE '2020-06%' THEN o.quantity * p.price
    ELSE 0
END) >= 100
    AND SUM(CASE
    WHEN o.order_date LIKE '2020-07%' THEN o.quantity * p.price
    ELSE 0
END) >= 100)

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
  
-- DROP FUNCTION calculate_total_revenue

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

SELECT DISTINCT
    sales_person,
    CALCULATE_TOTAL_REVENUE(sales_person) AS total_revenue
FROM
    sales_udf
-- --------------------------------------------------------------------------------
-- ---------   CONCAT   -----------------------------------------------------------
CREATE TABLE employee_names
(first_name varchar(20),
 last_name varchar(20)
);

insert into employee_names values ('Dilip','MG'),('Aman','Saiful'),('Satish','Teddu');

SELECT 
    *, CONCAT(first_name, ' ', last_name) AS full_name
FROM
    employee_names
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
select * from emp_new where age is null;  -- getting null values
SELECT 
    *
FROM
    emp_new
WHERE
    salary IS NOT NULL -- Ignoring null value
-- ----------------------------------------------------------------------
CREATE TABLE ORDERS_DATA (
    CUST_ID INT,
    ORDER_ID INT,
    COUNTRY VARCHAR(50),
    STATE VARCHAR(50)
)

insert into orders_data values(1,100,'USA','Seattle');
insert into orders_data values(2,101,'INDIA','UP');
insert into orders_data values(2,103,'INDIA','Bihar');
insert into orders_data values(4,108,'USA','WDC');
insert into orders_data values(5,109,'UK','London');
insert into orders_data values(4,110,'USA','WDC');
insert into orders_data values(3,120,'INDIA','AP');
insert into orders_data values(2,121,'INDIA','Goa');
insert into orders_data values(1,131,'USA','Seattle');
insert into orders_data values(6,142,'USA','Seattle');
insert into orders_data values(7,150,'USA','Seattle');

SELECT 
    *
FROM
    ORDERS_DATA

SELECT 
    COUNTRY, STATE, COUNT(*)
FROM
    ORDERS_DATA
GROUP BY COUNTRY , STATE
ORDER BY COUNTRY , STATE-- TOTAL ORDERS PLACED COUNTRYWISE AND STATE

SELECT * FROM EMP_NEW;
-- WRITE A QUERY TO FIND TOTAL SALARY FOR EACH AGE GROUP. 
SELECT
    AGE, 
    SUM(SALARY) as Total_salary_BY_age,
    max(SALARY) as mAX_salary_BY_age,
    MIN(SALARY) as MIN_salary_BY_age,
    AVG(SALARY) as AVG_salary_BY_age,
    COUNT(1) as COUNT_salary_BY_age
FROM
    EMP_NEW
GROUP BY AGE
ORDER BY AGE;

-- QUERY TO SUM THE SALARY FOR EACH GROUP WHERE SALARY > 20000;
SELECT 
    AGE, SUM(SALARY) AS Total_salary_BY_age
FROM
    EMP_NEW
WHERE
    SALARY > 20000
GROUP BY AGE
ORDER BY AGE

-- QUERY TO SUM THE SALARY FOR EACH GROUP WHERE TOTAL SUM > 20000;
SELECT 
    AGE, SUM(SALARY) AS Total_salary_BY_age
FROM
    EMP_NEW
GROUP BY AGE
HAVING Total_salary_BY_age > 20000
ORDER BY AGE

-- WRITE A QUERY TO FIND ONLY ONE ORDER PLACES
SELECT 
    COUNTRY, COUNT(*) AS country_count
FROM
    ORDERS_DATA
GROUP BY COUNTRY
HAVING country_count = 1;

-- QUERY To print distinct states present in the country
SELECT country, GROUP_CONCAT(state) AS states_in_country, COUNT(*) AS ORDER_count
FROM orders_data
GROUP BY country;

SELECT country, GROUP_CONCAT(state ORDER BY STATE DESC SEPARATOR '-') AS states_in_country, COUNT(*) AS ORDER_count
FROM orders_data
GROUP BY country;

SELECT YEAR(HIRING_DATE),COUNT(*) AS TOTAL_HIRING FROM EMP_NEW
GROUP BY YEAR(HIRING_DATE);
 

-- - Group RollUP
CREATE TABLE payment (payment_amount decimal(8,2), 
payment_date date, 
store_id int);
 
INSERT INTO payment
VALUES
(1200.99, '2018-01-18', 1),
(189.23, '2018-02-15', 1),
(33.43, '2018-03-03', 3),
(7382.10, '2019-01-11', 2),
(382.92, '2019-02-18', 1),
(322.34, '2019-03-29', 2),
(2929.14, '2020-01-03', 2),
(499.02, '2020-02-19', 3),
(994.11, '2020-03-14', 1),
(394.93, '2021-01-22', 2),
(3332.23, '2021-02-23', 3),
(9499.49, '2021-03-10', 3),
(3002.43, '2018-02-25', 2),
(100.99, '2019-03-07', 1),
(211.65, '2020-02-02', 1),
(500.73, '2021-01-06', 3);

-- - Write a query to calculate total reveue of each shop
-- - per year, also display year wise revenue
SELECT
  SUM(payment_amount),
  YEAR(payment_date) AS 'Payment Year',
  store_id AS 'Store'
FROM payment
GROUP BY YEAR(payment_date), store_id WITH ROLLUP
ORDER BY YEAR(payment_date), store_id;

-- TOTAL REVENUE PER YEAR
SELECT YEAR(PAYMENT_DATE), SUM(PAYMENT_AMOUNT) 
FROM PAYMENT
GROUP BY YEAR(PAYMENT_DATE);

SELECT * FROM
(SELECT
  SUM(payment_amount) AS TOTAL,
  YEAR(payment_date) AS PAYMENT_YEAR,
  store_id AS STORE
FROM payment
GROUP BY YEAR(payment_date), store_id WITH ROLLUP
ORDER BY YEAR(payment_date), store_id) TEMP
WHERE TEMP.STORE IS NULL AND TEMP.PAYMENT_YEAR IS NOT NULL;

SELECT * FROM
(SELECT
  SUM(payment_amount) AS TOTAL,
  YEAR(payment_date) AS PAYMENT_YEAR,
  store_id AS STORE
FROM payment
GROUP BY YEAR(payment_date), store_id WITH ROLLUP
ORDER BY YEAR(payment_date), store_id) TEMP
WHERE TEMP.STORE IS NOT NULL AND TEMP.PAYMENT_YEAR IS NOT NULL;


-- Subqueries in SQL
create table employees
(
    id int,
    name varchar(50),
    salary int
);

insert into employees values(1,'Shashank',5000),(2,'Amit',5500),(3,'Rahul',7000),(4,'Rohit',6000),(5,'Nitin',4000),(6,'Sunny',7500);

-- query to fetch employees getting more salary than 'Rohit';
select * from employees
where salary > 
(select salary from employees
where name = 'Rohit') ;

-- query to select records from Seattle and Goa
SELECT 
    *
FROM
    orders_data
WHERE state IN ('Seattle' , 'Goa');

create table customer_order_data
(
    order_id int,
    cust_id int,
    supplier_id int,
    cust_country varchar(50)
);


insert into customer_order_data values(101,200,300,'USA'),(102,201,301,'INDIA'),(103,202,302,'USA'),(104,203,303,'UK');

create table supplier_data
(
    supplier_id int,
    sup_country varchar(50)
);

insert into supplier_data values(300,'USA'),(303,'UK');

select * from customer_order_data;
select * from supplier_data;

-- write a query to find all customer order data where all customers are from same countries 
-- as the suppliers
select * from customer_order_data, 
(select sup_country from supplier_data) as sup
where cust_country = sup_country;


create table students
(
stu_id int,
marks int
);

insert into students values (1,90),(2,80),(3,40),(4,76),(5,95),(6,85),(7,65),(8,60);

-- Case for providing the Grades based on the marks
SELECT 
    *,
    Case
      when marks >= 90 then 'A+'
      when marks>+80 and marks < 90 then 'A'
      when marks>+70 and marks < 80 then 'B+'
      when marks>+60 and marks < 70 then 'B'
      else 'C'
    End as grade
FROM
    students;
