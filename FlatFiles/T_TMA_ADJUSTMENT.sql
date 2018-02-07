
-------creación de la estructura de la tabla externa con LOCATION donde se deposita el catalogo------------

create external table  FlatFiles_191.T_TMA_ADJUSTMENT (
Bill_Date string,
Period string,
TMA_Bucket string,
Customer_ID string,
Product_ID string,
Offer_Code string,
Total double)
row format delimited fields terminated by ',' lines terminated by '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/FlatFiles_191/T_TMA_ADJUSTMENT'
tblproperties("skip.header.line.count"="1");

------ creación de la estructura de la tabla externa con partición -----
create external table STG_DSD_CANADA.T_TMA_ADJUSTMENT (
Bill_Date string,
TMA_Bucket string,
Customer_ID string,
Product_ID string,
Offer_Code string,
Total double)
partitioned by (period string)
row format delimited fields terminated by ',' lines terminated by '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/tg_dsd_canada/T_TMA_ADJUSTMENT'
  tblproperties("skip.header.line.count"="1");

---- proceso de llenado de la tabla ------
 INSERT OVERWRITE table STG_DSD_CANADA.T_TMA_ADJUSTMENT partition(period) 
select Bill_Date,
TMA_Bucket, 
Customer_ID, 
Product_ID, 
Offer_Code,
Total, 
Period  
from FlatFiles_191.T_TMA_ADJUSTMENT;
 
