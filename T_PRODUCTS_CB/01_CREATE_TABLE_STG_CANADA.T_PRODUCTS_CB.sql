CREATE EXTERNAL TABLE IF NOT EXISTS STG_CANADA.T_PRODUCTS_CB
     (
      Legalentity_ID VARCHAR(10),
      Product_ID VARCHAR(30),
      Product_Name VARCHAR(50),
      Category_ID INTEGER,
      Market_Name VARCHAR(50),
      GB_Category_Name VARCHAR(50),
      Trade_Brand_Name VARCHAR(50),
      SubCategory_Name VARCHAR(50),
      Category_Name VARCHAR(50),
      Base_Unit_Of_Measure VARCHAR(10),
      Net_Weight FLOAT,
      Gross_Weight FLOAT,
      UPC VARCHAR(20),
      Weight_UOM VARCHAR(10),
      Pieces_UOM VARCHAR(10),
      Standard_Pack FLOAT,
      Each_By_Case VARCHAR(50),
      Category_Set_ID BIGINT,
      Conversion_Factor FLOAT,
      Unit_Of_Measure VARCHAR(25),
      Conversion_Rate FLOAT,
      Item_Type VARCHAR(30))
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'

STORED AS 
INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'

OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'

LOCATION
  's3a://devbimboaws/DEV_CANADA_IC/Data/STG_CANADA/T_PRODUCTS_CB';