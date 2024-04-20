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



--observe each company







--Q1.) During this period, seven companies offered scooters. How many scooters did each company have in this time frame? Did the number for each company change over time? Did scooter usage vary by company?

SELECT DISTINCT companyname, COUNT(sumdid)
FROM scooters
GROUP BY companyname;



SELECT EXTRACT(MONTH FROM pubdatetime) AS month,
       companyname,
       COUNT(*) AS count
FROM scooters
GROUP BY month, companyname
ORDER BY month, companyname;


--Q2.) According to Second Substitute Bill BL2018-1202 (as amended) (https://web.archive.org/web/20181019234657/https://www.nashville.gov/Metro-Clerk/Legislative/Ordinances/Details/7d2cf076-b12c-4645-a118-b530577c5ee8/2015-2019/BL2018-1202.aspx), all permitted operators will first clean data before providing or reporting data to Metro. Data processing and cleaning shall include:
----Removal of staff servicing and test trips
----Removal of trips below one minute
----Trip lengths are capped at 24 hours
----Are the scooter companies in compliance with the second and third part of this rule?

SELECT * 
FROM scooters
LIMIT 100


SELECT *
FROM trips
LIMIT 100


SELECT DISTINCT(companyname), COUNT(tripduration) AS count_tripduration
FROM trips
WHERE tripduration BETWEEN 1 AND 1440
GROUP BY companyname



--Q3.) The goal of Metro Nashville is to have each scooter used a minimum of 3 times per day. Based on the data, what is the average number of trips per scooter per day? Make sure to consider the days that a scooter was available. How does this vary by company?

SELECT DISTINCT(sumdid), companyname, startdate, COUNT(startdate) AS count
FROM trips 
GROUP BY sumdid, startdate, companyname
HAVING COUNT(startdate) >=3
ORDER BY sumdid

