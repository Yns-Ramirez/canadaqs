
CREATE TABLE  IF NOT EXISTS wrk_global.t_order_final_tmp_3_2 (
  cogsyear INT,                                
  product_id_oracle STRING,                    
  plant_id DOUBLE,                             
  ingredients DOUBLE,                          
  packaging DOUBLE,                            
  direct_labour DOUBLE,                        
  overhead DOUBLE                              
)                             
STORED AS PARQUET;  


CREATE TABLE IF NOT EXISTS wrk_global.t_order_final_tmp_3_1 (
  product_id VARCHAR(30),                      
  company_id VARCHAR(30),                      
  channel_id VARCHAR(30),                      
  bill_date VARCHAR(30),                       
  unit_sold VARCHAR(30),                       
  week CHAR(6),                                
  fiscal_period CHAR(7),                       
  currency VARCHAR(30),                        
  customer_id VARCHAR(30),                     
  sales_district VARCHAR(30),                  
  plant VARCHAR(30),                           
  ship_to VARCHAR(30),                         
  doc_number VARCHAR(30),                      
  offer_code VARCHAR(30),                      
  bill_num VARCHAR(30),                        
  bill_type VARCHAR(30),                       
  net_invoice_qty DECIMAL(19,4),               
  sales DECIMAL(19,4),                         
  net_weight DECIMAL(19,4),                    
  return_invoice_quantity DECIMAL(19,4),       
  retur DECIMAL(19,4),                         
  ingredients DECIMAL(19,4),                   
  packaging DECIMAL(19,4),                     
  direct_labour DECIMAL(19,4),                 
  overhead DECIMAL(19,4),                      
  total_storage DECIMAL(19,4),                 
  total_freight DECIMAL(19,4),                 
  bill_back_accrual DECIMAL(19,4),             
  co_op_allowances_accrual DECIMAL(19,4),      
  exclusivity_allowance_accrual DECIMAL(19,4), 
  growth_incentives_accrual DECIMAL(19,4),     
  merchandising_accrual DECIMAL(19,4),         
  rebates_accrual DECIMAL(19,4),               
  listing_fees_accrual DECIMAL(19,4),          
  rebates_lumpsum DECIMAL(19,4),               
  total_off_invoice_accrual DECIMAL(19,4),     
  uncon_and_relationship_accrual DECIMAL(19,4),
  bill_back_lumpsum DECIMAL(19,4),             
  co_op_allowances_lumpsum DECIMAL(19,4),      
  exclusivity_allowance_lumpsum DECIMAL(19,4), 
  growth_incentives_lumpsum DECIMAL(19,4),     
  merchandising_lumpsum DECIMAL(19,4),         
  total_off_invoice_lumpsum DECIMAL(19,4),     
  listing_fees_lumpsum DECIMAL(19,4),          
  uncon_and_relationship_lumpsum DECIMAL(19,4),
  trade_investments DECIMAL(19,4),             
  total_deductions DECIMAL(19,4),              
  co_op_allowances DECIMAL(19,4),              
  rebates DECIMAL(19,4),                       
  buying_group_vip_accrual DECIMAL(19,4),      
  buying_group_vip_lumpsum DECIMAL(19,4),      
  tma_event DECIMAL(19,4),                     
  tma_term DECIMAL(19,4),                      
  def STRING                                   
)                                              
STORED AS PARQUET;

TRUNCATE TABLE wrk_global.t_order_final_tmp_3_1;



CREATE TABLE IF NOT EXISTS wrk_global.t_order_final_tmp_3 ( 
  product_id VARCHAR(30),                     
  company_id VARCHAR(30),                     
  channel_id VARCHAR(30),                     
  bill_date VARCHAR(30),                      
  unit_sold VARCHAR(30),                      
  week VARCHAR(30),                           
  fiscal_period VARCHAR(30),                  
  currency VARCHAR(30),                       
  customer_id VARCHAR(30),                    
  sales_district VARCHAR(30),                 
  plant VARCHAR(30),                          
  ship_to VARCHAR(30),                        
  doc_number VARCHAR(30),                     
  offer_code VARCHAR(30),                     
  bill_num VARCHAR(30),                       
  bill_type VARCHAR(30),                      
  net_invoice_qty DECIMAL(19,4),              
  total_sales DECIMAL(20,4),                  
  return_invoice_quantity DECIMAL(19,4),      
  total_returns DECIMAL(19,4),                
  ingredients DECIMAL(19,4),                  
  packaging DECIMAL(19,4),                    
  direct_labour DECIMAL(19,4),                
  overhead DECIMAL(19,4),                     
  total_storage DECIMAL(19,4),                
  total_freight DECIMAL(19,4),                
  bill_back_accrual DECIMAL(19,4),            
  co_op_allowances_accrual DECIMAL(19,4),     
  exclusivity_allowance_accrual DECIMAL(19,4),
  growth_incentives_accrual DECIMAL(19,4),    
  merchandising_accrual DECIMAL(19,4),        
  rebates_accrual DECIMAL(19,4),              
  rebates_lumpsum DECIMAL(19,4),              
  total_off_invoice_accrual DECIMAL(19,4),    
  uncon_and_relationship_accrual DECIMAL(19,4),       
  listing_fees_accrual DECIMAL(19,4),         
  bill_back_lumpsum DECIMAL(19,4),            
  co_op_allowances_lumpsum DECIMAL(19,4),     
  exclusivity_allowance_lumpsum DECIMAL(19,4),
  growth_incentives_lumpsum DECIMAL(19,4),    
  merchandising_lumpsum DECIMAL(19,4),        
  total_off_invoice_lumpsum DECIMAL(19,4),    
  listing_fees_lumpsum DECIMAL(19,4),         
  uncon_and_relationship_lumpsum DECIMAL(19,4),       
  trade_investments DECIMAL(19,4),            
  total_deductions DECIMAL(19,4),             
  co_op_allowances DECIMAL(19,4),             
  rebates DECIMAL(19,4),                      
  buying_group_vip_accrual DECIMAL(19,4),     
  buying_group_vip_lumpsum DECIMAL(19,4),     
  tma_event DECIMAL(19,4),                    
  tma_term DECIMAL(19,4),                     
  total_trade DECIMAL(19,4),                  
  cost_of_goods_sold DECIMAL(19,4),           
  cost_of_sales DECIMAL(19,4),                
  gross_contribution DECIMAL(19,4),           
  gross_profit_standard DECIMAL(19,4),        
  gross_invoice_quantity DECIMAL(19,4),       
  kilos DECIMAL(19,4),                        
  gross_sales DECIMAL(19,4),                  
  net_sales DECIMAL(19,4),                    
  def STRING                                  
)                                             
STORED AS PARQUET;

TRUNCATE TABLE wrk_global.t_order_final_tmp_3_2;
INSERT INTO TABLE wrk_global.t_order_final_tmp_3_2
                                        SELECT
                                              CCS.COGSYear
                                             ,CCS.Product_ID_ORACLE
                                             ,CCS.PLANT_ID
                                             ,MAX(CCS.Ingredients)    AS Ingredients  -- Se toma el MAX debido a la repeticion de los datos en la tabla de COGS.
                                             ,MAX(CCS.Packaging)      AS Packaging
                                             ,MAX(CCS.Direct_Labour)  AS Direct_Labour
                                             ,MAX(CCS.Overhead)       AS Overhead
                                        FROM (
                                                  SELECT
                                                       X1.ANIOBIMBO AS COGSYear
                                                      ,X1.SEGMENT1  AS Product_ID_ORACLE
                                                      ,X1.ORGANIZATION_ID AS PLANT_ID
                                                      ,COALESCE(SUM(CASE
                                                          WHEN  X1.TIPO_COSTO_ID = 1 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  Ingredients
                                                      ,COALESCE(SUM(CASE
                                                          WHEN  X1.TIPO_COSTO_ID = 2 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  Direct_Labour
                                                      ,COALESCE(SUM(CASE
                                                          WHEN  X1.TIPO_COSTO_ID = 3 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  Packaging
                                                      ,COALESCE(SUM(CASE
                                                          WHEN  X1.TIPO_COSTO_ID = 4 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  Overhead
                                                      ,COALESCE(SUM(CASE
                                                          WHEN  X1.TIPO_COSTO_ID = 9 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00) AS  OUTPROCESSING_STD_ERP
                                                      --,(Ingredients+Direct_Labour+Packaging+Overhead+OUTPROCESSING_STD_ERP) AS TOTAL
                                                      ,(COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 1 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)
                                                       +COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 2 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)
                                                       +COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 3 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)
                                                       +COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 4 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)
                                                       +COALESCE(SUM(CASE WHEN  X1.TIPO_COSTO_ID = 9 THEN  X1.ITEM_COST  ELSE NULL  END), 0.00)
                                                       ) AS TOTAL
                                                  FROM
                                                  (
                                                          SELECT
                                                               ANIOBIMBO
                                                               ,MAX(MESBIMBO)AS MESBIMBO
                                                               ,CST.INVENTORY_ITEM_ID
                                                               ,SEGMENT1
                                                               ,DESCRIPTION
                                                               ,CST.ORGANIZATION_ID
                                                               ,CASE
                                                                    WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 1  THEN 1                                 -- MATERIALS COST STD ERP
                                                                    WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 3  AND BOM.RESOURCE_TYPE = 2    THEN 2    -- MO STD COST ERP
                                                                    WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 3  AND BOM.RESOURCE_TYPE = 1    THEN 3    -- DA STD COST ERP
                                                                    WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 4  AND BOM.RESOURCE_TYPE = 4    THEN 9    -- OUTPROCESSING STD ERP
                                                                    WHEN CST.COST_TYPE_ID = 1 AND CST.COST_ELEMENT_ID = 5  THEN  4                                -- CIP STD COST ERP
                                                                    ELSE NULL
                                                               END AS TIPO_COSTO_ID                 
                                                               ,CST.ITEM_COST AS ITEM_COST 
                                                          FROM Gb_mdl_canada_global_erp.cst_item_cost_details CST 
                                                               INNER JOIN 
                                                                     (
                                                                        SELECT RESOURCE_ID, RESOURCE_TYPE, MAX(LAST_UPDATE_DATE) AS LAST_UPDATE_DATE
                                                                        FROM erp_pgbari_sz.BOM_RESOURCES_BOM 
                                                                        GROUP BY 1,2
                                                                     )BOM 
                                                                   ON CST.RESOURCE_ID = BOM.RESOURCE_ID 
                                                               INNER JOIN erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV   MAT 
                                                                   ON CST.ORGANIZATION_ID = MAT.ORGANIZATION_ID  
                                                                   AND CST.INVENTORY_ITEM_ID = MAT.INVENTORY_ITEM_ID 
                                                          WHERE CST.ORGANIZATION_ID IN (SELECT ORGANIZATION_ID FROM erp_pgbari_sz.HR_ALL_ORGANIZATION_UNITS_HR WHERE NAME LIKE ('CBC%') AND LOCATION_ID IS NOT NULL GROUP BY 1)
                                                          GROUP BY 1,3,4,5,6,7,8
                                                  ) X1
                                                  GROUP BY 1,2,3
                                             ) CCS
                                        GROUP BY 1,2,3;




TRUNCATE TABLE wrk_global.t_order_final_tmp_3_1;
INSERT INTO TABLE wrk_global.t_order_final_tmp_3_1
                    SELECT
                          CAST(VOF.Product_ID                                 AS VARCHAR(30))         AS Product_ID                    
                         ,CAST(VOF.Company_ID                                 AS VARCHAR(30))         AS Company_ID                    
                         ,CAST(VOF.Channel_ID                                 AS VARCHAR(30))         AS Channel_ID          
                         ,CAST(substring(VOF.Bill_Date,1,10)                  AS VARCHAR(30))         AS Bill_Date                     
                         ,CAST(VOF.Unit_Sold                                  AS VARCHAR(30))         AS Unit_Sold                     
                         --,CAST(CC.Fiscal_Year||CC.Week                        AS CHAR(6))         AS Week                          
                         ,CAST(concat( CC.Fiscal_Year,CC.Week ) AS CHAR(6))   AS Week
                         --,CAST(CC.Fiscal_Year||'0'||CC.PERIOD                 AS CHAR(7))         AS Fiscal_Period                 
                         ,CAST(concat(CC.Fiscal_Year,'0',CC.PERIOD )              AS CHAR(7))         AS Fiscal_Period                 
                         ,CAST(VOF.INVOICE_CURRENCY_CODE                      AS VARCHAR(30))         AS Currency                      
                         ,CAST(VOF.Customer_ID                                AS VARCHAR(30))         AS Customer_ID                   
                         ,CAST('N/A'                                          AS VARCHAR(30))         AS Sales_District                
                         ,CAST(VOF.Plant_ID                                   AS VARCHAR(30))         AS Plant                         
                         ,CAST(VOF.Ship_To                                    AS VARCHAR(30))         AS Ship_To                       
                         ,CAST(VOF.Doc_Number                                 AS VARCHAR(30))         AS Doc_Number                    
                         ,CAST('N/A'                                          AS VARCHAR(30))         AS Offer_Code
                         ,CAST(VOF.Bill_Number                                AS VARCHAR(30))         AS Bill_Num                      
                         ,CAST(VOF.Bill_Type                                  AS VARCHAR(30))         AS Bill_Type                     
                         ,CAST(VOF.PIECES_SOLD                                AS DECIMAL(19,4))       AS Net_Invoice_Qty 
                         ,CAST(VOF.AMOUNT_SOLD                                AS DECIMAL(19,4))       AS Sales 
                         ,CAST(ZEROIFNULL(-1)                                 AS DECIMAL(19,4))       AS Net_Weight
                         ,CAST(ZEROIFNULL(VOF.PIECES_RETURNED)*(-1)           AS DECIMAL(19,4))       AS Return_Invoice_Quantity 
                         ,CAST(ZEROIFNULL(VOF.AMOUNT_RETURNED)*(-1)           AS DECIMAL(19,4))       AS Retur
                         ,CAST(ZEROIFNULL(VOF.PIECES_SOLD*CCSS.Ingredients)   AS DECIMAL(19,4))       AS Ingredients
                         ,CAST(ZEROIFNULL(VOF.PIECES_SOLD*CCSS.Packaging)     AS DECIMAL(19,4))       AS Packaging
                         ,CAST(ZEROIFNULL(VOF.PIECES_SOLD*CCSS.Direct_Labour) AS DECIMAL(19,4))       AS Direct_Labour
                         ,CAST(ZEROIFNULL(VOF.PIECES_SOLD*CCSS.Overhead)      AS DECIMAL(19,4))       AS Overhead
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Total_Storage
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Total_Freight
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Bill_Back_Accrual               
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Co_op_Allowances_Accrual        
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Exclusivity_Allowance_Accrual   
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Growth_Incentives_Accrual       
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Merchandising_Accrual           
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Rebates_Accrual                 
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Listing_Fees_Accrual                      
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Rebates_Lumpsum                 
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Total_Off_Invoice_Accrual       
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Uncon_And_Relationship_Accrual
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Bill_Back_Lumpsum                       
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Co_op_Allowances_Lumpsum              
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Exclusivity_Allowance_Lumpsum         
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Growth_Incentives_Lumpsum             
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Merchandising_Lumpsum                 
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Total_Off_Invoice_Lumpsum             
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Listing_Fees_Lumpsum                       
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Uncon_And_Relationship_Lumpsum
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Trade_Investments-- ar Accrual y Lump                                         
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Total_Deductions--_UNICODE '0020006100720020004100630063007200750061006C002000790020004C0075006D007000200009000900090009'XCF
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Co_op_Allowances
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Rebates
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Buying_Group_VIP_Accrual 
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS Buying_Group_VIP_Lumpsum
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS TMA_Event
                         ,CAST(ZEROIFNULL(0)                                  AS DECIMAL(19,4))       AS TMA_Term---Accrual y Lump
                         ,'ERP'                                                                       AS Def
                    FROM wrk_global.V_ORDER_FAC VOF
                         LEFT JOIN gb_smntc_191_canada.CN_CALENDAR CC 
                         ON substring(VOF.Bill_Date,1,10) = substring(CC.Bill_Date,1,10)
                         LEFT JOIN 
                                   (
                                        SELECT * FROM wrk_global.t_order_final_tmp_3_2
                                   ) CCSS ON TRIM(CAST(VOF.Product_ID AS VARCHAR(30)))= TRIM(CAST(CCSS.Product_ID_ORACLE AS VARCHAR(30))) 
                                        AND TRIM(CAST(CC.Fiscal_Year AS CHAR(4))) = TRIM(CAST(CCSS.COGSYear AS CHAR(4))) 
                                        AND TRIM(CAST(VOF.Plant_ID AS VARCHAR(30))) = TRIM(CAST(CCSS.Plant_ID AS VARCHAR(30)))
                    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54;



TRUNCATE TABLE wrk_global.t_order_final_tmp_3;

INSERT INTO TABLE wrk_global.t_order_final_tmp_3 
               SELECT 
                     SU.Product_ID                    
                    ,SU.Company_ID                    
                    ,SU.Channel_ID                    
                    ,SU.Bill_Date                     
                    ,SU.Unit_Sold                     
                    ,SU.Week                          
                    ,SU.Fiscal_Period                 
                    ,SU.Currency                      
                    ,SU.Customer_ID                   
                    ,SU.Sales_District                
                    ,SU.Plant                         
                    ,SU.Ship_To                       
                    ,SU.Doc_Number                    
                    ,SU.Offer_Code
                    ,SU.Bill_Num                      
                    ,SU.Bill_Type                     
                    ,SU.Net_Invoice_Qty               
                    ,SU.Sales - SU.Total_Off_Invoice_Accrual AS Total_Sales
                    ,SU.Return_Invoice_Quantity       
                    ,SU.Retur                         AS Total_Returns
                    ,SU.Ingredients                   
                    ,SU.Packaging                     
                    ,SU.Direct_Labour                 
                    ,SU.Overhead                      
                    ,SU.Total_Storage                 AS Total_Storage
                    ,SU.Total_Freight                 AS Total_Freight
                    ,SU.Bill_Back_Accrual             
                    ,SU.Co_op_Allowances_Accrual      
                    ,SU.Exclusivity_Allowance_Accrual 
                    ,SU.Growth_Incentives_Accrual     
                    ,SU.Merchandising_Accrual         
                    ,SU.Rebates_Accrual               
                    ,SU.Rebates_Lumpsum               
                    ,SU.Total_Off_Invoice_Accrual     
                    ,SU.Uncon_And_Relationship_Accrual
                    ,SU.Listing_Fees_Accrual
                    ,SU.Bill_Back_Lumpsum               
                    ,SU.Co_op_Allowances_Lumpsum        
                    ,SU.Exclusivity_Allowance_Lumpsum   
                    ,SU.Growth_Incentives_Lumpsum       
                    ,SU.Merchandising_Lumpsum           
                    ,SU.Total_Off_Invoice_Lumpsum       
                    ,SU.Listing_Fees_Lumpsum                 
                    ,SU.Uncon_And_Relationship_Lumpsum
                    ,SU.Trade_Investments             
                    ,SU.Total_Deductions              
                    ,SU.Co_op_Allowances              
                    ,SU.Rebates                       
                    ,SU.Buying_Group_VIP_Accrual              
                    ,SU.Buying_Group_VIP_Lumpsum
                    ,SU.TMA_Event                     
                    ,SU.TMA_Term                      
                    ,CAST((SU.Trade_Investments+SU.Total_Off_Invoice_Accrual) AS DECIMAL(19,4))  AS Total_Trade
                    ,CAST((SU.Overhead+SU.Packaging+SU.Ingredients+SU.Direct_Labour) AS DECIMAL(19,4))   AS Cost_of_Goods_Sold
                    ,CAST((SU.Overhead+SU.Packaging+SU.Ingredients+SU.Direct_Labour) AS DECIMAL(19,4))   AS Cost_of_Sales
                    --,CAST(((Total_Sales)-(SU.Total_Freight)-(SU.Total_Storage)-(SU.Trade_Investments)-(Cost_Of_Sales))+(SU.Overhead)AS DECIMAL(19,4))  AS Gross_Contribution    
                    ,CAST(((SU.Sales - SU.Total_Off_Invoice_Accrual)-(SU.Total_Freight)-(SU.Total_Storage)-(SU.Trade_Investments)-(CAST((SU.Overhead+SU.Packaging+SU.Ingredients+SU.Direct_Labour) AS DECIMAL(19,4))))+(SU.Overhead)AS DECIMAL(19,4))  AS Gross_Contribution    
                    ,CAST( (SU.Sales - SU.Total_Off_Invoice_Accrual)-(SU.Trade_Investments)-(CAST((SU.Overhead+SU.Packaging+SU.Ingredients+SU.Direct_Labour) AS DECIMAL(19,4))) AS DECIMAL(19,4))  AS Gross_Profit_Standard --AOL
                    ,CAST(CASE WHEN SU.Bill_Type = 'RETURN' THEN 0 ELSE SU.Net_Invoice_Qty + SU.Return_Invoice_Quantity END AS DECIMAL(19,4)) AS Gross_Invoice_Quantity
                    ,CAST(SU.Net_Weight*SU.Net_Invoice_Qty AS DECIMAL(19,4)) AS Kilos
                    ,CAST(CASE WHEN SU.Bill_Type = 'RETURN' THEN 0 ELSE SU.Sales+SU.Retur END AS DECIMAL(19,4))  AS Gross_Sales   
                    ,CAST( (SU.Sales - SU.Total_Off_Invoice_Accrual)-(SU.Trade_Investments)AS DECIMAL(19,4)) AS Net_Sales
                    ,SU.Def
               FROM
                    (
                    SELECT
                          CAST(Product_ID                          AS VARCHAR(30))     AS Product_ID          
                         ,CAST(Company_ID                          AS VARCHAR(30))     AS Company_ID    
                         ,CAST(Channel_ID                          AS VARCHAR(30))     AS Channel_ID    
                         ,CAST(Bill_Date                           AS VARCHAR(30))     AS Bill_Date     
                         ,CAST(Unit_Sold                           AS VARCHAR(30))     AS Unit_Sold     
                         ,CAST(Week                                AS VARCHAR(30))     AS Week          
                         ,CAST(Fiscal_Period                       AS VARCHAR(30))     AS Fiscal_Period 
                         ,CAST(Currency                            AS VARCHAR(30))     AS Currency      
                         ,CAST(Customer_ID                         AS VARCHAR(30))     AS Customer_ID   
                         ,CAST(Sales_District                      AS VARCHAR(30))     AS Sales_District
                         ,CAST(Plant                               AS VARCHAR(30))     AS Plant         
                         ,CAST(Ship_To                             AS VARCHAR(30))     AS Ship_To       
                         ,CAST(Doc_Number                          AS VARCHAR(30))     AS Doc_Number    
                         ,CAST(Offer_Code                          AS VARCHAR(30))     AS Offer_Code
                         ,CAST(Bill_Num                            AS VARCHAR(30))     AS Bill_Num      
                         ,CAST(Bill_Type                           AS VARCHAR(30))     AS Bill_Type     
                         ,CAST(Net_Invoice_Qty                AS DECIMAL(19,4))   AS Net_Invoice_Qty 
                         ,CAST(Sales                          AS DECIMAL(19,4))   AS Sales 
                         ,CAST(Net_Weight                     AS DECIMAL(19,4))   AS Net_Weight
                         ,CAST(Return_Invoice_Quantity        AS DECIMAL(19,4))   AS Return_Invoice_Quantity 
                         ,CAST(Retur                          AS DECIMAL(19,4))   AS Retur
                         ,CAST(Ingredients                    AS DECIMAL(19,4))   AS Ingredients
                         ,CAST(Packaging                      AS DECIMAL(19,4))   AS Packaging
                         ,CAST(Direct_Labour                  AS DECIMAL(19,4))   AS Direct_Labour
                         ,CAST(Overhead                       AS DECIMAL(19,4))   AS Overhead
                         ,CAST(Total_Storage                  AS DECIMAL(19,4))   AS Total_Storage
                         ,CAST(Total_Freight                  AS DECIMAL(19,4))   AS Total_Freight
                         ,CAST(Bill_Back_Accrual              AS DECIMAL(19,4))   AS Bill_Back_Accrual               
                         ,CAST(Co_op_Allowances_Accrual       AS DECIMAL(19,4))   AS Co_op_Allowances_Accrual        
                         ,CAST(Exclusivity_Allowance_Accrual  AS DECIMAL(19,4))   AS Exclusivity_Allowance_Accrual   
                         ,CAST(Growth_Incentives_Accrual      AS DECIMAL(19,4))   AS Growth_Incentives_Accrual       
                         ,CAST(Merchandising_Accrual          AS DECIMAL(19,4))   AS Merchandising_Accrual           
                         ,CAST(Rebates_Accrual                AS DECIMAL(19,4))   AS Rebates_Accrual                 
                         ,CAST(Rebates_Lumpsum                AS DECIMAL(19,4))   AS Rebates_Lumpsum                 
                         ,CAST(Total_Off_Invoice_Accrual      AS DECIMAL(19,4))   AS Total_Off_Invoice_Accrual       
                         ,CAST(Uncon_And_Relationship_Accrual AS DECIMAL(19,4))   AS Uncon_And_Relationship_Accrual
                         ,CAST(Listing_Fees_Accrual           AS DECIMAL(19,4))   AS Listing_Fees_Accrual
                         ,CAST(Bill_Back_Lumpsum              AS DECIMAL(19,4))   AS Bill_Back_Lumpsum               
                         ,CAST(Co_op_Allowances_Lumpsum       AS DECIMAL(19,4))   AS Co_op_Allowances_Lumpsum        
                         ,CAST(Exclusivity_Allowance_Lumpsum  AS DECIMAL(19,4))   AS Exclusivity_Allowance_Lumpsum   
                         ,CAST(Growth_Incentives_Lumpsum      AS DECIMAL(19,4))   AS Growth_Incentives_Lumpsum       
                         ,CAST(Merchandising_Lumpsum          AS DECIMAL(19,4))   AS Merchandising_Lumpsum           
                         ,CAST(Total_Off_Invoice_Lumpsum      AS DECIMAL(19,4))   AS Total_Off_Invoice_Lumpsum       
                         ,CAST(Listing_Fees_Lumpsum           AS DECIMAL(19,4))   AS Listing_Fees_Lumpsum                 
                         ,CAST(Uncon_And_Relationship_Lumpsum AS DECIMAL(19,4))   AS Uncon_And_Relationship_Lumpsum
                         ,Def
                         ,CAST((Exclusivity_Allowance_Accrual + Exclusivity_Allowance_Lumpsum)   -- ar Accrual y Lump                                        
                         +(Uncon_And_Relationship_Accrual + Uncon_And_Relationship_Lumpsum) -- ar Accrual y Lump                                         
                         +(Bill_Back_Accrual + Bill_Back_Lumpsum)              -- ar Accrual y Lump                                          
                         +(Co_op_Allowances_Accrual + Co_op_Allowances_Lumpsum)       -- ar Accrual y Lump                                          
                         +(Rebates_Accrual + Rebates_Lumpsum)                -- ar Accrual y Lump                                          
                         +(Merchandising_Accrual + Merchandising_Lumpsum)          -- ar Accrual y Lump                                          
                         +(Growth_Incentives_Accrual + Growth_Incentives_Lumpsum)AS DECIMAL(19,4))      AS Trade_Investments-- ar Accrual y Lump                                         
                         ,CAST((Exclusivity_Allowance_Accrual + Exclusivity_Allowance_Lumpsum)   -- ar Accrual y Lump                                        
                         +(Uncon_And_Relationship_Accrual + Uncon_And_Relationship_Lumpsum) -- ar Accrual y Lump                                         
                         +(Bill_Back_Accrual + Bill_Back_Lumpsum)              -- ar Accrual y Lump                                          
                         +(Co_op_Allowances_Accrual + Co_op_Allowances_Lumpsum)       -- ar Accrual y Lump                                          
                         +(Rebates_Accrual+Rebates_Lumpsum)                -- ar Accrual y Lump                                          
                         +(Merchandising_Accrual + Merchandising_Lumpsum)          -- ar Accrual y Lump                                          
                         +(Growth_Incentives_Accrual + Growth_Incentives_Lumpsum)AS DECIMAL(19,4))      AS Total_Deductions--_UNICODE '0020006100720020004100630063007200750061006C002000790020004C0075006D007000200009000900090009'XCF
                         ,CAST((Co_op_Allowances_Accrual + Co_op_Allowances_Lumpsum)AS DECIMAL(19,4)) AS Co_op_Allowances
                         ,CAST((Rebates_Accrual)+(Rebates_Lumpsum)AS DECIMAL(19,4))                   AS Rebates
                         ,CAST(Buying_Group_VIP_Accrual AS DECIMAL(19,4))         AS Buying_Group_VIP_Accrual 
                         ,CAST(Buying_Group_VIP_Lumpsum AS DECIMAL(19,4))         AS Buying_Group_VIP_Lumpsum
                         ,CAST((Bill_Back_Accrual + Bill_Back_Lumpsum)          ---Accrual y Lump
                         +(Merchandising_Accrual + Merchandising_Lumpsum)     ---Accrual y Lump
                         +(Total_Off_Invoice_Accrual + Total_Off_Invoice_Lumpsum)AS DECIMAL(19,4))                  AS TMA_Event
                         ,CAST((Rebates_Accrual+Rebates_Lumpsum)    ---Accrual y Lump
                         +(Uncon_And_Relationship_Accrual + Uncon_And_Relationship_Lumpsum) -- ar Accrual y Lump                                         
                         +(Growth_Incentives_Accrual + Growth_Incentives_Lumpsum) ---Accrual y Lump
                         +(Co_op_Allowances_Accrual + Co_op_Allowances_Lumpsum)       -- ar Accrual y Lump                                          
                         +(Exclusivity_Allowance_Accrual + Exclusivity_Allowance_Lumpsum)AS DECIMAL(19,4))     AS TMA_Term---Accrual y Lump
                    FROM 
                         (               
                                SELECT * FROM wrk_global.t_order_final_tmp_3_1
                    )A
                    )SU;


INSERT INTO wrk_global.T_ORDER_FINAL_PASO_DSD_1
     SELECT 
           fin.Product_ID                    
          ,fin.Company_ID                    
          ,fin.Channel_ID                    
          ,CAST('N/A'                               AS VARCHAR(30))     AS Channel_Name
          ,CAST('N/A'                               AS VARCHAR(30))     AS Province_ID 
          ,CAST(SUBSTR(fin.Bill_Date, 1, 10)        AS VARCHAR(30))     AS Bill_Date
          ,fin.Unit_Sold                     
          ,CAST(TRIM(fin.Week)                      AS CHAR(6))         AS Week
          ,CAST(TRIM(fin.Fiscal_Period )            AS CHAR(7))         AS Fiscal_Period
          ,fin.Currency                      
          ,fin.Customer_ID                   
          ,CAST('04'                                AS VARCHAR(30))     AS Sales_District
          ,CAST('East'                              AS VARCHAR(30))     AS Sales_District_Name
          ,fin.Plant                         
          ,CAST(-1                                  AS VARCHAR(30))     AS Sales_Center                         
          ,CAST(-1                                  AS VARCHAR(30))     AS Route_ID  
          ,fin.Ship_To                       
          ,fin.Doc_Number                    
          ,fin.Offer_Code
          ,fin.Bill_Num                      
          ,fin.Bill_Type                     
          ,0                                                            AS Franchisee_Revenue_ID
          ,0                                                            AS Commision_Group_ID
          ,-1                                                           AS TSM_ID
          ,'N/A'                                                        AS TSM_Name
          ,-1                                                           AS RSM_ID
          ,'N/A'                                                        AS RSM_Name
          ,-1                                                           AS Depot_ID
          ,'N/A'                                                        AS Depot_Name
          ,'N/A'                                                        AS IO_Name
          ,'N/A'                                                        AS Invoice_Type
          ,1                                                            AS Conversion_Rate
          ,CAST(ZEROIFNULL(0)                               AS DECIMAL(19,4)) AS Price
          ,CAST(ZEROIFNULL(0)                               AS DECIMAL(19,4)) AS Net_Invoice_Price
          ,CAST(0                                           AS DECIMAL(19,4)) AS PORCENTAJE     
          ,fin.Net_Invoice_Qty               
          ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4))   AS Net_Invoice_Qty_EA 
          ,CAST(fin.Gross_Sales + (fin.Total_Off_Invoice_Accrual + fin.Total_Off_Invoice_Lumpsum) AS DECIMAL(19,4))  AS Gross_Sales         
          ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4))   AS Gross_Sales_EA 
          ,fin.Return_Invoice_Quantity                      AS Return_Invoice_Qty       
          ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4))   AS Return_Invoice_Qty_EA
          ,fin.Total_Returns                 
          ,CAST(ZEROIFNULL(0) AS DECIMAL(19,4))   AS Total_Returns_EA
          ,fin.Ingredients                   
          ,fin.Packaging                     
          ,fin.Direct_Labour                 
          ,fin.Overhead                      
          ,fin.Total_Storage                 
          ,fin.Total_Freight                 
          ,fin.Bill_Back_Accrual             
          ,fin.Co_op_Allowances_Accrual      
          ,fin.Exclusivity_Allowance_Accrual 
          ,fin.Growth_Incentives_Accrual     
          ,fin.Merchandising_Accrual         
          ,fin.Rebates_Accrual              
          ,fin.Rebates_Lumpsum               
          ,fin.Total_Off_Invoice_Accrual     AS Total_Off_Invoice
          ,fin.Total_Off_Invoice_Accrual     AS Total_Off_Invoice_EA
          ,fin.Uncon_And_Relationship_Accrual
          ,fin.Listing_Fees_Accrual
          ,fin.Bill_Back_Lumpsum               
          ,fin.Co_op_Allowances_Lumpsum        
          ,fin.Exclusivity_Allowance_Lumpsum   
          ,fin.Growth_Incentives_Lumpsum       
          ,fin.Merchandising_Lumpsum           
          ,fin.Listing_Fees_Lumpsum                 
          ,fin.Uncon_And_Relationship_Lumpsum
          ,CAST(((fin.Exclusivity_Allowance_Accrual + fin.Exclusivity_Allowance_Lumpsum)+(fin.Listing_Fees_Accrual + fin.Listing_Fees_Lumpsum)+(fin.Uncon_And_Relationship_Accrual + fin.Uncon_And_Relationship_Lumpsum)+(fin.Bill_Back_Accrual + fin.Bill_Back_Lumpsum)+(fin.Co_op_Allowances_Accrual + fin.Co_op_Allowances_Lumpsum)+(fin.Rebates)+(fin.Rebates_Accrual)+(fin.Rebates_Lumpsum)+(fin.Merchandising_Accrual + fin.Merchandising_Lumpsum)+(fin.Growth_Incentives_Accrual + fin.Growth_Incentives_Lumpsum)+(fin.Buying_Group_VIP_Accrual + fin.Buying_Group_VIP_Lumpsum))AS DECIMAL(19,4)) AS Trade_Investments
          ,CAST(((fin.Rebates)+(fin.Rebates_Accrual)+(fin.Rebates_Lumpsum)+(fin.Uncon_And_Relationship_Accrual + fin.Uncon_And_Relationship_Lumpsum)+(fin.Growth_Incentives_Accrual + fin.Growth_Incentives_Lumpsum)+(fin.Co_op_Allowances_Accrual + fin.Co_op_Allowances_Lumpsum)+(fin.Exclusivity_Allowance_Accrual + fin.Exclusivity_Allowance_Lumpsum)+(fin.Listing_Fees_Accrual + fin.Listing_Fees_Lumpsum)+(fin.Bill_Back_Accrual + fin.Bill_Back_Lumpsum)+(fin.Merchandising_Accrual + fin.Merchandising_Lumpsum))AS DECIMAL(19,4)) AS Total_Deductions              
          ,fin.Co_op_Allowances              
          ,fin.Rebates                       
          ,fin.Buying_Group_VIP_Accrual
          ,fin.Buying_Group_VIP_Lumpsum
          ,fin.TMA_Event                     
          ,CAST((fin.Gross_Sales + (fin.Total_Off_Invoice_Accrual + fin.Total_Off_Invoice_Lumpsum))-(fin.Total_Returns)-(fin.Total_Off_Invoice_Accrual + fin.Total_Off_Invoice_Lumpsum) AS DECIMAL(19,4)) AS Total_Sales
          ,CAST(0 AS DECIMAL(19,4))               AS Total_Sales_EA                   
          ,CAST(0 AS DECIMAL(19,4))               AS Other_Discounts          
          ,CAST(((fin.Rebates_Accrual)+(fin.Rebates_Lumpsum)+(fin.Uncon_And_Relationship_Accrual + fin.Uncon_And_Relationship_Lumpsum)+(fin.Growth_Incentives_Accrual + fin.Growth_Incentives_Lumpsum)+(fin.Co_op_Allowances_Accrual + fin.Co_op_Allowances_Lumpsum)+(fin.Exclusivity_Allowance_Accrual + fin.Exclusivity_Allowance_Lumpsum) +(fin.Listing_Fees_Accrual + fin.Listing_Fees_Lumpsum) )AS DECIMAL(19,4)) AS TMA_Term
          ,CAST(((fin.Exclusivity_Allowance_Accrual + fin.Exclusivity_Allowance_Lumpsum)+(fin.Uncon_And_Relationship_Accrual + fin.Uncon_And_Relationship_Lumpsum)+(fin.Bill_Back_Accrual + fin.Bill_Back_Lumpsum)+(fin.Co_op_Allowances_Accrual + fin.Co_op_Allowances_Lumpsum)+(fin.Rebates_Accrual)+(fin.Rebates_Lumpsum)+(fin.Merchandising_Accrual + fin.Merchandising_Lumpsum)+(fin.Growth_Incentives_Accrual + fin.Growth_Incentives_Lumpsum)+(fin.Total_Off_Invoice_Accrual + fin.Total_Off_Invoice_Lumpsum)+(fin.Listing_Fees_Accrual + fin.Listing_Fees_Lumpsum))AS DECIMAL(19,4)) AS Total_Trade                   
          ,fin.Cost_of_Goods_Sold            
          ,CAST(((fin.Gross_Sales + (fin.Total_Off_Invoice_Accrual + fin.Total_Off_Invoice_Lumpsum))-(fin.Total_Returns)-((fin.Exclusivity_Allowance_Accrual + fin.Exclusivity_Allowance_Lumpsum)+(fin.Listing_Fees_Accrual + fin.Listing_Fees_Lumpsum)+(fin.Uncon_And_Relationship_Accrual + fin.Uncon_And_Relationship_Lumpsum)+(fin.Bill_Back_Accrual + fin.Bill_Back_Lumpsum)+(fin.Co_op_Allowances_Accrual + fin.Co_op_Allowances_Lumpsum)+(fin.Rebates_Accrual)+(fin.Rebates_Lumpsum)+(fin.Merchandising_Accrual + fin.Merchandising_Lumpsum)+(fin.Growth_Incentives_Accrual + fin.Growth_Incentives_Lumpsum))) AS DECIMAL(19,4)) AS Net_Sales
          ,CAST((fin.Overhead) +(fin.Packaging) +(fin.Ingredients) + (fin.Direct_Labour)AS DECIMAL(19,4))         AS Cost_of_Sales
          ,CAST((((fin.Gross_Sales + (fin.Total_Off_Invoice_Accrual + fin.Total_Off_Invoice_Lumpsum))-(fin.Total_Returns)-((fin.Exclusivity_Allowance_Accrual + fin.Exclusivity_Allowance_Lumpsum)+(fin.Listing_Fees_Accrual + fin.Listing_Fees_Lumpsum)+(fin.Uncon_And_Relationship_Accrual + fin.Uncon_And_Relationship_Lumpsum)+(fin.Bill_Back_Accrual + fin.Bill_Back_Lumpsum)+(fin.Co_op_Allowances_Accrual + fin.Co_op_Allowances_Lumpsum)+(fin.Rebates_Accrual)+(fin.Rebates_Lumpsum)+(fin.Merchandising_Accrual + fin.Merchandising_Lumpsum)+(fin.Growth_Incentives_Accrual + fin.Growth_Incentives_Lumpsum))) -  (fin.Cost_of_Goods_Sold) - (fin.Total_Freight) - (fin.Total_Storage)) AS DECIMAL(19,4)) AS Gross_Profit_Standard
          ,CAST((((fin.Gross_Sales + (fin.Total_Off_Invoice_Accrual + fin.Total_Off_Invoice_Lumpsum))-(fin.Total_Returns)-((fin.Exclusivity_Allowance_Accrual + fin.Exclusivity_Allowance_Lumpsum)+(fin.Listing_Fees_Accrual + fin.Listing_Fees_Lumpsum)+(fin.Uncon_And_Relationship_Accrual + fin.Uncon_And_Relationship_Lumpsum)+(fin.Bill_Back_Accrual + fin.Bill_Back_Lumpsum)+(fin.Co_op_Allowances_Accrual + fin.Co_op_Allowances_Lumpsum)+(fin.Rebates_Accrual)+(fin.Rebates_Lumpsum)+(fin.Merchandising_Accrual + fin.Merchandising_Lumpsum)+(fin.Growth_Incentives_Accrual + fin.Growth_Incentives_Lumpsum))) -  (fin.Cost_of_Goods_Sold) - (fin.Total_Freight) - (fin.Total_Storage)) +(fin.Overhead) AS DECIMAL(19,4)) AS Gross_Contribution
          ,fin.Gross_Invoice_Quantity AS Gross_Invoice_Qty        
          ,CAST(0 AS DECIMAL(19,4)) AS Gross_Invoice_Qty_EA       
          ,fin.Kilos                         
          ,CAST(0 AS DECIMAL(19,4)) AS Franchisee_Revenue
          ,fin.Def
     FROM
          (
                SELECT * FROM wrk_global.t_order_final_tmp_3
          ) Fin ;

