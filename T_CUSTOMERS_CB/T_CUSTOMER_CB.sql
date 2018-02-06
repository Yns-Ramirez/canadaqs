
-- ================== CREATE DDL'S ==================
CREATE EXTERNAL TABLE IF NOT EXISTS STG_CANADA.T_CUSTOMERS_CB
     (
      CUSTOMERORACLE_ID INT,
      `LOCATION` VARCHAR(50),
      CUSTOMERAR_ID VARCHAR(50),
      ACCOUNT_NUMBER VARCHAR(50),
      CUSTOMERSAP_ID VARCHAR(50),
      CUSTOMER_NAME VARCHAR(50),
      SITE_USE_CODE VARCHAR(50),
      SHIP_TO_CUSTOMER_NAME VARCHAR(50),
      ACCOUNT_NAME VARCHAR(50),
      STORE VARCHAR(50),
      BANNER_CUSTOMERORACLE_ID INT,
      BANNER_CUSTOMERSAP_ID VARCHAR(50),
      BANNER_CUSTOMER_NAME VARCHAR(50),
      REGIONAL_CUSTOMERORACLE_ID INT,
      REGIONAL_CUSTOMERSAP_ID VARCHAR(50),
      REGIONAL_CUSTOMER_NAME VARCHAR(50),
      NATIONAL_CUSTOMERORACLE_ID INT,
      NATIONAL_CUSTOMERSAP_ID VARCHAR(50),
      NATIONAL_CUSTOMER_NAME VARCHAR(50),
      CHANNEL_ID VARCHAR(50),
      CUSTOMER_GROUP VARCHAR(50),
      ADDRESS VARCHAR(50),
      CITY VARCHAR(50),
      POSTAL_CODE VARCHAR(50),
      COUNTRY_NAME VARCHAR(50),
      PROVINCE VARCHAR(50),
      ORG_ID INT,
      SALESFLAG CHAR(1))
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION
  's3a://devbimboaws/DEV_CANADA_IC/Data/stg_canada/T_CUSTOMERS_CB';


CREATE VIEW if not exists wrk_global.V_CUSTOMERS_CB
AS
SELECT     
      TRIM(CAST(CASE WHEN cast(ORG_ID as string) = '894' THEN `LOCATION` ELSE cast(CUSTOMERORACLE_ID as string) END AS STRING)) AS CUSTOMERORACLE_ID -- CC 16-75     
     ,`LOCATION`
     ,A.ARCustomer_ID AS CUSTOMERAR_ID
     ,ACCOUNT_NUMBER     
     ,CASE WHEN CUSTOMERSAP_ID LIKE '%-%' THEN TRIM(SUBSTR(CUSTOMERSAP_ID, 1,7)) ELSE CUSTOMERSAP_ID END AS CUSTOMERSAP_ID     
     ,CASE WHEN CUSTOMER_NAME LIKE '-%' THEN TRIM(SUBSTR(CUSTOMER_NAME, 2,100)) ELSE CUSTOMER_NAME END AS CUSTOMER_NAME     
     ,SITE_USE_CODE     
     ,ADDRESS1 AS SHIP_TO_CUSTOMER_NAME     
     ,ACCOUNT_NAME                               
     ,STORE     
     ,BANNER_CUSTOMERORACLE_ID       
     ,BANNER_CUSTOMERSAP_ID          
     ,CASE WHEN BANNER_CUSTOMER_NAME LIKE '-%' THEN TRIM(SUBSTR(BANNER_CUSTOMER_NAME, 2,100)) ELSE BANNER_CUSTOMER_NAME END AS BANNER_CUSTOMER_NAME     
     ,REGIONAL_CUSTOMERORACLE_ID     
     ,REGIONAL_CUSTOMERSAP_ID        
     ,REGIONAL_CUSTOMER_NAME         
     ,NATIONAL_CUSTOMERORACLE_ID     
     ,NATIONAL_CUSTOMERSAP_ID        
     ,NATIONAL_CUSTOMER_NAME         
     ,CHANNEL_ID                                 
     ,CUSTOMER_GROUP                             
     ,ADDRESS                             
     ,CITY     
     ,POSTAL_CODE     
     ,COUNTRY_NAME                               
     ,PROVINCE     
     ,ORG_ID                                     
     ,CASE WHEN C.CUSTOMER_ID IS NULL THEN 'N' ELSE 'Y' END AS SalesFlag
FROM     
(     
SELECT     
      A.CUSTOMERORACLE_ID                          
     ,A.`LOCATION`     
     ,A.ARCustomer_ID
     ,A.SITE_USE_CODE     
     ,A.ADDRESS1     
     ,A.ACCOUNT_NUMBER     
     ,A.CUSTOMERSAP_ID                             
     ,A.CUSTOMER_NAME AS CUSTOMER_NAME       
     ,A.ACCOUNT_NAME AS ACCOUNT_NAME          
     ,A.STORE AS STORE     
     ,A.BANNER_CUSTOMERORACLE_ID AS BANNER_CUSTOMERORACLE_ID       
     ,A.BANNER_CUSTOMERSAP_ID AS BANNER_CUSTOMERSAP_ID          
     ,A.BANNER_CUSTOMER_NAME AS BANNER_CUSTOMER_NAME           
     ,A.REGIONAL_CUSTOMERORACLE_ID AS REGIONAL_CUSTOMERORACLE_ID     
     ,A.REGIONAL_CUSTOMERSAP_ID AS REGIONAL_CUSTOMERSAP_ID        
     ,A.REGIONAL_CUSTOMER_NAME AS REGIONAL_CUSTOMER_NAME         
     ,A.NATIONAL_CUSTOMERORACLE_ID AS NATIONAL_CUSTOMERORACLE_ID     
     ,A.NATIONAL_CUSTOMERSAP_ID AS NATIONAL_CUSTOMERSAP_ID        
     ,A.NATIONAL_CUSTOMER_NAME AS NATIONAL_CUSTOMER_NAME         
     ,A.CHANNEL_ID                                 
     ,A.ADDRESS                             
     ,A.CITY     
     ,A.POSTAL_CODE     
     ,A.CUSTOMER_GROUP                             
     ,A.COUNTRY_NAME                               
     ,A.PROVINCE     
     ,A.ORG_ID                                     
FROM      
     (     
     SELECT                                               
           BAN.CUSTOMERORACLE_ID
          ,BAN.`LOCATION`
          ,B.BILLTO_CUST_ACCOUNT_ID AS ARCustomer_ID
          ,BAN.SITE_USE_CODE
          ,BAN.ADDRESS1
          ,BAN.ACCOUNT_NUMBER AS ACCOUNT_NUMBER                             
          ,BAN.STORE
          ,BAN.CUSTOMERSAP_ID
          ,BAN.BANNER_CUSTOMER_NAME AS CUSTOMER_NAME                
          ,BAN.ACCOUNT_NAME
          ,BAN.BANNER_CUSTOMERORACLE_ID
          ,BAN.BANNER_CUSTOMERSAP_ID
          ,BAN.BANNER_CUSTOMER_NAME
          ,COALESCE(REG.HIJO_ID,-1) AS REGIONAL_CUSTOMERORACLE_ID     
          ,BAN.REGIONAL_CUSTOMERSAP_ID
          ,BAN.REGIONAL_CUSTOMER_NAME
          ,COALESCE(NAT.HIJO_ID,-1) AS NATIONAL_CUSTOMERORACLE_ID     
          ,BAN.NATIONAL_CUSTOMERSAP_ID
          ,BAN.NATIONAL_CUSTOMER_NAME
          ,BAN.CHANNEL_ID
          ,BAN.CUSTOMER_GROUP
          ,BAN.ADDRESS
          ,BAN.CITY
          ,BAN.POSTAL_CODE
          ,BAN.COUNTRY_NAME
          ,BAN.PROVINCE
          ,BAN.ORG_ID
     FROM                                                 
          (                                               
               SELECT
                     PS.PARTY_SITE_ID AS CUSTOMERORACLE_ID
                    ,HCSUA.`LOCATION`
                    ,HCSUA.SITE_USE_CODE
                    ,PS.LOCATION_ID
                    ,HLO.ADDRESS1
                    ,HCASA.ORIG_SYSTEM_REFERENCE AS CUSTOMERSAP_ID
                    ,HCASA.CUST_ACCOUNT_ID
                    ,PS.PARTY_SITE_NAME AS CUSTOMER_NAME
                    ,HCASA.ATTRIBUTE3 AS STORE
                    ,HCA.ACCOUNT_NUMBER AS ACCOUNT_NUMBER
                    ,COALESCE(HCA.ACCOUNT_NAME,'Unassigned') AS ACCOUNT_NAME 
                    ,HCA.PARTY_ID AS BANNER_CUSTOMERORACLE_ID
                    ,BAN.VALUE3 AS BANNER_CUSTOMERSAP_ID
                    ,BAN.DESCRIPTION AS BANNER_CUSTOMER_NAME
                    ,REG.VALUE2 AS REGIONAL_CUSTOMERSAP_ID
                    ,REG.DESCRIPTION AS REGIONAL_CUSTOMER_NAME
                    ,NAT.VALUE1 AS NATIONAL_CUSTOMERSAP_ID
                    ,NAT.DESCRIPTION AS NATIONAL_CUSTOMER_NAME
                    ,HCASA.ATTRIBUTE11 AS CHANNEL_ID
                    ,HPB.GROUP_TYPE AS CUSTOMER_GROUP
                    ,HLO.ADDRESS2 AS ADDRESS
                    ,HLO.CITY AS CITY
                    ,HLO.POSTAL_CODE AS POSTAL_CODE
                    ,HPB.COUNTRY AS COUNTRY_NAME
                    ,HLO.PROVINCE AS PROVINCE
                    ,HCASA.ORG_ID AS ORG_ID
               FROM erp_pgbari_sz.hz_cust_accounts_ar HCA
                ,erp_pgbari_sz.hz_cust_acct_sites_all_ar HCASA
                ,erp_pgbari_sz.hz_parties_ar HPB
                ,erp_pgbari_sz.hz_parties_ar HPR
                ,erp_pgbari_sz.hz_parties_ar HPN
                ,erp_pgbari_sz.hz_party_sites_ar PS
                ,erp_pgbari_sz.hz_cust_site_uses_all_ar HCSUA
                ,erp_pgbari_sz.hz_locations_ar HLO
                ,erp_pgbari_sz.ra_territories_kfv_apps RT
                ,(SELECT FV.FLEX_VALUE VALUE3, FV.DESCRIPTION DESCRIPTION FROM erp_pgbari_sz.fnd_flex_value_sets_apps FL ,erp_pgbari_sz.fnd_flex_values_vl_apps FV WHERE 1=1 AND FL.FLEX_VALUE_SET_ID = FV.FLEX_VALUE_SET_ID AND FL.FLEX_VALUE_SET_NAME = 'XBOL_BANNER') BAN
                ,(SELECT FV.FLEX_VALUE VALUE2, FV.DESCRIPTION DESCRIPTION FROM erp_pgbari_sz.fnd_flex_value_sets_apps FL ,erp_pgbari_sz.fnd_flex_values_vl_apps FV WHERE 1=1 AND FL.FLEX_VALUE_SET_ID = FV.FLEX_VALUE_SET_ID  AND FL.FLEX_VALUE_SET_NAME = 'XBOL_REGIONAL') REG
                ,(SELECT FV.FLEX_VALUE VALUE1, FV.DESCRIPTION DESCRIPTION FROM erp_pgbari_sz.fnd_flex_value_sets_apps FL ,erp_pgbari_sz.fnd_flex_values_vl_apps FV WHERE 1=1 AND FL.FLEX_VALUE_SET_ID = FV.FLEX_VALUE_SET_ID  AND FL.FLEX_VALUE_SET_NAME = 'XBOL_NATIONAL') NAT
               WHERE HCA.PARTY_ID = HPB.PARTY_ID                                  
                 AND HCA.PARTY_ID = HPR.PARTY_ID                                  
                 AND HCA.PARTY_ID = HPN.PARTY_ID                                  
                 AND HCA.PARTY_ID = PS.PARTY_ID                                   
                 AND HCA.CUST_ACCOUNT_ID = HCASA.CUST_ACCOUNT_ID                                   
                 AND HCASA.CUST_ACCT_SITE_ID = HCSUA.CUST_ACCT_SITE_ID 
                 AND HCSUA.TERRITORY_ID = RT.TERRITORY_ID
                 AND HCASA.ORG_ID = HCSUA.ORG_ID      
                 AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID     
                 AND PS.LOCATION_ID = HLO.LOCATION_ID     
                 AND RT.SEGMENT3 = BAN.VALUE3 
                 AND RT.SEGMENT2 = REG.VALUE2 
                 AND RT.SEGMENT1 = NAT.VALUE1
                 AND HCASA.ORG_ID IN (SELECT ORGANIZATION_ID FROM STG_CANADA_VIEWS.V_PLANTS WHERE LEGALENTITY_ID IN ('191') GROUP BY 1 )     
                 AND HCASA.ATTRIBUTE10 IS NOT NULL     
               GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26
          ) BAN                                                              
               LEFT JOIN                                                     
                         (                                                   
                              SELECT                                         
                                    A.PARTY_ID AS PAPA_ID       
                                   ,A.PARTY_NAME AS PAPA_NAME     
                                   ,B.RELATIONSHIP_CODE AS RELATIONSHIP_CODE     
                                   ,C.PARTY_ID AS HIJO_ID               
                                   ,C.PARTY_NAME AS HIJO_NAME             
                                   ,B.RELATIONSHIP_TYPE AS RELATIONSHIP_TYPE     
                              FROM erp_pgbari_sz.hz_parties_ar A                   
                                   INNER JOIN erp_pgbari_sz.hz_relationships_ar B ON A.PARTY_ID = B.SUBJECT_ID      
                                   INNER JOIN erp_pgbari_sz.hz_parties_ar C ON B.OBJECT_ID = C.PARTY_ID           
                              WHERE B.RELATIONSHIP_CODE = 'SUBSIDIARY_OF'                                             
                              AND C.PARTY_NAME LIKE '%(REG)%'                                                         
                              AND B.STATUS = 'A'                                                                      
                         ) REG ON BAN.BANNER_CUSTOMERORACLE_ID = REG.PAPA_ID                                          
               LEFT JOIN                                                                                              
                         (                                                                                            
                              SELECT                                                                                  
                                    A.PARTY_ID AS PAPA_ID                                                
                                   ,A.PARTY_NAME AS PAPA_NAME                                              
                                   ,B.RELATIONSHIP_CODE AS RELATIONSHIP_CODE                                      
                                   ,C.PARTY_ID AS HIJO_ID                                                
                                   ,C.PARTY_NAME AS HIJO_NAME                                              
                                   ,B.RELATIONSHIP_TYPE AS RELATIONSHIP_TYPE                                      
                              FROM erp_pgbari_sz.hz_parties_ar A                                                    
                                   INNER JOIN erp_pgbari_sz.hz_relationships_ar B ON A.PARTY_ID = B.SUBJECT_ID      
                                   INNER JOIN erp_pgbari_sz.hz_parties_ar C ON B.OBJECT_ID = C.PARTY_ID           
                              WHERE B.RELATIONSHIP_CODE = 'SUBSIDIARY_OF'                                             
                              AND C.PARTY_NAME LIKE '%(NAT)%'                                                         
                              AND B.STATUS = 'A'                                                                      
                         ) NAT ON REG.HIJO_ID = NAT.PAPA_ID     
               LEFT JOIN (SELECT B.CUST_ACCOUNT_ID, B.BILLTO_CUST_ACCOUNT_ID FROM erp_pgbari_sz.ozf_funds_utilized_all_b_ozf B WHERE B.BILLTO_CUST_ACCOUNT_ID IS NOT NULL GROUP BY 1,2) B ON BAN.CUST_ACCOUNT_ID = B.CUST_ACCOUNT_ID
     WHERE BAN.ACCOUNT_NAME IS NOT NULL     
     )a     
)A     
     LEFT JOIN (SELECT CUSTOMER_ID FROM STG_DSD_CANADA.T_ORDER_FINAL WHERE DEF = 'CP' GROUP BY 1) C ON TRIM(A.`LOCATION`) = TRIM(C.CUSTOMER_ID)
WHERE `LOCATION` BETWEEN '0' AND '99999999999999999999';





-- ================== TRANSFORMATIONS ==================

-- Inserting values into STG_CANADA.T_CUSTOMERS_CB, using view WRK_GLOBAL.V_CUSTOMERS_CB

Insert overwrite table STG_CANADA.T_CUSTOMERS_CB 
select 
cast(customeroracle_id as int) as customeroracle_id,
cast(`location` as varchar(50)) as `location`,
cast(customerar_id as varchar(50)) as customerar_id,
cast(account_number as varchar(50)) as account_number,
cast(customersap_id as varchar(50)) as customersap_id,
cast(customer_name as varchar(50)) as customer_name,
cast(site_use_code as varchar(50)) as site_use_code,
cast(ship_to_customer_name as varchar(50)) as ship_to_customer_name,
cast(account_name as varchar(50)) as account_name,
cast(store as varchar(50)) as store,
cast(banner_customeroracle_id as int) as banner_customeroracle_id,
cast(banner_customersap_id as varchar(50)) as banner_customersap_id,
cast(banner_customer_name as varchar(50)) as banner_customer_name,
cast(regional_customeroracle_id as int) as regional_customeroracle_id,
cast(regional_customersap_id as varchar(50)) as regional_customersap_id,
cast(regional_customer_name as varchar(50)) as regional_customer_name,
cast(national_customeroracle_id as int) as national_customeroracle_id,
cast(national_customersap_id as varchar(50)) as national_customersap_id,
cast(national_customer_name as varchar(50)) as national_customer_name,
cast(channel_id as varchar(50)) as channel_id,
cast(customer_group as varchar(50)) as customer_group,
cast(address as varchar(50)) as address,
cast(city as varchar(50)) as city,
cast(postal_code as varchar(50)) as postal_code,
cast(country_name as varchar(50)) as country_name,
cast(province as varchar(50)) as province,
cast(org_id as int) as org_id,
cast(salesflag as char(1)) as salesflag
from WRK_GLOBAL.V_CUSTOMERS_CB;
