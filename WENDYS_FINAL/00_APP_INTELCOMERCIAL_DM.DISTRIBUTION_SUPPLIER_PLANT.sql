drop table if EXISTS APP_INTELCOMERCIAL_DM.DISTRIBUTION_SUPPLIER_PLANT;

CREATE table IF NOT EXISTS APP_INTELCOMERCIAL_DM.DISTRIBUTION_SUPPLIER_PLANT
AS
SELECT DISTRIBUTIONCENTERID,SUPPLIER,ADDRESS1, ADDRESS2, CITY, STATE,ZIP,COUNTRY,PHONE from (
SELECT
     CASE
          WHEN LOCATION_CODE LIKE '%WAF' THEN '14661'
          WHEN LOCATION_CODE LIKE '%WBB' THEN '14662'
          WHEN LOCATION_CODE LIKE '%WBC' THEN '14663'
          WHEN LOCATION_CODE LIKE '%WBD' THEN '14664'
          WHEN LOCATION_CODE LIKE '%WBE' THEN '14665'
          WHEN LOCATION_CODE LIKE '%WBF' THEN '14666'
          WHEN LOCATION_CODE LIKE '%WBG' THEN '14667'
          WHEN LOCATION_CODE LIKE '%WDN' THEN '14672'
          WHEN LOCATION_CODE LIKE '%WCR' THEN '14674'
          WHEN LOCATION_CODE LIKE '%WCS' THEN '14675'
          WHEN LOCATION_CODE LIKE '%WCT' THEN '14676'
          WHEN LOCATION_CODE LIKE '%WCU' THEN '14677'
          WHEN LOCATION_CODE LIKE '%WCV' THEN '14678'
          WHEN LOCATION_CODE LIKE '%WCZ' THEN '14681'
          WHEN LOCATION_CODE LIKE '%WDA' THEN '14682'
          WHEN LOCATION_CODE LIKE '%WDB' THEN '14683'
		  WHEN LOCATION_CODE LIKE '%WDD' THEN '14686'
          WHEN LOCATION_CODE LIKE '%WDE' THEN '14687'

     ELSE 'N/A'
     END AS DISTRIBUTIONCENTERID
     ,DESCRIPTION AS SUPPLIER
     ,ADDRESS_LINE_1 AS ADDRESS1
     ,ADDRESS_LINE_2 AS ADDRESS2
     ,TOWN_OR_CITY  AS CITY
     ,REGION_1 AS STATE
     ,UPPER(POSTAL_CODE) AS ZIP
     ,COUNTRY            AS COUNTRY
     ,TELEPHONE_NUMBER_1 AS PHONE,
     LOCATION_ID
FROM DWH_OPERERP_GLOBAL.HR_LOCATIONS_ALL    H  ) TEST
WHERE LOCATION_ID IN
     (
          SELECT LOCATION_ID FROM DWH_OPERERP_GLOBAL.HR_ALL_ORGANIZATION_UNITS
          WHERE NAME LIKE '%CBC_%'
          AND NAME LIKE '%DC%'
          AND TYPE_1 = 'DC'
          AND NAME NOT LIKE '%3PL%'
     )
AND DISTRIBUTIONCENTERID NOT IN ('N/A');
