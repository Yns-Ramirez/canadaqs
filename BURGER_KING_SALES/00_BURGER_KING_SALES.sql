drop table if EXISTS STG_DSD_CANADA.Burger_King_Sales;

CREATE TABLE IF NOT EXISTS STG_DSD_CANADA.Burger_King_Sales
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
AS
SELECT
      T.Customer_ID   AS ShipTo
      ,C.Customer_Name
    --  ,C.Bill_To_Name
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
     STG_DSD_CANADA.t_customer_master C
WHERE Bill_Date  >= TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),32))
AND T.CUSTOMER_ID = C.Customer_ID
AND T.Ship_To in ('60477236', '60503161', '60477297')
AND T.SALES_CENTER  <> '-1';

--cambiar fecha
--descomentar bill to name 
-- cambiar tabla 