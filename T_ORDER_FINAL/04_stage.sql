

CREATE TABLE IF NOT EXISTS  wrk_global.t_order_final_paso_tmpupdate_dsd_1 (
  product_id STRING,                          
  company_id STRING,                          
  channel_id STRING,                          
  channel_name STRING,                        
  province_id STRING,                         
  bill_date STRING,                           
  unit_sold STRING,                           
  week STRING,                                
  fiscal_period STRING,                       
  currency STRING,                            
  customer_id STRING,                         
  sales_district STRING,                      
  sales_district_name STRING,                 
  plant STRING,                               
  sales_center STRING,                        
  route_id STRING,                            
  ship_to STRING,                             
  doc_number STRING,                          
  offer_code STRING,                          
  bill_num STRING,                            
  bill_type STRING,                           
  franchisee_revenue_id INT,                  
  commision_group_id INT,                     
  tsm_id INT,                                 
  tsm_name STRING,                            
  rsm_id INT,                                 
  rsm_name STRING,                            
  depot_id INT,                               
  depot_name STRING,                          
  io_name STRING,                             
  invoice_type STRING,                        
  conversion_rate DECIMAL(19,4),              
  price DECIMAL(19,4),                        
  net_invoice_price DECIMAL(19,4),            
  perc DECIMAL(19,4),                         
  net_invoice_qty DECIMAL(19,4),              
  net_invoice_qty_ea DECIMAL(19,4),           
  gross_sales DECIMAL(19,4),                  
  gross_sales_ea DECIMAL(19,4),               
  return_invoice_qty DECIMAL(19,4),           
  return_invoice_qty_ea DECIMAL(19,4),        
  total_returns DECIMAL(19,4),                
  total_returns_ea DECIMAL(19,4),             
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
  total_off_invoice DECIMAL(19,4),            
  total_off_invoice_ea DECIMAL(19,4),         
  uncon_and_relationship_accrual DECIMAL(19,4),
  listing_fees_accrual DECIMAL(19,4),         
  bill_back_lumpsum DECIMAL(19,4),            
  co_op_allowances_lumpsum DECIMAL(19,4),     
  exclusivity_allowance_lumpsum DECIMAL(19,4),
  growth_incentives_lumpsum DECIMAL(19,4),    
  merchandising_lumpsum DECIMAL(19,4),        
  listing_fees_lumpsum DECIMAL(19,4),         
  uncon_and_relationship_lumpsum DECIMAL(19,4),
  trade_investments DECIMAL(19,4),            
  total_deductions DECIMAL(19,4),             
  co_op_allowances DECIMAL(19,4),             
  rebates DECIMAL(19,4),                      
  buying_group_vip_accrual DECIMAL(19,4),     
  buying_group_vip_lumpsum DECIMAL(19,4),     
  tma_event DECIMAL(19,4),                    
  total_sales DECIMAL(19,4),                  
  total_sales_ea DECIMAL(19,4),               
  other_discounts DECIMAL(19,4),              
  tma_term DECIMAL(19,4),                     
  total_trade DECIMAL(19,4),                  
  cost_of_goods_sold DECIMAL(19,4),           
  net_sales DECIMAL(19,4),                    
  cost_of_sales DECIMAL(19,4),                
  gross_profit_standard DECIMAL(19,4),        
  gross_contribution DECIMAL(19,4),           
  gross_invoice_qty DECIMAL(19,4),            
  gross_invoice_qty_ea DECIMAL(19,4),         
  kilos DECIMAL(19,4),                        
  franchisee_revenue DECIMAL(19,4),           
  def STRING                                  
)                                             
STORED AS PARQUET;



-- FILTRA LO QUE SE OBTIENE EN LA TABLA wrk_global.T_ORDER_FINAL_PASO_DSD_1 SEGUN LA SEMANA (WEEK)
-- Y EL PERDIODO FISCAL (FISCAL_PERIOD) DE LA TABLA gb_smntc_191_canada.CN_CALENDAR.

TRUNCATE TABLE wrk_global.t_order_final_paso_tmpupdate_dsd_1;
INSERT INTO wrk_global.t_order_final_paso_tmpupdate_dsd_1
    SELECT
        a.product_id,
        a.company_id,
        a.channel_id,
        a.channel_name,
        a.province_id,
        a.bill_date,
        a.unit_sold,
        a.week,
        b.fiscal_period, -- SE REALIZA EL UPDATE
        a.currency,
        a.customer_id,
        a.sales_district,
        a.sales_district_name,
        a.plant,
        a.sales_center,
        a.route_id,
        a.ship_to,
        a.doc_number,
        a.offer_code,
        a.bill_num,
        a.bill_type,
        a.franchisee_revenue_id,
        a.commision_group_id,
        a.tsm_id,
        a.tsm_name,
        a.rsm_id,
        a.rsm_name,
        a.depot_id,
        a.depot_name,
        a.io_name,
        a.invoice_type,
        a.conversion_rate,
        a.price,
        a.net_invoice_price,
        a.perc,
        a.net_invoice_qty,
        a.net_invoice_qty_ea,
        a.gross_sales,
        a.gross_sales_ea,
        a.return_invoice_qty,
        a.return_invoice_qty_ea,
        a.total_returns,
        a.total_returns_ea,
        a.ingredients,
        a.packaging,
        a.direct_labour,
        a.overhead,
        a.total_storage,
        a.total_freight,
        a.bill_back_accrual,
        a.co_op_allowances_accrual,
        a.exclusivity_allowance_accrual,
        a.growth_incentives_accrual,
        a.merchandising_accrual,
        a.rebates_accrual,
        a.rebates_lumpsum,
        a.total_off_invoice,
        a.total_off_invoice_ea,
        a.uncon_and_relationship_accrual,
        a.listing_fees_accrual,
        a.bill_back_lumpsum,
        a.co_op_allowances_lumpsum,
        a.exclusivity_allowance_lumpsum,
        a.growth_incentives_lumpsum,
        a.merchandising_lumpsum,
        a.listing_fees_lumpsum,
        a.uncon_and_relationship_lumpsum,
        a.trade_investments,
        a.total_deductions,
        a.co_op_allowances,
        a.rebates,
        a.buying_group_vip_accrual,
        a.buying_group_vip_lumpsum,
        a.tma_event,
        a.total_sales,
        a.total_sales_ea,
        a.other_discounts,
        a.tma_term,
        a.total_trade,
        a.cost_of_goods_sold,
        a.net_sales,
        a.cost_of_sales,
        a.gross_profit_standard,
        a.gross_contribution,
        a.gross_invoice_qty,
        a.gross_invoice_qty_ea,
        a.kilos,
        a.franchisee_revenue,
        a.def
    FROM
        wrk_global.T_ORDER_FINAL_PASO_DSD_1 a
        INNER JOIN (
            SELECT
                CAST(TRIM( concat(TRIM(Fiscal_Year),TRIM(Week)) ) AS CHAR(6)) AS WEEK
                ,CAST(TRIM(concat(TRIM(Fiscal_Year),'0',TRIM(PERIOD))) AS CHAR(7)) AS FISCAL_PERIOD
            FROM gb_smntc_191_canada.CN_CALENDAR
                   GROUP BY 1,2
        ) b
    WHERE
        a.week = b.week;


INSERT INTO wrk_global.T_ORDER_FINAL_PASO_DSD_1
    SELECT
        a.*
    FROM
        wrk_global.T_ORDER_FINAL_PASO_DSD_1 a
    WHERE
        a.week NOT IN (
            SELECT
                CAST(TRIM( concat(TRIM(Fiscal_Year),TRIM(Week)) ) AS CHAR(6)) AS WEEK
                --,CAST(TRIM(concat(TRIM(Fiscal_Year),'0',TRIM(PERIOD))) AS CHAR(7)) AS FISCAL_PERIOD
            FROM gb_smntc_191_canada.CN_CALENDAR
                   GROUP BY 1
        );


--INSERT INTO wrk_global.T_ORDER_FINAL_PASO_DSD_1
--E ELIMINA POR PETICION DE CORREO ELECTRONICO RE: CHG0031912/CC 17-30 CB Revenue Recalculation ---- ERRAT

-- ======= SE ELIMINA POR PETICION DE CORREO ELECTRONICO RE: CHG0031912/CC 17-30 CB Revenue Recalculation ---- ERRATUM------ =======
--     UPDATE wrk_global.T_ORDER_FINAL_PASO_DSD_1
--     FROM 
--          (
--               SELECT CODIGO_AGENCIA, CODIGO_RUTA,COD_LINEA_RUTA 
--               FROM bccan_xprs_prod.ruta
--               WHERE COD_LINEA_RUTA IN ('CY','FRAD','ADM','THR','DIR')
--               GROUP BY 1,2,3
--          ) a
--     SET Franchisee_Revenue = 0
--     WHERE gb_smntc_191_canada.T_ORDER_FINAL_DSD.Sales_Center = a.CODIGO_AGENCIA
--     AND gb_smntc_191_canada.T_ORDER_FINAL_DSD.Route_ID = a.CODIGO_RUTA
--     ;




TRUNCATE TABLE wrk_global.t_order_final_paso_tmpupdate_dsd_1;

INSERT INTO wrk_global.t_order_final_paso_tmpupdate_dsd_1
    SELECT * FROM wrk_global.T_ORDER_FINAL_PASO_DSD_1 WHERE SALES_CENTER IN ('14661','14662','14663');

INSERT OVERWRITE wrk_global.T_ORDER_FINAL_PASO_DSD_1
    SELECT * FROM wrk_global.T_ORDER_FINAL_PASO_DSD_1 WHERE SALES_CENTER NOT IN ('14661','14662','14663');
    
INSERT INTO wrk_global.T_ORDER_FINAL_PASO_DSD_1
    SELECT
        product_id,
        company_id,
        channel_id,
        channel_name,
        province_id,
        bill_date,
        unit_sold,
        week,
        fiscal_period,
        currency,
        customer_id,
        '04' AS sales_district,        -- DATO A ACTUALIZAR
        'East' AS sales_district_name, -- DATO A ACTUALIZAR
        plant,
        sales_center,
        route_id,
        ship_to,
        doc_number,
        offer_code,
        bill_num,
        bill_type,
        franchisee_revenue_id,
        commision_group_id,
        tsm_id,
        tsm_name,
        rsm_id,
        rsm_name,
        depot_id,
        depot_name,
        io_name,
        invoice_type,
        conversion_rate,
        price,
        net_invoice_price,
        perc,
        net_invoice_qty,
        net_invoice_qty_ea,
        gross_sales,
        gross_sales_ea,
        return_invoice_qty,
        return_invoice_qty_ea,
        total_returns,
        total_returns_ea,
        ingredients,
        packaging,
        direct_labour,
        overhead,
        total_storage,
        total_freight,
        bill_back_accrual,
        co_op_allowances_accrual,
        exclusivity_allowance_accrual,
        growth_incentives_accrual,
        merchandising_accrual,
        rebates_accrual,
        rebates_lumpsum,
        total_off_invoice,
        total_off_invoice_ea,
        uncon_and_relationship_accrual,
        listing_fees_accrual,
        bill_back_lumpsum,
        co_op_allowances_lumpsum,
        exclusivity_allowance_lumpsum,
        growth_incentives_lumpsum,
        merchandising_lumpsum,
        listing_fees_lumpsum,
        uncon_and_relationship_lumpsum,
        trade_investments,
        total_deductions,
        co_op_allowances,
        rebates,
        buying_group_vip_accrual,
        buying_group_vip_lumpsum,
        tma_event,
        total_sales,
        total_sales_ea,
        other_discounts,
        tma_term,
        total_trade,
        cost_of_goods_sold,
        net_sales,
        cost_of_sales,
        gross_profit_standard,
        gross_contribution,
        gross_invoice_qty,
        gross_invoice_qty_ea,
        kilos,
        franchisee_revenue,
        def
    from
        wrk_global.t_order_final_paso_tmpupdate_dsd_1;
    



TRUNCATE TABLE wrk_global.t_order_final_paso_tmpupdate_dsd_1;

INSERT INTO wrk_global.t_order_final_paso_tmpupdate_dsd_1
    SELECT * FROM wrk_global.T_ORDER_FINAL_PASO_DSD_1 WHERE SALES_CENTER IN ('14664','14665','14666','14667','14672');

INSERT OVERWRITE wrk_global.T_ORDER_FINAL_PASO_DSD_1
    SELECT * FROM wrk_global.T_ORDER_FINAL_PASO_DSD_1 WHERE SALES_CENTER NOT IN ('14664','14665','14666','14667','14672');
    
INSERT INTO wrk_global.T_ORDER_FINAL_PASO_DSD_1
    SELECT
        product_id,
        company_id,
        channel_id,
        channel_name,
        province_id,
        bill_date,
        unit_sold,
        week,
        fiscal_period,
        currency,
        customer_id,
        '01' AS sales_district,        -- DATO A ACTUALIZAR
        'West' AS sales_district_name, -- DATO A ACTUALIZAR
        plant,
        sales_center,
        route_id,
        ship_to,
        doc_number,
        offer_code,
        bill_num,
        bill_type,
        franchisee_revenue_id,
        commision_group_id,
        tsm_id,
        tsm_name,
        rsm_id,
        rsm_name,
        depot_id,
        depot_name,
        io_name,
        invoice_type,
        conversion_rate,
        price,
        net_invoice_price,
        perc,
        net_invoice_qty,
        net_invoice_qty_ea,
        gross_sales,
        gross_sales_ea,
        return_invoice_qty,
        return_invoice_qty_ea,
        total_returns,
        total_returns_ea,
        ingredients,
        packaging,
        direct_labour,
        overhead,
        total_storage,
        total_freight,
        bill_back_accrual,
        co_op_allowances_accrual,
        exclusivity_allowance_accrual,
        growth_incentives_accrual,
        merchandising_accrual,
        rebates_accrual,
        rebates_lumpsum,
        total_off_invoice,
        total_off_invoice_ea,
        uncon_and_relationship_accrual,
        listing_fees_accrual,
        bill_back_lumpsum,
        co_op_allowances_lumpsum,
        exclusivity_allowance_lumpsum,
        growth_incentives_lumpsum,
        merchandising_lumpsum,
        listing_fees_lumpsum,
        uncon_and_relationship_lumpsum,
        trade_investments,
        total_deductions,
        co_op_allowances,
        rebates,
        buying_group_vip_accrual,
        buying_group_vip_lumpsum,
        tma_event,
        total_sales,
        total_sales_ea,
        other_discounts,
        tma_term,
        total_trade,
        cost_of_goods_sold,
        net_sales,
        cost_of_sales,
        gross_profit_standard,
        gross_contribution,
        gross_invoice_qty,
        gross_invoice_qty_ea,
        kilos,
        franchisee_revenue,
        def
    from
        wrk_global.t_order_final_paso_tmpupdate_dsd_1;
    



 TRUNCATE TABLE wrk_global.t_order_final_paso_tmpupdate_dsd_1;

INSERT INTO wrk_global.t_order_final_paso_tmpupdate_dsd_1
    SELECT * FROM wrk_global.T_ORDER_FINAL_PASO_DSD_1 WHERE SALES_CENTER IN ('14674','14675','14676','14677','14678','14681','14682','14683');

INSERT OVERWRITE wrk_global.T_ORDER_FINAL_PASO_DSD_1
    SELECT * FROM wrk_global.T_ORDER_FINAL_PASO_DSD_1 WHERE SALES_CENTER NOT IN ('14674','14675','14676','14677','14678','14681','14682','14683');
    
INSERT INTO wrk_global.T_ORDER_FINAL_PASO_DSD_1
    SELECT
        product_id,
        company_id,
        channel_id,
        channel_name,
        province_id,
        bill_date,
        unit_sold,
        week,
        fiscal_period,
        currency,
        customer_id,
        '02' AS sales_district,            -- DATO A ACTUALIZAR.
        'Ontario' AS sales_district_name,  -- DATO A ACTUALIZAR.
        plant,
        sales_center,
        route_id,
        ship_to,
        doc_number,
        offer_code,
        bill_num,
        bill_type,
        franchisee_revenue_id,
        commision_group_id,
        tsm_id,
        tsm_name,
        rsm_id,
        rsm_name,
        depot_id,
        depot_name,
        io_name,
        invoice_type,
        conversion_rate,
        price,
        net_invoice_price,
        perc,
        net_invoice_qty,
        net_invoice_qty_ea,
        gross_sales,
        gross_sales_ea,
        return_invoice_qty,
        return_invoice_qty_ea,
        total_returns,
        total_returns_ea,
        ingredients,
        packaging,
        direct_labour,
        overhead,
        total_storage,
        total_freight,
        bill_back_accrual,
        co_op_allowances_accrual,
        exclusivity_allowance_accrual,
        growth_incentives_accrual,
        merchandising_accrual,
        rebates_accrual,
        rebates_lumpsum,
        total_off_invoice,
        total_off_invoice_ea,
        uncon_and_relationship_accrual,
        listing_fees_accrual,
        bill_back_lumpsum,
        co_op_allowances_lumpsum,
        exclusivity_allowance_lumpsum,
        growth_incentives_lumpsum,
        merchandising_lumpsum,
        listing_fees_lumpsum,
        uncon_and_relationship_lumpsum,
        trade_investments,
        total_deductions,
        co_op_allowances,
        rebates,
        buying_group_vip_accrual,
        buying_group_vip_lumpsum,
        tma_event,
        total_sales,
        total_sales_ea,
        other_discounts,
        tma_term,
        total_trade,
        cost_of_goods_sold,
        net_sales,
        cost_of_sales,
        gross_profit_standard,
        gross_contribution,
        gross_invoice_qty,
        gross_invoice_qty_ea,
        kilos,
        franchisee_revenue,
        def
    from
        wrk_global.t_order_final_paso_tmpupdate_dsd_1;

 
  

TRUNCATE TABLE wrk_global.t_order_final_paso2_DSD;



 INSERT INTO wrk_global.t_order_final_paso2_DSD
     SELECT
           CAST(Product_ID AS varchar(18))
          ,CAST(Company_ID AS varchar(4))
          ,CAST(Channel_ID AS varchar(20))
          ,CAST(Channel_Name AS varchar(50))
          ,CAST(Province_ID AS varchar(20))
          ,TO_DATE(Bill_Date) AS Bill_Date                
          ,CAST(dayofweek(Bill_Date) AS INT) AS Day_of_Week
          ,CAST(CASE 
               WHEN dayofweek(Bill_Date) = 1 THEN 4
               WHEN dayofweek(Bill_Date) = 2 THEN 5
               WHEN dayofweek(Bill_Date) = 3 THEN 6
               WHEN dayofweek(Bill_Date) = 4 THEN 7
               WHEN dayofweek(Bill_Date) = 5 THEN 1
               WHEN dayofweek(Bill_Date) = 6 THEN 2
               WHEN dayofweek(Bill_Date) = 7 THEN 3
          ELSE dayofweek(Bill_Date)
          END AS INT) AS Day_of_BimboWeek
          ,CAST(Unit_Sold AS varchar(3))
          ,CAST(Week AS char(6))
          ,CAST(TRIM( concat(TRIM(CAST(AnioBimbo AS STRING)),TRIM(CAST(SemanaBimbo AS STRING))) ) AS CHAR(6)) AS BimboWeek
          ,CAST(Fiscal_Period AS char(7))
          ,CAST(Currency AS varchar(5))
          ,CAST(Customer_ID AS varchar(10))
          ,CAST(Sales_District AS varchar(6))
          ,CAST(Sales_District_Name AS varchar(50))
          ,CAST(Plant AS varchar(4))
          ,CAST(Sales_Center AS varchar(40))
          ,CAST(Route_ID AS varchar(20))
          ,CAST(Ship_To AS varchar(10))
          ,CAST(Doc_Number AS varchar(50))
          ,CAST(Offer_Code AS varchar(30))
          ,CAST(Bill_Num AS varchar(50))
          ,CAST(Bill_Type AS varchar(4))                    
          ,Franchisee_Revenue_ID         
          ,Commision_Group_ID            
          ,TSM_ID 
          ,CAST(TSM_Name AS varchar(100))
          ,RSM_ID 
          ,CAST(RSM_Name AS varchar(100))
          ,Depot_ID 
          ,CAST(Depot_Name AS varchar(100))
          ,CAST(IO_Name AS varchar(100)) 
          ,CAST(Invoice_Type AS varchar(100))
          ,CAST(Conversion_Rate               AS decimal(19,4))
          ,CAST(Price                         AS decimal(19,4))
          ,CAST(Net_Invoice_Price             AS decimal(19,4))
          ,CAST(Perc                          AS decimal(19,4))
          ,CAST(Net_Invoice_Qty               AS decimal(19,4))
          ,CAST(Net_Invoice_Qty_EA            AS decimal(19,4))
          ,CAST(Gross_Sales                   AS decimal(19,4))
          ,CAST(Gross_Sales_EA                AS decimal(19,4))
          ,CAST(Return_Invoice_Qty            AS decimal(19,4))
          ,CAST(Return_Invoice_Qty_EA         AS decimal(19,4))
          ,CAST(Total_Returns                 AS decimal(19,4))
          ,CAST(Total_Returns_EA              AS decimal(19,4))
          ,CAST(Ingredients                   AS decimal(19,4))
          ,CAST(Packaging                     AS decimal(19,4))
          ,CAST(Direct_Labour                 AS decimal(19,4))
          ,CAST(Overhead                      AS decimal(19,4))
          ,CAST(Total_Storage                 AS decimal(19,4))
          ,CAST(Total_Freight                 AS decimal(19,4))
          ,CAST(Bill_Back_Accrual             AS decimal(19,4))
          ,CAST(Co_op_Allowances_Accrual      AS decimal(19,4))
          ,CAST(Exclusivity_Allowance_Accrual AS decimal(19,4))
          ,CAST(Growth_Incentives_Accrual     AS decimal(19,4))
          ,CAST(Merchandising_Accrual         AS decimal(19,4))
          ,CAST(Rebates_Accrual               AS decimal(19,4))
          ,CAST(Rebates_Lumpsum               AS decimal(19,4))
          ,CAST(Total_Off_Invoice             AS decimal(19,4))
          ,CAST(Total_Off_Invoice_EA          AS decimal(19,4))
          ,CAST(Uncon_And_Relationship_Accrual AS decimal(19,4))
          ,CAST(Listing_Fees_Accrual          AS decimal(19,4))
          ,CAST(Bill_Back_Lumpsum             AS decimal(19,4))
          ,CAST(Co_op_Allowances_Lumpsum      AS decimal(19,4))
          ,CAST(Exclusivity_Allowance_Lumpsum AS decimal(19,4))
          ,CAST(Growth_Incentives_Lumpsum     AS decimal(19,4))
          ,CAST(Merchandising_Lumpsum         AS decimal(19,4))
          ,CAST(Listing_Fees_Lumpsum          AS decimal(19,4))
          ,CAST(Uncon_And_Relationship_Lumpsum AS decimal(19,4))
          ,CAST(Trade_Investments             AS decimal(19,4))
          ,CAST(Total_Deductions              AS decimal(19,4))
          ,CAST(Co_op_Allowances              AS decimal(19,4))
          ,CAST(Rebates                       AS decimal(19,4))
          ,CAST(Buying_Group_VIP_Accrual      AS decimal(19,4))        
          ,CAST(Buying_Group_VIP_Lumpsum      AS decimal(19,4))
          ,CAST(TMA_Event                     AS decimal(19,4))
          ,CAST(Total_Sales                   AS decimal(19,4))
          ,CAST(Total_Sales_EA                AS decimal(19,4))
          ,CAST(Other_Discounts               AS decimal(19,4))
          ,CAST(TMA_Term                      AS decimal(19,4))
          ,CAST(Total_Trade                   AS decimal(19,4))
          ,CAST(Cost_of_Goods_Sold            AS decimal(19,4))
          ,CAST(Net_Sales                     AS decimal(19,4))
          ,CAST(Cost_of_Sales                 AS decimal(19,4))
          ,CAST(Gross_Profit_Standard         AS decimal(19,4))
          ,CAST(Gross_Contribution            AS decimal(19,4))
          ,CAST(Gross_Invoice_Qty             AS decimal(19,4))
          ,CAST(Gross_Invoice_Qty_EA          AS decimal(19,4))
          ,CAST(Kilos                         AS decimal(19,4))
          ,CAST(Franchisee_Revenue            AS decimal(19,4))
          ,CAST(Def                           AS varchar(20))
     FROM wrk_global.T_ORDER_FINAL_PASO_DSD_1 O
          INNER JOIN gb_smntc_191_canada.U_BIMBO_CALENDARIO C 
          ON O.Bill_Date = c.FechaCal;


 
/*INSERT OVERWRITE TABLE gb_smntc_191_canada.t_order_final_dsd
SELECT
    a.Product_ID,
    a.Company_ID,
    a.Channel_ID,
    a.Channel_Name,
    a.Province_ID,
    a.Bill_Date,
    a.Day_of_Week,
    a.Day_of_BimboWeek,
    a.Unit_Sold,
    a.Week,
    a.BimboWeek,
    a.Fiscal_Period,
    a.Currency,
    a.Customer_ID,
    a.Sales_District,
    a.Sales_District_Name,
    a.Plant,
    a.Sales_Center,
    a.Route_ID,
    a.Ship_To,
    a.Doc_Number,
    a.Offer_Code,
    a.Bill_Num,
    a.Bill_Type,
    a.Franchisee_Revenue_ID,
    a.Commision_Group_ID,
    a.TSM_ID,
    a.TSM_Name,
    a.RSM_ID,
    a.RSM_Name,
    a.Depot_ID,
    a.Depot_Name,
    a.IO_Name,
    a.Invoice_Type,
    a.Conversion_Rate,
    a.Price,
    a.Net_Invoice_Price,
    a.Perc,
    a.Net_Invoice_Qty,
    a.Net_Invoice_Qty_EA,
    a.Gross_Sales,
    a.Gross_Sales_EA,
    a.Return_Invoice_Qty,
    a.Return_Invoice_Qty_EA,
    a.Total_Returns,
    a.Total_Returns_EA,
    a.Ingredients,
    a.Packaging,
    a.Direct_Labour,
    a.Overhead,
    a.Total_Storage,
    a.Total_Freight,
    a.Bill_Back_Accrual,
    a.Co_op_Allowances_Accrual,
    a.Exclusivity_Allowance_Accrual,
    a.Growth_Incentives_Accrual,
    a.Merchandising_Accrual,
    a.Rebates_Accrual,
    a.Rebates_Lumpsum,
    a.Total_Off_Invoice,
    a.Total_Off_Invoice_EA,
    a.Uncon_And_Relationship_Accrual,
    a.Listing_Fees_Accrual,
    a.Bill_Back_Lumpsum,
    a.Co_op_Allowances_Lumpsum,
    a.Exclusivity_Allowance_Lumpsum,
    a.Growth_Incentives_Lumpsum,
    a.Merchandising_Lumpsum,
    a.Listing_Fees_Lumpsum,
    a.Uncon_And_Relationship_Lumpsum,
    a.Trade_Investments,
    a.Total_Deductions,
    a.Co_op_Allowances,
    a.Rebates,
    a.Buying_Group_VIP_Accrual,
    a.Buying_Group_VIP_Lumpsum,
    a.TMA_Event,
    a.Total_Sales,
    a.Total_Sales_EA,
    a.Other_Discounts,
    a.TMA_Term,
    a.Total_Trade,
    a.Cost_of_Goods_Sold,
    a.Net_Sales,
    a.Cost_of_Sales,
    a.Gross_Profit_Standard,
    a.Gross_Contribution,
    a.Gross_Invoice_Qty,
    a.Gross_Invoice_Qty_EA,
    a.Kilos,
    a.Franchisee_Revenue,
    a.Def
FROM
    gb_smntc_191_canada.t_order_final_dsd a,
 wrk_global.t_order_final_paso2_dsd b
WHERE
    a.week <> CAST(TRIM(b.Week) AS CHAR(6))
    AND a.Bill_Date <> b.Bill_Date
    AND a.Def <> 'CP-TMA'
    AND a.Sales_Center <> b.Sales_Center;
*/

INSERT OVERWRITE TABLE gb_smntc_191_canada.t_order_final_dsd
    select
        *
    from
        gb_smntc_191_canada.t_order_final_dsd
    where
        concat(week, '|', bill_date, '|', def, '|', sales_center) NOT IN (
            select
                concat(x1.week, '|', x1.bill_date, '|', x1.def, '|', x1.sales_center) as kye
            from (
                select
                    trim(week)      as week,
                    bill_date       as bill_date,
                    'CP-TMA'           as def,
                    sales_center    as sales_center
                from
                    wrk_global.t_order_final_paso2_dsd paso
                where
                    def = 'CP'
                group by
                    1,2,3,4
            ) x1
        );






/*INSERT OVERWRITE TABLE gb_smntc_191_canada.t_order_final_dsd
SELECT
    a.Product_ID,
    a.Company_ID,
    a.Channel_ID,
    a.Channel_Name,
    a.Province_ID,
    a.Bill_Date,
    a.Day_of_Week,
    a.Day_of_BimboWeek,
    a.Unit_Sold,
    a.Week,
    a.BimboWeek,
    a.Fiscal_Period,
    a.Currency,
    a.Customer_ID,
    a.Sales_District,
    a.Sales_District_Name,
    a.Plant,
    a.Sales_Center,
    a.Route_ID,
    a.Ship_To,
    a.Doc_Number,
    a.Offer_Code,
    a.Bill_Num,
    a.Bill_Type,
    a.Franchisee_Revenue_ID,
    a.Commision_Group_ID,
    a.TSM_ID,
    a.TSM_Name,
    a.RSM_ID,
    a.RSM_Name,
    a.Depot_ID,
    a.Depot_Name,
    a.IO_Name,
    a.Invoice_Type,
    a.Conversion_Rate,
    a.Price,
    a.Net_Invoice_Price,
    a.Perc,
    a.Net_Invoice_Qty,
    a.Net_Invoice_Qty_EA,
    a.Gross_Sales,
    a.Gross_Sales_EA,
    a.Return_Invoice_Qty,
    a.Return_Invoice_Qty_EA,
    a.Total_Returns,
    a.Total_Returns_EA,
    a.Ingredients,
    a.Packaging,
    a.Direct_Labour,
    a.Overhead,
    a.Total_Storage,
    a.Total_Freight,
    a.Bill_Back_Accrual,
    a.Co_op_Allowances_Accrual,
    a.Exclusivity_Allowance_Accrual,
    a.Growth_Incentives_Accrual,
    a.Merchandising_Accrual,
    a.Rebates_Accrual,
    a.Rebates_Lumpsum,
    a.Total_Off_Invoice,
    a.Total_Off_Invoice_EA,
    a.Uncon_And_Relationship_Accrual,
    a.Listing_Fees_Accrual,
    a.Bill_Back_Lumpsum,
    a.Co_op_Allowances_Lumpsum,
    a.Exclusivity_Allowance_Lumpsum,
    a.Growth_Incentives_Lumpsum,
    a.Merchandising_Lumpsum,
    a.Listing_Fees_Lumpsum,
    a.Uncon_And_Relationship_Lumpsum,
    a.Trade_Investments,
    a.Total_Deductions,
    a.Co_op_Allowances,
    a.Rebates,
    a.Buying_Group_VIP_Accrual,
    a.Buying_Group_VIP_Lumpsum,
    a.TMA_Event,
    a.Total_Sales,
    a.Total_Sales_EA,
    a.Other_Discounts,
    a.TMA_Term,
    a.Total_Trade,
    a.Cost_of_Goods_Sold,
    a.Net_Sales,
    a.Cost_of_Sales,
    a.Gross_Profit_Standard,
    a.Gross_Contribution,
    a.Gross_Invoice_Qty,
    a.Gross_Invoice_Qty_EA,
    a.Kilos,
    a.Franchisee_Revenue,
    a.Def
FROM
    gb_smntc_191_canada.t_order_final_dsd a,
    wrk_global.t_order_final_paso2_dsd b
WHERE
    a.week <> CAST(TRIM(b.Week) AS CHAR(6))
    AND a.Bill_Date <> b.Bill_Date
    AND a.Def <> 'ERP'
    AND a.Sales_Center <> b.Sales_Center;
*/

INSERT OVERWRITE TABLE gb_smntc_191_canada.t_order_final_dsd
    select
        *
    from
        gb_smntc_191_canada.t_order_final_dsd
    where
        concat(week, '|', bill_date, '|', def, '|', sales_center) NOT IN (
            select
                concat(x1.week, '|', x1.bill_date, '|', x1.def, '|', x1.sales_center) as kye
            from (
                select
                    trim(week)      as week,
                    bill_date       as bill_date,
                    'ERP'           as def,
                    sales_center    as sales_center
                from
                    wrk_global.t_order_final_paso2_dsd paso
                where
                    def = 'ERP'
                group by
                    1,2,3,4
            ) x1
        );



  --SET Paso = 7;
INSERT INTO
    gb_smntc_191_canada.t_order_final_dsd 
    SELECT
        t.product_id,
        t.company_id,
        t.channel_id,
        t.channel_name,
        t.province_id,
        t.bill_date,
        t.day_of_week,
        t.day_of_bimboweek,
        t.unit_sold,
        t.week,
        t.bimboweek,
        t.fiscal_period,
        t.currency,
        t.customer_id,
        t.sales_district,
        t.sales_district_name,
        t.plant,
        t.sales_center,
        t.route_id,
        t.ship_to,
        t.doc_number,
        t.offer_code,
        t.bill_num,
        t.bill_type,
        t.franchisee_revenue_id,
        t.commision_group_id,
        t.tsm_id,
        t.tsm_name,
        t.rsm_id,
        t.rsm_name,
        t.depot_id,
        t.depot_name,
        t.io_name,
        t.invoice_type,
        t.conversion_rate,
        t.price,
        t.net_invoice_price,
        t.perc,
        CAST(SUM(COALESCE(t.net_invoice_qty , 0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
        CAST(SUM(COALESCE(t.net_invoice_qty_ea , 0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
        CAST(SUM(COALESCE(t.gross_sales , 0)) AS DECIMAL(19, 4)) AS gross_sales,
        CAST(SUM(COALESCE(t.gross_sales_ea , 0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
        CAST(SUM(COALESCE(t.return_invoice_qty , 0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
        CAST(SUM(COALESCE(t.return_invoice_qty_ea , 0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
        CAST(SUM(COALESCE(t.total_returns , 0)) AS DECIMAL(19, 4)) AS total_returns,
        CAST(SUM(COALESCE(t.total_returns_ea , 0)) AS DECIMAL(19, 4)) AS total_returns_ea,
        CAST(SUM(COALESCE(t.ingredients , 0)) AS DECIMAL(19, 4)) AS ingredients,
        CAST(SUM(COALESCE(t.packaging , 0)) AS DECIMAL(19, 4)) AS packaging,
        CAST(SUM(COALESCE(t.direct_labour , 0)) AS DECIMAL(19, 4)) AS direct_labour,
        CAST(SUM(COALESCE(t.overhead , 0)) AS DECIMAL(19, 4)) AS overhead,
        CAST(SUM(COALESCE(t.total_storage , 0)) AS DECIMAL(19, 4)) AS total_storage,
        CAST(SUM(COALESCE(t.total_freight , 0)) AS DECIMAL(19, 4)) AS total_freight,
        CAST(SUM(COALESCE(m.bill_back_accrual , 0)) AS DECIMAL(19, 4)) AS bill_back_accrual,
        CAST(SUM(COALESCE(m.co_op_allowances_accrual , 0)) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
        CAST(SUM(COALESCE(m.exclusivity_allowance_accrual , 0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
        CAST(SUM(COALESCE(m.growth_incentives_accrual , 0)) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
        CAST(SUM(COALESCE(m.merchandising_accrual , 0)) AS DECIMAL(19, 4)) AS merchandising_accrual,
        CAST(SUM(COALESCE(m.rebates_accrual , 0)) AS DECIMAL(19, 4)) AS rebates_accrual,
        CAST(SUM(COALESCE(m.rebates_lumpsum , 0)) AS DECIMAL(19, 4)) AS rebates_lumpsum,
        CAST(SUM(COALESCE(t.total_off_invoice , 0)) AS DECIMAL(19, 4)) AS total_off_invoice,
        CAST(SUM(COALESCE(t.total_off_invoice_ea , 0)) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
        CAST(SUM(COALESCE(m.uncon_and_relationship_accrual , 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
        CAST(SUM(COALESCE(m.listing_fees_accrual , 0)) AS DECIMAL(19, 4)) AS listing_fees_accrual,
        CAST(SUM(COALESCE(m.bill_back_lumpsum , 0)) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
        CAST(SUM(COALESCE(m.co_op_allowances_lumpsum , 0)) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
        CAST(SUM(COALESCE(m.exclusivity_allowance_lumpsum , 0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
        CAST(SUM(COALESCE(m.growth_incentives_lumpsum , 0)) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
        CAST(SUM(COALESCE(m.merchandising_lumpsum , 0)) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
        CAST(SUM(COALESCE(m.listing_fees_lumpsum , 0)) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
        CAST(SUM(COALESCE(m.uncon_and_relationship_lumpsum , 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
        CAST(SUM(COALESCE(m.trade_investments , 0)) AS DECIMAL(19, 4)) AS trade_investments,
        CAST(SUM(COALESCE(t.total_deductions , 0)) AS DECIMAL(19, 4)) AS total_deductions,
        CAST(SUM(COALESCE(t.co_op_allowances , 0)) AS DECIMAL(19, 4)) AS co_op_allowances,
        CAST(SUM(COALESCE(t.rebates , 0)) AS DECIMAL(19, 4)) AS rebates,
        CAST(SUM(COALESCE(m.buying_group_vip_accrual , 0)) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
        CAST(SUM(COALESCE(m.buying_group_vip_lumpsum , 0)) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
        CAST(SUM(COALESCE(t.tma_event , 0)) AS DECIMAL(19, 4)) AS tma_event,
        CAST(SUM(COALESCE(t.total_sales , 0)) AS DECIMAL(19, 4)) AS total_sales,
        CAST(SUM(COALESCE(t.total_sales_ea , 0)) AS DECIMAL(19, 4)) AS total_sales_ea,
        CAST(SUM(COALESCE(t.other_discounts , 0)) AS DECIMAL(19, 4)) AS other_discounts,
        CAST(SUM(COALESCE(t.tma_term , 0)) AS DECIMAL(19, 4)) AS tma_term,
        CAST(SUM(COALESCE(t.total_trade , 0)) AS DECIMAL(19, 4)) AS total_trade,
        CAST(SUM(COALESCE(t.cost_of_goods_sold , 0)) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
        CAST(SUM(COALESCE(t.net_sales , 0)) AS DECIMAL(19, 4)) AS net_sales,
        CAST(SUM(COALESCE(t.cost_of_sales , 0)) AS DECIMAL(19, 4)) AS cost_of_sales,
        CAST(SUM(COALESCE(t.gross_profit_standard , 0)) AS DECIMAL(19, 4)) AS gross_profit_standard,
        CAST(SUM(COALESCE(t.gross_contribution , 0)) AS DECIMAL(19, 4)) AS gross_contribution,
        CAST(SUM(COALESCE(t.gross_invoice_qty , 0)) AS DECIMAL(19, 4)) AS gross_invoice_qty,
        CAST(SUM(COALESCE(t.gross_invoice_qty_ea , 0)) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
        CAST(SUM(COALESCE(t.kilos , 0)) AS DECIMAL(19, 4)) AS kilos,
        CAST(SUM(COALESCE(t.franchisee_revenue , 0)) AS DECIMAL(19, 4)) AS franchisee_revenue,
        CAST(('CP-TMA') AS VARCHAR(20)) AS def 
    FROM
        wrk_global.t_order_final_paso2_dsd t 
        LEFT JOIN
            (
                SELECT
                    product_id,
                    company_id,
                    bill_date,
                    customer_id,
                    sales_district,
                    doc_number,
                    doc_type,
                    SUM(bill_back_accrual ) AS bill_back_accrual,
                    SUM(co_op_allowances_accrual ) AS co_op_allowances_accrual,
                    SUM(exclusivity_allowance_accrual ) AS exclusivity_allowance_accrual,
                    SUM(growth_incentives_accrual ) AS growth_incentives_accrual,
                    SUM(merchandising_accrual ) AS merchandising_accrual,
                    SUM(rebates_accrual ) AS rebates_accrual,
                    SUM(rebates_lumpsum ) AS rebates_lumpsum,
                    SUM(total_off_invoice ) AS total_off_invoice,
                    SUM(total_off_invoice_ea ) AS total_off_invoice_ea,
                    SUM(uncon_and_relationship_accrual) AS uncon_and_relationship_accrual,
                    SUM(listing_fees_accrual ) AS listing_fees_accrual,
                    SUM(bill_back_lumpsum ) AS bill_back_lumpsum,
                    SUM(co_op_allowances_lumpsum ) AS co_op_allowances_lumpsum,
                    SUM(exclusivity_allowance_lumpsum ) AS exclusivity_allowance_lumpsum,
                    SUM(growth_incentives_lumpsum ) AS growth_incentives_lumpsum,
                    SUM(merchandising_lumpsum ) AS merchandising_lumpsum,
                    SUM(listing_fees_lumpsum ) AS listing_fees_lumpsum,
                    SUM(uncon_and_relationship_lumpsum) AS uncon_and_relationship_lumpsum,
                    SUM(buying_group_vip_accrual ) AS buying_group_vip_accrual,
                    SUM(buying_group_vip_lumpsum ) AS buying_group_vip_lumpsum,
                    SUM(trade_investments ) AS trade_investments 
                FROM
                    gb_smntc_191_canada.t_tma_final 
                WHERE
                    adjustment_flag = '0' 
                GROUP BY
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7 
            )
            m 
            ON t.product_id = m.product_id 
            AND t.company_id = m.company_id 
            AND t.bill_date = m.bill_date 
            AND t.customer_id = m.customer_id 
            AND t.sales_district = m.sales_district 
            AND t.doc_number = m.doc_number 
            AND t.bill_type = m.doc_type 
       WHERE
        t.def = 'CP' 
       GROUP BY 1,2,3,4,5,6,7,8,9,
        10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,
        25,26,27,28,29,30,31,32,33,34,35,36,37,38,92 ;


INSERT INTO
    gb_smntc_191_canada.t_order_final_dsd 
    SELECT
        CAST(t.product_id AS VARCHAR(18))   AS product_id,
        CAST(t.company_id AS VARCHAR(4))    AS company_id,
        CAST(t.channel_id AS VARCHAR(20))   AS channel_id,
        CAST(t.channel_name AS VARCHAR(50)) AS channel_name,
        CAST(t.province_id  AS VARCHAR(20)) AS province_id,
        t.bill_date,         --,CAST(T.Bill_Date AS DATE FORMAT 'YYYY-MM-DD') AS Bill_Date
        CAST(day_of_week AS INT) AS day_of_week,
        CAST( 
            CASE
                WHEN CAST(day_of_week AS INT) = 1 THEN 4 
                WHEN CAST(day_of_week AS INT) = 2 THEN 5 
                WHEN CAST(day_of_week AS INT) = 3 THEN 6 
                WHEN CAST(day_of_week AS INT) = 4 THEN 7 
                WHEN CAST(day_of_week AS INT) = 5 THEN 1 
                WHEN CAST(day_of_week AS INT) = 6 THEN 2 
                WHEN CAST(day_of_week AS INT) = 7 THEN 3 
                ELSE CAST(day_of_week AS INT) 
            END
        AS INT ) AS day_of_bimboweek,
        CAST(t.unit_sold AS VARCHAR(3))     AS unit_sold,
        CAST(t.week AS CHAR(6))             AS week,
        CAST(concat(TRIM(CAST(aniobimbo AS string)), TRIM(CAST(SemanaBimbo AS STRING))) AS CHAR(6)) AS BimboWeek,
        --,CAST(TRIM(TRIM(AnioBimbo)||TRIM(SemanaBimbo)) AS CHAR(6)) AS BimboWeek
        CAST(t.fiscal_period AS CHAR(7))    AS fiscal_period,
        CAST(t.currency AS VARCHAR(5))      AS currency,
        CAST(t.customer_id AS VARCHAR(10))  AS customer_id,
        CAST(t.sales_district AS VARCHAR(6)) AS sales_district,
        CAST(t.sales_district_name AS VARCHAR(50)) AS sales_district_name,
        CAST(t.plant AS VARCHAR(4))         AS plant,
        CAST(t.sales_center AS VARCHAR(40)) AS sales_center,
        CAST(t.route_id AS VARCHAR(20))     AS route_id,
        CAST(t.ship_to AS VARCHAR(10))      AS ship_to,
        CAST(t.doc_number AS VARCHAR(50))   AS doc_number,
        CAST(t.offer_code AS VARCHAR(30))   AS offer_code,
        CAST(t.bill_num AS VARCHAR(50))     AS bill_num,
        CAST(t.bill_type AS VARCHAR(4))     AS bill_type,
        CAST(t.franchisee_revenue_id AS INT) AS franchisee_revenue_id,
        CAST(t.commision_group_id AS INT) AS commision_group_id,
        t.tsm_id,
        CAST(t.tsm_name AS VARCHAR(100))    AS tsm_name,
        t.rsm_id,
        CAST(t.rsm_name AS VARCHAR(100))     AS rsm_name,
        t.depot_id,
        CAST(t.depot_name AS VARCHAR(100))  AS depot_name,
        CAST(t.io_name AS VARCHAR(100))     AS io_name,
        CAST(t.invoice_type AS VARCHAR(100)) AS invoice_type,
        CAST(t.conversion_rate AS DECIMAL(19,4)) AS conversion_rate,
        CAST(t.price AS DECIMAL(19,4))      AS price,
        CAST(t.net_invoice_price AS DECIMAL(19,4)) AS net_invoice_price,
        CAST(- 1 AS DECIMAL(19,4))          AS Perc,
        CAST(SUM(COALESCE(t.net_invoice_qty,                0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
        CAST(SUM(COALESCE(t.net_invoice_qty_ea,             0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
        CAST(SUM(COALESCE(t.gross_sales,                    0)) AS DECIMAL(19, 4)) AS gross_sales,
        CAST(SUM(COALESCE(t.gross_sales_ea,                 0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
        CAST(SUM(COALESCE(t.return_invoice_qty,             0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
        CAST(SUM(COALESCE(t.return_invoice_qty_ea,          0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
        CAST(SUM(COALESCE(t.total_returns,                  0)) AS DECIMAL(19, 4)) AS total_returns,
        CAST(SUM(COALESCE(t.total_returns_ea,               0)) AS DECIMAL(19, 4)) AS total_returns_ea,
        CAST(SUM(COALESCE(t.ingredients,                    0)) AS DECIMAL(19, 4)) AS ingredients,
        CAST(SUM(COALESCE(t.packaging,                      0)) AS DECIMAL(19, 4)) AS packaging,
        CAST(SUM(COALESCE(t.direct_labour,                  0)) AS DECIMAL(19, 4)) AS direct_labour,
        CAST(SUM(COALESCE(t.overhead,                       0)) AS DECIMAL(19, 4)) AS overhead,
        CAST(SUM(COALESCE(t.total_storage,                  0)) AS DECIMAL(19, 4)) AS total_storage,
        CAST(SUM(COALESCE(t.total_freight,                  0)) AS DECIMAL(19, 4)) AS total_freight,
        CAST(SUM(COALESCE(t.bill_back_accrual,              0)) AS DECIMAL(19, 4)) AS bill_back_accrual,
        CAST(SUM(COALESCE(t.co_op_allowances_accrual,       0)) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
        CAST(SUM(COALESCE(t.exclusivity_allowance_accrual,  0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
        CAST(SUM(COALESCE(t.growth_incentives_accrual,      0)) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
        CAST(SUM(COALESCE(t.merchandising_accrual,          0)) AS DECIMAL(19, 4)) AS merchandising_accrual,
        CAST(SUM(COALESCE(t.rebates_accrual,                0)) AS DECIMAL(19, 4)) AS rebates_accrual,
        CAST(SUM(COALESCE(t.rebates_lumpsum,                0)) AS DECIMAL(19, 4)) AS rebates_lumpsum,
        CAST(SUM(COALESCE(t.total_off_invoice,              0)) AS DECIMAL(19, 4)) AS total_off_invoice,
        CAST(SUM(COALESCE(t.total_off_invoice_ea,           0)) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
        CAST(SUM(COALESCE(t.uncon_and_relationship_accrual, 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
        CAST(SUM(COALESCE(t.listing_fees_accrual,           0)) AS DECIMAL(19, 4)) AS listing_fees_accrual,
        CAST(SUM(COALESCE(t.bill_back_lumpsum,              0)) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
        CAST(SUM(COALESCE(t.co_op_allowances_lumpsum,       0)) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
        CAST(SUM(COALESCE(t.exclusivity_allowance_lumpsum,  0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
        CAST(SUM(COALESCE(t.growth_incentives_lumpsum,      0)) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
        CAST(SUM(COALESCE(t.merchandising_lumpsum,          0)) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
        CAST(SUM(COALESCE(t.listing_fees_lumpsum,           0)) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
        CAST(SUM(COALESCE(t.uncon_and_relationship_lumpsum, 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
        CAST(SUM(COALESCE(t.trade_investments,              0)) AS DECIMAL(19, 4)) AS trade_investments,
        CAST(SUM(COALESCE(t.total_deductions,               0)) AS DECIMAL(19, 4)) AS total_deductions,
        CAST(SUM(COALESCE(t.co_op_allowances,               0)) AS DECIMAL(19, 4)) AS co_op_allowances,
        CAST(SUM(COALESCE(t.rebates,                        0)) AS DECIMAL(19, 4)) AS rebates,
        CAST(SUM(COALESCE(t.buying_group_vip_accrual,       0)) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
        CAST(SUM(COALESCE(t.buying_group_vip_lumpsum,       0)) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
        CAST(SUM(COALESCE(t.tma_event,                      0)) AS DECIMAL(19, 4)) AS tma_event,
        CAST(SUM(COALESCE(t.total_sales,                    0)) AS DECIMAL(19, 4)) AS total_sales,
        CAST(SUM(COALESCE(t.total_sales_ea,                 0)) AS DECIMAL(19, 4)) AS total_sales_ea,
        CAST(SUM(COALESCE(t.other_discounts,                0)) AS DECIMAL(19, 4)) AS other_discounts,
        CAST(SUM(COALESCE(t.tma_term,                       0)) AS DECIMAL(19, 4)) AS tma_term,
        CAST(SUM(COALESCE(t.total_trade,                    0)) AS DECIMAL(19, 4)) AS total_trade,
        CAST(SUM(COALESCE(t.cost_of_goods_sold,             0)) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
        CAST(SUM(COALESCE(t.net_sales,                      0)) AS DECIMAL(19, 4)) AS net_sales,
        CAST(SUM(COALESCE(t.cost_of_sales,                  0)) AS DECIMAL(19, 4)) AS cost_of_sales,
        CAST(SUM(COALESCE(t.gross_profit_standard,          0)) AS DECIMAL(19, 4)) AS gross_profit_standard,
        CAST(SUM(COALESCE(t.gross_contribution,             0)) AS DECIMAL(19, 4)) AS gross_contribution,
        CAST(SUM(COALESCE(t.gross_invoice_qty,              0)) AS DECIMAL(19, 4)) AS gross_invoice_qty,
        CAST(SUM(COALESCE(t.gross_invoice_qty_ea,           0)) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
        CAST(SUM(COALESCE(t.kilos,                          0)) AS DECIMAL(19, 4)) AS kilos,
        CAST(SUM(COALESCE(t.franchisee_revenue,             0)) AS DECIMAL(19, 4)) AS franchisee_revenue,
        CAST('CP-TMA' AS VARCHAR(20)) AS def 
    FROM
        (
            SELECT
                CAST(product_id AS VARCHAR(30)) AS product_id,
                CAST(company_id AS VARCHAR(30)) AS company_id,
                CAST(channel_id AS VARCHAR(30)) AS channel_id,
                CAST('N/A' AS VARCHAR(30)) AS channel_name,
                CAST('N/A' AS VARCHAR(30)) AS province_id,
                CAST(bill_date AS VARCHAR(30)) AS bill_date,
                CAST(unit_sold AS VARCHAR(30)) AS unit_sold,
                CAST(fiscal_week AS VARCHAR(30)) AS week,
                CAST(fiscal_period AS VARCHAR(30)) AS fiscal_period,
                CAST(currency AS VARCHAR(30)) AS currency,
                CAST(customer_id AS VARCHAR(30)) AS customer_id,
                CAST(sales_district AS VARCHAR(30)) AS sales_district,
                CAST(sales_district_name AS VARCHAR(30)) AS sales_district_name,
                CAST( - 1 AS VARCHAR(30)) AS plant,
                CAST( - 1 AS VARCHAR(30)) AS sales_center,
                CAST( - 1 AS VARCHAR(30)) AS route_id,
                CAST(ship_to AS VARCHAR(30)) AS ship_to,
                CAST(doc_number AS VARCHAR(30)) AS doc_number,
                CAST(offer_code AS VARCHAR(30)) AS offer_code,
                CAST('N/A' AS VARCHAR(30)) AS bill_num,
                CAST(doc_type AS VARCHAR(30)) AS bill_type,
                0 AS franchisee_revenue_id,
                0 AS commision_group_id,
                 - 1 AS tsm_id,
                'N/A' AS tsm_name,
                 - 1 AS rsm_id,
                'N/A' AS rsm_name,
                 - 1 AS depot_id,
                'N/A' AS depot_name,
                'N/A' AS io_name,
                'N/A' AS invoice_type,
                1 AS conversion_rate,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS price,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS net_invoice_price,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS porcentaje,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS gross_sales,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_returns,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_returns_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS ingredients,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS packaging,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS direct_labour,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS overhead,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_storage,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_freight,
                CAST(SUM(bill_back_accrual) AS DECIMAL(19, 4)) AS bill_back_accrual,
                CAST(SUM(co_op_allowances_accrual) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
                CAST(SUM(exclusivity_allowance_accrual) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
                CAST(SUM(growth_incentives_accrual) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
                CAST(SUM(merchandising_accrual) AS DECIMAL(19, 4)) AS merchandising_accrual,
                CAST(SUM(rebates_accrual) AS DECIMAL(19, 4)) AS rebates_accrual,
                CAST(SUM(rebates_lumpsum) AS DECIMAL(19, 4)) AS rebates_lumpsum,
                CAST(SUM(total_off_invoice) AS DECIMAL(19, 4)) AS total_off_invoice,
                CAST(SUM(total_off_invoice_ea) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
                CAST(SUM(uncon_and_relationship_accrual) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
                CAST(SUM(listing_fees_accrual) AS DECIMAL(19, 4)) AS listing_fees_accrual,
                CAST(SUM(bill_back_lumpsum) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
                CAST(SUM(co_op_allowances_lumpsum) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
                CAST(SUM(exclusivity_allowance_lumpsum) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
                CAST(SUM(growth_incentives_lumpsum) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
                CAST(SUM(merchandising_lumpsum) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
                CAST(SUM(listing_fees_lumpsum) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
                CAST(SUM(uncon_and_relationship_lumpsum) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
                CAST(SUM(((exclusivity_allowance_accrual + exclusivity_allowance_lumpsum) + (listing_fees_accrual + listing_fees_lumpsum) + (uncon_and_relationship_accrual + uncon_and_relationship_lumpsum) + (bill_back_accrual + bill_back_lumpsum) + (co_op_allowances_accrual + co_op_allowances_lumpsum) + (rebates_accrual) + (rebates_lumpsum) + (merchandising_accrual + merchandising_lumpsum) + (growth_incentives_accrual + growth_incentives_lumpsum) + (buying_group_vip_accrual + buying_group_vip_lumpsum)))AS DECIMAL(19, 4)) AS trade_investments,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_deductions,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS co_op_allowances,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS rebates,
                CAST(SUM(buying_group_vip_accrual) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
                CAST(SUM(buying_group_vip_lumpsum) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS tma_event,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_sales_ea,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS other_discounts,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS tma_term,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_trade,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS net_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS cost_of_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_profit_standard,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_contribution,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_invoice_qty,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS kilos,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS franchisee_revenue,
                'TMA' AS def 
            FROM
                gb_smntc_191_canada.t_tma_final 
            WHERE
                adjustment_flag = '1' 
                AND bill_date IN 
                (
                    SELECT
                        bill_date 
                    FROM
                        wrk_global.t_order_final_paso2_dsd 
                    WHERE
                        def = 'CP' 
                    GROUP BY 1
                )
            GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,
                15,16,17,18,19,20,21,22,23,24,25,26,27,28,29 
        ) t -- ISAIAS: VALIDAR DORMATO Y TIPO DE DATO.
        INNER JOIN
            cp_sys_calendar.calendar c 
            ON t.bill_date = c.calendar_date
        INNER JOIN
            gb_smntc_191_canada.u_bimbo_calendario bc 
            ON t.bill_date = bc.fechacal
    GROUP BY
        1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
        20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,92 ;




INSERT INTO
    gb_smntc_191_canada.t_order_final_dsd 
    SELECT
        cast(product_id as VARCHAR(18)),
        cast(company_id as VARCHAR(4)),
        cast(channel_id as VARCHAR(20)),
        cast(channel_name as VARCHAR(50)),
        cast(province_id as VARCHAR(20)),
        bill_date,
        CAST(dayofweek(bill_date) AS INT) AS dayofweek,
        CAST(
            CASE
                WHEN dayofweek(bill_date) = 1 THEN 4 
                WHEN dayofweek(bill_date) = 2 THEN 5 
                WHEN dayofweek(bill_date) = 3 THEN 6 
                WHEN dayofweek(bill_date) = 4 THEN 7 
                WHEN dayofweek(bill_date) = 5 THEN 1 
                WHEN dayofweek(bill_date) = 6 THEN 2 
                WHEN dayofweek(bill_date) = 7 THEN 3 
                ELSE dayofweek(bill_date) 
            END
        AS INT) AS day_of_bimboweek,
        cast(unit_sold as VARCHAR(3)),
        cast(week as  CHAR(6)),
        CAST(concat(TRIM(CAST(aniobimbo AS string)), TRIM(CAST(SemanaBimbo AS STRING))) AS CHAR(6)) AS BimboWeek,
        cast(fiscal_period as CHAR(7)),
        cast(currency as VARCHAR(5)),
        cast(customer_id as VARCHAR(10)),
        cast(sales_district as VARCHAR(6)),
        cast(sales_district_name as VARCHAR(50)),
        cast(plant as VARCHAR(4)),
        cast(sales_center as VARCHAR(40)),
        cast(route_id as VARCHAR(20)),
        cast(ship_to as VARCHAR(10)),
        cast(doc_number as VARCHAR(50)),
        cast(offer_code as VARCHAR(30)),
        cast(bill_num as VARCHAR(50)),
        cast(bill_type as VARCHAR(4)),
        franchisee_revenue_id,
        commision_group_id,
        tsm_id,
        cast(tsm_name as VARCHAR(100)),
        rsm_id,
        cast(rsm_name as VARCHAR(100)),
        depot_id,
        cast(depot_name as VARCHAR(100)),
        cast(io_name as VARCHAR(100)),
        cast(invoice_type as VARCHAR(100)),
        conversion_rate,
        price,
        net_invoice_price,
        perc,
        net_invoice_qty,
        net_invoice_qty_ea,
        gross_sales,
        gross_sales_ea,
        return_invoice_qty,
        return_invoice_qty_ea,
        total_returns,
        total_returns_ea,
        ingredients,
        packaging,
        direct_labour,
        overhead,
        total_storage,
        total_freight,
        bill_back_accrual,
        co_op_allowances_accrual,
        exclusivity_allowance_accrual,
        growth_incentives_accrual,
        merchandising_accrual,
        rebates_accrual,
        rebates_lumpsum,
        total_off_invoice,
        total_off_invoice_ea,
        uncon_and_relationship_accrual,
        listing_fees_accrual,
        bill_back_lumpsum,
        co_op_allowances_lumpsum,
        exclusivity_allowance_lumpsum,
        growth_incentives_lumpsum,
        merchandising_lumpsum,
        listing_fees_lumpsum,
        uncon_and_relationship_lumpsum,
        trade_investments,
        total_deductions,
        co_op_allowances,
        rebates,
        buying_group_vip_accrual,
        buying_group_vip_lumpsum,
        tma_event,
        total_sales,
        total_sales_ea,
        other_discounts,
        tma_term,
        total_trade,
        cost_of_goods_sold,
        net_sales,
        cost_of_sales,
        gross_profit_standard,
        gross_contribution,
        gross_invoice_qty,
        gross_invoice_qty_ea,
        kilos,
        franchisee_revenue,
        cast(def as VARCHAR(20))
--    FROM  wrk_global.t_order_final_paso_dsd o 
    FROM  wrk_global.t_order_final_paso_dsd_1 o  
      INNER JOIN
            gb_smntc_191_canada.u_bimbo_calendario c 
            ON o.bill_date = c.fechacal 
    WHERE def = 'ERP' ;


TRUNCATE TABLE wrk_global.t_order_final_paso2_dsd;

INSERT INTO
    wrk_global.t_order_final_paso2_dsd 
    SELECT
        CAST(t.product_id AS VARCHAR(18))                                          AS product_id,
        CAST(t.company_id AS VARCHAR(4))                                           AS company_id,
        CAST(t.channel_id AS VARCHAR(20))                                          AS channel_id,
        CAST(t.channel_name AS VARCHAR(50))                                        AS channel_name,
        CAST(t.province_id  AS VARCHAR(20))                                        AS province_id,
        t.bill_date,         --,CAST(T.Bill_Date AS DATE FORMAT 'YYYY-MM-DD') AS Bill_Date
        CAST(day_of_week AS INT) AS day_of_week,
        CAST(
            CASE
                WHEN CAST(day_of_week AS INT) = 1 THEN 4 
                WHEN CAST(day_of_week AS INT) = 2 THEN 5 
                WHEN CAST(day_of_week AS INT) = 3 THEN 6 
                WHEN CAST(day_of_week AS INT) = 4 THEN 7 
                WHEN CAST(day_of_week AS INT) = 5 THEN 1 
                WHEN CAST(day_of_week AS INT) = 6 THEN 2 
                WHEN CAST(day_of_week AS INT) = 7 THEN 3 
                ELSE CAST(day_of_week AS INT) 
            END
        AS INT)                                                                    AS day_of_bimboweek,
        CAST(t.unit_sold AS VARCHAR(3))                                            AS unit_sold,
        CAST(t.week AS CHAR(6))                                                    AS week,
        CAST(concat(TRIM(CAST(aniobimbo AS string)), TRIM(CAST(SemanaBimbo AS STRING))) AS CHAR(6)) AS BimboWeek,
        --,CAST(TRIM(TRIM(AnioBimbo)||TRIM(SemanaBimbo)) AS CHAR(6)) AS BimboWeek
        CAST(t.fiscal_period AS CHAR(7))                                           AS fiscal_period,
        CAST(t.currency AS VARCHAR(5))                                             AS currency,
        CAST(t.customer_id AS VARCHAR(10))                                         AS customer_id,
        CAST(t.sales_district AS VARCHAR(6))                                       AS sales_district,
        CAST(t.sales_district_name AS VARCHAR(50))                                 AS sales_district_name,
        CAST(t.plant AS VARCHAR(4))                                                AS plant,
        CAST(t.sales_center AS VARCHAR(40))                                        AS sales_center,
        CAST(t.route_id AS VARCHAR(20))                                            AS route_id,
        CAST(t.ship_to AS VARCHAR(10))                                             AS ship_to,
        CAST(t.doc_number AS VARCHAR(50))                                          AS doc_number,
        CAST(t.offer_code AS VARCHAR(30))                                          AS offer_code,
        CAST(t.bill_num AS VARCHAR(50))                                            AS bill_num,
        CAST(t.bill_type AS VARCHAR(4))                                            AS bill_type,
        CAST(t.franchisee_revenue_id AS INT)                                       AS franchisee_revenue_id,
        CAST(t.commision_group_id AS INT)                                          AS commision_group_id,
        t.tsm_id,
        CAST(t.tsm_name AS VARCHAR(100))                                           AS tsm_name,
        t.rsm_id,
        CAST(t.rsm_name AS VARCHAR(100))                                           AS rsm_name,
        t.depot_id,
        CAST(t.depot_name AS VARCHAR(100))                                         AS depot_name,
        CAST(t.io_name AS VARCHAR(100))                                            AS io_name,
        CAST(t.invoice_type AS VARCHAR(100))                                       AS invoice_type,
        CAST(t.conversion_rate AS DECIMAL(19,4))                                   AS conversion_rate,
        CAST(t.price AS DECIMAL(19,4))                                             AS price,
        CAST(t.net_invoice_price AS DECIMAL(19,4))                                 AS net_invoice_price,
        CAST(- 1 AS DECIMAL(19,4))                                                 AS Perc,
        CAST(SUM(COALESCE(t.net_invoice_qty,                0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
        CAST(SUM(COALESCE(t.net_invoice_qty_ea,             0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
        CAST(SUM(COALESCE(t.gross_sales,                    0)) AS DECIMAL(19, 4)) AS gross_sales,
        CAST(SUM(COALESCE(t.gross_sales_ea,                 0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
        CAST(SUM(COALESCE(t.return_invoice_qty,             0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
        CAST(SUM(COALESCE(t.return_invoice_qty_ea,          0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
        CAST(SUM(COALESCE(t.total_returns,                  0)) AS DECIMAL(19, 4)) AS total_returns,
        CAST(SUM(COALESCE(t.total_returns_ea,               0)) AS DECIMAL(19, 4)) AS total_returns_ea,
        CAST(SUM(COALESCE(t.ingredients,                    0)) AS DECIMAL(19, 4)) AS ingredients,
        CAST(SUM(COALESCE(t.packaging,                      0)) AS DECIMAL(19, 4)) AS packaging,
        CAST(SUM(COALESCE(t.direct_labour,                  0)) AS DECIMAL(19, 4)) AS direct_labour,
        CAST(SUM(COALESCE(t.overhead,                       0)) AS DECIMAL(19, 4)) AS overhead,
        CAST(SUM(COALESCE(t.total_storage,                  0)) AS DECIMAL(19, 4)) AS total_storage,
        CAST(SUM(COALESCE(t.total_freight,                  0)) AS DECIMAL(19, 4)) AS total_freight,
        CAST(SUM(COALESCE(t.bill_back_accrual,              0)) AS DECIMAL(19, 4)) AS bill_back_accrual,
        CAST(SUM(COALESCE(t.co_op_allowances_accrual,       0)) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
        CAST(SUM(COALESCE(t.exclusivity_allowance_accrual,  0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
        CAST(SUM(COALESCE(t.growth_incentives_accrual,      0)) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
        CAST(SUM(COALESCE(t.merchandising_accrual,          0)) AS DECIMAL(19, 4)) AS merchandising_accrual,
        CAST(SUM(COALESCE(t.rebates_accrual,                0)) AS DECIMAL(19, 4)) AS rebates_accrual,
        CAST(SUM(COALESCE(t.rebates_lumpsum,                0)) AS DECIMAL(19, 4)) AS rebates_lumpsum,
        CAST(SUM(COALESCE(t.total_off_invoice,              0)) AS DECIMAL(19, 4)) AS total_off_invoice,
        CAST(SUM(COALESCE(t.total_off_invoice_ea,           0)) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
        CAST(SUM(COALESCE(t.uncon_and_relationship_accrual, 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
        CAST(SUM(COALESCE(t.listing_fees_accrual,           0)) AS DECIMAL(19, 4)) AS listing_fees_accrual,
        CAST(SUM(COALESCE(t.bill_back_lumpsum,              0)) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
        CAST(SUM(COALESCE(t.co_op_allowances_lumpsum,       0)) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
        CAST(SUM(COALESCE(t.exclusivity_allowance_lumpsum,  0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
        CAST(SUM(COALESCE(t.growth_incentives_lumpsum,      0)) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
        CAST(SUM(COALESCE(t.merchandising_lumpsum,          0)) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
        CAST(SUM(COALESCE(t.listing_fees_lumpsum,           0)) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
        CAST(SUM(COALESCE(t.uncon_and_relationship_lumpsum, 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
        CAST(SUM(COALESCE(t.trade_investments,              0)) AS DECIMAL(19, 4)) AS trade_investments,
        CAST(SUM(COALESCE(t.total_deductions,               0)) AS DECIMAL(19, 4)) AS total_deductions,
        CAST(SUM(COALESCE(t.co_op_allowances,               0)) AS DECIMAL(19, 4)) AS co_op_allowances,
        CAST(SUM(COALESCE(t.rebates,                        0)) AS DECIMAL(19, 4)) AS rebates,
        CAST(SUM(COALESCE(t.buying_group_vip_accrual,       0)) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
        CAST(SUM(COALESCE(t.buying_group_vip_lumpsum,       0)) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
        CAST(SUM(COALESCE(t.tma_event,                      0)) AS DECIMAL(19, 4)) AS tma_event,
        CAST(SUM(COALESCE(t.total_sales,                    0)) AS DECIMAL(19, 4)) AS total_sales,
        CAST(SUM(COALESCE(t.total_sales_ea,                 0)) AS DECIMAL(19, 4)) AS total_sales_ea,
        CAST(SUM(COALESCE(t.other_discounts,                0)) AS DECIMAL(19, 4)) AS other_discounts,
        CAST(SUM(COALESCE(t.tma_term,                       0)) AS DECIMAL(19, 4)) AS tma_term,
        CAST(SUM(COALESCE(t.total_trade,                    0)) AS DECIMAL(19, 4)) AS total_trade,
        CAST(SUM(COALESCE(t.cost_of_goods_sold,             0)) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
        CAST(SUM(COALESCE(t.net_sales,                      0)) AS DECIMAL(19, 4)) AS net_sales,
        CAST(SUM(COALESCE(t.cost_of_sales,                  0)) AS DECIMAL(19, 4)) AS cost_of_sales,
        CAST(SUM(COALESCE(t.gross_profit_standard,          0)) AS DECIMAL(19, 4)) AS gross_profit_standard,
        CAST(SUM(COALESCE(t.gross_contribution,             0)) AS DECIMAL(19, 4)) AS gross_contribution,
        CAST(SUM(COALESCE(t.gross_invoice_qty,              0)) AS DECIMAL(19, 4)) AS gross_invoice_qty,
        CAST(SUM(COALESCE(t.gross_invoice_qty_ea,           0)) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
        CAST(SUM(COALESCE(t.kilos,                          0)) AS DECIMAL(19, 4)) AS kilos,
        CAST(SUM(COALESCE(t.franchisee_revenue,             0)) AS DECIMAL(19, 4)) AS franchisee_revenue,
        CAST('CP-TMA' AS VARCHAR(20)) AS def 
    FROM
        (
            SELECT
                CAST(x1.product_id AS VARCHAR(30)) AS product_id,
                CAST(x1.company_id AS VARCHAR(30)) AS company_id,
                CAST(x1.channel_id AS VARCHAR(30)) AS channel_id,
                CAST('N/A' AS VARCHAR(30)) AS channel_name,
                CAST('N/A' AS VARCHAR(30)) AS province_id,
                CAST(x1.bill_date AS VARCHAR(30)) AS bill_date,
                CAST(x1.unit_sold AS VARCHAR(30)) AS unit_sold,
                CAST(x1.fiscal_week AS VARCHAR(30)) AS week,
                CAST(x1.fiscal_period AS VARCHAR(30)) AS fiscal_period,
                CAST(x1.currency AS VARCHAR(30)) AS currency,
                CAST(x1.customer_id AS VARCHAR(30)) AS customer_id,
                CAST(x1.sales_district AS VARCHAR(30)) AS sales_district,
                CAST(x1.sales_district_name AS VARCHAR(30)) AS sales_district_name,
                CAST( - 1 AS VARCHAR(30)) AS plant,
                CAST( - 1 AS VARCHAR(30)) AS sales_center,
                CAST( - 1 AS VARCHAR(30)) AS route_id,
                CAST(x1.ship_to AS VARCHAR(30)) AS ship_to,
                CAST(x1.doc_number AS VARCHAR(30)) AS doc_number,
                CAST(x1.offer_code AS VARCHAR(30)) AS offer_code,
                CAST('N/A' AS VARCHAR(30)) AS bill_num,
                CAST(x1.doc_type AS VARCHAR(30)) AS bill_type,
                0 AS franchisee_revenue_id,
                0 AS commision_group_id,
                 - 1 AS tsm_id,
                'N/A' AS tsm_name,
                 - 1 AS rsm_id,
                'N/A' AS rsm_name,
                 - 1 AS depot_id,
                'N/A' AS depot_name,
                'N/A' AS io_name,
                'N/A' AS invoice_type,
                1 AS conversion_rate,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS price,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS net_invoice_price,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS porcentaje,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS gross_sales,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_returns,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_returns_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS ingredients,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS packaging,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS direct_labour,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS overhead,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_storage,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_freight,
                CAST(SUM(x1.bill_back_accrual) AS DECIMAL(19, 4)) AS bill_back_accrual,
                CAST(SUM(x1.co_op_allowances_accrual) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
                CAST(SUM(x1.exclusivity_allowance_accrual) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
                CAST(SUM(x1.growth_incentives_accrual) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
                CAST(SUM(x1.merchandising_accrual) AS DECIMAL(19, 4)) AS merchandising_accrual,
                CAST(SUM(x1.rebates_accrual) AS DECIMAL(19, 4)) AS rebates_accrual,
                CAST(SUM(x1.rebates_lumpsum) AS DECIMAL(19, 4)) AS rebates_lumpsum,
                CAST(SUM(x1.total_off_invoice) AS DECIMAL(19, 4)) AS total_off_invoice,
                CAST(SUM(x1.total_off_invoice_ea) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
                CAST(SUM(x1.uncon_and_relationship_accrual) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
                CAST(SUM(x1.listing_fees_accrual) AS DECIMAL(19, 4)) AS listing_fees_accrual,
                CAST(SUM(x1.bill_back_lumpsum) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
                CAST(SUM(x1.co_op_allowances_lumpsum) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
                CAST(SUM(x1.exclusivity_allowance_lumpsum) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
                CAST(SUM(x1.growth_incentives_lumpsum) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
                CAST(SUM(x1.merchandising_lumpsum) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
                CAST(SUM(x1.listing_fees_lumpsum) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
                CAST(SUM(x1.uncon_and_relationship_lumpsum) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
                CAST(SUM(((x1.exclusivity_allowance_accrual + x1.exclusivity_allowance_lumpsum) + (x1.listing_fees_accrual + x1.listing_fees_lumpsum) + (x1.uncon_and_relationship_accrual + x1.uncon_and_relationship_lumpsum) + (x1.bill_back_accrual + x1.bill_back_lumpsum) + (x1.co_op_allowances_accrual + x1.co_op_allowances_lumpsum) + (x1.rebates_accrual) + (x1.rebates_lumpsum) + (x1.merchandising_accrual + x1.merchandising_lumpsum) + (x1.growth_incentives_accrual + x1.growth_incentives_lumpsum) + (x1.buying_group_vip_accrual + x1.buying_group_vip_lumpsum)))AS DECIMAL(19, 4)) AS trade_investments,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_deductions,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS co_op_allowances,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS rebates,
                CAST(SUM(x1.buying_group_vip_accrual) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
                CAST(SUM(x1.buying_group_vip_lumpsum) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS tma_event,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_sales_ea,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS other_discounts,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS tma_term,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_trade,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS net_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS cost_of_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_profit_standard,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_contribution,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_invoice_qty,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS kilos,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS franchisee_revenue,
                'TMA' AS def 
            FROM
                gb_smntc_191_canada.t_tma_final x1,
                (
                    SELECT
                        product_id,
                        company_id,
                        bill_date,
                        customer_id,
                        sales_district,
                        doc_number,
                        bill_type 
                    FROM
                        gb_smntc_191_canada.t_order_final_dsd 
                    WHERE
                        def = 'CP-TMA' 
                        AND trade_investments <> 0 
                    GROUP BY 1,2,3,4,5,6,7 
                ) x2
            WHERE
                x1.adjustment_flag = '0' 
                AND x1.product_id = x2.product_id
                AND x1.company_id = x2.company_id
                AND x1.bill_date = x2.bill_date
                AND x1.customer_id = x2.customer_id
                AND x1.sales_district = x2.sales_district
                AND x1.doc_number = x2.doc_number
                AND x1.doc_type = x2.bill_type 
                AND x1.bill_date IN 
                (
                    SELECT
                        bill_date 
                    FROM
                        wrk_global.t_order_final_paso_dsd 
                    WHERE
                        def = 'CP' 
                    GROUP BY
                        1
                )
            GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,
                15,16,17,18,19,20,21,22,23,24,25,26,27,28,29 
        ) t 
        INNER JOIN
            cp_sys_calendar.calendar c 
            ON t.bill_date = c.calendar_date 
        INNER JOIN
            gb_smntc_191_canada.u_bimbo_calendario bc 
            ON t.bill_date = bc.fechacal 
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
        20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,92 ;


INSERT INTO
    gb_smntc_191_canada.t_order_final_dsd 
    SELECT
        t.product_id,
        t.company_id,
        t.channel_id,
        t.channel_name,
        t.province_id,
        t.bill_date,
        t.day_of_week,
        t.day_of_bimboweek,
        t.unit_sold,
        t.week,
        t.bimboweek,
        t.fiscal_period,
        t.currency,
        t.customer_id,
        t.sales_district,
        t.sales_district_name,
        t.plant,
        t.sales_center,
        t.route_id,
        t.ship_to,
        t.doc_number,
        t.offer_code,
        t.bill_num,
        t.bill_type,
        t.franchisee_revenue_id,
        t.commision_group_id,
        t.tsm_id,
        t.tsm_name,
        t.rsm_id,
        t.rsm_name,
        t.depot_id,
        t.depot_name,
        t.io_name,
        t.invoice_type,
        t.conversion_rate,
        t.price,
        t.net_invoice_price,
        t.perc,
        CAST(SUM(COALESCE(t.net_invoice_qty,                0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
        CAST(SUM(COALESCE(t.net_invoice_qty_ea,             0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
        CAST(SUM(COALESCE(t.gross_sales,                    0)) AS DECIMAL(19, 4)) AS gross_sales,
        CAST(SUM(COALESCE(t.gross_sales_ea,                 0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
        CAST(SUM(COALESCE(t.return_invoice_qty,             0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
        CAST(SUM(COALESCE(t.return_invoice_qty_ea,          0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
        CAST(SUM(COALESCE(t.total_returns,                  0)) AS DECIMAL(19, 4)) AS total_returns,
        CAST(SUM(COALESCE(t.total_returns_ea,               0)) AS DECIMAL(19, 4)) AS total_returns_ea,
        CAST(SUM(COALESCE(t.ingredients,                    0)) AS DECIMAL(19, 4)) AS ingredients,
        CAST(SUM(COALESCE(t.packaging,                      0)) AS DECIMAL(19, 4)) AS packaging,
        CAST(SUM(COALESCE(t.direct_labour,                  0)) AS DECIMAL(19, 4)) AS direct_labour,
        CAST(SUM(COALESCE(t.overhead,                       0)) AS DECIMAL(19, 4)) AS overhead,
        CAST(SUM(COALESCE(t.total_storage,                  0)) AS DECIMAL(19, 4)) AS total_storage,
        CAST(SUM(COALESCE(t.total_freight,                  0)) AS DECIMAL(19, 4)) AS total_freight,
        CAST(SUM(COALESCE(t.bill_back_accrual,              0)) AS DECIMAL(19, 4)) AS bill_back_accrual,
        CAST(SUM(COALESCE(t.co_op_allowances_accrual,       0)) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
        CAST(SUM(COALESCE(t.exclusivity_allowance_accrual,  0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
        CAST(SUM(COALESCE(t.growth_incentives_accrual,      0)) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
        CAST(SUM(COALESCE(t.merchandising_accrual,          0)) AS DECIMAL(19, 4)) AS merchandising_accrual,
        CAST(SUM(COALESCE(t.rebates_accrual,                0)) AS DECIMAL(19, 4)) AS rebates_accrual,
        CAST(SUM(COALESCE(t.rebates_lumpsum,                0)) AS DECIMAL(19, 4)) AS rebates_lumpsum,
        CAST(SUM(COALESCE(t.total_off_invoice,              0)) AS DECIMAL(19, 4)) AS total_off_invoice,
        CAST(SUM(COALESCE(t.total_off_invoice_ea,           0)) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
        CAST(SUM(COALESCE(t.uncon_and_relationship_accrual, 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
        CAST(SUM(COALESCE(t.listing_fees_accrual,           0)) AS DECIMAL(19, 4)) AS listing_fees_accrual,
        CAST(SUM(COALESCE(t.bill_back_lumpsum,              0)) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
        CAST(SUM(COALESCE(t.co_op_allowances_lumpsum,       0)) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
        CAST(SUM(COALESCE(t.exclusivity_allowance_lumpsum,  0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
        CAST(SUM(COALESCE(t.growth_incentives_lumpsum,      0)) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
        CAST(SUM(COALESCE(t.merchandising_lumpsum,          0)) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
        CAST(SUM(COALESCE(t.listing_fees_lumpsum,           0)) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
        CAST(SUM(COALESCE(t.uncon_and_relationship_lumpsum, 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
        CAST(SUM(COALESCE(t.trade_investments,              0)) AS DECIMAL(19, 4)) AS trade_investments,
        CAST(SUM(COALESCE(t.total_deductions,               0)) AS DECIMAL(19, 4)) AS total_deductions,
        CAST(SUM(COALESCE(t.co_op_allowances,               0)) AS DECIMAL(19, 4)) AS co_op_allowances,
        CAST(SUM(COALESCE(t.rebates,                        0)) AS DECIMAL(19, 4)) AS rebates,
        CAST(SUM(COALESCE(t.buying_group_vip_accrual,       0)) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
        CAST(SUM(COALESCE(t.buying_group_vip_lumpsum,       0)) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
        CAST(SUM(COALESCE(t.tma_event,                      0)) AS DECIMAL(19, 4)) AS tma_event,
        CAST(SUM(COALESCE(t.total_sales,                    0)) AS DECIMAL(19, 4)) AS total_sales,
        CAST(SUM(COALESCE(t.total_sales_ea,                 0)) AS DECIMAL(19, 4)) AS total_sales_ea,
        CAST(SUM(COALESCE(t.other_discounts,                0)) AS DECIMAL(19, 4)) AS other_discounts,
        CAST(SUM(COALESCE(t.tma_term,                       0)) AS DECIMAL(19, 4)) AS tma_term,
        CAST(SUM(COALESCE(t.total_trade,                    0)) AS DECIMAL(19, 4)) AS total_trade,
        CAST(SUM(COALESCE(t.cost_of_goods_sold,             0)) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
        CAST(SUM(COALESCE(t.net_sales,                      0)) AS DECIMAL(19, 4)) AS net_sales,
        CAST(SUM(COALESCE(t.cost_of_sales,                  0)) AS DECIMAL(19, 4)) AS cost_of_sales,
        CAST(SUM(COALESCE(t.gross_profit_standard,          0)) AS DECIMAL(19, 4)) AS gross_profit_standard,
        CAST(SUM(COALESCE(t.gross_contribution,             0)) AS DECIMAL(19, 4)) AS gross_contribution,
        CAST(SUM(COALESCE(t.gross_invoice_qty,              0)) AS DECIMAL(19, 4)) AS gross_invoice_qty,
        CAST(SUM(COALESCE(t.gross_invoice_qty_ea,           0)) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
        CAST(SUM(COALESCE(t.kilos,                          0)) AS DECIMAL(19, 4)) AS kilos,
        CAST(SUM(COALESCE(t.franchisee_revenue,             0)) AS DECIMAL(19, 4)) AS franchisee_revenue,
        CAST('CP-TMA' AS VARCHAR(20)) AS def 
    FROM
        wrk_global.t_order_final_paso2_dsd t 
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,
        19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,92;


     -- New Validation to ensure no differences between TMA and ORDERS

     --SET Paso = 8;
     --DELETE gb_smntc_191_canada.t_order_final_TMP ;


TRUNCATE TABLE wrk_global.t_order_final_TMP_dsd;
INSERT INTO
    wrk_global.t_order_final_tmp_dsd 
    SELECT
        CAST(t.product_id AS VARCHAR(18))                                          AS product_id,
        CAST(t.company_id AS VARCHAR(4))                                           AS company_id,
        CAST(t.channel_id AS VARCHAR(20))                                          AS channel_id,
        CAST(t.channel_name AS VARCHAR(50))                                        AS channel_name,
        CAST(t.province_id  AS VARCHAR(20))                                        AS province_id,
        t.bill_date,         --,CAST(T.Bill_Date AS DATE FORMAT 'YYYY-MM-DD') AS Bill_Date
        CAST(day_of_week AS INT) AS day_of_week,
        CAST(
            CASE
                WHEN CAST(day_of_week AS INT) = 1 THEN 4 
                WHEN CAST(day_of_week AS INT) = 2 THEN 5 
                WHEN CAST(day_of_week AS INT) = 3 THEN 6 
                WHEN CAST(day_of_week AS INT) = 4 THEN 7 
                WHEN CAST(day_of_week AS INT) = 5 THEN 1 
                WHEN CAST(day_of_week AS INT) = 6 THEN 2 
                WHEN CAST(day_of_week AS INT) = 7 THEN 3 
                ELSE CAST(day_of_week AS INT) 
            END
        AS INT) AS day_of_bimboweek,
        CAST(t.unit_sold AS VARCHAR(3))                                            AS unit_sold,
        CAST(t.week AS CHAR(6))                                                    AS week,
        CAST(concat(TRIM(CAST(aniobimbo AS string)), TRIM(CAST(SemanaBimbo AS STRING))) AS CHAR(6)) AS BimboWeek,
        --,CAST(TRIM(TRIM(AnioBimbo)||TRIM(SemanaBimbo)) AS CHAR(6)) AS BimboWeek
         CAST(t.fiscal_period AS CHAR(7))                                           AS fiscal_period,
        CAST(t.currency AS VARCHAR(5))                                             AS currency,
        CAST(t.customer_id AS VARCHAR(10))                                         AS customer_id,
        CAST(t.sales_district AS VARCHAR(6))                                       AS sales_district,
        CAST(t.sales_district_name AS VARCHAR(50))                                 AS sales_district_name,
        CAST(t.plant AS VARCHAR(4))                                                AS plant,
        CAST(t.sales_center AS VARCHAR(40))                                        AS sales_center,
        CAST(t.route_id AS VARCHAR(20))                                            AS route_id,
        CAST(t.ship_to AS VARCHAR(10))                                             AS ship_to,
        CAST(t.doc_number AS VARCHAR(50))                                          AS doc_number,
        CAST(t.offer_code AS VARCHAR(30))                                          AS offer_code,
        CAST(t.bill_num AS VARCHAR(50))                                            AS bill_num,
        CAST(t.bill_type AS VARCHAR(4))                                            AS bill_type,
        CAST(t.franchisee_revenue_id AS INT)                                       AS franchisee_revenue_id,
        CAST(t.commision_group_id AS INT)                                          AS commision_group_id,
        t.tsm_id,
        CAST(t.tsm_name AS VARCHAR(100))                                           AS tsm_name,
        t.rsm_id,
        CAST(t.rsm_name AS VARCHAR(100))                                           AS rsm_name,
        t.depot_id,
        CAST(t.depot_name AS VARCHAR(100))                                         AS depot_name,
        CAST(t.io_name AS VARCHAR(100))                                            AS io_name,
        CAST(t.invoice_type AS VARCHAR(100))                                       AS invoice_type,
        CAST(t.conversion_rate AS DECIMAL(19,4))                                   AS conversion_rate,
        CAST(t.price AS DECIMAL(19,4))                                             AS price,
        CAST(t.net_invoice_price AS DECIMAL(19,4))                                 AS net_invoice_price,
        CAST(- 1 AS DECIMAL(19,4))                                                 AS Perc,
        CAST(SUM(COALESCE(t.net_invoice_qty,                0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
        CAST(SUM(COALESCE(t.net_invoice_qty_ea,             0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
        CAST(SUM(COALESCE(t.gross_sales,                    0)) AS DECIMAL(19, 4)) AS gross_sales,
        CAST(SUM(COALESCE(t.gross_sales_ea,                 0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
        CAST(SUM(COALESCE(t.return_invoice_qty,             0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
        CAST(SUM(COALESCE(t.return_invoice_qty_ea,          0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
        CAST(SUM(COALESCE(t.total_returns,                  0)) AS DECIMAL(19, 4)) AS total_returns,
        CAST(SUM(COALESCE(t.total_returns_ea,               0)) AS DECIMAL(19, 4)) AS total_returns_ea,
        CAST(SUM(COALESCE(t.ingredients,                    0)) AS DECIMAL(19, 4)) AS ingredients,
        CAST(SUM(COALESCE(t.packaging,                      0)) AS DECIMAL(19, 4)) AS packaging,
        CAST(SUM(COALESCE(t.direct_labour,                  0)) AS DECIMAL(19, 4)) AS direct_labour,
        CAST(SUM(COALESCE(t.overhead,                       0)) AS DECIMAL(19, 4)) AS overhead,
        CAST(SUM(COALESCE(t.total_storage,                  0)) AS DECIMAL(19, 4)) AS total_storage,
        CAST(SUM(COALESCE(t.total_freight,                  0)) AS DECIMAL(19, 4)) AS total_freight,
        CAST(SUM(COALESCE(t.bill_back_accrual,              0)) AS DECIMAL(19, 4)) AS bill_back_accrual,
        CAST(SUM(COALESCE(t.co_op_allowances_accrual,       0)) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
        CAST(SUM(COALESCE(t.exclusivity_allowance_accrual,  0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
        CAST(SUM(COALESCE(t.growth_incentives_accrual,      0)) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
        CAST(SUM(COALESCE(t.merchandising_accrual,          0)) AS DECIMAL(19, 4)) AS merchandising_accrual,
        CAST(SUM(COALESCE(t.rebates_accrual,                0)) AS DECIMAL(19, 4)) AS rebates_accrual,
        CAST(SUM(COALESCE(t.rebates_lumpsum,                0)) AS DECIMAL(19, 4)) AS rebates_lumpsum,
        CAST(SUM(COALESCE(t.total_off_invoice,              0)) AS DECIMAL(19, 4)) AS total_off_invoice,
        CAST(SUM(COALESCE(t.total_off_invoice_ea,           0)) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
        CAST(SUM(COALESCE(t.uncon_and_relationship_accrual, 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
        CAST(SUM(COALESCE(t.listing_fees_accrual,           0)) AS DECIMAL(19, 4)) AS listing_fees_accrual,
        CAST(SUM(COALESCE(t.bill_back_lumpsum,              0)) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
        CAST(SUM(COALESCE(t.co_op_allowances_lumpsum,       0)) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
        CAST(SUM(COALESCE(t.exclusivity_allowance_lumpsum,  0)) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
        CAST(SUM(COALESCE(t.growth_incentives_lumpsum,      0)) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
        CAST(SUM(COALESCE(t.merchandising_lumpsum,          0)) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
        CAST(SUM(COALESCE(t.listing_fees_lumpsum,           0)) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
        CAST(SUM(COALESCE(t.uncon_and_relationship_lumpsum, 0)) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
        CAST(SUM(COALESCE(t.trade_investments,              0)) AS DECIMAL(19, 4)) AS trade_investments,
        CAST(SUM(COALESCE(t.total_deductions,               0)) AS DECIMAL(19, 4)) AS total_deductions,
        CAST(SUM(COALESCE(t.co_op_allowances,               0)) AS DECIMAL(19, 4)) AS co_op_allowances,
        CAST(SUM(COALESCE(t.rebates,                        0)) AS DECIMAL(19, 4)) AS rebates,
        CAST(SUM(COALESCE(t.buying_group_vip_accrual,       0)) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
        CAST(SUM(COALESCE(t.buying_group_vip_lumpsum,       0)) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
        CAST(SUM(COALESCE(t.tma_event,                      0)) AS DECIMAL(19, 4)) AS tma_event,
        CAST(SUM(COALESCE(t.total_sales,                    0)) AS DECIMAL(19, 4)) AS total_sales,
        CAST(SUM(COALESCE(t.total_sales_ea,                 0)) AS DECIMAL(19, 4)) AS total_sales_ea,
        CAST(SUM(COALESCE(t.other_discounts,                0)) AS DECIMAL(19, 4)) AS other_discounts,
        CAST(SUM(COALESCE(t.tma_term,                       0)) AS DECIMAL(19, 4)) AS tma_term,
        CAST(SUM(COALESCE(t.total_trade,                    0)) AS DECIMAL(19, 4)) AS total_trade,
        CAST(SUM(COALESCE(t.cost_of_goods_sold,             0)) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
        CAST(SUM(COALESCE(t.net_sales,                      0)) AS DECIMAL(19, 4)) AS net_sales,
        CAST(SUM(COALESCE(t.cost_of_sales,                  0)) AS DECIMAL(19, 4)) AS cost_of_sales,
        CAST(SUM(COALESCE(t.gross_profit_standard,          0)) AS DECIMAL(19, 4)) AS gross_profit_standard,
        CAST(SUM(COALESCE(t.gross_contribution,             0)) AS DECIMAL(19, 4)) AS gross_contribution,
        CAST(SUM(COALESCE(t.gross_invoice_qty,              0)) AS DECIMAL(19, 4)) AS gross_invoice_qty,
        CAST(SUM(COALESCE(t.gross_invoice_qty_ea,           0)) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
        CAST(SUM(COALESCE(t.kilos,                          0)) AS DECIMAL(19, 4)) AS kilos,
        CAST(SUM(COALESCE(t.franchisee_revenue,             0)) AS DECIMAL(19, 4)) AS franchisee_revenue,
        CAST('CP-TMA' AS VARCHAR(20)) AS def 
    FROM
        (
            SELECT
                CAST(product_id AS VARCHAR(30)) AS product_id,
                CAST(company_id AS VARCHAR(30)) AS company_id,
                CAST(channel_id AS VARCHAR(30)) AS channel_id,
                CAST('N/A' AS VARCHAR(30)) AS channel_name,
                CAST('N/A' AS VARCHAR(30)) AS province_id,
                CAST(bill_date AS VARCHAR(30)) AS bill_date,
                CAST(unit_sold AS VARCHAR(30)) AS unit_sold,
                CAST(fiscal_week AS VARCHAR(30)) AS week,
                CAST(fiscal_period AS VARCHAR(30)) AS fiscal_period,
                CAST(currency AS VARCHAR(30)) AS currency,
                CAST(customer_id AS VARCHAR(30)) AS customer_id,
                CAST(sales_district AS VARCHAR(30)) AS sales_district,
                CAST(sales_district_name AS VARCHAR(30)) AS sales_district_name,
                CAST( - 1 AS VARCHAR(30)) AS plant,
                CAST( - 1 AS VARCHAR(30)) AS sales_center,
                CAST( - 1 AS VARCHAR(30)) AS route_id,
                CAST(ship_to AS VARCHAR(30)) AS ship_to,
                CAST(doc_number AS VARCHAR(30)) AS doc_number,
                CAST(offer_code AS VARCHAR(30)) AS offer_code,
                CAST('N/A' AS VARCHAR(30)) AS bill_num,
                CAST(doc_type AS VARCHAR(30)) AS bill_type,
                0 AS franchisee_revenue_id,
                0 AS commision_group_id,
                 - 1 AS tsm_id,
                'N/A' AS tsm_name,
                 - 1 AS rsm_id,
                'N/A' AS rsm_name,
                 - 1 AS depot_id,
                'N/A' AS depot_name,
                'N/A' AS io_name,
                'N/A' AS invoice_type,
                1 AS conversion_rate,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS price,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS net_invoice_price,
                CAST(zeroifnull(0) AS DECIMAL(19, 4)) AS porcentaje,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS gross_sales,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_returns,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_returns_ea,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS ingredients,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS packaging,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS direct_labour,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS overhead,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_storage,
                CAST(zeroifnull(SUM(0)) AS DECIMAL(19, 4)) AS total_freight,
                CAST(SUM(bill_back_accrual) AS DECIMAL(19, 4)) AS bill_back_accrual,
                CAST(SUM(co_op_allowances_accrual) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
                CAST(SUM(exclusivity_allowance_accrual) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
                CAST(SUM(growth_incentives_accrual) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
                CAST(SUM(merchandising_accrual) AS DECIMAL(19, 4)) AS merchandising_accrual,
                CAST(SUM(rebates_accrual) AS DECIMAL(19, 4)) AS rebates_accrual,
                CAST(SUM(rebates_lumpsum) AS DECIMAL(19, 4)) AS rebates_lumpsum,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_off_invoice,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
                CAST(SUM(uncon_and_relationship_accrual) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
                CAST(SUM(listing_fees_accrual) AS DECIMAL(19, 4)) AS listing_fees_accrual,
                CAST(SUM(bill_back_lumpsum) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
                CAST(SUM(co_op_allowances_lumpsum) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
                CAST(SUM(exclusivity_allowance_lumpsum) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
                CAST(SUM(growth_incentives_lumpsum) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
                CAST(SUM(merchandising_lumpsum) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
                CAST(SUM(listing_fees_lumpsum) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
                CAST(SUM(uncon_and_relationship_lumpsum) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
                CAST(SUM(((exclusivity_allowance_accrual + exclusivity_allowance_lumpsum) + (listing_fees_accrual + listing_fees_lumpsum) + (uncon_and_relationship_accrual + uncon_and_relationship_lumpsum) + (bill_back_accrual + bill_back_lumpsum) + (co_op_allowances_accrual + co_op_allowances_lumpsum) + (rebates_accrual) + (rebates_lumpsum) + (merchandising_accrual + merchandising_lumpsum) + (growth_incentives_accrual + growth_incentives_lumpsum) + (buying_group_vip_accrual + buying_group_vip_lumpsum)))AS DECIMAL(19, 4)) AS trade_investments,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_deductions,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS co_op_allowances,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS rebates,
                CAST(SUM(buying_group_vip_accrual) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
                CAST(SUM(buying_group_vip_lumpsum) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS tma_event,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_sales_ea,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS other_discounts,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS tma_term,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS total_trade,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS net_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS cost_of_sales,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_profit_standard,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_contribution,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_invoice_qty,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS kilos,
                CAST(SUM(0) AS DECIMAL(19, 4)) AS franchisee_revenue,
                'TMA' AS def 
            FROM
                gb_smntc_191_canada.t_tma_final 
            WHERE
                fiscal_period IN 
                (
                    SELECT
                        MAX(fiscal_period) 
                    FROM
                        gb_smntc_191_canada.t_order_final_dsd 
                    WHERE
                        def = 'CP-TMA'
                )
            GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,
                15,16,17,18,19,20,21,22,23,24,25,26,27,28,29 
        )
        t 
        INNER JOIN
            cp_sys_calendar.calendar c 
            ON t.bill_date = c.calendar_date 
        INNER JOIN
            gb_smntc_191_canada.u_bimbo_calendario bc 
            ON t.bill_date = bc.fechacal 
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,
        19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,92;

TRUNCATE TABLE wrk_global.t_order_final_paso2_dsd;

INSERT INTO
    wrk_global.t_order_final_paso2_dsd 
    SELECT
        t.product_id,
        t.company_id,
        t.channel_id,
        t.channel_name,
        t.province_id,
        t.bill_date,
        t.day_of_week,
        t.day_of_bimboweek,
        t.unit_sold,
        t.week,
        t.bimboweek,
        t.fiscal_period,
        t.currency,
        t.customer_id,
        t.sales_district,
        t.sales_district_name,
        t.plant,
        t.sales_center,
        t.route_id,
        t.ship_to,
        t.doc_number,
        t.offer_code,
        t.bill_num,
        t.bill_type,
        t.franchisee_revenue_id,
        t.commision_group_id,
        t.tsm_id,
        t.tsm_name,
        t.rsm_id,
        t.rsm_name,
        t.depot_id,
        t.depot_name,
        t.io_name,
        t.invoice_type,
        t.conversion_rate,
        t.price,
        t.net_invoice_price,
        t.perc,
        CAST(SUM(COALESCE(t.net_invoice_qty,             0)) AS DECIMAL(19, 4)) AS net_invoice_qty,
        CAST(SUM(COALESCE(t.net_invoice_qty_ea,          0)) AS DECIMAL(19, 4)) AS net_invoice_qty_ea,
        CAST(SUM(COALESCE(t.gross_sales,                 0)) AS DECIMAL(19, 4)) AS gross_sales,
        CAST(SUM(COALESCE(t.gross_sales_ea,              0)) AS DECIMAL(19, 4)) AS gross_sales_ea,
        CAST(SUM(COALESCE(t.return_invoice_qty,          0)) AS DECIMAL(19, 4)) AS return_invoice_qty,
        CAST(SUM(COALESCE(t.return_invoice_qty_ea,       0)) AS DECIMAL(19, 4)) AS return_invoice_qty_ea,
        CAST(SUM(COALESCE(t.total_returns,               0)) AS DECIMAL(19, 4)) AS total_returns,
        CAST(SUM(COALESCE(t.total_returns_ea,            0)) AS DECIMAL(19, 4)) AS total_returns_ea,
        CAST(SUM(COALESCE(t.ingredients,                 0)) AS DECIMAL(19, 4)) AS ingredients,
        CAST(SUM(COALESCE(t.packaging,                   0)) AS DECIMAL(19, 4)) AS packaging,
        CAST(SUM(COALESCE(t.direct_labour,               0)) AS DECIMAL(19, 4)) AS direct_labour,
        CAST(SUM(COALESCE(t.overhead,                    0)) AS DECIMAL(19, 4)) AS overhead,
        CAST(SUM(COALESCE(t.total_storage,               0)) AS DECIMAL(19, 4)) AS total_storage,
        CAST(SUM(COALESCE(t.total_freight,               0)) AS DECIMAL(19, 4)) AS total_freight,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS bill_back_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS co_op_allowances_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS exclusivity_allowance_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS growth_incentives_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS merchandising_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS rebates_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS rebates_lumpsum,
        CAST(SUM(COALESCE(t.total_off_invoice,           0)) AS DECIMAL(19, 4)) AS total_off_invoice,
        CAST(SUM(COALESCE(t.total_off_invoice_ea,        0)) AS DECIMAL(19, 4)) AS total_off_invoice_ea,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS uncon_and_relationship_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS listing_fees_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS bill_back_lumpsum,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS co_op_allowances_lumpsum,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS exclusivity_allowance_lumpsum,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS growth_incentives_lumpsum,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS merchandising_lumpsum,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS listing_fees_lumpsum,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS uncon_and_relationship_lumpsum,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS trade_investments,
        CAST(SUM(COALESCE(t.total_deductions,            0)) AS DECIMAL(19, 4)) AS total_deductions,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS co_op_allowances,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS rebates,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS buying_group_vip_accrual,
        CAST(SUM(0) AS DECIMAL(19, 4)) AS buying_group_vip_lumpsum,
        CAST(SUM(COALESCE(t.tma_event,                   0)) AS DECIMAL(19, 4)) AS tma_event,
        CAST(SUM(COALESCE(t.total_sales,                 0)) AS DECIMAL(19, 4)) AS total_sales,
        CAST(SUM(COALESCE(t.total_sales_ea,              0)) AS DECIMAL(19, 4)) AS total_sales_ea,
        CAST(SUM(COALESCE(t.other_discounts,             0)) AS DECIMAL(19, 4)) AS other_discounts,
        CAST(SUM(COALESCE(t.tma_term,                    0)) AS DECIMAL(19, 4)) AS tma_term,
        CAST(SUM(COALESCE(t.total_trade,                 0)) AS DECIMAL(19, 4)) AS total_trade,
        CAST(SUM(COALESCE(t.cost_of_goods_sold,          0)) AS DECIMAL(19, 4)) AS cost_of_goods_sold,
        CAST(SUM(COALESCE(t.net_sales,                   0)) AS DECIMAL(19, 4)) AS net_sales,
        CAST(SUM(COALESCE(t.cost_of_sales,               0)) AS DECIMAL(19, 4)) AS cost_of_sales,
        CAST(SUM(COALESCE(t.gross_profit_standard,       0)) AS DECIMAL(19, 4)) AS gross_profit_standard,
        CAST(SUM(COALESCE(t.gross_contribution,          0)) AS DECIMAL(19, 4)) AS gross_contribution,
        CAST(SUM(COALESCE(t.gross_invoice_qty,           0)) AS DECIMAL(19, 4)) AS gross_invoice_qty,
        CAST(SUM(COALESCE(t.gross_invoice_qty_ea,        0)) AS DECIMAL(19, 4)) AS gross_invoice_qty_ea,
        CAST(SUM(COALESCE(t.kilos,                       0)) AS DECIMAL(19, 4)) AS kilos,
        CAST(SUM(COALESCE(t.franchisee_revenue,          0)) AS DECIMAL(19, 4)) AS franchisee_revenue,
        CAST('CP-TMA' AS VARCHAR(20)) AS def 
    FROM
        gb_smntc_191_canada.t_order_final_dsd t 
    WHERE
        t.fiscal_period IN 
        (
            SELECT
                MAX(fiscal_period) 
            FROM
                gb_smntc_191_canada.t_order_final_dsd 
            WHERE
                def = 'CP-TMA'
        )
        AND t.def = 'CP-TMA' 
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,
        19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,92;



     --DELETE gb_smntc_191_canada.t_order_final
     --WHERE DEF = 'CP-TMA'
     --AND FISCAL_PERIOD IN (SELECT MAX(FISCAL_PERIOD) FROM wrk_global.t_order_final_paso2 WHERE DEF = 'CP-TMA')
     --;


INSERT overwrite TABLE gb_smntc_191_canada.t_order_final_dsd 
SELECT * 
FROM gb_smntc_191_canada.t_order_final_dsd a 
WHERE a.def <> 'CP-TMA' 
    AND fiscal_period NOT IN 
    (
        SELECT
            MAX(fiscal_period) 
        FROM
            wrk_global.t_order_final_paso2_dsd 
        WHERE
            def = 'CP-TMA'
    );


INSERT INTO
    gb_smntc_191_canada.t_order_final_dsd 
    SELECT
        t.product_id,
        t.company_id,
        t.channel_id,
        t.channel_name,
        t.province_id,
        t.bill_date,
        t.day_of_week,
        t.day_of_bimboweek,
        t.unit_sold,
        t.week,
        t.bimboweek,
        t.fiscal_period,
        t.currency,
        t.customer_id,
        t.sales_district,
        t.sales_district_name,
        t.plant,
        t.sales_center,
        t.route_id,
        t.ship_to,
        t.doc_number,
        t.offer_code,
        t.bill_num,
        t.bill_type,
        t.franchisee_revenue_id,
        t.commision_group_id,
        t.tsm_id,
        t.tsm_name,
        t.rsm_id,
        t.rsm_name,
        t.depot_id,
        t.depot_name,
        t.io_name,
        t.invoice_type,
        t.conversion_rate,
        t.price,
        t.net_invoice_price,
        t.perc,
        CAST(SUM(t.net_invoice_qty )                AS DECIMAL(19,4))  AS net_invoice_qty,
        CAST(SUM(t.net_invoice_qty_ea )             AS DECIMAL(19,4))  AS net_invoice_qty_ea,
        CAST(SUM(t.gross_sales )                    AS DECIMAL(19,4))  AS gross_sales,
        CAST(SUM(t.gross_sales_ea )                 AS DECIMAL(19,4))  AS gross_sales_ea,
        CAST(SUM(t.return_invoice_qty )             AS DECIMAL(19,4))  AS return_invoice_qty,
        CAST(SUM(t.return_invoice_qty_ea )          AS DECIMAL(19,4))  AS return_invoice_qty_ea,
        CAST(SUM(t.total_returns )                  AS DECIMAL(19,4))  AS total_returns,
        CAST(SUM(t.total_returns_ea )               AS DECIMAL(19,4))  AS total_returns_ea,
        CAST(SUM(t.ingredients )                    AS DECIMAL(19,4))  AS ingredients,
        CAST(SUM(t.packaging )                      AS DECIMAL(19,4))  AS packaging,
        CAST(SUM(t.direct_labour )                  AS DECIMAL(19,4))  AS direct_labour,
        CAST(SUM(t.overhead )                       AS DECIMAL(19,4))  AS overhead,
        CAST(SUM(t.total_storage )                  AS DECIMAL(19,4))  AS total_storage,
        CAST(SUM(t.total_freight )                  AS DECIMAL(19,4))  AS total_freight,
        CAST(SUM(t.bill_back_accrual )              AS DECIMAL(19,4))  AS bill_back_accrual,
        CAST(SUM(t.co_op_allowances_accrual )       AS DECIMAL(19,4))  AS co_op_allowances_accrual,
        CAST(SUM(t.exclusivity_allowance_accrual )  AS DECIMAL(19,4))  AS exclusivity_allowance_accrual,
        CAST(SUM(t.growth_incentives_accrual )      AS DECIMAL(19,4))  AS growth_incentives_accrual,
        CAST(SUM(t.merchandising_accrual )          AS DECIMAL(19,4))  AS merchandising_accrual,
        CAST(SUM(t.rebates_accrual )                AS DECIMAL(19,4))  AS rebates_accrual,
        CAST(SUM(t.rebates_lumpsum )                AS DECIMAL(19,4))  AS rebates_lumpsum,
        CAST(SUM(t.total_off_invoice )              AS DECIMAL(19,4))  AS total_off_invoice,
        CAST(SUM(t.total_off_invoice_ea )           AS DECIMAL(19,4))  AS total_off_invoice_ea,
        CAST(SUM(t.uncon_and_relationship_accrual ) AS DECIMAL(19,4))  AS uncon_and_relationship_accrual,
        CAST(SUM(t.listing_fees_accrual )           AS DECIMAL(19,4))  AS listing_fees_accrual,
        CAST(SUM(t.bill_back_lumpsum )              AS DECIMAL(19,4))  AS bill_back_lumpsum,
        CAST(SUM(t.co_op_allowances_lumpsum )       AS DECIMAL(19,4))  AS co_op_allowances_lumpsum,
        CAST(SUM(t.exclusivity_allowance_lumpsum )  AS DECIMAL(19,4))  AS exclusivity_allowance_lumpsum,
        CAST(SUM(t.growth_incentives_lumpsum )      AS DECIMAL(19,4))  AS growth_incentives_lumpsum,
        CAST(SUM(t.merchandising_lumpsum )          AS DECIMAL(19,4))  AS merchandising_lumpsum,
        CAST(SUM(t.listing_fees_lumpsum )           AS DECIMAL(19,4))  AS listing_fees_lumpsum,
        CAST(SUM(t.uncon_and_relationship_lumpsum ) AS DECIMAL(19,4))  AS uncon_and_relationship_lumpsum,
        CAST(SUM(t.trade_investments )              AS DECIMAL(19,4))  AS trade_investments,
        CAST(SUM(t.total_deductions )               AS DECIMAL(19,4))  AS total_deductions,
        CAST(SUM(t.co_op_allowances )               AS DECIMAL(19,4))  AS co_op_allowances,
        CAST(SUM(t.rebates )                        AS DECIMAL(19,4))  AS rebates,
        CAST(SUM(t.buying_group_vip_accrual )       AS DECIMAL(19,4))  AS buying_group_vip_accrual,
        CAST(SUM(t.buying_group_vip_lumpsum )       AS DECIMAL(19,4))  AS buying_group_vip_lumpsum,
        CAST(SUM(t.tma_event )                      AS DECIMAL(19,4))  AS tma_event,
        CAST(SUM(t.total_sales )                    AS DECIMAL(19,4))  AS total_sales,
        CAST(SUM(t.total_sales_ea )                 AS DECIMAL(19,4))  AS total_sales_ea,
        CAST(SUM(t.other_discounts )                AS DECIMAL(19,4))  AS other_discounts,
        CAST(SUM(t.tma_term )                       AS DECIMAL(19,4))  AS tma_term,
        CAST(SUM(t.total_trade )                    AS DECIMAL(19,4))  AS total_trade,
        CAST(SUM(t.cost_of_goods_sold )             AS DECIMAL(19,4))  AS cost_of_goods_sold,
        CAST(SUM(t.net_sales )                      AS DECIMAL(19,4))  AS net_sales,
        CAST(SUM(t.cost_of_sales )                  AS DECIMAL(19,4))  AS cost_of_sales,
        CAST(SUM(t.gross_profit_standard )          AS DECIMAL(19,4))  AS gross_profit_standard,
        CAST(SUM(t.gross_contribution )             AS DECIMAL(19,4))  AS gross_contribution,
        CAST(SUM(t.gross_invoice_qty )              AS DECIMAL(19,4))  AS gross_invoice_qty,
        CAST(SUM(t.gross_invoice_qty_ea )           AS DECIMAL(19,4))  AS gross_invoice_qty_ea,
        CAST(SUM(t.kilos )                          AS DECIMAL(19,4))  AS kilos,
        CAST(SUM(t.franchisee_revenue )             AS DECIMAL(19,4))  AS franchisee_revenue,
        CAST('CP-TMA' AS VARCHAR(20)) AS def 
    FROM
        (
            SELECT
                t.product_id,
                t.company_id,
                t.channel_id,
                t.channel_name,
                t.province_id,
                t.bill_date,
                t.day_of_week,
                t.day_of_bimboweek,
                t.unit_sold,
                t.week,
                t.bimboweek,
                t.fiscal_period,
                t.currency,
                t.customer_id,
                t.sales_district,
                t.sales_district_name,
                t.plant,
                t.sales_center,
                t.route_id,
                t.ship_to,
                t.doc_number,
                t.offer_code,
                t.bill_num,
                t.bill_type,
                t.franchisee_revenue_id,
                t.commision_group_id,
                t.tsm_id,
                t.tsm_name,
                t.rsm_id,
                t.rsm_name,
                t.depot_id,
                t.depot_name,
                t.io_name,
                t.invoice_type,
                t.conversion_rate,
                t.price,
                t.net_invoice_price,
                t.perc,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS net_invoice_qty,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS net_invoice_qty_ea,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS gross_sales,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS gross_sales_ea,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS return_invoice_qty,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS return_invoice_qty_ea,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_returns,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_returns_ea,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS ingredients,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS packaging,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS direct_labour,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS overhead,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_storage,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_freight,
                CAST((COALESCE(t.bill_back_accrual , 0)) AS DECIMAL(20, 2)) AS bill_back_accrual,
                CAST((COALESCE(t.co_op_allowances_accrual , 0)) AS DECIMAL(20, 2)) AS co_op_allowances_accrual,
                CAST((COALESCE(t.exclusivity_allowance_accrual , 0)) AS DECIMAL(20, 2)) AS exclusivity_allowance_accrual,
                CAST((COALESCE(t.growth_incentives_accrual , 0)) AS DECIMAL(20, 2)) AS growth_incentives_accrual,
                CAST((COALESCE(t.merchandising_accrual , 0)) AS DECIMAL(20, 2)) AS merchandising_accrual,
                CAST((COALESCE(t.rebates_accrual , 0)) AS DECIMAL(20, 2)) AS rebates_accrual,
                CAST((COALESCE(t.rebates_lumpsum , 0)) AS DECIMAL(20, 2)) AS rebates_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_off_invoice,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_off_invoice_ea,
                CAST((COALESCE(t.uncon_and_relationship_accrual , 0)) AS DECIMAL(20, 2)) AS uncon_and_relationship_accrual,
                CAST((COALESCE(t.listing_fees_accrual , 0)) AS DECIMAL(20, 2)) AS listing_fees_accrual,
                CAST((COALESCE(t.bill_back_lumpsum , 0)) AS DECIMAL(20, 2)) AS bill_back_lumpsum,
                CAST((COALESCE(t.co_op_allowances_lumpsum , 0)) AS DECIMAL(20, 2)) AS co_op_allowances_lumpsum,
                CAST((COALESCE(t.exclusivity_allowance_lumpsum , 0)) AS DECIMAL(20, 2)) AS exclusivity_allowance_lumpsum,
                CAST((COALESCE(t.growth_incentives_lumpsum , 0)) AS DECIMAL(20, 2)) AS growth_incentives_lumpsum,
                CAST((COALESCE(t.merchandising_lumpsum , 0)) AS DECIMAL(20, 2)) AS merchandising_lumpsum,
                CAST((COALESCE(t.listing_fees_lumpsum , 0)) AS DECIMAL(20, 2)) AS listing_fees_lumpsum,
                CAST((COALESCE(t.uncon_and_relationship_lumpsum , 0)) AS DECIMAL(20, 2)) AS uncon_and_relationship_lumpsum,
                CAST((COALESCE(t.trade_investments , 0)) AS DECIMAL(20, 2)) AS trade_investments,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_deductions,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS co_op_allowances,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS rebates,
                CAST((COALESCE(t.buying_group_vip_accrual , 0)) AS DECIMAL(20, 2)) AS buying_group_vip_accrual,
                CAST((COALESCE(t.buying_group_vip_lumpsum , 0)) AS DECIMAL(20, 2)) AS buying_group_vip_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS tma_event,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_sales,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_sales_ea,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS other_discounts,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS tma_term,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS total_trade,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS cost_of_goods_sold,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS net_sales,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS cost_of_sales,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS gross_profit_standard,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS gross_contribution,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS gross_invoice_qty,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS gross_invoice_qty_ea,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS kilos,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS franchisee_revenue,
                'CP' AS def 
            FROM
                wrk_global.t_order_final_tmp_dsd t 
            UNION ALL
            SELECT
                t.product_id,
                t.company_id,
                t.channel_id,
                t.channel_name,
                t.province_id,
                t.bill_date,
                t.day_of_week,
                t.day_of_bimboweek,
                t.unit_sold,
                t.week,
                t.bimboweek,
                t.fiscal_period,
                t.currency,
                t.customer_id,
                t.sales_district,
                t.sales_district_name,
                t.plant,
                t.sales_center,
                t.route_id,
                t.ship_to,
                t.doc_number,
                t.offer_code,
                t.bill_num,
                t.bill_type,
                t.franchisee_revenue_id,
                t.commision_group_id,
                t.tsm_id,
                t.tsm_name,
                t.rsm_id,
                t.rsm_name,
                t.depot_id,
                t.depot_name,
                t.io_name,
                t.invoice_type,
                t.conversion_rate,
                t.price,
                t.net_invoice_price,
                t.perc,
                CAST((COALESCE(t.net_invoice_qty , 0)) AS DECIMAL(20, 2)) AS net_invoice_qty,
                CAST((COALESCE(t.net_invoice_qty_ea , 0)) AS DECIMAL(20, 2)) AS net_invoice_qty_ea,
                CAST((COALESCE(t.gross_sales , 0)) AS DECIMAL(20, 2)) AS gross_sales,
                CAST((COALESCE(t.gross_sales_ea , 0)) AS DECIMAL(20, 2)) AS gross_sales_ea,
                CAST((COALESCE(t.return_invoice_qty , 0)) AS DECIMAL(20, 2)) AS return_invoice_qty,
                CAST((COALESCE(t.return_invoice_qty_ea , 0)) AS DECIMAL(20, 2)) AS return_invoice_qty_ea,
                CAST((COALESCE(t.total_returns , 0)) AS DECIMAL(20, 2)) AS total_returns,
                CAST((COALESCE(t.total_returns_ea , 0)) AS DECIMAL(20, 2)) AS total_returns_ea,
                CAST((COALESCE(t.ingredients , 0)) AS DECIMAL(20, 2)) AS ingredients,
                CAST((COALESCE(t.packaging , 0)) AS DECIMAL(20, 2)) AS packaging,
                CAST((COALESCE(t.direct_labour , 0)) AS DECIMAL(20, 2)) AS direct_labour,
                CAST((COALESCE(t.overhead , 0)) AS DECIMAL(20, 2)) AS overhead,
                CAST((COALESCE(t.total_storage , 0)) AS DECIMAL(20, 2)) AS total_storage,
                CAST((COALESCE(t.total_freight , 0)) AS DECIMAL(20, 2)) AS total_freight,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS bill_back_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS co_op_allowances_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS exclusivity_allowance_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS growth_incentives_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS merchandising_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS rebates_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS rebates_lumpsum,
                CAST((COALESCE(t.total_off_invoice , 0)) AS DECIMAL(20, 2)) AS total_off_invoice,
                CAST((COALESCE(t.total_off_invoice_ea , 0)) AS DECIMAL(20, 2)) AS total_off_invoice_ea,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS uncon_and_relationship_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS listing_fees_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS bill_back_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS co_op_allowances_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS exclusivity_allowance_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS growth_incentives_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS merchandising_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS listing_fees_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS uncon_and_relationship_lumpsum,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS trade_investments,
                CAST((COALESCE(t.total_deductions , 0)) AS DECIMAL(20, 2)) AS total_deductions,
                CAST((COALESCE(t.co_op_allowances , 0)) AS DECIMAL(20, 2)) AS co_op_allowances,
                CAST((COALESCE(t.rebates , 0)) AS DECIMAL(20, 2)) AS rebates,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS buying_group_vip_accrual,
                CAST((COALESCE(0, 0)) AS DECIMAL(20, 2)) AS buying_group_vip_lumpsum,
                CAST((COALESCE(t.tma_event , 0)) AS DECIMAL(20, 2)) AS tma_event,
                CAST((COALESCE(t.total_sales , 0)) AS DECIMAL(20, 2)) AS total_sales,
                CAST((COALESCE(t.total_sales_ea , 0)) AS DECIMAL(20, 2)) AS total_sales_ea,
                CAST((COALESCE(t.other_discounts , 0)) AS DECIMAL(20, 2)) AS other_discounts,
                CAST((COALESCE(t.tma_term , 0)) AS DECIMAL(20, 2)) AS tma_term,
                CAST((COALESCE(t.total_trade , 0)) AS DECIMAL(20, 2)) AS total_trade,
                CAST((COALESCE(t.cost_of_goods_sold , 0)) AS DECIMAL(20, 2)) AS cost_of_goods_sold,
                CAST((COALESCE(t.net_sales , 0)) AS DECIMAL(20, 2)) AS net_sales,
                CAST((COALESCE(t.cost_of_sales , 0)) AS DECIMAL(20, 2)) AS cost_of_sales,
                CAST((COALESCE(t.gross_profit_standard , 0)) AS DECIMAL(20, 2)) AS gross_profit_standard,
                CAST((COALESCE(t.gross_contribution , 0)) AS DECIMAL(20, 2)) AS gross_contribution,
                CAST((COALESCE(t.gross_invoice_qty , 0)) AS DECIMAL(20, 2)) AS gross_invoice_qty,
                CAST((COALESCE(t.gross_invoice_qty_ea , 0)) AS DECIMAL(20, 2)) AS gross_invoice_qty_ea,
                CAST((COALESCE(t.kilos , 0)) AS DECIMAL(20, 2)) AS kilos,
                CAST((COALESCE(t.franchisee_revenue , 0)) AS DECIMAL(20, 2)) AS franchisee_revenue,
                'TMA' AS def 
            FROM
                wrk_global.t_order_final_paso2_dsd t 
        )
        t 
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
        20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,92 ;

CREATE TABLE wrk_global.t_order_final 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
location 's3a://devbimboaws/DEV_CANADA_IC/Data/wrk_global/t_order_final'
as select * from gb_smntc_191_canada.t_order_final_dsd;



