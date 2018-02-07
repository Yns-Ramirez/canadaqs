

CREATE external TABLE FlatFiles_191.T_THRIFT
     (
      Fiscal_Period string,
      Week string,
      Gross_Sales double,
      Total_Sales double,
      Gross_Equivalent_Units_EA double,
      Net_Equivalent_Units_EA double,
      Net_Equivalent_Units_Con_EA double,
      Net_Invoice_Qty double,
      Customer_ID string,
      SAP_Customer_Name string,
      SAP_SKU string,
      Product_ID string,
      Sales_District_Name string,
      Sales_District_ID string,
      Sales_Center string,
      Bill_Date string)
      row format delimited fields terminated by ',' lines terminated by '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/FlatFiles_191/T_THRIFT'
  ;

  CREATE external TABLE STG_DSD_CANADA.T_THRIFT
     (
      Fiscal_Period string,
      Gross_Sales double,
      Total_Sales double,
      Gross_Equivalent_Units_EA double,
      Net_Equivalent_Units_EA double,
      Net_Equivalent_Units_Con_EA double,
      Net_Invoice_Qty double,
      Customer_ID string,
      SAP_Customer_Name string,
      SAP_SKU string,
      Product_ID string,
      Sales_District_Name string,
      Sales_District_ID string,
      Sales_Center string,
      Bill_Date string)
     partitioned by (week string)
      row format delimited fields terminated by ',' lines terminated by '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/tg_dsd_canada/T_THRIFT'
  ;

  INSERT OVERWRITE table STG_DSD_CANADA.T_THRIFT partition(week) 
  select Fiscal_Period,
      Gross_Sales,
      Total_Sales,
      Gross_Equivalent_Units_EA,
      Net_Equivalent_Units_EA,
      Net_Equivalent_Units_Con_EA,
      Net_Invoice_Qty,
      Customer_ID,
      SAP_Customer_Name,
      SAP_SKU,
      Product_ID,
      Sales_District_Name,
      Sales_District_ID,
      Sales_Center,
      Bill_Date , week  from FlatFiles_191.T_THRIFT;
 
