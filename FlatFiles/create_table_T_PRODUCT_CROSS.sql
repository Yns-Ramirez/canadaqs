create external table STG_DSD_CANADA.T_PRODUCT_CROSS (Product_ID string,Product_SAP_ID string)
row format delimited fields terminated by ',' lines terminated by '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/stg_dsd_canada/T_PRODUCT_CROSS'
tblproperties("skip.header.line.count"="1");