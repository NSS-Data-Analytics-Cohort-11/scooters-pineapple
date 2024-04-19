SELECT * FROM scooters LIMIT 100;

SELECT * FROM trips LIMIT 100;

SELECT COUNT(sumdid) FROM scooters;


--charge levels has nulls
SELECT * 
FROM scooters 
WHERE chargelevel IS NULL;


--date range
SELECT MIN(pubdatetime), MAX(pubdatetime)
FROM scooters


--Q1.) During this period, seven companies offered scooters. How many scooters did each company have in this time frame? Did the number for each company change over time? Did scooter usage vary by company?

SELECT DISTINCT companyname, COUNT(sumdid)
FROM scooters
GROUP BY companyname;


SELECT  DISTINCT companyname, pubdatetime
FROM scooters
LIMIT 100

SELECT DISTINCT companyname, COUNT(companyname), pubdatetime
FROM scooters
GROUP BY companyname, pubdatetime


SELECT MONTH(pubdatetime)
FROM scooters