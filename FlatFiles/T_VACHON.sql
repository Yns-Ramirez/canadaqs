create external table FlatFiles_191.T_VACHON (
       Bill_Date string,
      Sales_Center_ID string,
      Sales_Center_Name string,
      Customer_ID string,
      Product_ID string,
      Gross_Sales string,
      Return string,
      Off_Invoice string,
      Total_Sales string,
      TMA string,
      Gross_Invoice_Qty string,
      Return_Invoice_Qty string,
      Net_Invoice_Qty string,
      Gross_Eaches string,
      Return_Eaches string,
      Net_Eaches string,
      COGS string,
      IO_Revenue string,
      Grams_Cello string,
      Grams_Box string,
      TONS string,
      GB_Conversion_Factor string,
      GB_Equivalent string,
      Week string,
      FIELD_4 string,
      FIELD_5 string,
      FIELD_6 string,
      FIELD_7 string,
      FIELD_8 string)
  row format delimited fields terminated by '|' lines terminated by '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/FlatFiles_191/T_VACHON'
 tblproperties("skip.header.line.count"="1");
  
  
  create external table STG_DSD_CANADA.T_VACHON (
       Bill_Date string,
      Sales_Center_ID string,
      Sales_Center_Name string,
      Customer_ID string,
      Product_ID string,
      Gross_Sales string,
      Return string,
      Off_Invoice string,
      Total_Sales string,
      TMA string,
      Gross_Invoice_Qty string,
      Return_Invoice_Qty string,
      Net_Invoice_Qty string,
      Gross_Eaches string,
      Return_Eaches string,
      Net_Eaches string,
      COGS string,
      IO_Revenue string,
      Grams_Cello string,
      Grams_Box string,
      TONS string,
      GB_Conversion_Factor string,
      GB_Equivalent string,
      FIELD_4 string,
      FIELD_5 string,
      FIELD_6 string,
      FIELD_7 string,
      FIELD_8 string)
      partitioned by (week string)
  row format delimited fields terminated by '|' lines terminated by '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/tg_dsd_canada/T_VACHON'
tblproperties("skip.header.line.count"="1");



INSERT OVERWRITE table STG_DSD_CANADA.T_VACHON partition(week) 
select 
Bill_Date, 
Sales_Center_ID, 
Sales_Center_Name, 
Customer_ID,
Product_ID, 
Gross_Sales,
Return, Off_Invoice,
Total_Sales,
TMA,
Gross_Invoice_Qty,
Return_Invoice_Qty,
Net_Invoice_Qty,
      Gross_Eaches,
      Return_Eaches,
      Net_Eaches,
      COGS,
      IO_Revenue,
      Grams_Cello,
      Grams_Box,
      TONS,
      GB_Conversion_Factor,
      GB_Equivalent,
      FIELD_4,
      FIELD_5,
      FIELD_6,
      FIELD_7,
      FIELD_8, week from FlatFiles_191.T_VACHON;