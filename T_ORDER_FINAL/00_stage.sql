
 
-------------***********************---------------

CREATE TABLE if not exists wrk_global.organization_id_CBC(
ORGANIZATION_ID double);

TRUNCATE TABLE wrk_global.organization_id_CBC;

INSERT INTO wrk_global.organization_id_CBC
SELECT ORGANIZATION_ID 
FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR 
WHERE NAME LIKE 'CBC%' 
AND LOCATION_ID IS NOT NULL 
GROUP BY 1;

-------------***********************---------------

DROP TABLE wrk_global.v_order_fac_tmp_a;

create table if not exists wrk_global.v_order_fac_tmp_a(
trx_date string,
SEGMENT1 string,
SEGMENT2 string,
SEGMENT3 string,
SEGMENT4 string,
SEGMENT5 string,
SEGMENT6 string,
SEGMENT7 string,
CUSTOMER_TRX_ID double,
LOCATION_ID double,
BILL_TO_CUSTOMER_ID double,
BILL_TO_SITE_USE_ID double, 
SHIP_TO_CUSTOMER_ID double,
SHIP_TO_SITE_USE_ID double,
SOLD_TO_CUSTOMER_ID double,
SOLD_TO_SITE_USE_ID double,   
ATTRIBUTE11 string,
sales_order string,
interface_line_attribute6 string,
trx_number string,
INVOICE_CURRENCY_CODE string,
cust_trx_line_gl_dist_id double,
xpercent double,
tipocambio double,
Fabrica_id string,
cuenta string,
code_combination_id double,
UNIT_SELLING_PRICE double,
QUANTITY_INVOICED double, 
order_type string);

TRUNCATE TABLE wrk_global.v_order_fac_tmp_a;

insert into wrk_global.v_order_fac_tmp_a
SELECT
    trx_date
    ,SEGMENT1
    ,SEGMENT2
    ,SEGMENT3
    ,SEGMENT4
    ,SEGMENT5
    ,SEGMENT6
    ,SEGMENT7
    ,Z.CUSTOMER_TRX_ID
    ,loc.LOCATION_ID
    ,BILL_TO_CUSTOMER_ID
    ,BILL_TO_SITE_USE_ID                                         
    ,z.SHIP_TO_CUSTOMER_ID
    ,z.SHIP_TO_SITE_USE_ID
    ,z.SOLD_TO_CUSTOMER_ID
    ,z.SOLD_TO_SITE_USE_ID           
    ,CAC.ATTRIBUTE11
    ,TRIM(CAST(COALESCE(INTERFACE_LINE_ATTRIBUTE1,'xxxxxx') AS VARCHAR(50))) sales_order
    ,a.interface_line_attribute6
    ,z.trx_number
    ,z.INVOICE_CURRENCY_CODE
    ,d.cust_trx_line_gl_dist_id
    ,d.percent xpercent
    ,EXCHANGE_RATE tipocambio
    ,SUBSTR(loc.LOCATION_CODE,5,4) Fabrica_id
    ,cac.ACCOUNT_NUMBER cuenta
    ,d.code_combination_id
    ,a.UNIT_SELLING_PRICE
    ,a.QUANTITY_INVOICED
    ,z.order_type
FROM (SELECT rct.* 
    FROM erp_pgbari_sz.ra_customer_trx_lines_all_ar rct, 
    wrk_global.organization_id_CBC cbc_org
    WHERE rct.ORG_ID = cbc_org.ORGANIZATION_ID )a
INNER JOIN (
          SELECT
                CUSTOMER_TRX_ID
                ,description
                ,a.attribute15
                ,creation_sign
                ,TYPE
                ,REASON_CODE
                ,BILL_TO_CUSTOMER_ID
                ,BILL_TO_SITE_USE_ID
                ,a.SHIP_TO_CUSTOMER_ID
                ,a.SHIP_TO_SITE_USE_ID
                ,a.SOLD_TO_CUSTOMER_ID
                ,a.SOLD_TO_SITE_USE_ID           
                ,creation_date
                ,trx_date
                ,TRX_NUMBER
                ,INVOICE_CURRENCY_CODE
                ,EXCHANGE_RATE
                ,a.interface_header_attribute2 as order_type
          FROM erp_pgbari_sz.ra_customer_trx_all_ar a, wrk_global.organization_id_CBC cbc_org
  LEFT OUTER JOIN (
          SELECT  
                 rctt.cust_trx_type_id
                 ,rctt.attribute15
                 ,rctt.TYPE
                 ,CASE WHEN instr(UPPER(rctt.description), ' A ') <>0 THEN TRIM(SUBSTR(rctt.description,3+instr(UPPER(rctt.description), ' A '),100)) ELSE TRIM(concat(rctt.attribute15,' ',rctt.description)) END description  
                 ,rctt.creation_sign
                 FROM erp_pgbari_sz.ra_cust_trx_types_all_ar rctt,wrk_global.organization_id_CBC cbc_org
                 WHERE rctt.ATTRIBUTE15 IS NOT NULL
                 AND rctt.ORG_ID = cbc_org.ORGANIZATION_ID 
                 GROUP BY 
                 1,2,3,4,5
               ) b ON a.cust_trx_type_id=b.cust_trx_type_id
        WHERE a.COMPLETE_FLAG = 'Y'
        AND a.ORG_ID = cbc_org.ORGANIZATION_ID                
        --IN (SELECT ORGANIZATION_ID FROM erp_pgbari_sz.hr_all_organization_units_hr WHERE NAME LIKE 'CBC%' AND LOCATION_ID IS NOT NULL GROUP BY 1)
        ) z ON a.customer_trx_id =z.customer_trx_id

        LEFT OUTER JOIN erp_pgbari_sz.hr_all_organization_units_hr org ON a.WAREHOUSE_ID = org.ORGANIZATION_ID
        LEFT OUTER JOIN erp_pgbari_sz.hr_locations_all_hr loc ON org.LOCATION_ID = loc.LOCATION_ID
        LEFT OUTER JOIN erp_pgbari_sz.hz_cust_accounts_ar cac ON z.BILL_TO_CUSTOMER_ID = cac.CUST_ACCOUNT_ID
        LEFT OUTER JOIN (
                           SELECT
                                  B.FLEX_VALUE
                                 ,A.DESCRIPTION
                             FROM erp_pgbari_sz.fnd_flex_values_tl_apps A,
                                  erp_pgbari_sz.fnd_flex_values_apps B,
                                  erp_pgbari_sz.fnd_flex_value_sets_apps C
                            WHERE A.FLEX_VALUE_ID = B.FLEX_VALUE_ID
                              AND B.FLEX_VALUE_SET_ID = C.FLEX_VALUE_SET_ID
                              AND /*C.FLEX_VALUE_SET_NAME LIKE 'BIMBO_CANALES_AR'
                              AND */A.LANGUAGE = 'US'
                         ) CANALES 
        ON canales.FLEX_VALUE  = Z.attribute15
        INNER JOIN erp_pgbari_sz.ra_cust_trx_line_gl_dist_all_ar d  
        ON d.CUSTOMER_TRX_LINE_ID = a.CUSTOMER_TRX_LINE_ID
             LEFT OUTER JOIN (
                           SELECT
                                       GL.CODE_COMBINATION_ID as code
                                      ,GL.SEGMENT1 as segment1
                                      ,GL.SEGMENT2 as segment2
                                      ,GL.SEGMENT3 as segment3
                                      ,GL.SEGMENT4 as segment4
                                      ,GL.SEGMENT5 as segment5
                                      ,GL.SEGMENT6 as segment6
                                      ,GL.SEGMENT7 as segment7
                                  FROM erp_pgbari_sz.GL_CODE_COMBINATIONS_GL GL
                                WHERE segment1 IN ('191')
                         ) x ON x.code = d.CODE_COMBINATION_ID
       WHERE to_date(d.gl_date) >= to_date(date_sub(from_unixtime(unix_timestamp()),60))
         AND to_date(d.gl_date) <= to_date(date_add(from_unixtime(unix_timestamp()),90))
         AND segment1 IN ('191')
       GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29;

-------------***********************---------------

create table if not exists wrk_global.v_order_fac_tmp_b(
order_number string,
line_id double,
ORDERED_ITEM string,
ORGANIZATION_ID double,
LOCATION_ID double,
FabricaOM_id string,
PRICING_QUANTITY_UOM string,
line_category_code string,
unit_selling_price double,
unit_list_price double,
ordered_quantity double,
fulfilled_quantity double,
CONVERSION_RATE double,
ventapiezas double,
ventapiezasDEV double,
shipping_quantity double,
pricing_quantity double,
OM_monto_selling double,
OM_monto_fullfilled double );

TRUNCATE TABLE wrk_global.v_order_fac_tmp_b;

insert into wrk_global.v_order_fac_tmp_b
SELECT
  TRIM(CAST(a.order_number AS string)) order_number
 ,line_id
 ,b.SEGMENT1 AS ORDERED_ITEM
 ,ORG.ORGANIZATION_ID
 ,ORG.LOCATION_ID
 ,SUBSTR(loc.LOCATION_CODE,5,4) FabricaOM_id
 ,PRICING_QUANTITY_UOM
 ,line_category_code
 ,unit_selling_price
 ,unit_list_price
 ,ordered_quantity
 ,fulfilled_quantity
 ,con.CONVERSION_RATE
 ,SUM(CASE
          WHEN line_category_code <> 'RETURN' AND shipping_quantity <> 0 THEN shipping_quantity
          WHEN line_category_code <> 'RETURN' AND (shipping_quantity = 0 OR shipping_quantity IS NULL) AND PRICING_QUANTITY_UOM = 'CS' THEN PRICING_QUANTITY
          WHEN line_category_code <> 'RETURN' AND (shipping_quantity = 0 OR shipping_quantity IS NULL) AND PRICING_QUANTITY_UOM <> 'CS' THEN PRICING_QUANTITY * (COALESCE(con.CONVERSION_RATE,1))
          WHEN line_category_code = 'RETURN' AND shipping_quantity <> 0 THEN shipping_quantity *(-1)
          WHEN line_category_code = 'RETURN' AND (shipping_quantity = 0 OR shipping_quantity IS NULL) AND PRICING_QUANTITY_UOM = 'CS' THEN PRICING_QUANTITY *(-1)
          WHEN line_category_code = 'RETURN' AND (shipping_quantity = 0 OR shipping_quantity IS NULL) AND PRICING_QUANTITY_UOM <> 'CS' THEN PRICING_QUANTITY * (COALESCE(con.CONVERSION_RATE,1))*(-1)
       END) ventapiezas
 ,SUM(CASE
          WHEN line_category_code = 'RETURN' AND shipping_quantity <> 0 THEN shipping_quantity *(-1)
          WHEN line_category_code = 'RETURN' AND (shipping_quantity = 0 OR shipping_quantity IS NULL) AND PRICING_QUANTITY_UOM = 'CS' THEN PRICING_QUANTITY *(-1)
          WHEN line_category_code = 'RETURN' AND (shipping_quantity = 0 OR shipping_quantity IS NULL) AND PRICING_QUANTITY_UOM <> 'CS' THEN PRICING_QUANTITY * (COALESCE(con.CONVERSION_RATE,1))*(-1)
       END) ventapiezasDEV
 ,SUM(CASE
           WHEN line_category_code = 'RETURN' THEN (-1)*shipping_quantity
           ELSE shipping_quantity
       END) shipping_quantity
 ,SUM(CASE
          WHEN line_category_code = 'RETURN' THEN (-1)*pricing_quantity
          ELSE pricing_quantity
       END) pricing_quantity
 ,SUM(CASE
          WHEN line_category_code = 'RETURN' THEN (-1)*ordered_quantity * unit_selling_price
          ELSE ordered_quantity * unit_selling_price
       END) OM_monto_selling
 ,SUM(CASE
          WHEN line_category_code = 'RETURN' THEN (-1)*fulfilled_quantity * unit_list_price
          ELSE fulfilled_quantity * unit_list_price 
      END) OM_monto_fullfilled
FROM (SELECT oe.*, ms.SEGMENT1 
FROM erp_pgbari_sz.OE_ORDER_LINES_ALL_ONT oe
LEFT JOIN (SELECT INVENTORY_ITEM_ID,SEGMENT1 
         FROM erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV 
         GROUP BY 1,2) ms 
     ON oe.inventory_item_id = ms.inventory_item_id
INNER JOIN wrk_global.organization_id_CBC org_cbc
ON oe.ORG_ID=org_cbc.ORGANIZATION_ID
WHERE line_number <= 1000000
AND last_update_date >= date_sub(from_unixtime(unix_timestamp()),60)
AND ordered_item IS NOT NULL
AND ordered_item NOT LIKE '%P%'
AND ordered_item NOT LIKE '%-%'
/* AND ORG_ID IN (SELECT ORGANIZATION_ID FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR 
          WHERE NAME LIKE 'CBC%' 
          AND LOCATION_ID IS NOT NULL GROUP BY 1)*/
 ) b
  INNER JOIN (SELECT a.* 
    FROM erp_pgbari_sz.OE_ORDER_HEADERS_ALL_ONT a, wrk_global.organization_id_CBC org_cbc 
    WHERE a.last_update_date >= date_sub(from_unixtime(unix_timestamp()),60) 
    AND a.ORG_ID = org_cbc.ORGANIZATION_ID  
    )a 
  ON a.header_id = b.header_id
LEFT OUTER JOIN (
                 SELECT
                        FROM_UOM_CLASS
                       ,TO_UOM_CLASS
                       ,FROM_UOM_CODE
                       ,TO_UOM_CODE
                       ,CONVERSION_RATE
                       ,BASE_UOM_FLAG
                       ,SR_ITEM_PK
                       ,ITEM
                   FROM erp_pgbari_sz.msd_sr_uom_conversions_v_apps
--                                       WHERE FROM_UOM_CODE =  'PZA'
                   --AND TO_UOM_CLASS = 'NYB_W'
               ) con ON (b.INVENTORY_ITEM_ID = con.SR_ITEM_PK ) AND (b.pricing_quantity_uom = con.TO_UOM_CODE )
LEFT OUTER JOIN erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR org ON b.SHIP_FROM_ORG_ID = org.ORGANIZATION_ID
LEFT OUTER JOIN erp_pgbari_sz.HR_LOCATIONS_ALL_HR loc ON (org.LOCATION_ID = loc.LOCATION_ID )
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13;

-------------***********************---------------

create table if not exists  wrk_global.v_order_fac_tmp_c(
PARTY_SITE_ID double,
CUST_ACCOUNT_ID double,
SITE_USE_ID double,
ATTRIBUTE11 string );

TRUNCATE TABLE wrk_global.v_order_fac_tmp_c;

insert into wrk_global.v_order_fac_tmp_c
SELECT 
 PS.PARTY_SITE_ID
,hca.CUST_ACCOUNT_ID
,HCASA.SITE_USE_ID
,HCASA.ATTRIBUTE11
FROM erp_pgbari_sz.hz_cust_accounts_ar HCA
,(
    SELECT 
     CSUA.SITE_USE_ID
    ,CASA.CUST_ACCOUNT_ID
    ,CASA.PARTY_SITE_ID
    ,CASA.ORG_ID
    ,CASA.ATTRIBUTE11
    FROM erp_pgbari_sz.hz_cust_acct_sites_all_ar CASA
    INNER JOIN erp_pgbari_sz.hz_cust_site_uses_all_ar CSUA 
    ON CASA.CUST_ACCT_SITE_ID = CSUA.CUST_ACCT_SITE_ID 
    AND CASA.ORG_ID = CSUA.ORG_ID                
    GROUP BY 1,2,3,4,5
  ) HCASA   
,erp_pgbari_sz.hz_parties_ar HPB
,erp_pgbari_sz.hz_parties_ar HPR
,erp_pgbari_sz.hz_parties_ar HPN
, erp_pgbari_sz.hz_party_sites_ar PS
, wrk_global.organization_id_CBC org_cbc
WHERE HCA.PARTY_ID = HPB.PARTY_ID
 AND HCA.PARTY_ID = HPR.PARTY_ID
 AND HCA.PARTY_ID = HPN.PARTY_ID
 AND HCA.PARTY_ID = PS.PARTY_ID
 AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID
 --AND HCASA.ORG_ID IN (SELECT ORGANIZATION_ID FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR WHERE NAME LIKE 'CBC%' AND LOCATION_ID IS NOT NULL GROUP BY 1)
 AND HCASA.ORG_ID = org_cbc.ORGANIZATION_ID 
GROUP BY 1,2,3,4 ;

-------------***********************---------------

create table if not exists wrk_global.v_order_fac_tmp_d(
PARTY_SITE_ID double,
CUST_ACCOUNT_ID double,
SITE_USE_ID double);

TRUNCATE TABLE wrk_global.v_order_fac_tmp_d;

insert into wrk_global.v_order_fac_tmp_d
SELECT 
 PS.PARTY_SITE_ID
,hca.CUST_ACCOUNT_ID
,HCASA.SITE_USE_ID
FROM erp_pgbari_sz.hz_cust_accounts_ar HCA
,(
    SELECT 
     CSUA.SITE_USE_ID
    ,CASA.CUST_ACCOUNT_ID
    ,CASA.PARTY_SITE_ID
    ,CASA.ORG_ID
    FROM erp_pgbari_sz.hz_cust_acct_sites_all_ar CASA
    INNER JOIN erp_pgbari_sz.hz_cust_site_uses_all_ar CSUA 
    ON CASA.CUST_ACCT_SITE_ID = CSUA.CUST_ACCT_SITE_ID 
    AND CASA.ORG_ID = CSUA.ORG_ID                
         GROUP BY 1,2,3,4
  ) HCASA   
,erp_pgbari_sz.HZ_PARTIES_AR HPB
,erp_pgbari_sz.HZ_PARTIES_AR HPR
,erp_pgbari_sz.HZ_PARTIES_AR HPN
, erp_pgbari_sz.HZ_PARTY_SITES_AR PS
, wrk_global.organization_id_CBC org_cbc
WHERE HCA.PARTY_ID = HPB.PARTY_ID
 AND HCA.PARTY_ID = HPR.PARTY_ID
 AND HCA.PARTY_ID = HPN.PARTY_ID
 AND HCA.PARTY_ID = PS.PARTY_ID
 AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID
 --AND HCASA.ORG_ID IN (SELECT ORGANIZATION_ID FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR WHERE NAME LIKE 'CBC%' AND LOCATION_ID IS NOT NULL GROUP BY 1)
AND HCASA.ORG_ID = org_cbc.ORGANIZATION_ID 
GROUP BY 1,2,3;

-------------***********************---------------

create table if not exists wrk_global.v_order_fac_tmp_e(
PARTY_SITE_ID double,
CUST_ACCOUNT_ID double,
SITE_USE_ID double);

TRUNCATE TABLE wrk_global.v_order_fac_tmp_e;

insert into wrk_global.v_order_fac_tmp_e
SELECT 
 PS.PARTY_SITE_ID
,hca.CUST_ACCOUNT_ID
,HCASA.SITE_USE_ID
FROM erp_pgbari_sz.hz_cust_accounts_ar HCA
,(
    SELECT 
     CSUA.SITE_USE_ID
    ,CASA.CUST_ACCOUNT_ID
    ,CASA.PARTY_SITE_ID
    ,CASA.ORG_ID
    FROM erp_pgbari_sz.hz_cust_acct_sites_all_ar CASA
    INNER JOIN erp_pgbari_sz.hz_cust_site_uses_all_ar CSUA 
    ON CASA.CUST_ACCT_SITE_ID = CSUA.CUST_ACCT_SITE_ID 
    AND CASA.ORG_ID = CSUA.ORG_ID                
         GROUP BY 1,2,3,4
  )      HCASA   
,erp_pgbari_sz.HZ_PARTIES_AR HPB
,erp_pgbari_sz.HZ_PARTIES_AR HPR
,erp_pgbari_sz.HZ_PARTIES_AR HPN
, erp_pgbari_sz.HZ_PARTY_SITES_AR PS
, wrk_global.organization_id_CBC org_cbc
WHERE HCA.PARTY_ID = HPB.PARTY_ID
 AND HCA.PARTY_ID = HPR.PARTY_ID
 AND HCA.PARTY_ID = HPN.PARTY_ID
 AND HCA.PARTY_ID = PS.PARTY_ID
 AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID
 --AND HCASA.ORG_ID IN (SELECT ORGANIZATION_ID FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR WHERE NAME LIKE 'CBC%' AND LOCATION_ID IS NOT NULL GROUP BY 1)
AND HCASA.ORG_ID = org_cbc.ORGANIZATION_ID 
GROUP BY 1,2,3;

-------------***********************---------------

create table if not exists wrk_global.v_order_fac_tmp_f(
PARTY_SITE_ID double,
CUST_ACCOUNT_ID double,
SITE_USE_ID double);

TRUNCATE TABLE wrk_global.v_order_fac_tmp_f;

insert into wrk_global.v_order_fac_tmp_f
SELECT 
 PS.PARTY_SITE_ID
,hca.CUST_ACCOUNT_ID
,HCASA.SITE_USE_ID
FROM erp_pgbari_sz.HZ_CUST_ACCOUNTS_AR HCA
,(
    SELECT 
     CSUA.SITE_USE_ID
    ,CASA.CUST_ACCOUNT_ID
    ,CASA.PARTY_SITE_ID
    ,CASA.ORG_ID
    FROM erp_pgbari_sz.HZ_CUST_ACCT_SITES_ALL_AR CASA
    INNER JOIN erp_pgbari_sz.HZ_CUST_SITE_USES_ALL_AR CSUA 
    ON CASA.CUST_ACCT_SITE_ID = CSUA.CUST_ACCT_SITE_ID 
    AND CASA.ORG_ID = CSUA.ORG_ID                
    GROUP BY 1,2,3,4
  ) HCASA   
,erp_pgbari_sz.HZ_PARTIES_AR HPB
,erp_pgbari_sz.HZ_PARTIES_AR HPR
,erp_pgbari_sz.HZ_PARTIES_AR HPN
, erp_pgbari_sz.HZ_PARTY_SITES_AR PS
, wrk_global.organization_id_CBC org_cbc
WHERE HCA.PARTY_ID = HPB.PARTY_ID
 AND HCA.PARTY_ID = HPR.PARTY_ID
 AND HCA.PARTY_ID = HPN.PARTY_ID
 AND HCA.PARTY_ID = PS.PARTY_ID
 AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID
/* AND HCASA.ORG_ID IN (SELECT ORGANIZATION_ID 
                      FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR 
                      WHERE NAME LIKE 'CBC%' 
                      AND LOCATION_ID IS NOT NULL GROUP BY 1)*/
 AND HCASA.ORG_ID = org_cbc.ORGANIZATION_ID 
GROUP BY 1,2,3;

-------------***********************---------------

create table if not exists wrk_global.v_order_fac_tmp_g(
FROM_CURRENCY string,
TO_CURRENCY string,
CONVERSION_DATE string,
CONVERSION_RATE double);

TRUNCATE TABLE wrk_global.v_order_fac_tmp_g;

insert into wrk_global.v_order_fac_tmp_g
SELECT FROM_CURRENCY, TO_CURRENCY, CONVERSION_DATE, CONVERSION_RATE 
FROM erp_pgbari_sz.GL_DAILY_RATES_GL
WHERE FROM_CURRENCY = 'USD'
AND TO_CURRENCY = 'CAD'
GROUP BY 1,2,3,4;

-------------***********************---------------

create table if not exists wrk_global.v_order_fac_tmp_h (
FROM_CURRENCY string,
TO_CURRENCY string,
CONVERSION_DATE string,
CONVERSION_RATE double);

TRUNCATE TABLE wrk_global.v_order_fac_tmp_h;

insert into wrk_global.v_order_fac_tmp_h
SELECT G.FROM_CURRENCY, G.TO_CURRENCY, G.CONVERSION_DATE, G.CONVERSION_RATE 
FROM erp_pgbari_sz.GL_DAILY_RATES_GL G
INNER JOIN 
 ( SELECT FROM_CURRENCY, TO_CURRENCY, MAX(CONVERSION_DATE) AS CONVERSION_DATE 
      FROM erp_pgbari_sz.GL_DAILY_RATES_GL
      WHERE FROM_CURRENCY = 'USD'
      AND TO_CURRENCY = 'CAD'
      GROUP BY 1,2
 ) M ON G.FROM_CURRENCY=M.FROM_CURRENCY 
 AND G.TO_CURRENCY=M.TO_CURRENCY 
 AND G.CONVERSION_DATE = M.CONVERSION_DATE
WHERE G.FROM_CURRENCY = 'USD'
AND G.TO_CURRENCY = 'CAD'
GROUP BY 1,2,3,4;

-------------***********************---------------


CREATE VIEW if not exists wrk_global.V_ORDER_FAC
AS
SELECT 
      fin.PRODUCT_ID AS PRODUCT_ID                    
     ,CUST.PARTY_SITE_ID AS CUSTOMER_ID                   
     ,fin.COMPANY_ID AS COMPANY_ID                    
     ,BILL.ATTRIBUTE11 AS CHANNEL_ID                    
     ,fin.AN_ID AS AN_ID                         
     ,fin.CN_ID AS CN_ID                         
     ,fin.AL_ID AS AL_ID                         
     ,fin.CC_ID AS CC_ID                         
     ,fin.PLANT_ID AS PLANT_ID                      
     ,fin.BILL_DATE AS BILL_DATE                     
     ,BILL.PARTY_SITE_ID AS BILL_TO                       
     ,SHIP.PARTY_SITE_ID AS SHIP_TO                       
     ,SOLD.PARTY_SITE_ID AS SOLD_TO                       
     ,fin.TRANSACTION_NUMBER AS TRANSACTION_NUMBER            
     ,fin.ACCOUNT_NUMBER AS ACCOUNT_NUMBER                
     ,fin.DOC_NUMBER AS DOC_NUMBER                    
     ,fin.BILL_NUMBER AS BILL_NUMBER                   
     ,fin.BILL_TYPE AS BILL_TYPE                     
     ,fin.PIECES_SOLD2 AS PIECES_SOLD                   
     ,COALESCE(CASE WHEN fin.INVOICE_CURRENCY_CODE = 'USD' 
      THEN G.CONVERSION_RATE * fin.AMOUNT_SOLD2 
      ELSE fin.AMOUNT_SOLD2 END, 
      CASE WHEN fin.INVOICE_CURRENCY_CODE = 'USD' 
      THEN M.CONVERSION_RATE * fin.AMOUNT_SOLD2 
      ELSE fin.AMOUNT_SOLD2 END) AS AMOUNT_SOLD                   
     ,fin.PIECES_RETURNED AS PIECES_RETURNED               
     ,COALESCE(CASE WHEN fin.INVOICE_CURRENCY_CODE = 'USD' THEN G.CONVERSION_RATE * fin.AMOUNT_RETURNED ELSE fin.AMOUNT_RETURNED END, CASE WHEN fin.INVOICE_CURRENCY_CODE = 'USD' THEN M.CONVERSION_RATE * fin.AMOUNT_RETURNED ELSE fin.AMOUNT_RETURNED END) AS AMOUNT_RETURNED                   
     ,fin.UNIT_SOLD AS UNIT_SOLD                     
     ,COALESCE(CASE WHEN fin.INVOICE_CURRENCY_CODE = 'USD' THEN G.TO_CURRENCY ELSE fin.INVOICE_CURRENCY_CODE END, CASE WHEN fin.INVOICE_CURRENCY_CODE = 'USD' THEN M.TO_CURRENCY ELSE fin.INVOICE_CURRENCY_CODE END) AS INVOICE_CURRENCY_CODE
     ,fin.PRICING_QUANTITY_UOM AS PRICING_QUANTITY_UOM
     ,fin.order_type
FROM
     (
SELECT
           ORDERED_ITEM AS PRODUCT_ID
          ,SOLD_TO_CUSTOMER_ID AS CUSTOMER_ID
          ,COALESCE(A.SEGMENT1,'') AS COMPANY_ID
          ,ATTRIBUTE11 AS CHANNEL_ID                  
          ,COALESCE(A.SEGMENT2,'') AS AN_ID
          ,COALESCE(A.SEGMENT3,'') AS CN_ID
          ,COALESCE(A.SEGMENT4,'') AS AL_ID
          ,COALESCE(A.SEGMENT5,'') AS CC_ID
          ,FABRICAOM_ID AS PLANT_ID          
          ,TRX_DATE AS BILL_DATE
          ,BILL_TO_CUSTOMER_ID AS BILL_TO
          ,SHIP_TO_CUSTOMER_ID AS SHIP_TO
          ,a.SOLD_TO_CUSTOMER_ID AS SOLD_TO
          ,a.BILL_TO_SITE_USE_ID AS BILL_TO_SITE_USE_ID                         
          ,a.SHIP_TO_SITE_USE_ID AS SHIP_TO_SITE_USE_ID
          ,a.SHIP_TO_SITE_USE_ID AS SOLD_TO_SITE_USE_ID
          ,INTERFACE_LINE_ATTRIBUTE6 AS TRANSACTION_NUMBER
          ,CUENTA AS ACCOUNT_NUMBER
          ,ORDER_NUMBER AS DOC_NUMBER
          ,TRX_NUMBER AS BILL_NUMBER
          ,LINE_CATEGORY_CODE AS BILL_TYPE
          ,INVOICE_CURRENCY_CODE AS INVOICE_CURRENCY_CODE
          ,b.LOCATION_ID
          ,a.LOCATION_ID AS loc2
          ,b.PRICING_QUANTITY_UOM AS PRICING_QUANTITY_UOM          
          ,tipocambio
          ,a.order_type
           ,CASE
                    WHEN b.line_category_code <> 'RETURN' AND A.QUANTITY_INVOICED <> 0 THEN A.QUANTITY_INVOICED
                    WHEN b.line_category_code <> 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM = 'CS' THEN A.QUANTITY_INVOICED
                    WHEN b.line_category_code <> 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM <> 'CS' THEN A.QUANTITY_INVOICED * (COALESCE(B.CONVERSION_RATE,1))
                    WHEN b.line_category_code = 'RETURN' AND A.QUANTITY_INVOICED <> 0 THEN A.QUANTITY_INVOICED *(-1)
                    WHEN b.line_category_code = 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM = 'CS' THEN A.QUANTITY_INVOICED *(-1)
                    WHEN b.line_category_code = 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM <> 'CS' THEN A.QUANTITY_INVOICED * (COALESCE(B.CONVERSION_RATE,1))*(-1)
            END as ventapiezas2
           ,CASE
                    WHEN b.line_category_code = 'RETURN' THEN (-1)* a.QUANTITY_INVOICED * a.unit_selling_price
                    ELSE a.QUANTITY_INVOICED * a.unit_selling_price
             END OM_monto_selling2
          ,CASE WHEN VENTAPIEZAS IS NULL THEN 0
                WHEN XPERCENT = -100 THEN (-1)* VENTAPIEZAS
                ELSE VENTAPIEZAS                                        
            END AS PIECES_SOLD                                             
          ,CASE WHEN CASE WHEN b.line_category_code <> 'RETURN' AND A.QUANTITY_INVOICED <> 0 THEN A.QUANTITY_INVOICED 
                WHEN b.line_category_code <> 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM = 'CS' THEN A.QUANTITY_INVOICED 
                WHEN b.line_category_code <> 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM <> 'CS' THEN A.QUANTITY_INVOICED * (COALESCE(B.CONVERSION_RATE,1)) 
                WHEN b.line_category_code = 'RETURN' AND A.QUANTITY_INVOICED <> 0 THEN A.QUANTITY_INVOICED *(-1) WHEN b.line_category_code = 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM = 'CS' THEN A.QUANTITY_INVOICED *(-1) 
                WHEN b.line_category_code = 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM <> 'CS' THEN A.QUANTITY_INVOICED * (COALESCE(B.CONVERSION_RATE,1))*(-1) END IS NULL THEN 0
                WHEN XPERCENT = -100 THEN (-1)* CASE WHEN b.line_category_code <> 'RETURN' AND A.QUANTITY_INVOICED <> 0 THEN A.QUANTITY_INVOICED 
                WHEN b.line_category_code <> 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM = 'CS' THEN A.QUANTITY_INVOICED 
                WHEN b.line_category_code <> 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM <> 'CS' THEN A.QUANTITY_INVOICED * (COALESCE(B.CONVERSION_RATE,1)) 
                WHEN b.line_category_code = 'RETURN' AND A.QUANTITY_INVOICED <> 0 THEN A.QUANTITY_INVOICED *(-1) 
                WHEN b.line_category_code = 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM = 'CS' THEN A.QUANTITY_INVOICED *(-1) 
                WHEN b.line_category_code = 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM <> 'CS' THEN A.QUANTITY_INVOICED * (COALESCE(B.CONVERSION_RATE,1))*(-1) END
                ELSE CASE WHEN b.line_category_code <> 'RETURN' AND A.QUANTITY_INVOICED <> 0 THEN A.QUANTITY_INVOICED WHEN b.line_category_code <> 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM = 'CS' THEN A.QUANTITY_INVOICED 
                WHEN b.line_category_code <> 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM <> 'CS' THEN A.QUANTITY_INVOICED * (COALESCE(B.CONVERSION_RATE,1)) 
                WHEN b.line_category_code = 'RETURN' AND A.QUANTITY_INVOICED <> 0 THEN A.QUANTITY_INVOICED *(-1) 
                WHEN b.line_category_code = 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM = 'CS' THEN A.QUANTITY_INVOICED *(-1) 
                WHEN b.line_category_code = 'RETURN' AND (A.QUANTITY_INVOICED = 0 OR A.QUANTITY_INVOICED IS NULL) AND b.PRICING_QUANTITY_UOM <> 'CS' THEN A.QUANTITY_INVOICED * (COALESCE(B.CONVERSION_RATE,1))*(-1) END                                        
            END AS PIECES_SOLD2 
          ,CASE WHEN OM_MONTO_SELLING IS NULL THEN 0
                WHEN XPERCENT = -100 THEN (-1)* OM_MONTO_SELLING
                ELSE OM_MONTO_SELLING                                   
            END AS AMOUNT_SOLD                                                
          ,CASE WHEN CASE WHEN b.line_category_code = 'RETURN' THEN (-1)* a.QUANTITY_INVOICED * a.unit_selling_price ELSE a.QUANTITY_INVOICED * a.unit_selling_price END IS NULL THEN 0
                WHEN XPERCENT = -100 THEN (-1)* CASE WHEN b.line_category_code = 'RETURN' THEN (-1)* a.QUANTITY_INVOICED * a.unit_selling_price ELSE a.QUANTITY_INVOICED * a.unit_selling_price END
                ELSE CASE WHEN b.line_category_code = 'RETURN' THEN (-1)* a.QUANTITY_INVOICED * a.unit_selling_price ELSE a.QUANTITY_INVOICED * a.unit_selling_price END                                   
            END AS AMOUNT_SOLD2                                                
         ,ventapiezasDEV AS PIECES_RETURNED
          ,CASE WHEN OM_MONTO_SELLING > 0 THEN 0 ELSE OM_MONTO_SELLING END AS AMOUNT_RETURNED
          ,PRICING_QUANTITY_UOM AS UNIT_SOLD
FROM wrk_global.v_order_fac_tmp_a a
LEFT JOIN wrk_global.v_order_fac_tmp_b b 
    ON ( TRIM(CAST(a.sales_order AS VARCHAR(100)))= TRIM(CAST(b.order_number AS VARCHAR(100))) 
               AND TRIM(CAST(a.interface_line_attribute6 AS VARCHAR(100))) = TRIM(CAST(b.line_id AS VARCHAR(100))) )
    WHERE cuenta IS NOT NULL
    AND FabricaOM_id IS NOT NULL
     ) fin
INNER JOIN wrk_global.v_order_fac_tmp_c bill 
     ON fin.BILL_TO = bill.CUST_ACCOUNT_ID 
     AND fin.BILL_TO_SITE_USE_ID = bill.SITE_USE_ID
LEFT JOIN wrk_global.v_order_fac_tmp_d SHIP 
     ON fin.SHIP_TO = SHIP.CUST_ACCOUNT_ID 
     AND FIN.SHIP_TO_SITE_USE_ID = SHIP.SITE_USE_ID
LEFT JOIN wrk_global.v_order_fac_tmp_e SOLD 
     ON fin.SOLD_TO = SOLD.CUST_ACCOUNT_ID 
     AND FIN.SOLD_TO_SITE_USE_ID = SOLD.SITE_USE_ID
LEFT JOIN wrk_global.v_order_fac_tmp_f CUST 
     ON fin.CUSTOMER_ID = CUST.CUST_ACCOUNT_ID 
     AND FIN.SHIP_TO_SITE_USE_ID = CUST.SITE_USE_ID
LEFT JOIN wrk_global.v_order_fac_tmp_g G 
     ON fin.INVOICE_CURRENCY_CODE = G.FROM_CURRENCY 
     AND fin.BILL_DATE = G.CONVERSION_DATE          
LEFT JOIN wrk_global.v_order_fac_tmp_h M 
     ON fin.INVOICE_CURRENCY_CODE = M.FROM_CURRENCY;


invalidate metadata;
