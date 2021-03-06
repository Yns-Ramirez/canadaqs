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
      SALESFLAG CHAR(1)
)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3a://devbimboaws/DEV_CANADA_IC/Data/stg_canada/T_CUSTOMERS_CB';