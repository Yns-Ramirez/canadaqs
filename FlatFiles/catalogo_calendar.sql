

create external table if not exists DWH_OPERERP_CANADA.CN_CALENDAR
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
location 's3a://devbimboaws/DEV_CANADA_IC/Data/dwh_opererp_canada/CN_CALENDAR'
as
SELECT calendar.calendar_date as bill_date,
case 
           WHEN CAST(calendar.week_of_year AS INT)= 0 THEN  '01'
           WHEN CAST(calendar.week_of_year AS INT)= 1 THEN  '01'
           WHEN CAST(calendar.week_of_year AS INT)= 2 THEN  '02'
           WHEN CAST(calendar.week_of_year AS INT)= 3 THEN  '03'
           WHEN CAST(calendar.week_of_year AS INT)= 4 THEN  '04'
           WHEN CAST(calendar.week_of_year AS INT)= 5 THEN  '05'
           WHEN CAST(calendar.week_of_year AS INT)= 6 THEN  '06'
           WHEN CAST(calendar.week_of_year AS INT)= 7 THEN  '07'
           WHEN CAST(calendar.week_of_year AS INT)= 8 THEN  '08'
           WHEN CAST(calendar.week_of_year AS INT)= 9 THEN  '09'
           ELSE calendar.week_of_year
       END week,
       CASE
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 0 AND 4 THEN  '01'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 5 AND 8 THEN  '02'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 9 AND 13 THEN '03'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 14 AND 17 THEN '04'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 18 AND 21 THEN '05'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 22 AND 26 THEN '06'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 27 AND 30 THEN '07'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 31 AND 34 THEN '08'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 35 AND 39 THEN '09'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 40 AND 43 THEN '10'
           WHEN CAST(calendar.week_of_year AS INT) BETWEEN 44 AND 47 THEN '11'
           WHEN CAST(calendar.week_of_year AS INT) >= 48 THEN '12'
           ELSE '0'
       END period, 
       CASE
           WHEN CAST(calendar.quarter_of_year AS INT)=1 THEN '01'
           WHEN CAST(calendar.quarter_of_year AS INT)=2 THEN '02'
           WHEN CAST(calendar.quarter_of_year AS INT)=3 THEN '03'
           WHEN CAST(calendar.quarter_of_year AS INT)=4 THEN '04'
           ELSE calendar.quarter_of_year
       END fiscal_quarter, year_of_calendar as fiscal_year
FROM cp_sys_calendar.CALENDAR
WHERE CAST(calendar.year_of_calendar AS INT) >= 2014 ;