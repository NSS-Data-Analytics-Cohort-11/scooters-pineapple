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
LIMIT 10


SELECT DISTINCT(companyname), COUNT(tripduration) AS count_tripduration
FROM trips
WHERE tripduration BETWEEN 1 AND 1440
GROUP BY companyname



--Q3.) The goal of Metro Nashville is to have each scooter used a minimum of 3 times per day. Based on the data, what is the average number of trips per scooter per day? Make sure to consider the days that a scooter was available. How does this vary by company?
WITH dist AS (
SELECT DISTINCT 
    sumdid, 
    companyname, 
    EXTRACT(MONTH from pubdatetime) ||' '|| EXTRACT(DAY from pubdatetime) AS day
FROM scooters
	)
SELECT sumdid, companyname, month ||' '||day
group by companyname, sumdid, day




---- Q3.) Dalton code
WITH
  scooter_trips AS (
    SELECT
      sumdid,
      companyname,
      COUNT(DISTINCT DATE(startdate)) AS days_with_trips
    FROM
      trips
    WHERE
      companyname ILIKE 'BIRD'
    GROUP BY
      sumdid,
      companyname
  ),
  scooter_availability AS (
    SELECT
      sumdid,
	  companyname,
      COUNT(DISTINCT DATE(pubdatetime)) AS total_days_available
    FROM
      scooters
    WHERE
      companyname ILIKE 'Bird'
    GROUP BY
      sumdid, companyname
  )
SELECT
  st.companyname,
  AVG(
    CAST(st.days_with_trips AS DECIMAL) / sa.total_days_available
  ) AS avg_trips_per_scooter_per_day
FROM
  scooter_trips st
  JOIN scooter_availability sa ON st.sumdid = sa.sumdid
GROUP BY
  st.companyname;



--Q4.) Metro would like to know how many scooters are needed, and something that could help with this is knowing peak demand. Estimate the highest count of scooters being used at the same time. When were the highest volume times? Does this vary by zip code or other geographic region?
select *
FROM trips
limit 100

SELECT
    sumdid,
    COUNT(*) AS num_trips
FROM trips
GROUP BY sumdid;