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