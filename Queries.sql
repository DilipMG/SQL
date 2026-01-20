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
SELECT 
    country,
    GROUP_CONCAT(state) AS states_in_country,
    COUNT(*) AS ORDER_count
FROM
    orders_data
GROUP BY country

SELECT 
    country,
    GROUP_CONCAT(state
        ORDER BY STATE DESC
        SEPARATOR '-') AS states_in_country,
    COUNT(*) AS ORDER_count
FROM
    orders_data
GROUP BY country

SELECT 
    YEAR(HIRING_DATE), COUNT(*) AS TOTAL_HIRING
FROM
    EMP_NEW
GROUP BY YEAR(HIRING_DATE)
 

-- - Group RollUP
CREATE TABLE payment (
    payment_amount DECIMAL(8 , 2 ),
    payment_date DATE,
    store_id INT
)
 
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
FROM
    payment
GROUP BY YEAR(payment_date) , store_id WITH ROLLUP
ORDER BY YEAR(payment_date) , store_id

-- TOTAL REVENUE PER YEAR
SELECT 
    YEAR(PAYMENT_DATE), SUM(PAYMENT_AMOUNT)
FROM
    PAYMENT
GROUP BY YEAR(PAYMENT_DATE)

SELECT 
    *
FROM
    (SELECT 
        SUM(payment_amount) AS TOTAL,
            YEAR(payment_date) AS PAYMENT_YEAR,
            store_id AS STORE
    FROM
        payment
    GROUP BY YEAR(payment_date) , store_id WITH ROLLUP
    ORDER BY YEAR(payment_date) , store_id) TEMP
WHERE
    TEMP.STORE IS NULL
        AND TEMP.PAYMENT_YEAR IS NOT NULL

SELECT 
    *
FROM
    (SELECT 
        SUM(payment_amount) AS TOTAL,
            YEAR(payment_date) AS PAYMENT_YEAR,
            store_id AS STORE
    FROM
        payment
    GROUP BY YEAR(payment_date) , store_id WITH ROLLUP
    ORDER BY YEAR(payment_date) , store_id) TEMP
WHERE
    TEMP.STORE IS NOT NULL
        AND TEMP.PAYMENT_YEAR IS NOT NULL


-- Subqueries in SQL
CREATE TABLE employees (
    id INT,
    name VARCHAR(50),
    salary INT
)

insert into employees values(1,'Shashank',5000),(2,'Amit',5500),(3,'Rahul',7000),(4,'Rohit',6000),(5,'Nitin',4000),(6,'Sunny',7500);

-- query to fetch employees getting more salary than 'Rohit';
SELECT 
    *
FROM
    employees
WHERE
    salary > (SELECT 
            salary
        FROM
            employees
        WHERE
            name = 'Rohit')

-- query to select records from Seattle and Goa
SELECT 
    *
FROM
    orders_data
WHERE
    state IN ('Seattle' , 'Goa')

CREATE TABLE customer_order_data (
    order_id INT,
    cust_id INT,
    supplier_id INT,
    cust_country VARCHAR(50)
)


insert into customer_order_data values(101,200,300,'USA'),(102,201,301,'INDIA'),(103,202,302,'USA'),(104,203,303,'UK');

CREATE TABLE supplier_data (
    supplier_id INT,
    sup_country VARCHAR(50)
)

insert into supplier_data values(300,'USA'),(303,'UK');

SELECT 
    *
FROM
    customer_order_data
select * from supplier_data;

-- write a query to find all customer order data where all customers are from same countries 
-- as the suppliers
SELECT 
    *
FROM
    customer_order_data,
    (SELECT 
        sup_country
    FROM
        supplier_data) AS sup
WHERE
    cust_country = sup_country




CREATE TABLE students (
    stu_id INT,
    marks INT
)

insert into students values (1,90),(2,80),(3,40),(4,76),(5,95),(6,85),(7,65),(8,60);

-- Case for providing the Grades based on the marks
SELECT 
    *,
    CASE
        WHEN marks >= 90 THEN 'A+'
        WHEN marks >= 80 AND marks < 90 THEN 'A'
        WHEN marks >= 70 AND marks < 80 THEN 'B+'
        WHEN marks >= 60 AND marks < 70 THEN 'B'
        ELSE 'C'
    END AS Grades
FROM
    students

-- Uber SQL Interview questions
CREATE TABLE tree (
    node INT,
    parent INT
)

insert into tree values (5,8),(9,8),(4,5),(2,9),(1,5),(3,9),(8,null);

SELECT 
    *,
    CASE
        WHEN parent IS NULL THEN 'Root'
        WHEN
            node IN (SELECT DISTINCT
                    (parent)
                FROM
                    tree)
        THEN
            'Inner'
        ELSE 'Leaf'
    END AS Type
FROM
    tree

-- --------------------------------------------------------
-- --------------------------------------------------------
-- ---------------- JOINS  --------------------------------
-- --------------------------------------------------------
-- --------------------------------------------------------
CREATE TABLE customers_j (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(50)
)

CREATE TABLE orders_j (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('PLACED', 'SHIPPED', 'CANCELLED') NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers_j (customer_id)
)

CREATE TABLE products_j (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(80) NOT NULL,
    category VARCHAR(40),
    price DECIMAL(10 , 2 ) NOT NULL
)

CREATE TABLE order_items_j (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES orders_j (order_id),
    FOREIGN KEY (product_id)
        REFERENCES products_j (product_id)
)

-- Customers
INSERT INTO customers_j (customer_id, customer_name, city) VALUES
(1,'Alice','Mumbai'),
(2,'Bob','Delhi'),
(3,'Charlie','Bengaluru'),
(4,'Diana','Pune');

-- Orders
INSERT INTO orders_j (order_id, customer_id, order_date, status) VALUES
(101,1,'2025-08-01','PLACED'),
(102,1,'2025-08-02','SHIPPED'),
(103,2,'2025-08-03','PLACED'),
(104,3,'2025-08-04','CANCELLED');

-- Products
INSERT INTO products_j (product_id, product_name, category, price) VALUES
(201,'Smartphone','Electronics',69999.00),
(202,'Laptop','Electronics',89990.00),
(203,'Headphones','Audio',3999.00),
(204,'Wireless Mouse','Accessories',999.00),
(205,'Mechanical Keyboard','Accessories',4999.00);

-- Order Items
INSERT INTO order_items_j (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1,101,201,1,69999.00),
(2,101,203,2,3999.00),
(3,102,202,1,89990.00),
(4,103,204,3,999.00);

-- Query to show orders with customer names (customers that actually placed orders)
SELECT 
    o.order_id, o.order_date, o.status, c.customer_name, c.city
FROM
    orders_j o
        JOIN
    customers_j c ON o.customer_id = c.customer_id
WHERE
    o.status = 'PLACED'

-- Query to show all customers and any orders they placed
SELECT 
    *
FROM
    customers_j c
        LEFT JOIN
    orders_j o ON o.customer_id = c.customer_id
ORDER BY order_id

-- QUery to find customer who did not place any orders; 

SELECT 
    c.customer_id, c.customer_name
FROM
    customers_j c
WHERE
    c.customer_id NOT IN (SELECT DISTINCT
            (customer_id)
        FROM
            orders_j)

-- Query to show all products and any order line that used them (expose never orderd products)
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    o.order_id,
    o.quantity,
    o.unit_price
FROM
    products_j p
        LEFT JOIN
    order_items_j o ON p.product_id = o.product_id
ORDER BY p.product_id , o.order_id

-- Query to detailed order lines with product names and extended amount. 
SELECT 
    o.order_id,
    o.order_date,
    o.status,
    oi.order_item_id,
    oi.product_id,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS extended_price
FROM
    orders_j o
        JOIN
    order_items_j oi ON o.order_id = oi.order_id
        JOIN
    products_j p ON oi.product_id = p.product_id
 
-- Self Join example
CREATE TABLE employees_full_data (
    emp_id INT,
    name VARCHAR(50),
    mgr_id INT
)

insert into employees_full_data values(1, 'Shashank', 3);
insert into employees_full_data values(2, 'Amit', 3);
insert into employees_full_data values(3, 'Rajesh', 4);
insert into employees_full_data values(4, 'Ankit', 6);
insert into employees_full_data values(6, 'Nikhil', null);

SELECT 
    *
FROM
    employees_full_data 

-- Write a query to print the all manager's name  == SELF JOIN
SELECT DISTINCT
    manager.emp_id, manager.name
FROM
    employees_full_data employee
        JOIN
    employees_full_data manager ON employee.mgr_id = manager.emp_id

-- ------------=============================================================
-- =========================================================================
CREATE TABLE sales_tb (
    product_id INTEGER,
    store_id INTEGER,
    customer_id INTEGER,
    promotion_id INTEGER,
    store_sales DECIMAL(10 , 2 ),
    store_cost DECIMAL(10 , 2 ),
    units_sold DECIMAL(10 , 2 ),
    transaction_date DATE
)

CREATE TABLE products_tb (
    product_id INTEGER,
    product_class_id INTEGER,
    brand_name VARCHAR(100),
    product_name VARCHAR(100),
    is_low_fat_flg TINYINT,
    is_recyclable_flg TINYINT,
    gross_weight DECIMAL(10 , 2 ),
    net_weight DECIMAL(10 , 2 )
)

CREATE TABLE customers_tb (
    customer_id INTEGER,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    state VARCHAR(50),
    birthdate DATE,
    gender VARCHAR(10)
)

INSERT INTO products_tb (product_id, product_class_id, brand_name, product_name, is_low_fat_flg, is_recyclable_flg, gross_weight, net_weight) VALUES
(1, 101, 'Fabulous', 'Product A', 1, 1, 1.0, 0.9),
(2, 102, 'SuperCool', 'Product B', 1, 1, 1.2, 1.0),
(3, 103, 'Fabulous', 'Product C', 1, 1, 1.5, 1.3),
(4, 104, 'MegaBrand', 'Product D', 0, 1, 2.0, 1.8),
(5, 105, 'Fabulous', 'Product E', 1, 0, 2.5, 2.3),
(6, 106, 'EcoLife', 'Product F', 0, 1, 0.8, 0.7);

INSERT INTO sales_tb (product_id, store_id, customer_id, promotion_id, store_sales, store_cost, units_sold, transaction_date) VALUES
(1, 1, 101, 1, 100.00, 50.00, 1, '2024-01-01'),
(2, 1, 102, 2, 200.00, 80.00, 2, '2024-01-02'),
(3, 1, 103, 1, 300.00, 120.00, 3, '2024-01-03'),
(4, 2, 104, 3, 150.00, 60.00, 1, '2024-01-04'),
(5, 3, 105, 4, 250.00, 100.00, 5, '2024-01-05'),
(6, 3, 101, 2, 180.00, 70.00, 3, '2024-01-06'),
(3, 2, 102, 3, 220.00, 90.00, 4, '2024-01-07'),
(4, 2, 103, 2, 320.00, 150.00, 6, '2024-01-08');

INSERT INTO customers_tb (customer_id, first_name, last_name, state, birthdate, gender) VALUES
(101, 'John', 'Doe', 'California', '1990-01-01', 'Male'),
(102, 'Jane', 'Smith', 'Texas', '1985-05-15', 'Female'),
(103, 'Alice', 'Johnson', 'New York', '1992-07-23', 'Female'),
(104, 'Bob', 'Brown', 'Florida', '1988-10-10', 'Male'),
(105, 'Emily', 'Davis', 'Washington', '1995-03-12', 'Female'),
(106, 'Michael', 'Williams', 'Nevada', '1987-08-30', 'Male'),
(107, 'Chris', 'Taylor', 'Oregon', '1993-11-17', 'Male'),
(108, 'Sophia', 'Martinez', 'Arizona', '1990-05-22', 'Female');

-- Q.) Produce a list of all customers' names who have bought anything from the brand "Fabulous"
SELECT DISTINCT
    S.CUSTOMER_ID
FROM
    SALES_TB S
        JOIN
    PRODUCTS_TB P ON P.PRODUCT_ID = S.PRODUCT_ID
WHERE
    P.brand_name = 'Fabulous'

-- Q.) Produce a list of all customers' names who have never bought anything from the brand "Fabulous"
SELECT 
    C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME
FROM
    CUSTOMERS_TB C
WHERE
    C.CUSTOMER_ID NOT IN (SELECT DISTINCT
            S.CUSTOMER_ID
        FROM
            SALES_TB S
                JOIN
            PRODUCTS_TB P ON P.PRODUCT_ID = S.PRODUCT_ID
        WHERE
            P.brand_name = 'Fabulous')
 
-- =========================== 
-- Any Operation 
-- =========================== 

CREATE TABLE Students_tb (
    StudentID INT,
    StudentName VARCHAR(50)
)

INSERT INTO Students_tb VALUES 
(1, 'John'),
(2, 'Alice'),
(3, 'Bob');

CREATE TABLE Courses (
    CourseID INT,
    CourseName VARCHAR(50)
)

INSERT INTO Courses VALUES 
(100, 'Math'),
(101, 'English'),
(102, 'Science');

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT
);

INSERT INTO Enrollments VALUES 
(1, 100),
(1, 101),
(2, 101),
(2, 102),
(3, 100),
(3, 102);

-- Example: Lets find the students who are enrolled in any course taken by 'John':
SELECT DISTINCT
    S1.STUDENTNAME
FROM
    STUDENTS_TB S1
        JOIN
    ENROLLMENTS E1 ON S1.STUDENTID = E1.STUDENTID
WHERE
    S1.STUDENTNAME <> 'JOHN'
        AND E1.COURSEID = ANY (SELECT 
            E2.COURSEiD
        FROM
            ENROLLMENTS E2
                JOIN
            STUDENTS_TB S2 ON S2.STUDENTid = E2.STUDENTID
        WHERE
            S2.STUDENTNAME = 'John');
 
SELECT DISTINCT
    S1.STUDENTNAME
FROM
    STUDENTS_TB S1
        JOIN
    ENROLLMENTS E1 ON S1.STUDENTID = E1.STUDENTID
WHERE
    S1.STUDENTNAME <> 'JOHN'
        AND E1.COURSEID IN (SELECT 
            E2.COURSEiD
        FROM
            ENROLLMENTS E2
                JOIN
            STUDENTS_TB S2 ON S2.STUDENTid = E2.STUDENTID
        WHERE
            S2.STUDENTNAME = 'John'); 
-- =========================== 
-- All
-- =========================== 

CREATE TABLE Products_v1 (
    ProductID INT,
    ProductName VARCHAR(50),
    Price DECIMAL(5 , 2 )
);

INSERT INTO Products_v1 VALUES 
(1, 'Apple', 1.20),
(2, 'Banana', 0.50),
(3, 'Cherry', 2.00),
(4, 'Date', 1.50),
(5, 'Elderberry', 3.00);

CREATE TABLE Orders_v1 (
    OrderID INT,
    ProductID INT,
    Quantity INT
);

INSERT INTO Orders_v1 VALUES 
(1001, 1, 10),
(1002, 2, 20),
(1003, 3, 30),
(1004, 1, 5),
(1005, 4, 25),
(1006, 5, 15);

-- Now, suppose we want to find the products that have a price less than 
-- the price of all products ordered in order 1001:

SELECT p.ProductName
FROM Products_v1 p
WHERE p.Price < ALL (
    SELECT pr.Price
    FROM Products_v1 pr
    INNER JOIN Orders_v1 o ON pr.ProductID = o.ProductID
    WHERE o.OrderID = 1001
);

-- -----------------------
-- =========================== 
-- EXISTS Operation
-- =========================== 
CREATE TABLE Customers_v2 (
    CustomerID INT,
    CustomerName VARCHAR(50)
);

INSERT INTO Customers_v2 VALUES 
(1, 'John Doe'),
(2, 'Alice Smith'),
(3, 'Bob Johnson'),
(4, 'Charlie Brown'),
(5, 'David Williams');

CREATE TABLE Orders_v2 (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE
);

INSERT INTO Orders_v2 VALUES 
(1001, 1, '2023-01-01'),
(1002, 2, '2023-02-01'),
(1003, 1, '2023-03-01'),
(1004, 3, '2023-04-01'),
(1005, 5, '2023-05-01');

-- Example: Lets find the customers who have placed at least one order.

-- - Best for existence check → ✅ Query 1 (EXISTS)
-- Short circuits, avoids unnecessary aggregation, and is the most efficient pattern
select c.customerName
from customers_v2 c 
where exists (select 1 from orders_v2 o
where o.customerid = c.customerid);

-- Readable alternative → Query 2 (IN)
-- Works fine, but may be slower with large datasets.
select c.customerName
from customers_v2 c 
where customerid in (select customerid from orders_v2 o
where o.customerid = c.customerid);

-- Analytics/reporting → Query 3 (JOIN + GROUP BY)
-- Only justified if you need order_count
select customername from customers_v2 c join  
(select customerid,count(*) as order_count from orders_v2 
group by customerid) as tmp
on c.customerid = tmp.customerid
where tmp.order_count >= 1;

-- NOT EXISTS Operation
-- Example: Lets find the customers who have not placed any orders.
SELECT c.CustomerName
FROM Customers_v2 c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders_v2 o
    WHERE o.CustomerID = c.CustomerID
);

-- -----=============== FUNCTION 


-- Window Functions
create table shop_sales_data
(
sales_date date,
shop_id varchar(5),
sales_amount int
);

insert into shop_sales_data values('2022-02-14','S1',200);
insert into shop_sales_data values('2022-02-15','S1',300);
insert into shop_sales_data values('2022-02-14','S2',600);
insert into shop_sales_data values('2022-02-15','S3',500);
insert into shop_sales_data values('2022-02-18','S1',400);
insert into shop_sales_data values('2022-02-17','S2',250);
insert into shop_sales_data values('2022-02-20','S3',300);

-- Total count of sales for each shop using window function
-- Working functions - SUM(), MIN(), MAX(), COUNT(), AVG()

-- If we only use Order by In Over Clause, then running sum happens, when two rows have same sales_amount(order by column), adds together
select *,
       sum(sales_amount) over(order by sales_amount desc) as sum_of_sales
from shop_sales_data;

# sales_date, shop_id, sales_amount, sum_of_sales
-- '2022-02-14', 'S2', '600', '600'
-- '2022-02-15', 'S3', '500', '1100'
-- '2022-02-18', 'S1', '400', '1500'
-- '2022-02-15', 'S1', '300', '2100'
-- '2022-02-20', 'S3', '300', '2100'
-- '2022-02-17', 'S2', '250', '2350'
-- '2022-02-14', 'S1', '200', '2550'

-- If we only use Partition By, within each shop_id, total sum calculated and placed
select *,
       sum(sales_amount) over(partition by shop_id) as total_sum_of_sales
from shop_sales_data;

-- If we only use Partition By & Order By together then running sum happens for each shop_id separately
select *,
       sum(sales_amount) over(partition by shop_id order by sales_date) as running_sum_of_sales
from shop_sales_data;

select *,
       sum(sales_amount) over(partition by shop_id order by sales_date) 
       as running_sum_of_sales,
       avg(sales_amount) over(partition by shop_id order by sales_date) 
       as running_avg_of_sales,
       max(sales_amount) over(partition by shop_id order by sales_date) 
       as running_max_of_sales,
       min(sales_amount) over(partition by shop_id order by sales_date) 
       as running_min_of_sales
from shop_sales_data;

create table amazon_sales_data
(
    sales_date date,
    sales_amount int
);

insert into amazon_sales_data values('2022-08-21',500);
insert into amazon_sales_data values('2022-08-22',600);
insert into amazon_sales_data values('2022-08-19',300);
insert into amazon_sales_data values('2022-08-18',200);
insert into amazon_sales_data values('2022-08-25',800);

-- Query - Calculate the date wise rolling average of amazon sales
select *, 
       avg(sales_amount) over (order by sales_date) as  rolling_avg
from amazon_sales_data;

select *,
       avg(sales_amount) over(order by sales_date) as rolling_avg,
       sum(sales_amount) over(order by sales_date) as rolling_sum
from amazon_sales_data;

insert into shop_sales_data values('2022-02-19','S1',400);
insert into shop_sales_data values('2022-02-20','S1',400);
insert into shop_sales_data values('2022-02-22','S1',300);
insert into shop_sales_data values('2022-02-25','S1',200);
insert into shop_sales_data values('2022-02-15','S2',600);
insert into shop_sales_data values('2022-02-16','S2',600);
insert into shop_sales_data values('2022-02-16','S3',500);
insert into shop_sales_data values('2022-02-18','S3',500);
insert into shop_sales_data values('2022-02-19','S3',300);

select *, 
      row_number() over (partition by shop_id order by sales_amount desc) as row_num,
      rank() over(partition by shop_id order by sales_amount desc) as rank_val,
	  dense_rank() over(partition by shop_id order by sales_amount desc) as dense_rank_val
from    shop_sales_data;

	create table employees_r
	(
		emp_id int,
		salary int,
		dept_name VARCHAR(30)
	);

	insert into employees_r values(1,10000,'Software');
	insert into employees_r values(2,11000,'Software');
	insert into employees_r values(3,11000,'Software');
	insert into employees_r values(4,11000,'Software');
	insert into employees_r values(5,15000,'Finance');
	insert into employees_r values(6,15000,'Finance');
	insert into employees_r values(7,15000,'IT');
	insert into employees_r values(8,12000,'HR');
	insert into employees_r values(9,12000,'HR');
	insert into employees_r values(10,11000,'HR');


	-- get one employee from each department who is getting 
	-- maximum salary (employee can be random if salary is same)
select 
    tmp.*
from (select *,
        row_number() over(partition by dept_name order by salary desc) as row_num
    from employees_r) tmp
where tmp.row_num = 1;

-- Query - get one employee from each department who is getting maximum salary (employee can be random if salary is same)
select 
    tmp.*
from (select *,
        row_number() over(partition by dept_name order by salary desc) as row_num
    from employees_r) tmp
where tmp.row_num = 1;

-- Query - get all employees from each department who are getting maximum salary
select 
    tmp.*
from (select *,
        rank() over(partition by dept_name order by salary desc) as rank_num
    from employees_r) tmp
where tmp.rank_num = 1;

-- Query - get all top 2 ranked employees from each department who are getting maximum salary
select 
    tmp.*
from (select *,
        dense_rank() over(partition by dept_name order by salary desc) as dense_rank_num
    from employees_r) tmp
where tmp.dense_rank_num <= 2;
