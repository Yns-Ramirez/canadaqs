CREATE TABLE if not exists STG_CANADA_VIEWS.V_PLANTS
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/STG_CANADA_VIEWS/V_PLANTS'
AS 

SELECT 
     SUBSTR(HR_Location_0.LOCATION_CODE ,1 ,3 ) AS LegalEntity_ID
     ,HR_Organizacion_0.ORGANIZATION_ID AS Organization_ID
     ,SUBSTR(HR_Location_0.LOCATION_CODE ,5 ,4 ) AS Plant_ID
     ,HR_Organizacion_0.NAME AS Plant_DS
FROM erp_pgbari_sz.hr_locations_all_hr HR_Location_0
INNER JOIN erp_pgbari_sz.hr_all_organization_units_hr HR_Organizacion_0 
             ON HR_Location_0.LOCATION_ID = HR_Organizacion_0.LOCATION_ID
GROUP BY 1,2,3,4;


