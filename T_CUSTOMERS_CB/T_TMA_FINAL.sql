-- ================== CREATE DDL'S ==================
CREATE VIEW if not exists wrk_global.V_CUSTOMERS
AS
SELECT 
      BAN.CUSTOMERORACLE_ID
     ,BAN.CUSTOMERSAP_ID
     ,BAN.CUSTOMER_NAME
     ,BAN.ACCOUNT_NAME
     ,BAN.BANNER_CUSTOMERORACLE_ID
     ,BAN.BANNER_CUSTOMERSAP_ID
     ,BAN.BANNER_CUSTOMER_NAME
     ,REG.HIJO_ID AS REGIONAL_CUSTOMERORACLE_ID
     ,BAN.REGIONAL_CUSTOMERSAP_ID
     ,REG.HIJO_NAME AS REGIONAL_CUSTOMER_NAME
     ,NAT.HIJO_ID AS NATIONAL_CUSTOMERORACLE_ID
     ,BAN.NATIONAL_CUSTOMERSAP_ID
     ,NAT.HIJO_NAME AS NATIONAL_CUSTOMER_NAME
     ,BAN.CHANNEL_ID
     ,BAN.CUSTOMER_GROUP
     ,BAN.COUNTRY_NAME
     ,BAN.ORG_ID 
FROM 
     (
     SELECT 
           PS.PARTY_SITE_ID AS CUSTOMERORACLE_ID
          ,HCASA.ORIG_SYSTEM_REFERENCE AS CUSTOMERSAP_ID
          ,PS.PARTY_SITE_NAME AS CUSTOMER_NAME
          ,HCA.ACCOUNT_NAME AS ACCOUNT_NAME
          ,HCA.PARTY_ID AS BANNER_CUSTOMERORACLE_ID
          ,HCASA.ATTRIBUTE10 AS BANNER_CUSTOMERSAP_ID
          ,HPB.PARTY_NAME AS BANNER_CUSTOMER_NAME
          ,PS.ATTRIBUTE1 AS REGIONAL_CUSTOMERSAP_ID
          ,HPR.PARTY_NAME AS REGIONAL_CUSTOMER_NAME
          ,PS.ATTRIBUTE15 AS NATIONAL_CUSTOMERSAP_ID
          ,HPN.PARTY_NAME AS NATIONAL_CUSTOMER_NAME
          ,HCASA.ATTRIBUTE11 AS CHANNEL_ID
          ,HPB.GROUP_TYPE AS CUSTOMER_GROUP
          ,HPB.COUNTRY AS COUNTRY_NAME
          ,HCASA.ORG_ID AS ORG_ID
     FROM erp_pgbari_sz.HZ_CUST_ACCOUNTS_AR HCA
      ,erp_pgbari_sz.HZ_CUST_ACCT_SITES_ALL_AR HCASA   
      ,erp_pgbari_sz.HZ_PARTIES_AR HPB
      ,erp_pgbari_sz.HZ_PARTIES_AR HPR
      ,erp_pgbari_sz.HZ_PARTIES_AR HPN
     , erp_pgbari_sz.HZ_PARTY_SITES_AR PS
     WHERE HCA.PARTY_ID = HPB.PARTY_ID
       AND HCA.PARTY_ID = HPR.PARTY_ID
       AND HCA.PARTY_ID = HPN.PARTY_ID
       AND HCA.PARTY_ID = PS.PARTY_ID
       AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID
       AND HCASA.ORG_ID = 714
     GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
     ) BAN
          LEFT JOIN 
                    (
                         SELECT 
                               N.PAPA_ID
                              ,N.PAPA_NAME
                              ,N.RELATIONSHIP_CODE
                              ,N.HIJO_ID
                              ,N.HIJO_NAME
                              ,N.RELATIONSHIP_TYPE
                         FROM
                         (
                              SELECT 
                                    A.PARTY_ID AS PAPA_ID
                                   ,A.PARTY_NAME AS PAPA_NAME
                                   ,B.RELATIONSHIP_CODE AS RELATIONSHIP_CODE
                                   ,C.PARTY_ID AS HIJO_ID
                                   ,C.PARTY_NAME AS HIJO_NAME
                                   ,B.RELATIONSHIP_TYPE AS RELATIONSHIP_TYPE
                                   ,B.LAST_UPDATE_DATE
                              FROM erp_pgbari_sz.HZ_PARTIES_AR A
                                   INNER JOIN erp_pgbari_sz.HZ_RELATIONSHIPS_AR B ON A.PARTY_ID = B.SUBJECT_ID
                                   INNER JOIN erp_pgbari_sz.HZ_PARTIES_AR C ON B.OBJECT_ID = C.PARTY_ID
                              --WHERE B.RELATIONSHIP_TYPE = 'PARENT/SUBSIDIARY'
                              WHERE B.RELATIONSHIP_CODE = 'SUBSIDIARY_OF'
                              AND C.PARTY_NAME LIKE '%(REG)%'
                              AND B.STATUS = 'A'
                         )N
                              INNER JOIN
                                        (
                                             SELECT 
                                                   A.PARTY_ID AS PAPA_ID
                                                  ,MAX(B.LAST_UPDATE_DATE) AS LAST_UPDATE_DATE
                                             FROM erp_pgbari_sz.HZ_PARTIES_AR A
                                                  INNER JOIN erp_pgbari_sz.HZ_RELATIONSHIPS_AR B ON A.PARTY_ID = B.SUBJECT_ID
                                                  INNER JOIN erp_pgbari_sz.HZ_PARTIES_AR C ON B.OBJECT_ID = C.PARTY_ID
                                             --WHERE B.RELATIONSHIP_TYPE = 'PARENT/SUBSIDIARY'
                                             WHERE B.RELATIONSHIP_CODE = 'SUBSIDIARY_OF'
                                             AND C.PARTY_NAME LIKE '%(REG)%'
                                             AND B.STATUS = 'A'
                                             GROUP BY 1
                                        )M ON N.PAPA_ID = M.PAPA_ID AND N.LAST_UPDATE_DATE = M.LAST_UPDATE_DATE
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
                         FROM erp_pgbari_sz.HZ_PARTIES_AR A
                              INNER JOIN erp_pgbari_sz.HZ_RELATIONSHIPS_AR B ON A.PARTY_ID = B.SUBJECT_ID
                              INNER JOIN erp_pgbari_sz.HZ_PARTIES_AR C ON B.OBJECT_ID = C.PARTY_ID
                         --WHERE B.RELATIONSHIP_TYPE = 'PARENT/SUBSIDIARY'
                         WHERE B.RELATIONSHIP_CODE = 'SUBSIDIARY_OF'
                         AND C.PARTY_NAME LIKE '%(NAT)%'
                         AND B.STATUS = 'A'
                    ) NAT ON REG.HIJO_ID = NAT.PAPA_ID
WHERE BAN.BANNER_CUSTOMER_NAME NOT LIKE '%(NAT)%'
AND BAN.BANNER_CUSTOMER_NAME NOT LIKE '%(REG)%';


-- ================== TRANSFORMATIONS ==================

----------------------------------- PASO 1:   DROP table wrk_global.T_TMA_FINAL_PASO  -----------------------------------------

DROP TABLE IF EXISTS wrk_global.t_tma_final_paso;


----------------------------------- PASO 2:   Create table wrk_global.T_TMA_FINAL_PASO  -----------------------------------------

CREATE TABLE wrk_global.T_TMA_FINAL_PASO 

AS

SELECT
      TRIM(CAST(LEGALENTITY_ID AS VARCHAR(4))) AS Company_ID,
      TRIM(CAST(REGION_ID AS VARCHAR(6))) AS Sales_District,
      TRIM(CAST(REGION AS VARCHAR(20))) AS Sales_District_Name,
      TRIM(CAST(OFFER_TYPE AS VARCHAR(50))) AS Offer_Type,
      TRIM(CAST('N/A' AS VARCHAR(20))) AS Category,
      TRIM(CAST(CHANNEL_ID AS VARCHAR(20))) AS Channel_ID,
      TRIM(CAST(FISCAL_YEAR AS VARCHAR(4))) AS Fiscal_Year,
      TRIM(CAST(TRIM(CAST(CONCAT(TRIM(CAST(FISCAL_YEAR  AS VARCHAR(10))),'0',TRIM(CAST(FISCAL_PERIOD AS VARCHAR(10)))) AS VARCHAR(10))) AS VARCHAR(7))) AS Fiscal_Period,
      --TRIM(CAST(TRIM(CAST(TRIM(CAST(FISCAL_YEAR  AS VARCHAR(10)))||'0'||TRIM(CAST(FISCAL_PERIOD AS VARCHAR(10)))AS VARCHAR(10))) AS VARCHAR(7))) AS Fiscal_Period,
      TRIM(CAST(TRIM(CAST(CONCAT(TRIM(CAST(FISCAL_YEAR  AS VARCHAR(10))),TRIM(CAST(WEEK AS VARCHAR(10)))) AS VARCHAR(10))) AS VARCHAR(6))) AS Fiscal_Week,
      --TRIM(CAST(TRIM(CAST(TRIM(CAST(FISCAL_YEAR  AS VARCHAR(10)))||TRIM(CAST(WEEK AS VARCHAR(10)))AS VARCHAR(10))) AS VARCHAR(6))) AS Fiscal_Week,
      TO_DATE(ADJUSTMENT_DATE) AS Bill_Date,
      CAST(UTILIZATION_ID AS INTEGER) AS Utilization_ID,
      TRIM(CAST(OFFER_CODE AS VARCHAR(30))) AS Offer_Code,
      CAST(FUND_ID AS INTEGER) AS Fund_ID,
      TRIM(CAST(CASE
     	          WHEN SHORT_NAME LIKE '%BillBack%' THEN 'Bill_Back_Accrual'
     	          WHEN SHORT_NAME LIKE '%Coop Allowance%' THEN 'Co_op_Allowances_Accrual'
     	          WHEN SHORT_NAME LIKE '%Exclusivity%' THEN 'Exclusivity_Allowance_Accrual'
     	          WHEN SHORT_NAME LIKE '%Growth Incentive%' THEN 'Growth_Incentives_Accrual'
     	          WHEN SHORT_NAME LIKE '%Merchandising%' THEN 'Merchandising_Accrual'
     	          WHEN SHORT_NAME LIKE '%Rebate%' THEN 'Rebates_Accrual'
     	          WHEN SHORT_NAME LIKE '%Unconditional & Relationship Spend%' THEN 'Unconditional_And_Relationship_Accrual'
     	          WHEN SHORT_NAME LIKE '%Buying Group%' THEN 'Buying_Group_Accrual'
                  WHEN SHORT_NAME LIKE '%Listing Fee%' THEN 'Listing_Fee_Accrual' ELSE SHORT_NAME END AS VARCHAR(50))) AS Account_Description,
      TRIM(CAST(SPEND_TYPE AS VARCHAR(50))) AS Spend_Type,
      TRIM(CAST(DOC_NUMBER AS VARCHAR(20))) AS Doc_Number,
      TRIM(CAST(BILL_TYPE AS VARCHAR(20))) AS Doc_Type,
      TRIM(CAST(TRIM(COALESCE(A.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string))) AS VARCHAR(10))) AS Customer_ID,
      TRIM(CAST(TRIM(COALESCE(cast(A.CUSTOMERAR_ID as string),'9999')) AS VARCHAR(10))) AS CustomerAR_ID,
      TRIM(CAST(Ship_To AS VARCHAR(10))) AS Ship_To,
      TRIM(CAST(PRODUCT_ID AS VARCHAR(18))) AS Product_ID,
      CAST(AMOUNT AS DECIMAL(19,4)) AS Amount,
      TRIM(CAST(CURRENCY_CODE AS VARCHAR(5))) AS Currency,
      SUM(CAST(QUANTITY AS DECIMAL(19,4))) AS Unit_Sold,
      SUM(CAST(AMOUNT AS DECIMAL(19,4))) AS Total,
      TRIM(CAST(FLAG_ADJ AS CHAR(1))) AS Adjustment_Flag
FROM
    (
     SELECT
           TRIM(CASE
                 WHEN FUNDS.SHORT_NAME ILIKE '%ATL%' THEN 'East'
                 WHEN FUNDS.SHORT_NAME ILIKE '%WEST%' THEN 'West'
                 WHEN FUNDS.SHORT_NAME ILIKE '%ONT%' THEN 'Ontario'
                ELSE 'NA' END) AS REGION,
           TRIM(CASE
                 WHEN FUNDS.SHORT_NAME ILIKE '%ATL%' THEN '04'
                 WHEN FUNDS.SHORT_NAME ILIKE '%WEST%' THEN '01'
                 WHEN FUNDS.SHORT_NAME ILIKE '%ONT%' THEN '02'
                ELSE 'NA' END) AS REGION_ID,
           B.UTILIZATION_ID AS UTILIZATION_ID,
           '191' AS LEGALENTITY_ID,
           '00' AS CHANNEL_ID,
           CAST(FUNDS.SHORT_NAME AS VARCHAR(50)) AS SPEND_TYPE,
           B.FUND_ID AS FUND_ID,
           B.AMOUNT AS AMOUNT,
           ORL.QUANTITY AS QUANTITY,
           'CAD' AS CURRENCY_CODE,
           B.GL_DATE AS ADJUSTMENT_DATE,
           OZF.OFFER_CODE AS OFFER_CODE,
           TRIM(CONCAT(SUBSTR(ORL.ORDER_NUMBER, 1,1),SUBSTR(ORL.ORDER_NUMBER, 9,3),SUBSTR(ORL.ORDER_NUMBER, 4,4),SUBSTR(ORL.ORDER_NUMBER, 12,4))) AS DOC_NUMBER,
           TRIM(SUBSTR(ORL.ORDER_NUMBER, 2,2)) AS BILL_TYPE,
           OZF.OFFER_TYPE AS OFFER_TYPE,
           CND.FISCAL_YEAR AS FISCAL_YEAR,
           CND.WEEK AS WEEK,
           CND.PERIOD AS FISCAL_PERIOD,
           COALESCE(ORL.ITEM_NUMBER, MTL.SEGMENT1) AS PRODUCT_ID,
           FUNDS.SHORT_NAME AS SHORT_NAME,
           B.CUST_ACCOUNT_ID AS CUSTOMERAR_ID,
           ORL.SHIP_FROM_LOCATION AS CUSTOMERORACLE_ID,
           ORL.BILL_TO_LOCATION AS SHIP_TO,
           '0' AS FLAG_ADJ,
           CAST(0 AS DECIMAL(18,2)) AS LMPADJ_AMT
     FROM (
           SELECT * --Atlantic & West
           FROM erp_pgbari_sz.OZF_FUNDS_UTILIZED_ALL_B_OZF B
           WHERE to_date(b.gl_date) >= TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),28))
           AND cast(B.ORG_ID as string) = '894'
     	   AND B.AMOUNT <> 0 
     	   AND B.FUND_ID IN
     	                   (
                            SELECT
                            B.FUND_ID AS FUND_ID
                            FROM erp_pgbari_sz.OZF_FUNDS_UTILIZED_ALL_B_OZF B                                                                                                                                                                            
                            INNER JOIN erp_pgbari_sz.OZF_FUNDS_ALL_TL_OZF FUNDS ON B.FUND_ID = FUNDS.FUND_ID                                                                                                                                                                 
                            WHERE cast(B.ORG_ID as string) = '894' AND B.AMOUNT <> 0 AND FUNDS.LANGUAGE = 'US' AND FUNDS.SHORT_NAME LIKE '%CB%' AND FUNDS.SHORT_NAME NOT LIKE '%ONT%'
                            GROUP BY  1                                                                                                                           
                           )
           UNION ALL
          
           SELECT * --Ontario
           FROM erp_pgbari_sz.OZF_FUNDS_UTILIZED_ALL_B_OZF B
           WHERE to_date(b.gl_date) >= TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),28))
           AND cast(B.ORG_ID as string) = '894'
           AND B.AMOUNT <> 0 
           AND B.FUND_ID IN
                          (
                           10500
                          ,10502
                          ,10520
                          ,10521
                          ,10522
                          ,10503
                          ,10504
                          ,10505
                          )
          ) B
    INNER JOIN erp_pgbari_sz.OZF_OFFERS_OZF OZF ON B.PLAN_ID = OZF.QP_LIST_HEADER_ID
    INNER JOIN erp_pgbari_sz.OZF_FUNDS_ALL_TL_OZF FUNDS ON B.FUND_ID = FUNDS.FUND_ID
    INNER JOIN DWH_OPERERP_CANADA.CN_CALENDAR CND ON to_date(B.GL_DATE) = CND.BILL_DATE
    LEFT JOIN (SELECT INVENTORY_ITEM_ID, SEGMENT1 FROM erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV GROUP BY 1,2) MTL ON B.PRODUCT_ID = MTL.INVENTORY_ITEM_ID
    LEFT JOIN erp_pgbari_sz.OZF_RESALE_ADJUSTMENTS_ALL_OZF ORAA ON B.PLAN_ID = ORAA.LIST_HEADER_ID AND B.OBJECT_ID = ORAA.RESALE_LINE_ID
    LEFT JOIN erp_pgbari_sz.OZF_RESALE_LINES_ALL_OZF ORL ON ORL.RESALE_LINE_ID = ORAA.RESALE_LINE_ID 
    WHERE FUNDS.LANGUAGE = 'US' AND (OZF.OFFER_TYPE = 'ACCRUAL' AND B.UTILIZATION_TYPE = 'ACCRUAL')
    AND FUNDS.FUND_ID NOT IN
                       (
                        10468
                       ,10480
                       ,10481
                       ,10482
                       ,10485
                       ,10486
                       ,10487
                       ,10483
                       ,10484
                       ,10467
                       ,10460
                       ,10461
                       ,10462
                       ,10463
                       ,10464
                       ,10465
                       ,10466
                       ,10469
                       )
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
    )a
LEFT JOIN (SELECT CUSTOMERAR_ID ,MAX(CUSTOMERORACLE_ID) AS CUSTOMERORACLE_ID FROM STG_CANADA.T_CUSTOMERS_CB GROUP BY 1) CUS ON TRIM(CAST(A.CUSTOMERAR_ID AS VARCHAR(20))) = TRIM(CAST(CUS.CUSTOMERAR_ID AS VARCHAR(20)))
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,26;




----------------------------------- PASO 3:   Insert into table wrk_global.T_TMA_FINAL_PASO  -----------------------------------------

INSERT INTO wrk_global.T_TMA_FINAL_PASO
	
SELECT
      TRIM(CAST('191' AS VARCHAR(4))) AS Company_ID,
      TRIM(CAST(B.REGION_ID AS VARCHAR(6))) AS Sales_District,
      TRIM(CAST(B.REGION AS VARCHAR(20))) AS Sales_District_Name,
      TRIM(CAST(UTILIZATION_TYPE AS VARCHAR(50))) AS Offer_Type,
      TRIM(CAST(B.CATEGORY AS VARCHAR(20))) AS Category,
      TRIM(CAST('00' AS VARCHAR(20))) AS Channel_ID,
      TRIM(CAST(B.FISCAL_YEAR AS VARCHAR(4))) AS Fiscal_Year,
      TRIM(CAST(TRIM(CAST(CONCAT(TRIM(CAST(B.FISCAL_YEAR AS VARCHAR(10))),'0',TRIM(CAST(B.FISCAL_PERIOD AS VARCHAR(10)))) AS VARCHAR(10))) AS VARCHAR(7))) AS Fiscal_Period,
    --TRIM(CAST(TRIM(CAST(TRIM(CAST(B.FISCAL_YEAR AS VARCHAR(10)))||'0'||TRIM(CAST(B.FISCAL_PERIOD AS VARCHAR(10)))AS VARCHAR(10))) AS VARCHAR(7))) AS Fiscal_Period,
      TRIM(CAST(TRIM(CAST(CONCAT(TRIM(CAST(B.FISCAL_YEAR AS VARCHAR(10))),TRIM(CAST(B.WEEK AS VARCHAR(10)))) AS VARCHAR(10))) AS VARCHAR(6))) AS Fiscal_Week,
    --TRIM(CAST(TRIM(CAST(TRIM(CAST(B.FISCAL_YEAR AS VARCHAR(10)))||TRIM(CAST(B.WEEK AS VARCHAR(10)))AS VARCHAR(10))) AS VARCHAR(6))) AS Fiscal_Week,
      TO_DATE(B.ADJUSTMENT_DATE) AS Bill_Date,
      CAST(B.UTILIZATION_ID AS INTEGER) AS Utilization_ID,
      TRIM(CAST(B.OFFER_CODE AS VARCHAR(30))) AS Offer_Code,
      CAST(B.FUND_ID AS INTEGER) AS Fund_ID,
      TRIM(CAST(CASE 
                      WHEN B.SHORT_NAME LIKE '%BillBack%' THEN 'Bill_Back_Lumpsum'
                      WHEN B.SHORT_NAME LIKE '%Coop Allowance%' THEN 'Co_op_Allowances_Lumpsum'
                      WHEN B.SHORT_NAME LIKE '%Exclusivity%' THEN 'Exclusivity_Allowance_Lumpsum'
                      WHEN B.SHORT_NAME LIKE '%Growth Incentive%' THEN 'Growth_Incentives_Lumpsum'
                      WHEN B.SHORT_NAME LIKE '%Merchandising%' THEN 'Merchandising_Lumpsum'
                      WHEN B.SHORT_NAME LIKE '%Rebate%' THEN 'Rebates_Lumpsum'
                      WHEN B.SHORT_NAME LIKE '%Unconditional & Relationship Spend%' THEN 'Unconditional_And_Relationship_Lumpsum'
                      WHEN B.SHORT_NAME LIKE '%Buying Group%' THEN 'Buying_Group_Lumpsum'
                      WHEN B.SHORT_NAME LIKE '%Listing Fee%' THEN 'Listing_Fee_Lumpsum'
                ELSE B.SHORT_NAME END AS VARCHAR(50))) AS Account_Description,
      TRIM(CAST(B.SHORT_NAME AS VARCHAR(50))) AS Spend_Type,
      TRIM(CAST('N/A' AS VARCHAR(20))) AS Doc_Number,
      TRIM(CAST('N/A' AS VARCHAR(20))) AS Doc_Type,
      TRIM(CAST(CASE
                    WHEN B.CATEGORY = 'TMA BRANDED' THEN COALESCE(BRANDED.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string),'9999')
                    WHEN B.CATEGORY = 'TMA CUS BRANDED' THEN COALESCE(CUSBRANDED.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string),'9999')
                    WHEN B.CATEGORY = 'TMA ALL ITEMS' THEN COALESCE(ALLITEMS.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string),'9999')
                    WHEN B.CATEGORY  = 'ALL FG ITEMS' THEN COALESCE(FG.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string),'9999')
			    ELSE cast(CUS.CUSTOMERORACLE_ID as string) END AS VARCHAR(10))) AS Customer_ID,
      TRIM(CAST(TRIM(COALESCE(cast(B.CUSTOMERAR_ID as string),'9999')) AS VARCHAR(10))) AS CustomerAR_ID,
      TRIM(CAST(CASE
                    WHEN B.CATEGORY = 'TMA BRANDED' THEN COALESCE(BRANDED.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string),'9999')
                    WHEN B.CATEGORY = 'TMA CUS BRANDED' THEN COALESCE(CUSBRANDED.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string),'9999')
                    WHEN B.CATEGORY = 'TMA ALL ITEMS' THEN COALESCE(ALLITEMS.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string),'9999')
                    WHEN B.CATEGORY = 'ALL FG ITEMS' THEN COALESCE(FG.CUSTOMERORACLE_ID,cast(CUS.CUSTOMERORACLE_ID as string),'9999')
                ELSE cast(CUS.CUSTOMERORACLE_ID as string) END AS VARCHAR(10))) AS Ship_To,                                             
      TRIM(CAST(CASE WHEN B.CATEGORY = 'TMA BRANDED' THEN COALESCE(BRANDED.PRODUCT_ID,'9999') 
                     WHEN B.CATEGORY = 'TMA CUS BRANDED' THEN COALESCE(CUSBRANDED.PRODUCT_ID,'9999') 
                     WHEN B.CATEGORY = 'TMA ALL ITEMS' THEN COALESCE(ALLITEMS.PRODUCT_ID,'9999') 
                     WHEN B.CATEGORY = 'ALL FG ITEMS' THEN COALESCE(FG.PRODUCT_ID,'9999') 
                ELSE '9999' END AS VARCHAR(10))) AS Product_ID,
      CAST(B.AMOUNT AS DECIMAL(19,4)) AS Amount,
      TRIM(CAST(B.CURRENCY_CODE AS VARCHAR(5))) AS Currency,
      SUM(CAST(0 AS DECIMAL(19,4))) AS Unit_Sold,
      SUM(CAST(CASE
                    WHEN B.CATEGORY = 'TMA BRANDED' THEN COALESCE(CAST(B.AMOUNT AS FLOAT)*(CAST(BRANDED.GROSS_SALES AS FLOAT)/NULLIFZERO(CAST(BRANDED.GROSS_SALES_SUM AS FLOAT))),CAST(B.AMOUNT AS FLOAT))
                    WHEN B.CATEGORY = 'TMA CUS BRANDED' THEN COALESCE(CAST(B.AMOUNT AS FLOAT)*(CAST(CUSBRANDED.GROSS_SALES AS FLOAT)/NULLIFZERO(CAST(CUSBRANDED.GROSS_SALES_SUM AS FLOAT))),CAST(B.AMOUNT AS FLOAT))
                    WHEN B.CATEGORY = 'TMA ALL ITEMS' THEN COALESCE(CAST(B.AMOUNT AS FLOAT)*(CAST(ALLITEMS.GROSS_SALES AS FLOAT)/NULLIFZERO(CAST(ALLITEMS.GROSS_SALES_SUM AS FLOAT))),CAST(B.AMOUNT AS FLOAT))
                    WHEN B.CATEGORY = 'ALL FG ITEMS' THEN COALESCE(CAST(B.AMOUNT AS FLOAT)*(CAST(FG.GROSS_SALES AS FLOAT)/NULLIFZERO(CAST(FG.GROSS_SALES_SUM AS FLOAT))),CAST(B.AMOUNT AS FLOAT))
               ELSE B.AMOUNT END AS DECIMAL(19,4))) AS Total,
      TRIM(CAST('1' AS CHAR(1))) AS Adjustment_Flag
FROM
    (
     SELECT
           TRIM(CASE
                    WHEN FUNDS.SHORT_NAME ILIKE '%ATL%' THEN 'East'
                    WHEN FUNDS.SHORT_NAME ILIKE '%WEST%' THEN 'West'
                    WHEN FUNDS.SHORT_NAME ILIKE '%ONT%' THEN 'Ontario'
                ELSE 'NA' END) AS REGION,
           TRIM(CASE
                    WHEN FUNDS.SHORT_NAME ILIKE '%ATL%' THEN '04'
                    WHEN FUNDS.SHORT_NAME ILIKE '%WEST%' THEN '01'
                    WHEN FUNDS.SHORT_NAME ILIKE '%ONT%' THEN '02'							 
                ELSE 'NA' END) AS REGION_ID,
           B.UTILIZATION_ID AS UTILIZATION_ID,
           B.UTILIZATION_TYPE AS UTILIZATION_TYPE,
           B.FUND_ID AS FUND_ID,
           CAST(B.AMOUNT AS DECIMAL(18,4)) AS AMOUNT,
           B.CURRENCY_CODE AS CURRENCY_CODE,
           B.GL_DATE AS ADJUSTMENT_DATE,
           B.UNIV_CURR_AMOUNT AS UNIV_CURR_AMOUNT,
           OZF.QP_LIST_HEADER_ID AS OFFER_ID,
           OZF.OFFER_TYPE AS OFFER_TYPE,
           OZF.OFFER_CODE AS OFFER_CODE,
           CND.WEEK AS WEEK,
           CND.FISCAL_YEAR AS FISCAL_YEAR,
           TRIM(CAST(CONCAT(TRIM(CAST(CND.FISCAL_YEAR AS VARCHAR(100))),'0',TRIM(CAST(CND.PERIOD AS VARCHAR(100)))) AS VARCHAR(100))) AS FISCAL_PERIOD_2,
           CND.PERIOD AS FISCAL_PERIOD,
           FLEX.SEGMENT1 AS CATEGORY,
           FUNDS.SHORT_NAME AS SHORT_NAME,
           B.CUST_ACCOUNT_ID AS CUSTOMERAR_ID
     FROM (
           SELECT * --Atlantic & West
           FROM erp_pgbari_sz.OZF_FUNDS_UTILIZED_ALL_B_OZF B
           WHERE to_date(b.gl_date) >= TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),28))
           AND cast(B.ORG_ID as string) = '894'
           AND B.AMOUNT <> 0 
           AND B.FUND_ID IN
                          (
                           SELECT
                           B.FUND_ID AS FUND_ID
                           FROM erp_pgbari_sz.OZF_FUNDS_UTILIZED_ALL_B_OZF B                                                                                                                                                                            
                           INNER JOIN erp_pgbari_sz.OZF_FUNDS_ALL_TL_OZF FUNDS ON B.FUND_ID = FUNDS.FUND_ID                                                                                                                                                                 
                           WHERE cast(B.ORG_ID as string) = '894' AND B.AMOUNT <> 0 AND FUNDS.LANGUAGE = 'US' AND FUNDS.SHORT_NAME LIKE '%CB%' AND FUNDS.SHORT_NAME NOT LIKE '%ONT%'
                           GROUP BY  1                                                                                                                           
                          )
                          UNION ALL
                           SELECT * --Ontario
                           FROM erp_pgbari_sz.OZF_FUNDS_UTILIZED_ALL_B_OZF B
                           WHERE to_date(b.gl_date) >= TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),28))
                           AND cast(B.ORG_ID as string) = '894'
                           AND B.AMOUNT <> 0 
                           AND B.FUND_ID IN
                                          (
                                           10500
                                          ,10502
                                          ,10520
                                          ,10521
                                          ,10522
                                          ,10503
                                          ,10504
                                          ,10505
                                          )
          ) B
    INNER JOIN erp_pgbari_sz.OZF_OFFERS_OZF OZF ON B.PLAN_ID = OZF.QP_LIST_HEADER_ID
    INNER JOIN erp_pgbari_sz.OZF_FUNDS_ALL_TL_OZF FUNDS ON B.FUND_ID = FUNDS.FUND_ID
    INNER JOIN DWH_OPERERP_CANADA.CN_CALENDAR CND ON to_date(B.GL_DATE) = CND.BILL_DATE
    LEFT JOIN (SELECT ITEM_ID, SEGMENT1,DESCRIPTION FROM erp_pgbari_sz.MTL_ITEM_FLEXFIELDS_APPS GROUP BY 1,2,3) FLEX ON FLEX.ITEM_ID = B.PRODUCT_ID
    WHERE FUNDS.LANGUAGE = 'US' AND NOT (OZF.OFFER_TYPE = 'ACCRUAL' AND B.UTILIZATION_TYPE = 'ACCRUAL')
    AND FUNDS.FUND_ID NOT IN
                           (
                            10468
                           ,10480
                           ,10481
                           ,10482
                           ,10485
                           ,10486
                           ,10487
                           ,10483
                           ,10484
                           ,10467
                           ,10460
                           ,10461
                           ,10462
                           ,10463
                           ,10464
                           ,10465
                           ,10466
                           ,10469
                          )
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
    )B
	--BRANDED
LEFT JOIN
        (
         SELECT
              PRODUCT_ID,
              WEEK,
              CUSTOMERORACLE_ID,
              CUSTOMER_ID,
              SALES_DISTRICT_NAME,
              CAST(GROSS_SALES AS DECIMAL(18,4)) AS GROSS_SALES ,
              CAST(SUM(TOF.GROSS_SALES) OVER (PARTITION BY WEEK, SALES_DISTRICT_NAME, CUSTOMER_ID ORDER BY TOF.WEEK,TOF.GROSS_SALES) AS DECIMAL(18,4)) AS GROSS_SALES_SUM
         FROM
             (
              SELECT
                 TRIM(TOF.PRODUCT_ID) AS PRODUCT_ID,
                 TRIM(TOF.WEEK) AS WEEK,
                 TRIM(TOF.CUSTOMER_ID) AS CUSTOMERORACLE_ID,
                 TRIM(CUS.CUSTOMERAR_ID) AS CUSTOMER_ID,
                 TRIM(TOF.SALES_DISTRICT_NAME) AS SALES_DISTRICT_NAME,
                 SUM(TOF.GROSS_SALES) AS GROSS_SALES
              FROM
                 (
                  SELECT
                     PRODUCT_ID
                    ,WEEK
                    ,CUSTOMER_ID
                    ,SALES_DISTRICT_NAME
                    ,GROSS_SALES
                  FROM STG_DSD_CANADA.T_ORDER_FINAL
                  WHERE GROSS_SALES <> 0
                  AND DEF = 'CP-TMA'
                 )TOF
              LEFT JOIN STG_CANADA.T_CUSTOMERS_CB CUS ON TOF.CUSTOMER_ID = cast(CUS.CUSTOMERORACLE_ID as string)
              WHERE PRODUCT_ID IN
                          (
                           SELECT
                              A.SEGMENT1
                           FROM erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV A
                           INNER JOIN erp_pgbari_sz.MTL_ITEM_CATEGORIES_INV B ON A.ORGANIZATION_ID = B.ORGANIZATION_ID AND A.INVENTORY_ITEM_ID = B.INVENTORY_ITEM_ID
                           INNER JOIN erp_pgbari_sz.MTL_CATEGORIES_B_INV C ON B.CATEGORY_ID = C.CATEGORY_ID
                           INNER JOIN STG_CANADA_VIEWS.V_PLANTS P ON A.ORGANIZATION_ID = P.ORGANIZATION_ID AND P.LEGALENTITY_ID = '191'
                           WHERE C.SEGMENT1 = 'BRANDED'
                           GROUP BY 1
                          )
              GROUP BY 1,2,3,4,5
            )TOF
        )BRANDED ON TRIM(CAST(B.CUSTOMERAR_ID AS VARCHAR(20))) = TRIM(CAST(BRANDED.CUSTOMER_ID AS VARCHAR(20))) AND TRIM(CAST(CONCAT(TRIM(B.FISCAL_YEAR),TRIM(B.WEEK)) AS VARCHAR(10))) = BRANDED.WEEK  AND B.REGION = BRANDED.SALES_DISTRICT_NAME AND B.CATEGORY = 'TMA BRANDED'
--CUSTOMER BRANDED
LEFT JOIN
        (
         SELECT
            PRODUCT_ID,
            WEEK,
            CUSTOMERORACLE_ID,
            CUSTOMER_ID,
            SALES_DISTRICT_NAME,
            CAST(GROSS_SALES AS DECIMAL(18,4)) AS GROSS_SALES ,
            CAST(SUM(TOF.GROSS_SALES) OVER (PARTITION BY WEEK, SALES_DISTRICT_NAME, CUSTOMER_ID ORDER BY TOF.WEEK,TOF.GROSS_SALES) AS DECIMAL(18,4)) AS GROSS_SALES_SUM
         FROM
            (
             SELECT
                TRIM(TOF.PRODUCT_ID) AS PRODUCT_ID,
                TRIM(TOF.WEEK) AS WEEK,
                TRIM(TOF.CUSTOMER_ID) AS CUSTOMERORACLE_ID,
                TRIM(CUS.CUSTOMERAR_ID) AS CUSTOMER_ID,
                TRIM(TOF.SALES_DISTRICT_NAME) AS SALES_DISTRICT_NAME,
                SUM(TOF.GROSS_SALES) AS GROSS_SALES
             FROM
                (
                 SELECT
                    PRODUCT_ID
                   ,WEEK
                   ,CUSTOMER_ID
                   ,SALES_DISTRICT_NAME
                   ,GROSS_SALES
                 FROM STG_DSD_CANADA.T_ORDER_FINAL
                 WHERE GROSS_SALES <> 0
                 AND DEF = 'CP-TMA'
                )TOF
             LEFT JOIN STG_CANADA.T_CUSTOMERS_CB CUS ON TOF.CUSTOMER_ID  = cast(CUS.CUSTOMERORACLE_ID as string)
             WHERE PRODUCT_ID IN
                                (
                                 SELECT
                                    A.SEGMENT1
                                 FROM erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV A
                                 INNER JOIN erp_pgbari_sz.MTL_ITEM_CATEGORIES_INV B ON A.ORGANIZATION_ID = B.ORGANIZATION_ID AND A.INVENTORY_ITEM_ID = B.INVENTORY_ITEM_ID
                                 INNER JOIN erp_pgbari_sz.MTL_CATEGORIES_B_INV C ON B.CATEGORY_ID = C.CATEGORY_ID
                                 INNER JOIN STG_CANADA_VIEWS.V_PLANTS P ON A.ORGANIZATION_ID = P.ORGANIZATION_ID AND P.LEGALENTITY_ID = '191'
                                 WHERE C.SEGMENT1 =  'CUSTOMER BRANDED'
                                 GROUP BY 1
                                )
            GROUP BY 1,2,3,4,5
            )TOF
        )CUSBRANDED ON TRIM(CAST(B.CUSTOMERAR_ID AS VARCHAR(20))) = TRIM(CAST(CUSBRANDED.CUSTOMER_ID AS VARCHAR(20))) AND TRIM(CAST(CONCAT(TRIM(B.FISCAL_YEAR),TRIM(B.WEEK)) AS VARCHAR(10))) = CUSBRANDED.WEEK AND B.REGION = CUSBRANDED.SALES_DISTRICT_NAME AND B.CATEGORY = 'TMA CUS BRANDED'
--FG
LEFT JOIN
        (
         SELECT
            PRODUCT_ID,
            WEEK,
            CUSTOMERORACLE_ID,
            CUSTOMER_ID,
            SALES_DISTRICT_NAME,
            CAST(GROSS_SALES AS DECIMAL(18,4)) AS GROSS_SALES ,
            CAST(SUM(TOF.GROSS_SALES) OVER (PARTITION BY WEEK, SALES_DISTRICT_NAME, CUSTOMER_ID ORDER BY TOF.WEEK,TOF.GROSS_SALES) AS DECIMAL(18,4)) AS GROSS_SALES_SUM
         FROM
            (
             SELECT
                TRIM(TOF.PRODUCT_ID) AS PRODUCT_ID,
                TRIM(TOF.WEEK) AS WEEK,
                TRIM(TOF.CUSTOMER_ID) AS CUSTOMERORACLE_ID,
                TRIM(CUS.CUSTOMERAR_ID) AS CUSTOMER_ID,
                TRIM(TOF.SALES_DISTRICT_NAME) AS SALES_DISTRICT_NAME,
                SUM(TOF.GROSS_SALES) AS GROSS_SALES
             FROM
                (
                 SELECT
                    PRODUCT_ID
                   ,WEEK
                   ,CUSTOMER_ID
                   ,SALES_DISTRICT_NAME
                   ,GROSS_SALES
                 FROM STG_DSD_CANADA.T_ORDER_FINAL
                 WHERE GROSS_SALES <> 0
                 AND DEF = 'CP-TMA'
                )TOF
             LEFT JOIN STG_CANADA.T_CUSTOMERS_CB CUS ON TOF.CUSTOMER_ID  = cast(CUS.CUSTOMERORACLE_ID as string)
             WHERE PRODUCT_ID IN
                               (
                                SELECT
                                   A.SEGMENT1
                                FROM erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV A
                                INNER JOIN erp_pgbari_sz.MTL_ITEM_CATEGORIES_INV B ON A.ORGANIZATION_ID = B.ORGANIZATION_ID AND A.INVENTORY_ITEM_ID = B.INVENTORY_ITEM_ID
                                INNER JOIN erp_pgbari_sz.MTL_CATEGORIES_B_INV C ON B.CATEGORY_ID = C.CATEGORY_ID
                                INNER JOIN STG_CANADA_VIEWS.V_PLANTS P ON A.ORGANIZATION_ID = P.ORGANIZATION_ID AND P.LEGALENTITY_ID = '191'
                                WHERE C.SEGMENT1 =  'FG'
                                GROUP BY 1
                               )
             GROUP BY 1,2,3,4,5
             )TOF
        )FG ON TRIM(CAST(B.CUSTOMERAR_ID AS VARCHAR(20))) = TRIM(CAST(FG.CUSTOMER_ID AS VARCHAR(20))) AND TRIM(CAST(CONCAT(TRIM(B.FISCAL_YEAR),TRIM(B.WEEK)) AS VARCHAR(10))) = FG.WEEK  AND B.REGION = FG.SALES_DISTRICT_NAME AND B.CATEGORY = 'ALL FG ITEMS'
--ALL ITEMS
LEFT JOIN
        (
         SELECT
            PRODUCT_ID,
            WEEK,
            CUSTOMERORACLE_ID,
            CUSTOMER_ID,
            SALES_DISTRICT_NAME,
            CAST(GROSS_SALES AS DECIMAL(18,4)) AS GROSS_SALES,
            CAST(SUM(TOF.GROSS_SALES) OVER (PARTITION BY WEEK, SALES_DISTRICT_NAME, CUSTOMER_ID ORDER BY TOF.WEEK,TOF.GROSS_SALES) AS DECIMAL(18,4)) AS GROSS_SALES_SUM
         FROM
            (
             SELECT
                TRIM(TOF.PRODUCT_ID) AS PRODUCT_ID,
                TRIM(TOF.WEEK) AS WEEK,
                TRIM(TOF.CUSTOMER_ID) AS CUSTOMERORACLE_ID,
                TRIM(CUS.CUSTOMERAR_ID) AS CUSTOMER_ID,
                TRIM(TOF.SALES_DISTRICT_NAME) AS SALES_DISTRICT_NAME,
                SUM(TOF.GROSS_SALES) AS GROSS_SALES
             FROM
                (
                 SELECT
                    PRODUCT_ID
                   ,WEEK
                   ,CUSTOMER_ID
                   ,SALES_DISTRICT_NAME
                   ,GROSS_SALES
                 FROM STG_DSD_CANADA.T_ORDER_FINAL
                 WHERE GROSS_SALES <> 0
                 AND DEF = 'CP-TMA'
                )TOF
             LEFT JOIN STG_CANADA.T_CUSTOMERS_CB CUS ON TOF.CUSTOMER_ID = cast(CUS.CUSTOMERORACLE_ID as string)
             WHERE PRODUCT_ID IN
                               (
                                SELECT
                                   A.SEGMENT1
                                FROM erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV A
                                INNER JOIN erp_pgbari_sz.MTL_ITEM_CATEGORIES_INV B ON A.ORGANIZATION_ID = B.ORGANIZATION_ID AND A.INVENTORY_ITEM_ID = B.INVENTORY_ITEM_ID
                                INNER JOIN erp_pgbari_sz.MTL_CATEGORIES_B_INV C ON B.CATEGORY_ID = C.CATEGORY_ID
                                INNER JOIN STG_CANADA_VIEWS.V_PLANTS P ON A.ORGANIZATION_ID = P.ORGANIZATION_ID AND P.LEGALENTITY_ID = '191'
                                GROUP BY 1
                                )
             GROUP BY 1,2,3,4,5
             )TOF
        )ALLITEMS ON TRIM(CAST(B.CUSTOMERAR_ID AS VARCHAR(20))) = TRIM(CAST(ALLITEMS.CUSTOMER_ID AS VARCHAR(20))) AND TRIM(CAST(CONCAT(TRIM(B.FISCAL_YEAR),TRIM(ALLITEMS.WEEK)) AS VARCHAR(10))) = ALLITEMS.WEEK  AND B.REGION = ALLITEMS.SALES_DISTRICT_NAME AND  B.CATEGORY = 'TMA ALL ITEMS'
LEFT JOIN (SELECT CUSTOMERAR_ID ,MAX(CUSTOMERORACLE_ID) AS CUSTOMERORACLE_ID FROM STG_CANADA.T_CUSTOMERS_CB GROUP BY 1) CUS ON TRIM(CAST(B.CUSTOMERAR_ID AS VARCHAR(20))) = TRIM(CAST(CUS.CUSTOMERAR_ID AS VARCHAR(20)))
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,26;



---------------------------------- PASO 4:   DROP table wrk_global.T_TMA_FINAL_PASO_2  -----------------------------------------


DROP TABLE IF EXISTS WRK_GLOBAL.T_TMA_FINAL_PASO2;



----------------------------------- PASO 5:   Create table wrk_global.T_TMA_FINAL_PASO_2  -----------------------------------------


CREATE TABLE WRK_GLOBAL.T_TMA_FINAL_PASO2

AS

SELECT
   Company_ID
  ,Sales_District
  ,Sales_District_Name
  ,Offer_Type
  ,Category
  ,Channel_ID
  ,Fiscal_Year
  ,Fiscal_Period
  ,Fiscal_Week
  ,Bill_Date
  ,Utilization_ID
  ,Offer_Code
  ,Fund_ID
  ,Account_Description
  ,Spend_Type
  ,Doc_Number
  ,Doc_Type
  ,Customer_ID
  ,CustomerAR_ID
  ,Ship_To
  ,Product_ID
  ,Amount
  ,Currency
  ,Unit_Sold
  ,Adjustment_Flag
  ,SUM(Fin.Bill_Back_Accrual) AS Bill_Back_Accrual
  ,SUM(Fin.Co_op_Allowances_Accrual) AS Co_op_Allowances_Accrual
  ,SUM(Fin.Exclusivity_Allowance_Accrual) AS Exclusivity_Allowance_Accrual
  ,SUM(Fin.Growth_Incentives_Accrual) AS Growth_Incentives_Accrual
  ,SUM(Fin.Merchandising_Accrual) AS Merchandising_Accrual
  ,SUM(Fin.Rebates_Accrual) AS Rebates_Accrual
  ,SUM(Fin.Rebates_Lumpsum) AS Rebates_Lumpsum
  ,SUM(Fin.Total_Off_Invoice) AS Total_Off_Invoice
  ,SUM(Fin.Total_Off_Invoice_EA) AS Total_Off_Invoice_EA
  ,SUM(Fin.Uncon_And_Relationship_Accrual) AS Uncon_And_Relationship_Accrual
  ,SUM(Fin.Listing_Fee_Accrual) AS Listing_Fee_Accrual
  ,SUM(Fin.Bill_Back_Lumpsum) AS Bill_Back_Lumpsum
  ,SUM(Fin.Co_op_Allowances_Lumpsum) AS Co_op_Allowances_Lumpsum
  ,SUM(Fin.Exclusivity_Allowance_Lumpsum) AS Exclusivity_Allowance_Lumpsum
  ,SUM(Fin.Growth_Incentives_Lumpsum) AS Growth_Incentives_Lumpsum
  ,SUM(Fin.Merchandising_Lumpsum) AS Merchandising_Lumpsum
  ,SUM(Fin.Listing_Fee_Lumpsum) AS Listing_Fee_Lumpsum
  ,SUM(Fin.Uncon_And_Relationship_Lumpsum) AS Uncon_And_Relationship_Lumpsum
  ,SUM(Fin.Buying_Group_VIP_Accrual) AS Buying_Group_VIP_Accrual
  ,SUM(Fin.Buying_Group_VIP_Lumpsum) AS Buying_Group_VIP_Lumpsum
  ,SUM(Fin.Trade_Investments) AS Trade_Investments
FROM
   (
    SELECT
       Company_ID
      ,Sales_District
      ,Sales_District_Name
      ,Offer_Type
      ,Category
      ,Channel_ID
      ,Fiscal_Year
      ,Fiscal_Period
      ,Fiscal_Week
      ,Bill_Date
      ,Utilization_ID
      ,Offer_Code
      ,Fund_ID
      ,Account_Description
      ,Spend_Type
      ,Doc_Number
      ,Doc_Type
      ,Customer_ID
      ,CustomerAR_ID
      ,Ship_To
      ,Product_ID
      ,Amount
      ,Currency
      ,Unit_Sold
      ,Adjustment_Flag
      ,CAST(SUM(Bill_Back_Accrual) AS DECIMAL(19,4)) AS Bill_Back_Accrual
      ,CAST(SUM(Co_op_Allowances_Accrual) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
      ,CAST(SUM(Exclusivity_Allowance_Accrual) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
      ,CAST(SUM(Growth_Incentives_Accrual) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
      ,CAST(SUM(Merchandising_Accrual) AS DECIMAL(19,4)) AS Merchandising_Accrual
      ,CAST(SUM(Rebates_Accrual) AS DECIMAL(19,4)) AS Rebates_Accrual
      ,CAST(SUM(Rebates_Lumpsum) AS DECIMAL(19,4)) AS Rebates_Lumpsum
      ,CAST(SUM(Total_Off_Invoice_Accrual) AS DECIMAL(19,4)) AS Total_Off_Invoice
      ,CAST(SUM(Total_Off_Invoice_Accrual) AS DECIMAL(19,4)) AS Total_Off_Invoice_EA
      ,CAST(SUM(Uncon_And_Relationship_Accrual) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
      ,CAST(SUM(Listing_Fee_Accrual) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
      ,CAST(SUM(Bill_Back_Lumpsum) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
      ,CAST(SUM(Co_op_Allowances_Lumpsum) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
      ,CAST(SUM(Exclusivity_Allowance_Lumpsum) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
      ,CAST(SUM(Growth_Incentives_Lumpsum) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
      ,CAST(SUM(Merchandising_Lumpsum) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
      ,CAST(SUM(Listing_Fee_Lumpsum) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
      ,CAST(SUM(Uncon_And_Relationship_Lumpsum) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
      ,CAST(SUM(Buying_Group_VIP_Accrual) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
      ,CAST(SUM(Buying_Group_VIP_Lumpsum) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
      ,CAST(SUM(((a.Exclusivity_Allowance_Accrual + a.Exclusivity_Allowance_Lumpsum)+(a.Listing_Fee_Accrual + a.Listing_Fee_Lumpsum)+(a.Uncon_And_Relationship_Accrual + a.Uncon_And_Relationship_Lumpsum)+(a.Bill_Back_Accrual + a.Bill_Back_Lumpsum)+(a.Co_op_Allowances_Accrual + a.Co_op_Allowances_Lumpsum)+(a.Rebates_Accrual)+(a.Rebates_Lumpsum)+(a.Merchandising_Accrual + a.Merchandising_Lumpsum)+(a.Growth_Incentives_Accrual + a.Growth_Incentives_Lumpsum)+(a.Buying_Group_VIP_Accrual + a.Buying_Group_VIP_Lumpsum))) AS DECIMAL(19,4)) AS Trade_Investments
    FROM
        (
         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,ZEROIFNULL(Total) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Unconditional_And_Relationship_Accrual' --8000

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,ZEROIFNULL(Total) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Bill_Back_Accrual'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,ZEROIFNULL(Total) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Co_op_Allowances_Accrual' --3880

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,ZEROIFNULL(Total) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Exclusivity_Allowance_Accrual' --5500

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,ZEROIFNULL(Total) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Growth_Incentives_Accrual' --5370

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,ZEROIFNULL(Total) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Merchandising_Accrual'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,ZEROIFNULL(Total) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Rebates_Accrual' --7490

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,ZEROIFNULL(Total) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Rebates_Lumpsum'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,ZEROIFNULL(Total) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Total_Off_Invoice_Accrual'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,ZEROIFNULL(Total) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Listing_Fee_Accrual'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,ZEROIFNULL(Total) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Bill_Back_Lumpsum'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,ZEROIFNULL(Total) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Co_op_Allowances_Lumpsum' --3880

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,ZEROIFNULL(Total) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Exclusivity_Allowance_Lumpsum' --5500

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,ZEROIFNULL(Total) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Growth_Incentives_Lumpsum' --5370

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,ZEROIFNULL(Total) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Merchandising_Lumpsum'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,ZEROIFNULL(Total) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Total_Off_Invoice_Lumpsum' --7490

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,ZEROIFNULL(Total) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Listing_Fee_Lumpsum'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,ZEROIFNULL(Total) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Unconditional_And_Relationship_Lumpsum'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,ZEROIFNULL(Total) AS Buying_Group_VIP_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Buying_Group_Accrual'

         UNION ALL

         SELECT
            Company_ID
           ,Sales_District
           ,Sales_District_Name
           ,Offer_Type
           ,Category
           ,Channel_ID
           ,Fiscal_Year
           ,Fiscal_Period
           ,Fiscal_Week
           ,Bill_Date
           ,Utilization_ID
           ,Offer_Code
           ,Fund_ID
           ,Account_Description
           ,Spend_Type
           ,Doc_Number
           ,Doc_Type
           ,Customer_ID
           ,CustomerAR_ID
           ,Ship_To
           ,Product_ID
           ,Amount
           ,Currency
           ,Unit_Sold
           ,Adjustment_Flag
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Rebates_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Accrual
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Bill_Back_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Co_op_Allowances_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Exclusivity_Allowance_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Growth_Incentives_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Merchandising_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Total_Off_Invoice_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Listing_Fee_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Uncon_And_Relationship_Lumpsum
           ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4)) AS Buying_Group_VIP_Accrual
           ,ZEROIFNULL(Total) AS Buying_Group_VIP_Lumpsum
         FROM WRK_GLOBAL.T_TMA_FINAL_PASO
         WHERE Account_Description = 'Buying_Group_Lumpsum'
        )A
        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
)FIN
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25;


----------------------------------- PASO 6:   Create table STG_DSD_Canada.T_TMA_FINAL  -----------------------------------------

CREATE TABLE IF NOT EXISTS STG_DSD_CANADA.T_TMA_FINAL
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/stg_dsd_canada/T_TMA_FINAL'
as
SELECT * FROM WRK_GLOBAL.T_TMA_FINAL_PASO2
WHERE 1!=1;

INSERT OVERWRITE TABLE STG_DSD_CANADA.T_TMA_FINAL
SELECT * FROM WRK_GLOBAL.T_TMA_FINAL_PASO2;
