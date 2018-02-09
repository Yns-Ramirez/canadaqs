CREATE VIEW IF NOT EXISTS APP_INTELCOMERCIAL_DM.DISTRIBUTOR_ACCOUNT_VF
AS
SELECT
       Customer_ID AS ShipTo
      ,Doc_Number AS InvoiceNumber
     ,Bill_Num AS LineNumber
     ,'  ' AS CreditMemoNumber
     ,Ship_To AS DistributorCustomerID
     ,Sales_Center AS DistributorCenterID
     ,Product_ID AS DistributorProductID
     ,'  ' AS GTIN
     ,'  ' AS SellUOM
     ,Bill_Date AS InvoiceDate
     ,'  ' AS OrderDate
     ,'  ' AS ShippingDate
     ,'  ' AS ScheduledDeliveryDate
     ,'  ' AS ActualDeliveryDate
     ,Net_Invoice_Qty AS OrderQuantity
     ,Gross_Invoice_Qty AS OriginalShippedQuantity
     ,Price AS UnitPrice
     ,Total_Sales AS ExtendedPrice
FROM STG_DSD_CANADA.T_ORDER_FINAL
WHERE Bill_Date >= TO_DATE(DATE_SUB(FROM_UNIXTIME(UNIX_TIMESTAMP()),1))
AND CUSTOMER_ID IN
                    (
                         SELECT Customer_ID FROM tmp_ic.customers_by_route_all_test
                         WHERE CUSTOMER_NAME LIKE '%WENDY%'
                         GROUP BY 1
                    )
AND SALES_CENTER  NOT IN ('-1')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18;
