
cd /home/proyectos2/Canada/Wendy/datos #/home/proyectos2/Canada/Wendy/datos

rm *.csv

#descipcion: script que controla el flijo entre los diferentes label(s) del BTEQ
#!/usr/bin/ksh

# Incio variables ##########

#Logon teradata
vIP=dbc  ##DIRECCION IP DE PRODUCCION O DESARROLLO
vUser=user_ic_intd_mex  ##CAMBIAR USUARIO
#Password de usuario teradata
vPass=usrintdic        ##CAMBIAR PASS

##Datos de las bases de datos

export vUser
export vPass
export vIP

bteq <<ENDOFBTQ

.logon ${vIP}/${vUser},${vPass}
.SET OMIT off ALL
.set width 1500
.EXPORT REPORT FILE=/home/proyectos2/Canada/Wendy/datos/DISTRIBUTION_SUPPLIER_PLANT_`date +%y%m%d`.csv

SELECT 'DISTRIBUTIONCENTERID,SUPPLIER,ADDRESS1,ADDRESS2,CITY,STATE,ZIP,COUNTRY,PHONE' (TITLE '')
FROM (SELECT 1 DUMMY_COLUMN) AS DUMMY_TABLE;
SELECT
      '' || TRIM(COALESCE(DISTRIBUTIONCENTERID,''))
  || ',' || TRIM(COALESCE(SUPPLIER,''))
  || ',' || TRIM(COALESCE(ADDRESS1,''))
  || ',' || TRIM(COALESCE(ADDRESS2,''))
  || ',' || TRIM(COALESCE(CITY,''))
  || ',' || TRIM(COALESCE(STATE,''))
  || ',' || TRIM(COALESCE(ZIP,''))
  || ',' || TRIM(COALESCE(COUNTRY,''))
  || ',' || TRIM(COALESCE(PHONE,''))
  || ''  (TITLE '')
FROM
     (
          SELECT
                CAST(DISTRIBUTIONCENTERID        AS VARCHAR(240))    AS DISTRIBUTIONCENTERID
               ,CAST(SUPPLIER                    AS VARCHAR(240))    AS SUPPLIER
               ,CAST(ADDRESS1                    AS VARCHAR(100))    AS ADDRESS1
               ,CAST(ADDRESS2                    AS VARCHAR(100))    AS ADDRESS2
               ,CAST(CITY                        AS VARCHAR(100))    AS CITY
               ,CAST(STATE                       AS VARCHAR(100))    AS STATE
               ,CAST(ZIP                         AS VARCHAR(240))    AS ZIP
               ,CAST(COUNTRY                     AS VARCHAR(240))    AS COUNTRY
               ,CAST(PHONE                       AS VARCHAR(240))    AS PHONE
          FROM APP_INTELCOMERCIAL_DM.DISTRIBUTION_SUPPLIER_PLANT
     )A
;


.EXPORT REPORT FILE=/home/proyectos2/Canada/Wendy/datos/DISTRIBUTOR_ACCOUNT_BT_ST_`date +%y%m%d`.csv

SELECT 'BILLTONUMBER,BILLTONUMBER2,BILLTONAME1,BILLTOADDRESS1,BILLTOADDRESS2,BILLTOCITY,BILLTOSTATEPROV,BILLTOZIPCODE,BILLTOCOUNTRY,SHIPTONUMBER,ShipToSiteNumber,SHIPTONAME1,SHIPTOADDRESS1,SHIPTOADDRESS2,SHIPTOCITY,SHIPTOSTATEPROV,SHIPTOZIPCODE,SHIPTOCOUNTRY' (TITLE '')
FROM (SELECT 1 dummy_column) AS dummy_table;

SELECT
      '' || TRIM(COALESCE(BILLTONUMBER,''))
  || ',' || TRIM(COALESCE(BILLTONUMBER2,''))
  || ',' || TRIM(COALESCE(BILLTONAME1,''))
  || ',' || TRIM(COALESCE(BILLTOADDRESS1,''))
  || ',' || TRIM(COALESCE(BILLTOADDRESS2,''))
  || ',' || TRIM(COALESCE(BILLTOCITY,''))
  || ',' || TRIM(COALESCE(BILLTOSTATEPROV,''))
  || ',' || TRIM(COALESCE(BILLTOZIPCODE,''))
  || ',' || TRIM(COALESCE(BILLTOCOUNTRY,''))
  || ',' || TRIM(COALESCE(SHIPTONUMBER,''))
  || ',' || TRIM(COALESCE(ShipToSiteNumber	,''))
  || ',' || TRIM(COALESCE(SHIPTONAME1,''))
  || ',' || TRIM(COALESCE(SHIPTOADDRESS1,''))
  || ',' || TRIM(COALESCE(SHIPTOADDRESS2,''))
  || ',' || TRIM(COALESCE(SHIPTOCITY,''))
  || ',' || TRIM(COALESCE(SHIPTOSTATEPROV,''))
  || ',' || TRIM(COALESCE(SHIPTOZIPCODE,''))
  || ',' || TRIM(COALESCE(SHIPTOCOUNTRY,''))
  || ''  (TITLE '')
FROM
     (
          SELECT
                CAST(BILLTONUMBER                 AS VARCHAR(240))                      AS BILLTONUMBER
               ,CAST(BILLTONUMBER2                AS VARCHAR(240))                      AS BILLTONUMBER2
               ,CAST(BILLTONAME1                  AS VARCHAR(240))                      AS BILLTONAME1
               ,CAST(BILLTOADDRESS1               AS VARCHAR(240))                      AS BILLTOADDRESS1
               ,CAST(BILLTOADDRESS2               AS VARCHAR(240))                      AS BILLTOADDRESS2
               ,CAST(BILLTOCITY                   AS VARCHAR(240))                      AS BILLTOCITY
               ,CAST(BILLTOSTATEPROV              AS VARCHAR(240))                      AS BILLTOSTATEPROV
               ,CAST(BILLTOZIPCODE                AS VARCHAR(240))                      AS BILLTOZIPCODE
               ,CAST(BILLTOCOUNTRY                AS VARCHAR(240))                      AS BILLTOCOUNTRY
               ,CAST(SHIPTONUMBER                 AS VARCHAR(240))                      AS SHIPTONUMBER
               ,CAST(ShipToSiteNumber	          AS VARCHAR(240))                      AS ShipToSiteNumber
               ,CAST(SHIPTONAME1                  AS VARCHAR(240))                      AS SHIPTONAME1
               ,CAST(SHIPTOADDRESS1               AS VARCHAR(240))                      AS SHIPTOADDRESS1
               ,CAST(SHIPTOADDRESS2               AS VARCHAR(240))                      AS SHIPTOADDRESS2
               ,CAST(SHIPTOCITY                   AS VARCHAR(240))                      AS SHIPTOCITY
               ,CAST(SHIPTOSTATEPROV              AS VARCHAR(240))                      AS SHIPTOSTATEPROV
               ,CAST(SHIPTOZIPCODE                AS VARCHAR(240))                      AS SHIPTOZIPCODE
               ,CAST(SHIPTOCOUNTRY                AS VARCHAR(240))                      AS SHIPTOCOUNTRY
          FROM APP_INTELCOMERCIAL_DM.DISTRIBUTOR_ACCOUNT_BT_ST
     )A
;

.EXPORT REPORT FILE=/home/proyectos2/Canada/Wendy/datos/DISTRIBUTOR_RESTAURANT_`date +%y%m%d`.csv

SELECT 'ShipTo,InvoiceNumber,LineNumber,CreditMemoNumber,DistributorCustomerID,DistributorCenterID,DistributorProductID,GTIN,SellUOM,InvoiceDate,OrderDate,ShippingDate,ScheduledDeliveryDate,ActualDeliveryDate,OrderQuantity,OriginalShippedQuantity,UnitPrice,ExtendedPrice' (TITLE '')
FROM (SELECT 1 dummy_column) AS dummy_table;

         SELECT
      '' || TRIM(COALESCE(ShipTo,''))
  || ',' || TRIM(COALESCE(InvoiceNumber,''))
  || ',' || TRIM(COALESCE(LineNumber,''))
  || ',' || TRIM(COALESCE(CreditMemoNumber	,''))
  || ',' || TRIM(COALESCE(DistributorCustomerID,''))
  || ',' || TRIM(COALESCE(DistributorCenterID,''))
  || ',' || TRIM(COALESCE(DistributorProductID,''))
  || ',' || TRIM(COALESCE(GTIN,''))
  || ',' || TRIM(COALESCE(SellUOM,''))
  || ',' || TRIM(COALESCE(InvoiceDate,''))
  || ',' || TRIM(COALESCE(OrderDate,''))
  || ',' || TRIM(COALESCE(ShippingDate,''))
  || ',' || TRIM(COALESCE(ScheduledDeliveryDate,''))
  || ',' || TRIM(COALESCE(ActualDeliveryDate,''))
  || ',' || TRIM(COALESCE(OrderQuantity,''))
  || ',' || TRIM(COALESCE(OriginalShippedQuantity,''))
  || ',' || TRIM(COALESCE(UnitPrice,''))
  || ',' || TRIM(COALESCE(ExtendedPrice,''))
  || ''  (TITLE '')
FROM
     (
          SELECT
                CAST(ShipTo   AS VARCHAR(240))                                      AS ShipTo
               ,CAST(InvoiceNumber   AS VARCHAR(240))                               AS InvoiceNumber
               ,CAST(LineNumber   AS VARCHAR(240))                                  AS LineNumber
               ,CAST(CreditMemoNumber	   AS VARCHAR(100))                         AS CreditMemoNumber
               ,CAST(DistributorCustomerID    AS VARCHAR(100))                      AS DistributorCustomerID
               ,CAST(DistributorCenterID  AS DECIMAL(20,10))                        AS DistributorCenterID
               ,CAST(DistributorProductID AS DECIMAL(20,10))                        AS DistributorProductID
			   ,CAST(GTIN   AS VARCHAR(240))                                        AS GTIN
			   ,CAST(SellUOM   AS VARCHAR(240))                                     AS SellUOM
               ,CAST(InvoiceDate AS DATE FORMAT  'DD/MM/YYYY') (CHAR(10))             AS InvoiceDate
               ,' '           AS OrderDate
               ,' '        AS ShippingDate
               ,' ' AS ScheduledDeliveryDate
               ,' '     AS ActualDeliveryDate
			   ,CAST(OrderQuantity   AS VARCHAR(240))                               AS OrderQuantity
			   ,CAST(OriginalShippedQuantity   AS VARCHAR(240))                     AS OriginalShippedQuantity
               ,CAST(UnitPrice   AS VARCHAR(100))                                   AS UnitPrice
               ,CAST(ExtendedPrice    AS VARCHAR(100))                              AS ExtendedPrice
              FROM APP_INTELCOMERCIAL_DM.DISTRIBUTOR_ACCOUNT_VF
     )A
;

.LOGOFF;
.quit

ENDOFBTQ

## Cambiar delimitador de Archivo .CSV de ',' a '|'
echo "-= Conversion de separador de Archivos de ',' a '|'=-"

perl -i -pe 's/\,/|/g' *.csv

echo "-= Finalizo la conversion de separador =-"
