

CREATE TABLE IF NOT EXISTS wrk_global.T_ORDER_FINAL_PASO_DSD_1
     (
      Product_ID STRING,
      Company_ID STRING,
      Channel_ID STRING,
      Channel_Name STRING,
      Province_ID STRING,
      Bill_Date STRING,
      Unit_Sold STRING,
      Week STRING,
      Fiscal_Period STRING,
      Currency STRING,
      Customer_ID STRING,
      Sales_District STRING,
      Sales_District_Name STRING,
      Plant STRING,
      Sales_Center STRING,
      Route_ID STRING,
      Ship_To STRING,
      Doc_Number STRING,
      Offer_Code STRING,
      Bill_Num STRING,
      Bill_Type STRING,
      Franchisee_Revenue_ID INT,
      Commision_Group_ID INT,
      TSM_ID INT,
      TSM_Name STRING,
      RSM_ID INT,
      RSM_Name STRING,
      Depot_ID INT,
      Depot_Name STRING,
      IO_Name STRING,
      Invoice_Type STRING,
      Conversion_Rate DECIMAL(19,4),
      Price DECIMAL(19,4),
      Net_Invoice_Price DECIMAL(19,4),
      Perc DECIMAL(19,4),
      --Discount DECIMAL(19,4),
      Net_Invoice_Qty DECIMAL(19,4),
      Net_Invoice_Qty_EA DECIMAL(19,4),
      Gross_Sales DECIMAL(19,4),
      Gross_Sales_EA DECIMAL(19,4),
      Return_Invoice_Qty DECIMAL(19,4),
      Return_Invoice_Qty_EA DECIMAL(19,4),
      Total_Returns DECIMAL(19,4),
      Total_Returns_EA DECIMAL(19,4),
      Ingredients DECIMAL(19,4),
      Packaging DECIMAL(19,4),
      Direct_Labour DECIMAL(19,4),
      Overhead DECIMAL(19,4),
      Total_Storage DECIMAL(19,4),
      Total_Freight DECIMAL(19,4),
      Bill_Back_Accrual DECIMAL(19,4),
      Co_op_Allowances_Accrual DECIMAL(19,4),
      Exclusivity_Allowance_Accrual DECIMAL(19,4),
      Growth_Incentives_Accrual DECIMAL(19,4),
      Merchandising_Accrual DECIMAL(19,4),
      Rebates_Accrual DECIMAL(19,4),
      Rebates_Lumpsum DECIMAL(19,4),
      Total_Off_Invoice DECIMAL(19,4),
      Total_Off_Invoice_EA DECIMAL(19,4),
      Uncon_And_Relationship_Accrual DECIMAL(19,4),
      Listing_Fees_Accrual DECIMAL(19,4),
      Bill_Back_Lumpsum DECIMAL(19,4),
      Co_op_Allowances_Lumpsum DECIMAL(19,4),
      Exclusivity_Allowance_Lumpsum DECIMAL(19,4),
      Growth_Incentives_Lumpsum DECIMAL(19,4),
      Merchandising_Lumpsum DECIMAL(19,4),
      Listing_Fees_Lumpsum DECIMAL(19,4),
      Uncon_And_Relationship_Lumpsum DECIMAL(19,4),
      Trade_Investments DECIMAL(19,4),
      Total_Deductions DECIMAL(19,4),
      Co_op_Allowances DECIMAL(19,4),
      Rebates DECIMAL(19,4),
      Buying_Group_VIP_Accrual DECIMAL(19,4),
      Buying_Group_VIP_Lumpsum DECIMAL(19,4),
      TMA_Event DECIMAL(19,4),
      Total_Sales DECIMAL(19,4),
      Total_Sales_EA DECIMAL(19,4),
      Other_Discounts DECIMAL(19,4),
      TMA_Term DECIMAL(19,4),
      Total_Trade DECIMAL(19,4),
      Cost_of_Goods_Sold DECIMAL(19,4),
      Net_Sales DECIMAL(19,4),
      Cost_of_Sales DECIMAL(19,4),
      Gross_Profit_Standard DECIMAL(19,4),
      Gross_Contribution DECIMAL(19,4),
      Gross_Invoice_Qty DECIMAL(19,4),
      Gross_Invoice_Qty_EA DECIMAL(19,4),
      Kilos DECIMAL(19,4),
      Franchisee_Revenue DECIMAL(19,4),
      Def STRING);


----------*****************************************************----------
create table if not exists wrk_global.order_final_cross_Clas_Dev(
codigo_agencia int, 
codigo_ruta string, 
codigo_producto int, 
fecha string, 
id_tipo int, 
cantidad bigint, 
CLICOD string, 
no_factura int)
STORED AS PARQUET ;

truncate table wrk_global.order_final_cross_Clas_Dev;

insert into wrk_global.order_final_cross_Clas_Dev
SELECT codigo_agencia, codigo_ruta, codigo_producto, fecha, id_tipo, SUM(cantidad) AS cantidad , CLICOD, no_factura
FROM (
SELECT codigo_agencia, codigo_ruta, codigo_producto, fecha, id_tipo, id_ajuste, cantidad, CLICOD, no_factura
FROM bccan_xprs_prod.Clasificacion_Devolucion 
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9 
) a
GROUP BY 1, 2, 3, 4, 5, 7, 8;

----------*****************************************************----------



CREATE TABLE IF NOT EXISTS  wrk_global.tmp_t_order_final_1(
segment1 STRING,
unit_of_measure STRING,
uom_code STRING, 
conversion_rate DOUBLE)
STORED AS PARQUET ;

truncate table wrk_global.tmp_t_order_final_1;

INSERT INTO wrk_global.tmp_t_order_final_1
SELECT 
 S.SEGMENT1
,C.UNIT_OF_MEASURE
,C.UOM_CODE
,C.CONVERSION_RATE
FROM erp_pgbari_sz.MTL_UOM_CONVERSIONS_INV C
INNER JOIN erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV S 
ON C.INVENTORY_ITEM_ID = S.INVENTORY_ITEM_ID
WHERE S.ORGANIZATION_ID IN
                         (
                    SELECT ORGANIZATION_ID 
                    FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR 
                    WHERE NAME LIKE ('CBC%') AND LOCATION_ID IS NOT NULL GROUP BY 1
                         )
AND UNIT_OF_MEASURE='PACK'
GROUP BY 1,2,3,4;

----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.tmp_t_order_final_2 (
cogsyear INT,
product_id_oracle STRING,
sales_center DOUBLE,
--ingredients Decimal(15,13),
ingredients DOUBLE,
packaging DOUBLE,
direct_labour DOUBLE,
overhead DOUBLE)
STORED AS PARQUET ;

truncate table  wrk_global.tmp_t_order_final_2;

insert into wrk_global.tmp_t_order_final_2 
SELECT
 CCS.COGSYear
,CCS.Product_ID_ORACLE
,CASE
     WHEN CCS.ORGANIZATION_ID = 1834 THEN 14661
     WHEN CCS.ORGANIZATION_ID = 1837 THEN 14662
     WHEN CCS.ORGANIZATION_ID = 1838 THEN 14663
     WHEN CCS.ORGANIZATION_ID = 2057 THEN 14664
     WHEN CCS.ORGANIZATION_ID = 2058 THEN 14665
     WHEN CCS.ORGANIZATION_ID = 2059 THEN 14666
     WHEN CCS.ORGANIZATION_ID = 2060 THEN 14667
 ELSE CCS.ORGANIZATION_ID  END AS Sales_Center
,MAX(cast(CCS.Ingredients as double))    AS Ingredients  -- Se toma el MAX debido a la repeticion de los datos en la tabla de COGS.
,MAX(CCS.Packaging)      AS Packaging
,MAX(CCS.Direct_Labour)  AS Direct_Labour
,MAX(CCS.Overhead)       AS Overhead
FROM (
     SELECT
          X1.ANIOBIMBO AS COGSYear
         ,X1.SEGMENT1  AS Product_ID_ORACLE
         ,X1.ORGANIZATION_ID AS ORGANIZATION_ID
         --,X1.ITEM_COST ----- 
         ,COALESCE(SUM(CASE
             WHEN  X1.TIPO_COSTO_ID = 1 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  Ingredients
         ,COALESCE(SUM(CASE
             WHEN  X1.TIPO_COSTO_ID = 2 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  Direct_Labour
         ,COALESCE(SUM(CASE
             WHEN  X1.TIPO_COSTO_ID = 3 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  Packaging
         ,COALESCE(SUM(CASE
             WHEN  X1.TIPO_COSTO_ID = 4 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  Overhead
         ,COALESCE(SUM(CASE
             WHEN  X1.TIPO_COSTO_ID = 9 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  OUTPROCESSING_STD_ERP
        -- ,(Ingredients+Direct_Labour+Packaging+Overhead+OUTPROCESSING_STD_ERP) AS TOTAL
        ,(COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 1 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)+
           COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 2 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)+
           COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 3 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)+
           COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 4 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)+
           COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 9 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)
           ) AS TOTAL
     FROM
     (
             SELECT
                  ANIOBIMBO
                  ,MAX(MESBIMBO)AS MESBIMBO
                  ,CST.INVENTORY_ITEM_ID
                  ,SEGMENT1
                  ,DESCRIPTION
                  ,CST.ORGANIZATION_ID
                  ,CASE
                       WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 1  THEN 1                                 -- MATERIALS COST STD ERP
                       WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 3  AND BOM.RESOURCE_TYPE = 2    THEN 2     -- MO STD COST ERP
                       WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 3  AND BOM.RESOURCE_TYPE = 1     THEN 3       -- DA STD COST ERP
                       WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 4  AND BOM.RESOURCE_TYPE = 4    THEN 9    -- OUTPROCESSING STD ERP
                       WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 5  THEN  4                                -- CIP STD COST ERP
                       ELSE NULL
                  END AS TIPO_COSTO_ID                 
                 ,ROUND(cast(CST.ITEM_COST as decimal(15,13)),10) AS ITEM_COST
                  -- ,CST.ITEM_COST AS ITEM_COST  ----original
             FROM Gb_mdl_canada_global_erp.cst_item_cost_details CST 
                  INNER JOIN 
                        (
                           SELECT RESOURCE_ID, RESOURCE_TYPE, MAX(LAST_UPDATE_DATE) AS LAST_UPDATE_DATE
                           FROM erp_pgbari_sz.BOM_RESOURCES_BOM 
                           GROUP BY 1,2
                        )BOM 
                      ON CST.RESOURCE_ID = BOM.RESOURCE_ID 
          INNER JOIN erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV   MAT 
                      ON CST.ORGANIZATION_ID = MAT.ORGANIZATION_ID  
                      AND CST.INVENTORY_ITEM_ID = MAT.INVENTORY_ITEM_ID 
             WHERE CST.ORGANIZATION_ID IN ( SELECT ORGANIZATION_ID 
                                           FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR 
                                           WHERE NAME LIKE ('CBC%') 
                                           AND LOCATION_ID IS NOT NULL 
                                           GROUP BY 1)
             GROUP BY 1,3,4,5,6,7,8
     ) X1
     GROUP BY 1,2,3--,4
) CCS
GROUP BY 1,2,3;

----------*****************************************************----------

-- timestamp
CREATE TABLE IF NOT EXISTS wrk_global.tmp_agy003_0 (
ag03fc STRING,    
numero STRING,    
clicod STRING,    
ag19id STRING,    
codigo_agencia INT,
codigo_ruta STRING,
no_factura INT)
STORED AS PARQUET ;

truncate table wrk_global.tmp_agy003_0;

insert into wrk_global.tmp_agy003_0
SELECT AGYB.ag03fc,    
AGYB.numero,
AGYB.clicod,
AGYB.ag19id,
AGYB.codigo_agencia,
AGYB.codigo_ruta,
AGYB.no_factura
FROM bccan_xprs_prod.agy003 AGYB
WHERE AGYB.AG03FC >= (SELECT date_sub( MAX(AG03FC),31) --- original 8 
                     FROM bccan_xprs_prod.agy003)
group by 1,2,3,4,5,6,7;  

----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.tmp_agy003 (
ag03fc STRING,                    
numero STRING,                    
clicod STRING,                    
ag19id STRING,                    
codigo_agencia INT,               
codigo_ruta STRING,               
no_factura INT)
STORED AS PARQUET ;

truncate table wrk_global.tmp_agy003;

insert into wrk_global.tmp_agy003
SELECT
AGYB.AG03FC,
AGYB.NUMERO,
AGYB.CLICOD,
AGYB.AG19ID,
AGYB.CODIGO_AGENCIA,
AGYB.CODIGO_RUTA,
AGYB.NO_FACTURA
FROM bccan_xprs_prod.agy003 AGYB
WHERE AGYB.AG03FC >= (SELECT date_sub( MAX(AG03FC),31) ----- original 8  
                  FROM bccan_xprs_prod.agy003)
AND AGYB.AG19ID IN ('IN','DN')
group by 1,2,3,4,5,6,7;


----------*****************************************************----------


CREATE TABLE IF NOT EXISTS wrk_global.tmp_agy003_2 (
ag03fc STRING,                    
numero STRING,                    
clicod STRING,                    
ag19id STRING,                    
codigo_agencia INT,               
codigo_ruta STRING,               
no_factura INT)
STORED AS PARQUET ;

truncate table wrk_global.tmp_agy003_2;

insert into wrk_global.tmp_agy003_2
SELECT
AGYB.AG03FC,
AGYB.NUMERO,
AGYB.CLICOD,
AGYB.AG19ID,
AGYB.CODIGO_AGENCIA,
AGYB.CODIGO_RUTA,
AGYB.NO_FACTURA
FROM bccan_xprs_prod.agy003 AGYB
WHERE AGYB.AG03FC >= (SELECT date_sub( MAX(AG03FC),31) -----------original 8 
                  FROM bccan_xprs_prod.agy003)
AND AGYB.AG19ID IN ('CN')
group by 1,2,3,4,5,6,7;


----------*****************************************************----------


CREATE TABLE IF NOT EXISTS wrk_global.calendar_tmp (
week STRING,
calendar_date STRING)
STORED AS PARQUET ;

truncate table wrk_global.calendar_tmp;

insert into wrk_global.calendar_tmp
SELECT 
concat(TRIM(YEAR_OF_CALENDAR)
,TRIM(CASE WHEN WEEK_OF_YEAR = '1' THEN '01' 
  WHEN WEEK_OF_YEAR = '2' THEN '02' 
  WHEN WEEK_OF_YEAR = '3' THEN '03' 
  WHEN WEEK_OF_YEAR = '4' THEN '04' 
  WHEN WEEK_OF_YEAR = '5' THEN '05' 
  WHEN WEEK_OF_YEAR = '6' THEN '06' 
  WHEN WEEK_OF_YEAR = '7' THEN '07' 
  WHEN WEEK_OF_YEAR = '8' THEN '08' 
  WHEN WEEK_OF_YEAR = '9' THEN '09' 
  ELSE WEEK_OF_YEAR END)) AS WEEK
       ,CALENDAR_DATE AS CALENDAR_DATE 
  FROM CP_SYS_CALENDAR.CALENDAR ;

----------*****************************************************----------
-- timestamp 
CREATE TABLE IF NOT EXISTS wrk_global.categoriaproductos_tmp ( 
categoriaid INT,
codigo_producto INT)
PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.categoriaproductos_tmp;

insert into wrk_global.categoriaproductos_tmp PARTITION(CODIGO_AGENCIA)
select 
categoriaid,
codigo_producto,
CAST(substring(agency, 6, 10) AS INT)
FROM bccan_xprs_prod.CATEGORIAPRODUCTOS
GROUP BY 1,2,3;


----------*****************************************************---------- 
-- timestamp
CREATE TABLE IF NOT EXISTS wrk_global.clienteingresodevolucion_tmp (
  clicod STRING,
  codigo_ruta STRING,
  ingresoid INT,
  devolucionid INT
) PARTITIONED BY ( codigo_agencia INT );

truncate table wrk_global.clienteingresodevolucion_tmp;

insert into wrk_global.clienteingresodevolucion_tmp partition (codigo_agencia)
select 
clicod,
codigo_ruta,
ingresoid,
devolucionid,
CAST(substring(agency, 6, 10) AS INT)
from bccan_xprs_prod.clienteingresodevolucion
group by 1,2,3,4,5;

----------*****************************************************---------- 
-- timestamp
CREATE TABLE IF NOT EXISTS wrk_global.ingresos_tmp (
 ingresoid INT,
 descripcion STRING,
 tablenumber STRING)
PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.ingresos_tmp;

insert into wrk_global.ingresos_tmp partition (CODIGO_AGENCIA)
select ingresoid,
 descripcion,
 tablenumber,
 CAST(substring(agency, 6, 10) AS INT)
 from bccan_xprs_prod.ingresos
 GROUP BY 1,2,3,4;

----------*****************************************************----------
-- timestamp, se tiene que hay duplicados en DEV en bccan_xprs_prod.ruta, para quitarlos se agrupa en la nueva tabla wrk_global.ruta_tmp  se reduce, pero no queda como en la fuenta 
--porque en la bccan_xprs_prod.ruta para el campo AG13ID hay registros que tienen valor y otros nulo(esto no pasa en la fuente), para hacer la compactacion
--tendria que evitar comparar por ese campo y me seguiria dando el valor , considero que lo que hay que hacer , es extraer de nuevo y ya uqede limpia bccan_xprs_prod.ruta, 
--para avanzar agrupare de nuevo evitando el campo AG13ID, regresar ( qry comentadO) cuando ya quede limpia la tabla de ruta

CREATE TABLE IF NOT EXISTS wrk_global.ruta_tmp (
 CODIGO_SUPERVISOR INT,
 AG13ID STRING,
 CODIGO_RUTA STRING,
 CODIGO_VENDEDOR INT)
PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.ruta_tmp;

insert into wrk_global.ruta_tmp partition (CODIGO_AGENCIA)
select 
CODIGO_SUPERVISOR,
AG13ID,
CODIGO_RUTA,
CODIGO_VENDEDOR,
CODIGO_AGENCIA
from bccan_xprs_prod.ruta
WHERE AG13ID is not null  ----------QUITAR CUANDO SE VUELVA A INGRESAR LA INFO  Y QUEDE COMO LA FUENTE
group by 1,2,3,4,5;


----------*****************************************************----------
-- timestamp
CREATE TABLE IF NOT EXISTS wrk_global.agm013_tmp (
 AG13DS STRING,
 AG13ID INT)
PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.agm013_tmp;

insert into wrk_global.agm013_tmp partition (CODIGO_AGENCIA)
select 
AG13DS,
AG13ID,
CODIGO_AGENCIA
from bccan_xprs_prod.agm013
group by 1,2,3;

----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.agy004_tmp (
CODIGO_PRODUCTO INT,
NO_FACTURA INT,
PRECIO DOUBLE,
PROMOCION DOUBLE,
FACDET DOUBLE,
CANTIDAD INT,
DIF_PRECIO DOUBLE,
FACDSL DOUBLE,
CODIGO_RUTA STRING,
AG03FC STRING,
DESCUENTO DOUBLE)
PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.agy004_tmp;

insert into wrk_global.agy004_tmp partition (CODIGO_AGENCIA)
select 
CODIGO_PRODUCTO,
NO_FACTURA,
PRECIO,
PROMOCION,
FACDET,
CANTIDAD,
DIF_PRECIO,
FACDSL,
CODIGO_RUTA,
AG03FC,
DESCUENTO,
CODIGO_AGENCIA
 from bccan_xprs_prod.agy004
 GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12;


----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.ingresocategorias_tmp (
ingresoid INT, 
categoriaid INT,
porcentaje DOUBLE ) 
PARTITIONED BY ( CODIGO_AGENCIA int);

truncate table wrk_global.ingresocategorias_tmp;

insert into wrk_global.ingresocategorias_tmp partition (CODIGO_AGENCIA)
select ingresoid,
 categoriaid,
 porcentaje,
 CAST(substring(agency, 6, 10) AS INT)
from bccan_xprs_prod.INGRESOCATEGORIAS 
group by 1,2,3,4;

----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.agm001_TMP(
AG3COD INT,
CLICOD STRING,
AG1CO1 INT,
ag1est STRING
) PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.agm001_TMP;

INSERT INTO wrk_global.agm001_TMP partition(CODIGO_AGENCIA)
SELECT AGM001.AG3COD,
AGM001.CLICOD,
AGM001.AG1CO1,
AGM001.ag1est,
CAST(substring(AGM001.agency, 6, 10) AS INT)
FROM bccan_xprs_prod.agm001 AGM001 
GROUP BY 1,2,3,4,5;

----------*****************************************************----------

create table IF NOT EXISTS wrk_global.agp001_TMP(
AG1CO1 INT,
AG1DE1 STRING
) partitioned by (CODIGO_AGENCIA INT);

truncate table wrk_global.agp001_TMP;

insert into wrk_global.agp001_TMP partition (CODIGO_AGENCIA)
select 
AGP001.AG1CO1,
AGP001.AG1DE1,
 CAST(substring(AGP001.agency, 6, 10) AS INT)
from bccan_xprs_prod.agp001 AGP001 
group by 1,2,3;

----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.vendedor_tmp (
  codigo_vendedor INT, 
  nombre_vendedor STRING,              
  apell_pat_vend STRING,               
  apell_mat_vend STRING,               
  es_supervisor BOOLEAN,               
  inactivo BOOLEAN
) PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.vendedor_tmp;

insert into wrk_global.vendedor_tmp PARTITION(CODIGO_AGENCIA)
SELECT 
codigo_vendedor,
  nombre_vendedor, 
  apell_pat_vend,
  apell_mat_vend,
  es_supervisor,
  inactivo,
  CAST(substring(agency, 6, 10) AS INT)
 FROM bccan_xprs_prod.vendedor
 GROUP BY 1,2,3,4,5,6,7;

----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.supervisor_tmp (
codigo_supervisor INT,    
  codigo_vendedor INT,   
  apellido_pat STRING,   
  apellido_mat STRING,   
  nombre STRING
) PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.supervisor_tmp;

insert into wrk_global.supervisor_tmp PARTITION(CODIGO_AGENCIA)
select
codigo_supervisor,
  codigo_vendedor,
  apellido_pat,
  apellido_mat,
  nombre,
  CAST(substring(agency, 6, 10) AS INT)
 FROM bccan_xprs_prod.supervisor
 GROUP BY 1,2,3,4,5,6;

----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.divisional_tmp (
  codigo_divisional INT, 
  descrip_divisional STRING
) PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.divisional_tmp;

insert into wrk_global.divisional_tmp PARTITION(CODIGO_AGENCIA)
SELECT 
  codigo_divisional, 
  descrip_divisional,
  CAST(substring(agency, 6, 10) AS INT)
  FROM bccan_xprs_prod.divisional 
  GROUP BY 1,2,3;

----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.env_configuracionenvio_tmp (
  jerarquiaid BIGINT,
  horamaxima STRING, 
  horaminima STRING, 
  envioautomatico BOOLEAN,           
  texto1 STRING,     
  pedidosolitarias BOOLEAN,          
  pedidodistribuidores BOOLEAN,      
  enviarajusteundia BOOLEAN,         
  estatusservicio INT,               
  bmusuario STRING,  
  bmfechamod STRING, 
  intefasesabiertas BOOLEAN,         
  puestoexp STRING,  
  interfacesabiertas BOOLEAN         
) PARTITIONED BY (CODIGO_AGENCIA INT);

truncate table wrk_global.env_configuracionenvio_tmp;

insert into wrk_global.env_configuracionenvio_tmp PARTITION(CODIGO_AGENCIA)
SELECT jerarquiaid,
  horamaxima,
  horaminima,
  envioautomatico,
  texto1,
  pedidosolitarias,
  pedidodistribuidores,
  enviarajusteundia,
  estatusservicio,
  bmusuario,
  bmfechamod,
  intefasesabiertas,
  puestoexp,  
  interfacesabiertas,
CAST(substring(agency, 6, 10) AS INT)
FROM bccan_xprs_prod.env_configuracionenvio
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15;

----------*****************************************************----------

create table IF NOT EXISTS wrk_global.operations_0 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
promocion2 double,
descuento2 double,
div1 DECIMAL(19,8),
div2 DECIMAL(19,8))
stored as parquet;

truncate table wrk_global.operations_0;

insert into wrk_global.operations_0
select AGYB.CODIGO_AGENCIA,AGYB.CODIGO_RUTA,AGYB.NO_FACTURA,AGYB.AG03FC,AGYA.codigo_producto,trim(AGYB.CLICOD) as CLICOD
,((AGYA.PROMOCION * CDE.CANTIDAD)/AGYA.CANTIDAD) AS PROMOCION2
,((AGYA.DESCUENTO * CDE.CANTIDAD)/AGYA.CANTIDAD) AS DESCUENTO2
,CAST(CAST((CAST( (((AGYA.PROMOCION * CDE.CANTIDAD)/AGYA.CANTIDAD)) AS DECIMAL(19,8))/ CAST(CDE.CANTIDAD AS DECIMAL(19,8))) AS VARCHAR(100)) AS DECIMAL(19,8)) AS Div1
,CAST(CAST((CAST( (((AGYA.DESCUENTO * CDE.CANTIDAD)/AGYA.CANTIDAD)) AS DECIMAL(19,8))/ CAST(CDE.CANTIDAD AS DECIMAL(19,8))) AS VARCHAR(100)) AS DECIMAL(19,8)) AS Div2
FROM  wrk_global.tmp_agy003_2 AGYB
INNER JOIN bccan_xprs_prod.agy004 AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
group by 1,2,3,4,5,6,7,8,9,10;
        

----------*****************************************************----------

create table IF NOT EXISTS wrk_global.operations_1 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
promocion2 double,
descuento2 double,
Div14d DECIMAL(19,4),
Div24d DECIMAL(19,4))
stored as parquet;

truncate table wrk_global.operations_1;


insert into wrk_global.operations_1
select oper_0.CODIGO_AGENCIA,
oper_0.CODIGO_RUTA, 
oper_0.NO_FACTURA,
oper_0.AG03FC,
oper_0.codigo_producto,
oper_0.CLICOD,
oper_0.promocion2,
oper_0.descuento2,
CAST(CAST(SUBSTRING(cast(Div1 as string),1,find_in_set('.',cast(Div1 as string)) + 5) AS CHAR(5))AS DECIMAL(19,4)) Div14d,
CAST(CAST(SUBSTRING(cast(Div2 as string),1,find_in_set('.',cast(Div2 as string)) + 5) AS CHAR(5))AS DECIMAL(19,4)) Div24d
FROM   wrk_global.operations_0 oper_0;

----------*****************************************************----------

create table IF NOT EXISTS wrk_global.operations_2 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
Part1C  DECIMAL(19,3))
stored as parquet;

truncate table wrk_global.operations_2;

insert into wrk_global.operations_2
select AGYB.CODIGO_AGENCIA,AGYB.CODIGO_RUTA,AGYB.NO_FACTURA,AGYB.AG03FC,AGYA.codigo_producto,trim(AGYB.CLICOD) as CLICOD,
CAST((CDE.CANTIDAD * (AGYA.PRECIO - (oper_1.Div14d) - (oper_1.Div24d))) AS DECIMAL(19,3)) AS Part1C
FROM  wrk_global.tmp_agy003_2 AGYB
INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
LEFT OUTER JOIN wrk_global.operations_1 oper_1
        ON AGYB.CODIGO_AGENCIA=oper_1.CODIGO_AGENCIA
        AND AGYB.CODIGO_RUTA = oper_1.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_1.NO_FACTURA 
        AND substring(AGYB.AG03FC,1,10) = substring(oper_1.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_1.codigo_producto
        AND trim(AGYB.CLICOD) = oper_1.CLICOD 
group by 1,2,3,4,5,6,7;

----------*****************************************************----------

create table IF NOT EXISTS wrk_global.operations_3 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
Part1C2  DECIMAL(19,2))
stored as parquet;

truncate table wrk_global.operations_3;

insert into wrk_global.operations_3
select AGYB.CODIGO_AGENCIA,AGYB.CODIGO_RUTA,AGYB.NO_FACTURA,AGYB.AG03FC,AGYA.codigo_producto,trim(AGYB.CLICOD) as CLICOD,
CAST(CASE 
      WHEN TRIM(CAST(oper_2.Part1C AS VARCHAR(100))) LIKE '%5' AND TRIM(CAST(oper_2.Part1C AS VARCHAR(100))) NOT LIKE '-%' THEN CAST(TRIM(CAST(oper_2.Part1C AS VARCHAR(100))) AS DECIMAL(19,3) ) + .001
      WHEN TRIM(CAST(oper_2.Part1C AS VARCHAR(100))) LIKE '%5' AND TRIM(CAST(oper_2.Part1C AS VARCHAR(100))) LIKE '-%' THEN CAST(TRIM(CAST(oper_2.Part1C AS VARCHAR(100))) AS  DECIMAL(19,3) ) - .001 
      ELSE CAST(TRIM(CAST(oper_2.Part1C AS VARCHAR(100)) ) AS  DECIMAL(19,3) )
      END AS DECIMAL(19,2))AS Part1C2
FROM  wrk_global.tmp_agy003_2 AGYB
INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
LEFT OUTER JOIN wrk_global.operations_2 oper_2
        ON AGYB.CODIGO_AGENCIA=oper_2.CODIGO_AGENCIA
        AND AGYB.CODIGO_RUTA = oper_2.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_2.NO_FACTURA 
        AND substring(AGYB.AG03FC,1,10) = substring(oper_2.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_2.codigo_producto
        AND trim(AGYB.CLICOD) = oper_2.CLICOD 
group by 1,2,3,4,5,6,7;


----------*****************************************************----------


create table IF NOT EXISTS wrk_global.operations_4 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
Part2  DECIMAL(23,12),
--Franchise_RevenueFinal3 DECIMAL(19,2),
Franchise_RevenueFinal3 DECIMAL(19,3),
varc STRING,
varc2 STRING 
) stored as parquet;


truncate table wrk_global.operations_4;

insert into wrk_global.operations_4
select AGYB.CODIGO_AGENCIA,AGYB.CODIGO_RUTA,AGYB.NO_FACTURA,AGYB.AG03FC,AGYA.codigo_producto,trim(AGYB.CLICOD) as CLICOD
,(COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100) AS Part2
,CAST(CAST(oper_3.Part1C2*((COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100)) AS DECIMAL(19,3))AS DECIMAL(19,3)) AS Franchise_RevenueFinal3
,CAST(oper_3.Part1C2*((COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100)) AS VARCHAR(100)) AS varc
,SUBSTR(CAST(  CAST(oper_3.Part1C2*((COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100)) AS VARCHAR(100)) AS VARCHAR(10)), 1, find_in_set( (CAST(oper_3.Part1C2*( (COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100 ) ) AS VARCHAR(100))) , '.')+3) varc2
FROM  wrk_global.tmp_agy003_2 AGYB
INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND AGYB.AG03FC = AGYA.AG03FC
LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND AGYA.AG03FC = CDE.fecha
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
LEFT JOIN wrk_global.categoriaproductos_tmp CP 
         ON AGYA.CODIGO_AGENCIA = CP.CODIGO_AGENCIA 
         AND AGYA.CODIGO_PRODUCTO = CP.CODIGO_PRODUCTO
LEFT JOIN wrk_global.clienteingresodevolucion_tmp CC
         ON AGYA.CODIGO_AGENCIA = CC.CODIGO_AGENCIA 
         AND trim(AGYB.CLICOD) = trim(CC.CLICOD)
         AND AGYB.CODIGO_RUTA = CC.CODIGO_RUTA         
LEFT JOIN wrk_global.ingresos_tmp I 
         ON AGYA.CODIGO_AGENCIA = I.CODIGO_AGENCIA 
         AND CC.INGRESOID = I.INGRESOID         
LEFT JOIN wrk_global.ingresocategorias_tmp IC 
         ON AGYA.CODIGO_AGENCIA = IC.CODIGO_AGENCIA 
         AND CP.CATEGORIAID = IC.CATEGORIAID 
         AND I.INGRESOID = IC.INGRESOID
LEFT OUTER JOIN wrk_global.operations_3 oper_3
        ON AGYB.CODIGO_AGENCIA=oper_3.CODIGO_AGENCIA
        AND AGYB.CODIGO_RUTA = oper_3.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_3.NO_FACTURA 
        AND substring(AGYB.AG03FC,1,10) = substring(oper_3.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_3.codigo_producto
        AND trim(AGYB.CLICOD) = trim(oper_3.CLICOD)
group by 1,2,3,4,5,6,7,8,9,10;


----------*****************************************************----------

create table IF NOT EXISTS wrk_global.operations_5 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
promocion2 double,
descuento2 double,
--div1 DECIMAL(19,8),
div1 VARCHAR(100),
--div2 DECIMAL(19,8))
div2 VARCHAR(100))
stored as parquet;

truncate table wrk_global.operations_5;

insert into wrk_global.operations_5
select AGYB.CODIGO_AGENCIA,AGYB.CODIGO_RUTA,AGYB.NO_FACTURA,AGYB.AG03FC,AGYA.codigo_producto,trim(AGYB.CLICOD) as CLICOD
,((AGYA.PROMOCION * CDE.CANTIDAD)/AGYA.CANTIDAD) AS PROMOCION2
,((AGYA.DESCUENTO * CDE.CANTIDAD)/AGYA.CANTIDAD) AS DESCUENTO2
,CAST((CAST(AGYA.PROMOCION AS DECIMAL(19,8))/ CAST(AGYA.CANTIDAD AS DECIMAL(19,8))) AS VARCHAR(100)) AS Div1
--,CAST(CAST( (CAST( (((AGYA.PROMOCION * CDE.CANTIDAD)/AGYA.CANTIDAD)) AS DECIMAL(19,8))/ CAST(CDE.CANTIDAD AS DECIMAL(19,8)) ) AS VARCHAR(100)) AS DECIMAL(19,8)) AS Div1
,CAST((CAST(AGYA.DESCUENTO AS DECIMAL(19,8))/ CAST(AGYA.CANTIDAD AS DECIMAL(19,8))) AS VARCHAR(100)) AS Div2
--,CAST(CAST((CAST( (((AGYA.DESCUENTO * CDE.CANTIDAD)/AGYA.CANTIDAD)) AS DECIMAL(19,8))/ CAST(CDE.CANTIDAD AS DECIMAL(19,8))) AS VARCHAR(100)) AS DECIMAL(19,8)) AS Div2
FROM  wrk_global.tmp_agy003 AGYB
INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
        group by 1,2,3,4,5,6,7,8,9,10;

        

----------*****************************************************----------

create table IF NOT EXISTS wrk_global.operations_6 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
promocion2 double,
descuento2 double,
Div14d DECIMAL(19,4),
Div24d DECIMAL(19,4))
stored as parquet;

truncate table wrk_global.operations_6;

insert into wrk_global.operations_6
select oper_5.CODIGO_AGENCIA,
oper_5.CODIGO_RUTA, 
oper_5.NO_FACTURA,
oper_5.AG03FC,
oper_5.codigo_producto,
oper_5.CLICOD,
oper_5.promocion2,
oper_5.descuento2,
CAST(CAST(SUBSTRING(cast(oper_5.Div1 as string),1,find_in_set('.',cast(oper_5.Div1 as string)) + 5) AS CHAR(5))AS DECIMAL(19,4)) Div14d,
CAST(CAST(SUBSTRING(cast(oper_5.Div2 as string),1,find_in_set('.',cast(oper_5.Div2 as string)) + 5) AS CHAR(5))AS DECIMAL(19,4)) Div24d
FROM   wrk_global.operations_5 oper_5
group by 1,2,3,4,5,6,7,8,9,10;



----------*****************************************************----------

create table IF NOT EXISTS wrk_global.operations_7 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
Part1C  DECIMAL(19,3))
stored as parquet;

truncate table wrk_global.operations_7;

insert into wrk_global.operations_7
select AGYB.CODIGO_AGENCIA,AGYB.CODIGO_RUTA,AGYB.NO_FACTURA,AGYB.AG03FC,AGYA.codigo_producto,trim(AGYB.CLICOD) as CLICOD,
CAST((AGYA.CANTIDAD * (AGYA.PRECIO - (oper_6.Div14d) - (oper_6.Div24d))) AS DECIMAL(19,3)) AS Part1C
FROM  wrk_global.tmp_agy003 AGYB
INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
LEFT OUTER JOIN wrk_global.operations_6 oper_6
        ON AGYB.CODIGO_AGENCIA=oper_6.CODIGO_AGENCIA
        AND AGYB.CODIGO_RUTA = oper_6.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_6.NO_FACTURA 
        AND substring(AGYB.AG03FC,1,10) = substring(oper_6.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_6.codigo_producto
        AND trim(AGYB.CLICOD) = oper_6.CLICOD ;

----------*****************************************************----------

create table IF NOT EXISTS wrk_global.operations_8 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
Part1C2  DECIMAL(19,2))
stored as parquet;

truncate table wrk_global.operations_8;

insert into wrk_global.operations_8
select AGYB.CODIGO_AGENCIA,AGYB.CODIGO_RUTA,AGYB.NO_FACTURA,AGYB.AG03FC,AGYA.codigo_producto,trim(AGYB.CLICOD) as CLICOD,
CAST(CASE 
      WHEN TRIM(CAST(oper_7.Part1C AS VARCHAR(100))) LIKE '%5' AND TRIM(CAST(oper_7.Part1C AS VARCHAR(100))) NOT LIKE '-%' THEN CAST(TRIM(CAST(oper_7.Part1C AS VARCHAR(100))) AS DECIMAL(19,3) ) + .001
      WHEN TRIM(CAST(oper_7.Part1C AS VARCHAR(100))) LIKE '%5' AND TRIM(CAST(oper_7.Part1C AS VARCHAR(100))) LIKE '-%' THEN CAST(TRIM(CAST(oper_7.Part1C AS VARCHAR(100))) AS  DECIMAL(19,3) ) - .001 
      ELSE CAST(TRIM(CAST(oper_7.Part1C AS VARCHAR(100)) ) AS  DECIMAL(19,3) )
      END AS DECIMAL(19,2))AS Part1C2
FROM  wrk_global.tmp_agy003 AGYB
INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
LEFT OUTER JOIN wrk_global.operations_7  oper_7
        ON AGYB.CODIGO_AGENCIA=oper_7.CODIGO_AGENCIA
        AND AGYB.CODIGO_RUTA = oper_7.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_7.NO_FACTURA 
        AND substring(AGYB.AG03FC,1,10) = substring(oper_7.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_7.codigo_producto
        AND trim(AGYB.CLICOD) = oper_7.CLICOD ;


----------*****************************************************----------


create table IF NOT EXISTS wrk_global.operations_9 (
CODIGO_AGENCIA int,
CODIGO_RUTA string, 
NO_FACTURA int,
AG03FC string,
codigo_producto int,
CLICOD string,
Part2  DECIMAL(23,12),
--Franchise_RevenueFinal3 DECIMAL(19,2),
Franchise_RevenueFinal3 DECIMAL(19,3),
varc STRING,
varc2 STRING 
) stored as parquet;

truncate table wrk_global.operations_9;

insert into wrk_global.operations_9
select AGYB.CODIGO_AGENCIA,AGYB.CODIGO_RUTA,AGYB.NO_FACTURA,AGYB.AG03FC,AGYA.codigo_producto,trim(AGYB.CLICOD) as CLICOD
,(COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100) AS Part2
,CAST(CAST(oper_8.Part1C2*((COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100)) AS DECIMAL(19,3))AS DECIMAL(19,3)) AS Franchise_RevenueFinal3
,CAST(oper_8.Part1C2*((COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100)) AS VARCHAR(100)) AS varc
,SUBSTR(CAST(  CAST(oper_8.Part1C2*((COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100)) AS VARCHAR(100)) AS VARCHAR(100)), 1, find_in_set( (CAST(oper_8.Part1C2*( (COALESCE(CAST(IC.PORCENTAJE AS DECIMAL(19,8)),0)/100 ) ) AS VARCHAR(100))) , '.')+4) varc2
FROM  wrk_global.tmp_agy003 AGYB
INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
LEFT JOIN wrk_global.categoriaproductos_tmp CP 
         ON AGYA.CODIGO_AGENCIA = CP.CODIGO_AGENCIA 
         AND AGYA.CODIGO_PRODUCTO = CP.CODIGO_PRODUCTO
LEFT JOIN wrk_global.clienteingresodevolucion_tmp CC
         ON AGYA.CODIGO_AGENCIA = CC.CODIGO_AGENCIA 
         AND trim(AGYB.CLICOD) = trim(CC.CLICOD)
         AND AGYB.CODIGO_RUTA = CC.CODIGO_RUTA         
LEFT JOIN wrk_global.ingresos_tmp I 
         ON AGYA.CODIGO_AGENCIA = I.CODIGO_AGENCIA 
         AND CC.INGRESOID = I.INGRESOID         
LEFT JOIN wrk_global.ingresocategorias_tmp IC 
         ON AGYA.CODIGO_AGENCIA = IC.CODIGO_AGENCIA 
         AND CP.CATEGORIAID = IC.CATEGORIAID 
         AND I.INGRESOID = IC.INGRESOID
LEFT OUTER JOIN wrk_global.operations_8 oper_8
        ON AGYB.CODIGO_AGENCIA=oper_8.CODIGO_AGENCIA
        AND AGYB.CODIGO_RUTA = oper_8.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_8.NO_FACTURA 
        AND substring(AGYB.AG03FC,1,10) = substring(oper_8.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_8.codigo_producto
        AND trim(AGYB.CLICOD) = oper_8.CLICOD ;


----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.fr_part1 (   
  codigo_ruta STRING,            
  numero VARCHAR(30),            
  no_factura INT,                
  codigo_producto INT,           
  clicod STRING,                 
  ag19id STRING,                 
  ag03fc STRING,                 
  id_tipo INT,                   
  cantidad2 BIGINT,              
  cantidad INT,                  
  promocion DOUBLE,              
  promocion2 DOUBLE,             
  descuento DOUBLE,              
  descuento2 DOUBLE,             
  div1 DECIMAL(19,8),            
  div14d DECIMAL(19,4),          
  div2 DECIMAL(19,8),            
  div24d DECIMAL(19,4),          
  part1c DECIMAL(19,3),          
  part1c2 DECIMAL(19,2),         
  part2 DECIMAL(23,12),          
  --franchise_revenuefinal3 DECIMAL(19,2),
  franchise_revenuefinal3 DECIMAL(19,3),
  varc STRING,                   
  varc2 STRING,                  
  franchise_revenue DECIMAL(19,3)
  --franchise_revenue DECIMAL(19,2)
) PARTITIONED BY (codigo_agencia INT) STORED AS PARQUET;

TRUNCATE TABLE wrk_global.fr_part1;

insert into wrk_global.fr_part1 partition (codigo_agencia)
SELECT 
      AGYA.CODIGO_RUTA
      ,CAST(CASE WHEN AGYB.AG03FC >= from_unixtime(1161103,"yyyy-MM-dd HH:mm:ss.SSSS") THEN  TRIM( CONCAT(SUBSTR(AGYB.NUMERO, 1,1),SUBSTR(AGYB.NUMERO, 14,3),SUBSTR(AGYB.NUMERO, 7,4),SUBSTR(AGYB.NUMERO, 17,4)) ) ELSE AGYB.NUMERO END AS VARCHAR(30)) AS NUMERO
      ,AGYA.NO_FACTURA
      ,AGYA.CODIGO_PRODUCTO
      ,AGYB.CLICOD
     ,AGYB.AG19ID
     ,AGYA.AG03FC
     ,CDE.id_tipo
     ,CDE.CANTIDAD AS CANTIDAD2
     ,AGYA.CANTIDAD 
     ,AGYA.PROMOCION
     ,oper_0.promocion2
     ,AGYA.DESCUENTO
    ,oper_0.descuento2
   ,oper_0.Div1
    ,oper_1.Div14d
    ,oper_0.Div2
    ,oper_1.Div24d
   ,oper_2.Part1C
    ,oper_3.Part1C2
    ,oper_4.Part2
    ,oper_4.Franchise_RevenueFinal3
    ,oper_4.varc
    ,oper_4.varc2
    ,CAST(CASE 
      WHEN TRIM(CAST(oper_4.varc2 AS VARCHAR(100))) LIKE '%5' AND TRIM(CAST(oper_4.Franchise_RevenueFinal3 AS VARCHAR(100))) NOT LIKE '-%' THEN CAST(TRIM(CAST(oper_4.varc2 AS VARCHAR(100))) AS  DECIMAL(19,8) ) + .001 
      WHEN TRIM(CAST(oper_4.varc2 AS VARCHAR(100))) LIKE '%5' AND TRIM(CAST(oper_4.Franchise_RevenueFinal3 AS VARCHAR(100))) LIKE '-%' THEN CAST(TRIM(CAST(oper_4.varc2 AS VARCHAR(100))) AS  DECIMAL(19,8) ) - .001 
      ELSE CAST(TRIM(CAST(oper_4.varc2 AS VARCHAR(100))) AS  DECIMAL(19,8))
      END AS DECIMAL(19,3)) AS Franchise_Revenue
    ,AGYA.CODIGO_AGENCIA
FROM  wrk_global.tmp_agy003_2 AGYB 

    INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
    LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
    LEFT JOIN wrk_global.operations_0 oper_0
        ON AGYB.CODIGO_AGENCIA = oper_0.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_0.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_0.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_0.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_0.codigo_producto
        AND trim(AGYB.CLICOD) = oper_0.CLICOD
    LEFT JOIN wrk_global.operations_1 oper_1
        ON AGYB.CODIGO_AGENCIA = oper_1.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_1.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_1.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_1.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_1.codigo_producto
        AND trim(AGYB.CLICOD) = oper_1.CLICOD
    LEFT JOIN wrk_global.operations_2 oper_2
        ON AGYB.CODIGO_AGENCIA = oper_2.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_2.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_2.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_2.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_2.codigo_producto
        AND trim(AGYB.CLICOD) = oper_2.CLICOD
    LEFT JOIN wrk_global.operations_3 oper_3
        ON AGYB.CODIGO_AGENCIA = oper_3.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_3.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_3.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_3.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_3.codigo_producto
        AND trim(AGYB.CLICOD) = oper_3.CLICOD
    LEFT JOIN wrk_global.operations_4 oper_4
        ON AGYB.CODIGO_AGENCIA = oper_4.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_4.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_4.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_4.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_4.codigo_producto
        AND trim(AGYB.CLICOD) = oper_4.CLICOD;


----------*****************************************************----------

CREATE TABLE IF NOT EXISTS wrk_global.fr_part2 (           
  codigo_ruta STRING,            
  numero VARCHAR(30),            
  no_factura INT,                
  codigo_producto INT,           
  clicod STRING,                 
  ag19id STRING,                 
  ag03fc STRING,                 
  id_tipo INT,                   
  cantidad2 BIGINT,              
  cantidad INT,                  
  promocion DOUBLE,              
  promocion2 DOUBLE,             
  descuento DOUBLE,              
  descuento2 DOUBLE,             
  div1 DECIMAL(19,8),            
  div14d DECIMAL(19,4),          
  div2 DECIMAL(19,8),            
  div24d DECIMAL(19,4),          
  part1c DECIMAL(19,3),          
  part1c2 DECIMAL(19,2),         
  part2 DECIMAL(23,12),          
  --franchise_revenuefinal3 DECIMAL(19,2),
  franchise_revenuefinal3 DECIMAL(19,3),
  varc STRING,                   
  varc2 STRING,                  
  franchise_revenue DECIMAL(19,3)
  --franchise_revenue DECIMAL(19,2)
) PARTITIONED BY (codigo_agencia INT) STORED AS PARQUET;

TRUNCATE TABLE wrk_global.fr_part2;

insert into wrk_global.fr_part2 partition (codigo_agencia)
SELECT 
      AGYA.CODIGO_RUTA
      ,CAST(CASE WHEN AGYB.AG03FC >= from_unixtime(1161103,"yyyy-MM-dd HH:mm:ss.SSSS") THEN  TRIM( CONCAT(SUBSTR(AGYB.NUMERO, 1,1),SUBSTR(AGYB.NUMERO, 14,3),SUBSTR(AGYB.NUMERO, 7,4),SUBSTR(AGYB.NUMERO, 17,4)) ) ELSE AGYB.NUMERO END AS VARCHAR(30)) AS NUMERO
      ,AGYA.NO_FACTURA
      ,AGYA.CODIGO_PRODUCTO
      ,AGYB.CLICOD
     ,AGYB.AG19ID
     ,AGYA.AG03FC
     ,CDE.id_tipo
     ,CDE.CANTIDAD AS CANTIDAD2
     ,AGYA.CANTIDAD 
     ,AGYA.PROMOCION
     ,oper_5.promocion2
     ,AGYA.DESCUENTO
    ,oper_5.descuento2
   ,cast(oper_5.Div1 as decimal(19,8)) as Div1
    ,oper_6.Div14d
    ,cast(oper_5.Div2 as decimal(19,8)) as Div1
    ,oper_6.Div24d
   ,oper_7.Part1C
    ,oper_8.Part1C2
    ,oper_9.Part2
    ,oper_9.Franchise_RevenueFinal3
    ,oper_9.varc
    ,oper_9.varc2
    ,CAST(CASE 
      WHEN TRIM(CAST(oper_9.varc2 AS VARCHAR(100))) LIKE '%5' AND TRIM(CAST(oper_9.Franchise_RevenueFinal3 AS VARCHAR(100))) NOT LIKE '-%' THEN CAST(TRIM(CAST(oper_9.varc2 AS VARCHAR(100))) AS  DECIMAL(19,8) ) + .001 
      WHEN TRIM(CAST(oper_9.varc2 AS VARCHAR(100))) LIKE '%5' AND TRIM(CAST(oper_9.Franchise_RevenueFinal3 AS VARCHAR(100))) LIKE '-%' THEN CAST(TRIM(CAST(oper_9.varc2 AS VARCHAR(100))) AS  DECIMAL(19,8) ) - .001 
      ELSE CAST(TRIM(CAST(oper_9.varc2 AS VARCHAR(100))) AS  DECIMAL(19,8))
      END AS DECIMAL(19,3)) AS Franchise_Revenue
    ,AGYA.CODIGO_AGENCIA
FROM  wrk_global.tmp_agy003 AGYB 

    INNER JOIN wrk_global.agy004_tmp AGYA 
         ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
         AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
         AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
         AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
    LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
        ON AGYA.codigo_producto = CDE.codigo_producto
        AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
        AND trim(AGYB.CLICOD) = trim(CDE.CLICOD)
        AND AGYA.codigo_ruta = CDE.codigo_ruta
        AND AGYA.no_factura = CDE.no_factura
    LEFT JOIN wrk_global.operations_5 oper_5
        ON AGYB.CODIGO_AGENCIA = oper_5.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_5.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_5.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_5.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_5.codigo_producto
        AND trim(AGYB.CLICOD) = oper_5.CLICOD
    LEFT JOIN wrk_global.operations_6 oper_6
        ON AGYB.CODIGO_AGENCIA = oper_6.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_6.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_6.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_6.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_6.codigo_producto
        AND trim(AGYB.CLICOD) = oper_6.CLICOD
    LEFT JOIN wrk_global.operations_7 oper_7
        ON AGYB.CODIGO_AGENCIA = oper_7.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_7.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_7.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_7.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_7.codigo_producto
        AND trim(AGYB.CLICOD) = oper_7.CLICOD
    LEFT JOIN wrk_global.operations_8 oper_8
        ON AGYB.CODIGO_AGENCIA = oper_8.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_8.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_8.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_8.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_8.codigo_producto
        AND trim(AGYB.CLICOD) = oper_8.CLICOD
    LEFT JOIN wrk_global.operations_9 oper_9
        ON AGYB.CODIGO_AGENCIA = oper_9.CODIGO_AGENCIA 
        AND AGYB.CODIGO_RUTA = oper_9.CODIGO_RUTA 
        AND AGYB.NO_FACTURA = oper_9.NO_FACTURA
        AND substring(AGYB.AG03FC,1,10) = substring(oper_9.AG03FC,1,10)
        AND AGYA.codigo_producto = oper_9.codigo_producto
        AND trim(AGYB.CLICOD) = oper_9.CLICOD;


----------*****************************************************----------


CREATE TABLE IF NOT EXISTS wrk_global.revenuexproducto_tmp (
  codigo_agencia INT,
  codigo_ruta STRING,
  fecha_venta STRING,
  numero_documento STRING,
  codigo_cliente STRING,
  codigo_producto INT,
  cantidad_producto INT,
  total_revenue DOUBLE
)                         
PARTITIONED BY (    
  agency INT
);

truncate table wrk_global.revenuexproducto_tmp;

insert into wrk_global.revenuexproducto_tmp partition(agency)
select  codigo_agencia,
  codigo_ruta ,
  fecha_venta ,
  numero_documento ,
  codigo_cliente,
  codigo_producto ,
  cantidad_producto,
  total_revenue,    
  agency 
from bccan_xprs.RevenueXProducto
group by 1,2,3,4,5,6,7,8,9;

----------*****************************************************----------
CREATE TABLE IF NOT EXISTS wrk_global.fr_master_tmp (
  codigo_ruta STRING,     
  numero VARCHAR(30),     
  no_factura INT,         
  codigo_producto INT,    
  clicod STRING,          
  ag19id STRING,          
  ag03fc STRING,          
  cantidad INT,           
  id_tipo INT,            
  franchise_revenue DOUBLE
) partitioned by (codigo_agencia INT) stored as parquet;

truncate table wrk_global.fr_master_tmp;

insert into wrk_global.fr_master_tmp partition(codigo_agencia)
      SELECT 
         FR.CODIGO_RUTA
        ,FR.NUMERO   
        ,FR.NO_FACTURA
        ,FR.CODIGO_PRODUCTO
        ,FR.CLICOD
        ,FR.AG19ID
        ,FR.AG03FC
        ,FR.CANTIDAD
        ,FR.ID_TIPO
        ,CASE WHEN FR.AG03FC >= from_unixtime(1161229,"yyyy-MM-dd HH:mm:ss.SSSS") THEN SUM(FR2.total_revenue) 
          ELSE CASE WHEN FR.AG19ID IN ('IN','DN') THEN SUM(FR.Franchise_Revenue) 
             ELSE SUM(FR.Franchise_Revenue*-1) 
             END 
             END AS Franchise_Revenue
         ,FR.CODIGO_AGENCIA
        FROM
         (
          select 
                p1.codigo_ruta,
                p1.numero,
                p1.no_factura, 
                p1.codigo_producto,
                p1.clicod,
                p1.ag19id, 
                p1.ag03fc,
                p1.id_tipo,
                p1.cantidad2,
                p1.cantidad,
                p1.promocion,
                p1.promocion2,
                p1.descuento,
                p1.descuento2,
                p1.div1,
                p1.div14d,
                p1.div2,
                p1.div24d,
                p1.part1c,
                p1.part1c2,
                p1.part2,
                p1.franchise_revenuefinal3,
                p1.varc,
                p1.varc2,
                p1.franchise_revenue,
                p1.codigo_agencia
                from wrk_global.fr_part1 p1
                

                UNION ALL

           select 
                p2.codigo_ruta,
                p2.numero,
                p2.no_factura, 
                p2.codigo_producto,
                p2.clicod,
                p2.ag19id, 
                p2.ag03fc,
                p2.id_tipo,
                p2.cantidad2,
                p2.cantidad,
                p2.promocion,
                p2.promocion2,
                p2.descuento,
                p2.descuento2,
                p2.div1,
                p2.div14d,
                p2.div2,
                p2.div24d,
                p2.part1c,
                p2.part1c2,
                p2.part2,
                p2.franchise_revenuefinal3,
                p2.varc,
                p2.varc2,
                p2.franchise_revenue,
                p2.codigo_agencia
                from wrk_global.fr_part2 p2

        ) FR
       LEFT JOIN wrk_global.revenuexproducto_tmp FR2 
        ON FR.CODIGO_AGENCIA = FR2.CODIGO_AGENCIA
              AND FR.CODIGO_RUTA = FR2.CODIGO_RUTA
              AND TRIM(FR.NUMERO) = TRIM(FR2.NUMERO_DOCUMENTO)
              AND FR.CODIGO_PRODUCTO = FR2.CODIGO_PRODUCTO
              AND FR.CLICOD = FR2.CODIGO_CLIENTE
              AND substring(FR.AG03FC,1,10) = substring(FR2.FECHA_VENTA,1,10)
      GROUP BY 1,2,3,4,5,6,7,8,9,11 ;


----------*****************************************************----------


