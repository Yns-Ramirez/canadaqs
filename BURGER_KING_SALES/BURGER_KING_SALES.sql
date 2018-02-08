CREATE EXTERNAL TABLE IF NOT EXISTS STG_DSD_CANADA.Burger_King_Sales
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION 's3a://devbimboaws/DEV_CANADA_IC/Data/stg_dsd_canada/Burger_King_Sales'
AS
SELECT
      T.Customer_ID   AS ShipTo
      ,C.Customer_Name
      ,C.Bill_To_Name
      ,C.Store_Number
      ,Doc_Number  AS InvoiceNumber
     ,T.Ship_To  AS DistributorCustomerID
     ,T.Sales_Center AS DistributorCenterID
     ,Product_ID AS DistributorProductID
     ,Bill_Date AS InvoiceDate
     ,Net_Invoice_Qty AS OrderQuantity
     ,Gross_Invoice_Qty AS OriginalShippedQuantity
     ,Price AS UnitPrice
     ,Total_Sales AS ExtendedPrice
FROM STG_DSD_CANADA.T_ORDER_FINAL  T,
             tmp_ic.customers_by_route_all_test C
WHERE Bill_Date  >= Current_Date - 1
AND T.CUSTOMER_ID = C.Customer_ID
AND T.Ship_To in ('60477236', '60503161', '60477297')
AND T.SALES_CENTER  <> '-1'
