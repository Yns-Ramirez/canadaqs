
-- SET Paso = 1;

TRUNCATE TABLE wrk_global.T_ORDER_FINAL_PASO_DSD_1;

-- SET Paso = 2;
 INSERT INTO wrk_global.T_ORDER_FINAL_PASO_DSD_1
     SELECT
       a.Product_ID
      ,a.Company_ID
      ,a.Channel_ID
      ,a.Channel_Name
      ,a.Province_ID
      ,SUBSTRING(a.Bill_Date,1,10) AS Bill_Date
      ,a.Unit_Sold
      ,a.Week
      ,a.Fiscal_Period
      ,a.Currency
      ,a.Customer_ID
      ,a.Sales_District
      ,a.Sales_District_Name
      ,a.Plant
      ,a.Sales_Center
      ,a.Route_ID
      ,a.Ship_To
      ,a.Doc_Number
      ,a.Offer_Code
      ,a.Bill_Num
      ,a.Bill_Type
      ,a.Franchisee_Revenue_ID
      ,a.Commision_Group_ID
      ,a.TSM_ID 
      ,a.TSM_Name
      ,a.RSM_ID 
      ,a.RSM_Name 
      ,a.Depot_ID 
      ,a.Depot_Name
      ,a.IO_Name
      ,a.Invoice_Type
      ,cast(a.Conversion_Rate as DECIMAL(19,4)) as Conversion_Rate
      ,a.Price
      ,a.Net_Invoice_Price
      ,a.Discount
      ,cast(a.Net_Invoice_Qty1 as DECIMAL(19,4)) AS Net_Invoice_Qty
      ,cast(a.Net_Invoice_Qty_EA as DECIMAL(19,4)) AS Net_Invoice_Qty_EA 
      ,cast((a.TOTAL_SALES + a.TOTAL_OFF_INVOICE + a.TOTAL_RETURNS + a.OTHER_DISCOUNTS) as DECIMAL(19,4)) AS Gross_Sales
      ,cast(a.Gross_Sales_EA as DECIMAL(19,4)) as Gross_Sales_EA
  ,CASE 
    WHEN a.Return_Invoice_Qty1 = 0 THEN 0
    WHEN a.Return_Invoice_Qty1 <> (a.Net_Invoice_Qty1*-1) THEN cast((a.Net_Invoice_Qty1 *-1) as DECIMAL(19,4)) 
    ELSE cast((a.Net_Invoice_Qty1 *-1) as DECIMAL(19,4))
    END AS Return_Invoice_Qty
  ,cast(a.Return_Invoice_Qty_EA as DECIMAL(19,4)) as Return_Invoice_Qty_EA
  ,CASE 
    WHEN a.Total_Returns = 0 THEN 0
    WHEN a.Total_Returns <> (a.Net_Sales *-1) AND a.Net_Sales <> 0 THEN cast((a.Net_Sales *-1) as DECIMAL(19,4)) 
    WHEN a.Total_Returns <> (a.Net_Sales *-1) AND a.Net_Sales = 0 THEN cast((a.Total_Returns) as DECIMAL(19,4)) 
    ELSE cast((a.Net_Sales *-1) as DECIMAL(19,4)) 
     END AS Total_Returns
  ,cast(a.Total_Returns_EA as DECIMAL(19,4)) as Total_Returns_EA
      ,cast(a.Ingredients as DECIMAL(19,4)) as Ingredients
      ,cast(a.Packaging as DECIMAL(19,4))  as Packaging
      ,cast(a.Direct_Labour as DECIMAL(19,4))
      ,cast(a.Overhead as DECIMAL(19,4))
      ,cast(a.Total_Storage as DECIMAL(19,4))
      ,cast(a.Total_Freight as DECIMAL(19,4))
      ,cast(a.Bill_Back_Accrual as DECIMAL(19,4))
      ,cast(a.Co_op_Allowances_Accrual as DECIMAL(19,4))
      ,cast(a.Exclusivity_Allowance_Accrual as DECIMAL(19,4))
      ,cast(a.Growth_Incentives_Accrual as DECIMAL(19,4))
      ,cast(a.Merchandising_Accrual as DECIMAL(19,4))
      ,cast(a.Rebates_Accrual as DECIMAL(19,4))
      ,cast(a.Rebates_Lumpsum as DECIMAL(19,4))
      ,cast(a.Total_Off_Invoice as DECIMAL(19,4))
      ,cast(a.Total_Off_Invoice_EA as DECIMAL(19,4))
      ,cast(a.Uncon_And_Relationship_Accrual as DECIMAL(19,4))
      ,cast(a.Listing_Fees_Accrual as DECIMAL(19,4))
      ,cast(a.Bill_Back_Lumpsum as DECIMAL(19,4))
      ,cast(a.Co_op_Allowances_Lumpsum as DECIMAL(19,4))
      ,cast(a.Exclusivity_Allowance_Lumpsum as DECIMAL(19,4))
      ,cast(a.Growth_Incentives_Lumpsum as DECIMAL(19,4))
      ,cast(a.Merchandising_Lumpsum as DECIMAL(19,4))
      ,cast(a.Listing_Fees_Lumpsum as DECIMAL(19,4))
      ,cast(a.Uncon_And_Relationship_Lumpsum as DECIMAL(19,4))
      ,cast(a.Trade_Investments as DECIMAL(19,4))
      ,cast(a.Total_Deductions as DECIMAL(19,4))
      ,cast(a.Co_op_Allowances as DECIMAL(19,4))
      ,cast(a.Rebates as DECIMAL(19,4))
      ,cast(a.Buying_Group_VIP_Accrual as DECIMAL(19,4))
      ,cast(a.Buying_Group_VIP_Lumpsum as DECIMAL(19,4))
      ,cast(a.TMA_Event as DECIMAL(19,4))
      ,CASE WHEN Bill_Type = 'CN' AND a.Total_Sales = 0 THEN cast(a.Total_Returns *-1 as DECIMAL(19,4)) 
        ELSE cast(a.Total_Sales  as DECIMAL(19,4))
        END AS Total_Sales
      ,cast(a.Total_Sales_EA as DECIMAL(19,4))
      ,cast(a.Other_Discounts as DECIMAL(19,4))
      ,cast(a.TMA_Term as DECIMAL(19,4))
      ,cast(a.Total_Trade as DECIMAL(19,4))
      ,cast(a.Cost_of_Goods_Sold as DECIMAL(19,4))
      ,CASE WHEN Bill_Type = 'CN' AND a.Net_Sales = 0 THEN cast(a.Total_Returns *-1  as DECIMAL(19,4))
        ELSE cast(a.Net_Sales  as DECIMAL(19,4))
        END AS Net_Sales
      ,cast(a.Cost_of_Sales as DECIMAL(19,4))
      ,cast(a.Gross_Profit_Standard as DECIMAL(19,4))
      ,cast(a.Gross_Contribution as DECIMAL(19,4))
      ,cast(cast(a.Net_Invoice_Qty1  as DECIMAL(19,4)) + (CASE WHEN a.Return_Invoice_Qty1 = 0 THEN 0 
                            WHEN a.Return_Invoice_Qty1 <> a.Net_Invoice_Qty1*-1 THEN cast((a.Net_Invoice_Qty1 *-1)  as DECIMAL(19,4))
                            ELSE cast((a.Net_Invoice_Qty1 *-1)  as DECIMAL(19,4))
                            END) as DECIMAL(19,4) ) AS Gross_Invoice_Qty
      --,Net_Invoice_Qty + Return_Invoice_Qty AS Gross_Invoice_Qty
      ,cast(a.Gross_Invoice_Qty_EA as DECIMAL(19,4))
      ,cast(a.Kilos as DECIMAL(19,4))
  , cast(COALESCE(a.Franchise_Revenue,0) as DECIMAL(19,4)) AS Franchisee_Revenue
      ,a.Def
     FROM 
     (
              SELECT
              CAST(AGYA.CODIGO_PRODUCTO AS VARCHAR(30))         AS Product_ID                    
              ,CAST('191' AS VARCHAR(30))                        AS Company_ID                    
              ,CAST(CASE
                  WHEN AGP001.AG1DE1  = 'Retail'          THEN '13'
                  WHEN AGP001.AG1DE1  = 'Food Service'    THEN '3'
                  WHEN AGP001.AG1DE1  LIKE 'Int%'         THEN '90'
                  ELSE '00'
              END  AS VARCHAR(30)) AS Channel_ID
              ,CAST(AGP001.AG1DE1 AS VARCHAR(30)) AS Channel_Name                    
              ,CAST(AGM001.AG1EST AS VARCHAR(30))       AS Province_ID 
              ,CAST(AGYB.AG03FC AS VARCHAR(30))    AS Bill_Date                     
              ,CAST('N/A' AS VARCHAR(30))                        AS Unit_Sold                     
              ,CAST(DA.WEEK AS VARCHAR(30))                      AS Week
              ,CAST( CONCAT (TRIM( SUBSTR(CAST(AGYB.AG03FC AS STRING) ,1,4) ) , '0' ,TRIM(SUBSTR(CAST(AGYB.AG03FC AS STRING), 6,2)))  AS VARCHAR(30) )     AS Fiscal_Period     
              ,CAST('CAD' AS VARCHAR(30))                        AS Currency                    
              ,CAST(AGYB.CLICOD AS VARCHAR(30))                  AS Customer_ID                   
              ,CAST(
                    CASE 
                  WHEN CAST(AGYB.CODIGO_AGENCIA AS STRING) IN ('14661','14662','14663') THEN '04' 
                  WHEN CAST(AGYB.CODIGO_AGENCIA AS STRING) IN ('14664','14665','14666','14667','14672') THEN '01' 
                  WHEN CAST(AGYB.CODIGO_AGENCIA AS STRING) IN ('14674','14675','14676','14677','14678','14681','14682','14683') THEN '02'       
                  ELSE '-1' 
                 END AS VARCHAR(30)) AS Sales_District                
              ,CAST(
                CASE 
              WHEN CAST(AGYB.CODIGO_AGENCIA AS STRING) IN ('14661','14662','14663') THEN 'East' 
              WHEN CAST(AGYB.CODIGO_AGENCIA AS STRING) IN ('14664','14665','14666','14667','14672') THEN 'West' 
              WHEN CAST(AGYB.CODIGO_AGENCIA AS STRING) IN ('14674','14675','14676','14677','14678','14681','14682','14683') THEN 'Ontario'       
              ELSE '-1' 
              END AS VARCHAR(30)) AS Sales_District_Name
               ,CAST('N/A' AS VARCHAR(30))                        AS Plant         
               ,CAST(AGYB.CODIGO_AGENCIA AS VARCHAR(30))          AS Sales_Center                         
               ,CAST(AGYB.CODIGO_RUTA AS VARCHAR(30))             AS Route_ID  
               ,CAST(AGM001.AG3COD AS VARCHAR(30))                AS Ship_To                       
              ,CAST(CASE WHEN AGYB.AG03FC >= from_unixtime(1161103,"yyyy-MM-dd HH:mm:ss.SSSS") THEN TRIM(CONCAT(SUBSTR(AGYB.NUMERO, 1,1),SUBSTR(AGYB.NUMERO, 14,3),SUBSTR(AGYB.NUMERO, 7,4),SUBSTR(AGYB.NUMERO, 17,4)) ) ELSE AGYB.NUMERO END AS VARCHAR(30)) AS Doc_Number
               ,CAST('N/A' AS VARCHAR(30))                        AS Offer_Code                    
               ,CAST(AGYA.NO_FACTURA AS VARCHAR(30))              AS Bill_Num                      
               ,CAST(AGYB.AG19ID AS VARCHAR(30))                  AS Bill_Type                     
               ,CAST(COALESCE(CDE.id_tipo,1) AS INT)          AS Id_Type
               ,CAST(I.ingresoid AS INT)  AS Franchisee_Revenue_ID   -----------***************************************
               ,CAST(CP.categoriaid AS INT)  AS Commision_Group_ID
               ,CAST(COALESCE(r.CODIGO_SUPERVISOR,-1) AS INT) AS TSM_ID
               ,CAST(COALESCE(UPPER( CONCAT( TRIM(s.NOMBRE),TRIM(s.APELLIDO_PAT)) ),'N/A') AS VARCHAR(100)) AS TSM_NAME
               ,CAST(COALESCE(d.CODIGO_DIVISIONAL,-1) AS INT) AS RSM_ID
               ,CAST(COALESCE(UPPER(d.DESCRIP_DIVISIONAL),'N/A') AS VARCHAR(100)) AS RSM_NAME
               ,CAST(COALESCE( CAST( TRIM(r.AG13ID) AS INT) ,-1) AS INT) AS DEPOT_ID
               ,CAST(UPPER(COALESCE(g.AG13DS,'N/A')) AS VARCHAR(100)) AS DEPOT_NAME
               ,CAST(UPPER(COALESCE( CONCAT(TRIM(v.NOMBRE_VENDEDOR),TRIM(v.APELL_PAT_VEND)) ,'N/A')) AS VARCHAR(100))  AS IO_Name
               
               ,CAST(CASE WHEN CAST(CDE.id_tipo AS INT) = 4 THEN 'BUYBACK' ELSE 'OTHER' END AS VARCHAR(20)) AS Invoice_Type
               ,COALESCE(CRO.CONVERSION_RATE,1)                   AS Conversion_Rate
               ,CAST(AGYA.PRECIO AS DECIMAL(19,4))                AS Price
               ,CAST(AGYA.PROMOCION AS DECIMAL(19,4))             AS Discount     
               ,CAST(AGYA.FACDET/AGYA.CANTIDAD AS DECIMAL(19,4))       AS Net_Invoice_Price
               ,CASE WHEN AGYB.AG19ID = 'CN' THEN SUM(CDE.Cantidad*-1) ELSE SUM(AGYA.Cantidad) END AS Net_Invoice_Qty1
               ,SUM(CASE WHEN AGYB.AG19ID = 'CN' THEN (CDE.Cantidad*-1) ELSE AGYA.Cantidad END * COALESCE(CRO.CONVERSION_RATE,1))  AS Net_Invoice_Qty_EA               
               ,CASE WHEN AGYB.AG19ID IN ('IN','DN') THEN SUM(AGYA.CANTIDAD*AGYA.PRECIO) ELSE 0 END AS Gross_Sales                   
               ,SUM( (AGYA.CANTIDAD*AGYA.DIF_PRECIO)
                    +CASE WHEN AGYB.AG19ID = 'CN' THEN (((AGYA.CANTIDAD * COALESCE(CRO.CONVERSION_RATE,1))*AGYA.PRECIO)*-1) ELSE 0 END 
                    +CASE WHEN AGYB.AG19ID IN ('IN','DN') THEN ((AGYA.CANTIDAD * COALESCE(CRO.CONVERSION_RATE,1))*AGYA.PRECIO) ELSE 0 END
                    ) AS Gross_Sales_EA                   
               ,CASE WHEN CAST(CDE.id_tipo AS INT) <> 4 THEN CASE WHEN AGYB.AG19ID = 'CN' THEN SUM(AGYA.CANTIDAD*-1) ELSE 0 END ELSE 0 END AS Return_Invoice_Qty1       
               ,CASE WHEN CAST(CDE.id_tipo AS INT) <> 4 THEN CASE WHEN AGYB.AG19ID = 'CN' THEN SUM((AGYA.CANTIDAD * COALESCE(CRO.CONVERSION_RATE,1))*-1) ELSE 0 END ELSE 0 END AS Return_Invoice_Qty_EA       
               ,CASE WHEN CAST(CDE.id_tipo AS INT) <> 4 THEN CASE WHEN AGYB.AG19ID = 'CN' THEN SUM(AGYA.FACDET*-1) ELSE 0 END ELSE 0 END AS Total_Returns                   
               ,CASE WHEN CAST(CDE.id_tipo AS INT) <> 4 THEN CASE WHEN AGYB.AG19ID = 'CN' THEN SUM(((AGYA.CANTIDAD * COALESCE(CRO.CONVERSION_RATE,1))*AGYA.PRECIO)*-1) ELSE 0 END ELSE 0 END AS Total_Returns_EA                 
               ,SUM(AGYA.CANTIDAD*C.Ingredients)           AS Ingredients                   
               ,SUM(AGYA.CANTIDAD*C.Packaging)             AS Packaging                     
               ,SUM(AGYA.CANTIDAD*C.Direct_Labour)         AS Direct_Labour                 
               ,SUM(AGYA.CANTIDAD*C.Overhead)              AS Overhead                      
               ,SUM(0)               AS Total_Storage                 
               ,SUM(0)               AS Total_Freight                 
               ,SUM(0)               AS Bill_Back_Accrual             
               ,SUM(0)               AS Co_op_Allowances_Accrual      
               ,SUM(0)               AS Exclusivity_Allowance_Accrual 
               ,SUM(0)               AS Growth_Incentives_Accrual     
               ,SUM(0)               AS Merchandising_Accrual         
               ,SUM(0)               AS Rebates_Accrual               
               ,SUM(0)               AS Rebates_Lumpsum               
               ,SUM(AGYA.PROMOCION)  AS Total_Off_Invoice    
               ,SUM((AGYA.CANTIDAD * COALESCE(CRO.CONVERSION_RATE,1))*AGYA.PRECIO) AS Total_Off_Invoice_EA
               ,SUM(0)               AS Uncon_And_Relationship_Accrual
               ,SUM(0)               AS Listing_Fees_Accrual          
               ,SUM(0)               AS Bill_Back_Lumpsum             
               ,SUM(0)               AS Co_op_Allowances_Lumpsum      
               ,SUM(0)               AS Exclusivity_Allowance_Lumpsum 
               ,SUM(0)               AS Growth_Incentives_Lumpsum     
               ,SUM(0)               AS Merchandising_Lumpsum         
               ,SUM(0)               AS Listing_Fees_Lumpsum          
               ,SUM(0)               AS Uncon_And_Relationship_Lumpsum
               ,SUM(0)               AS Trade_Investments             
               ,SUM(0)               AS Total_Deductions              
               ,SUM(0)               AS Co_op_Allowances              
               ,SUM(0)               AS Rebates                       
               ,SUM(0)               AS Buying_Group_VIP_Accrual              
               ,SUM(0)               AS Buying_Group_VIP_Lumpsum
               ,SUM(0)               AS TMA_Event                     
               ,CASE WHEN AGYB.AG19ID IN ('IN','DN') THEN SUM(CASE WHEN AGYA.FACDSL = 100 THEN 0 ELSE AGYA.FACDET END) ELSE SUM(CASE WHEN AGYA.FACDSL = 100 THEN 0 ELSE (ZEROIFNULL(CDE.Cantidad) * ZEROIFNULL(CAST(AGYA.PRECIO-(AGYA.PROMOCION/AGYA.CANTIDAD) AS DECIMAL(19,4))))*-1 END) END AS Total_Sales
               ,SUM(CASE WHEN AGYA.FACDSL = 100 THEN AGYA.FACDET ELSE 0 END) AS Other_Discounts                   
               ,CASE WHEN AGYB.AG19ID IN ('IN','DN') THEN SUM((AGYA.CANTIDAD * COALESCE(CRO.CONVERSION_RATE,1))*AGYA.PRECIO) ELSE 0 END AS Total_Sales_EA                   
               ,SUM(0)               AS TMA_Term                      
               ,SUM(0)               AS Total_Trade                   
               ,SUM(((AGYA.CANTIDAD*C.Ingredients)+(AGYA.CANTIDAD*C.Packaging)+(AGYA.CANTIDAD*C.Direct_Labour)+(AGYA.CANTIDAD*C.Overhead))) AS Cost_of_Goods_Sold            
               ,CASE WHEN AGYB.AG19ID IN ('IN','DN') THEN SUM(CASE WHEN AGYA.FACDSL = 100 THEN 0 ELSE AGYA.FACDET END) ELSE SUM(CASE WHEN AGYA.FACDSL = 100 THEN 0 ELSE (ZEROIFNULL(CDE.Cantidad) * ZEROIFNULL(CAST(AGYA.PRECIO-(AGYA.PROMOCION/AGYA.CANTIDAD) AS DECIMAL(19,4))))*-1 END) END AS Net_Sales                     
               ,SUM(((AGYA.CANTIDAD*C.Ingredients)+(AGYA.CANTIDAD*C.Packaging)+(AGYA.CANTIDAD*C.Direct_Labour)+(AGYA.CANTIDAD*C.Overhead))) AS Cost_of_Sales                 
               ,SUM(0)               AS Gross_Profit_Standard         
               ,SUM(0)               AS Gross_Contribution            
               ,CASE WHEN AGYB.AG19ID IN ('IN','DN') THEN SUM(AGYA.CANTIDAD) ELSE 0 END AS Gross_Invoice_Qty       
               ,CASE WHEN AGYB.AG19ID IN ('IN','DN') THEN SUM(AGYA.CANTIDAD * COALESCE(CRO.CONVERSION_RATE,1)) ELSE 0 END AS Gross_Invoice_Qty_EA       
               ,SUM(0)               AS Kilos                         
              ,SUM(0)               AS REVENUE              
              ,SUM(CASE 
                  WHEN AGYA.FACDSL = 100 THEN 0
                  ELSE ((((CAST((CASE WHEN AGYB.AG19ID = 'CN' THEN CAST(CDE.Cantidad AS DECIMAL(19,4)) *-1 
                  ELSE CAST(AGYA.Cantidad AS DECIMAL(19,4)) END)*CAST(100 AS DECIMAL(19,4))/ CAST(FR.CANTIDAD AS DECIMAL(19,4)) AS DECIMAL(19,4))/CAST(100 AS DECIMAL(19,4)))*CAST(FR.Franchise_Revenue AS DECIMAL(19,4)))))
                 END) AS Franchise_Revenue
               ,'CP' AS Def
     FROM wrk_global.tmp_agy003_0 AGYB
    INNER JOIN wrk_global.agy004_tmp AGYA 
               ON AGYB.CODIGO_AGENCIA = AGYA.CODIGO_AGENCIA 
               AND AGYB.CODIGO_RUTA = AGYA.CODIGO_RUTA 
               AND AGYB.NO_FACTURA = AGYA.NO_FACTURA 
               AND substring(AGYB.AG03FC,1,10) = substring(AGYA.AG03FC,1,10)
    LEFT JOIN wrk_global.agm001_tmp AGM001 
               ON AGYB.CODIGO_AGENCIA = AGM001.CODIGO_AGENCIA 
               AND AGYB.CLICOD = AGM001.CLICOD  
    LEFT JOIN wrk_global.agp001_TMP AGP001 
               ON AGM001.CODIGO_AGENCIA = AGP001.CODIGO_AGENCIA 
               AND AGM001.AG1CO1 = AGP001.AG1CO1 
     LEFT JOIN wrk_global.env_configuracionenvio_tmp CE 
               ON AGYB.CODIGO_AGENCIA = CE.CODIGO_AGENCIA 
     LEFT JOIN wrk_global.categoriaproductos_tmp CP 
               ON AGYA.CODIGO_AGENCIA = CP.CODIGO_AGENCIA 
               AND AGYA.CODIGO_PRODUCTO = CP.CODIGO_PRODUCTO
     LEFT JOIN wrk_global.clienteingresodevolucion_tmp CC 
               ON AGYA.CODIGO_AGENCIA = CC.CODIGO_AGENCIA 
               AND TRIM(AGYB.CLICOD) = TRIM(CC.CLICOD)
               AND AGYB.CODIGO_RUTA = CC.CODIGO_RUTA 
     LEFT JOIN wrk_global.ingresos_tmp I 
               ON AGYA.CODIGO_AGENCIA = I.CODIGO_AGENCIA 
               AND CC.INGRESOID = I.INGRESOID
     LEFT JOIN wrk_global.ingresocategorias_tmp IC 
               ON AGYA.CODIGO_AGENCIA = IC.CODIGO_AGENCIA 
               AND CP.CATEGORIAID = IC.CATEGORIAID 
               AND I.INGRESOID = IC.INGRESOID
     LEFT JOIN wrk_global.divisional_tmp d 
               ON AGYB.CODIGO_AGENCIA = d.CODIGO_AGENCIA
     LEFT JOIN wrk_global.ruta_tmp r 
               ON AGYB.CODIGO_AGENCIA = r.CODIGO_AGENCIA 
               AND AGYB.CODIGO_RUTA = r.CODIGO_RUTA
     LEFT JOIN wrk_global.supervisor_tmp  s 
               ON r.CODIGO_AGENCIA = s.CODIGO_AGENCIA 
               AND r.CODIGO_SUPERVISOR = s.CODIGO_SUPERVISOR
     LEFT JOIN wrk_global.vendedor_tmp v 
               ON r.CODIGO_AGENCIA = v.CODIGO_AGENCIA 
               AND r.CODIGO_VENDEDOR = v.CODIGO_VENDEDOR
     LEFT JOIN wrk_global.agm013_tmp g 
               ON r.CODIGO_AGENCIA = g.CODIGO_AGENCIA 
               AND TRIM(r.AG13ID) = TRIM(CAST(g.AG13ID AS STRING))
     
      LEFT JOIN wrk_global.order_final_cross_Clas_Dev CDE 
               ON AGYA.codigo_producto = CDE.codigo_producto
               AND substring(AGYA.AG03FC,1,10) = substring(CDE.fecha,1,10)
               AND AGYB.CLICOD = CDE.CLICOD
               AND AGYA.codigo_ruta = CDE.codigo_ruta
               AND AGYA.no_factura = CDE.no_factura

     LEFT JOIN wrk_global.fr_master_tmp FR
         ON  TRIM(CAST(AGYA.CODIGO_AGENCIA AS VARCHAR(50)))= TRIM(CAST(FR.CODIGO_AGENCIA AS VARCHAR(50)))
          AND TRIM(CAST(AGYA.CODIGO_RUTA AS VARCHAR(50)))  = TRIM(CAST(FR.CODIGO_RUTA AS VARCHAR(50)))
          AND TRIM(CAST(TRIM( CONCAT(SUBSTR(AGYB.NUMERO, 1,1),SUBSTR(AGYB.NUMERO, 14,3),SUBSTR(AGYB.NUMERO, 7,4),SUBSTR(AGYB.NUMERO, 17,4)) ) AS VARCHAR(50))) = TRIM(CAST(FR.NUMERO AS VARCHAR(50)))
          AND TRIM(CAST(AGYA.NO_FACTURA AS VARCHAR(50)))   = TRIM(CAST(FR.NO_FACTURA AS VARCHAR(50)))
          AND TRIM(CAST(AGYA.CODIGO_PRODUCTO AS VARCHAR(50)))   = TRIM(CAST(FR.CODIGO_PRODUCTO AS VARCHAR(50)))
          AND TRIM(CAST(AGYB.CLICOD AS VARCHAR(50)))  = TRIM(CAST(FR.CLICOD AS VARCHAR(50)))
          AND TRIM(CAST(AGYA.AG03FC AS VARCHAR(50)))  = TRIM(CAST(FR.AG03FC AS VARCHAR(50)))
          AND COALESCE(TRIM(CAST(CDE.id_tipo AS VARCHAR(50))),'99999') = COALESCE(TRIM(CAST(FR.id_tipo AS VARCHAR(50))),'99999')
         
               LEFT JOIN wrk_global.calendar_tmp DA 
               ON substring(AGYB.AG03FC,1,10) = DA.CALENDAR_DATE 
                -- COGS from ORACLE Source System

              LEFT JOIN wrk_global.tmp_t_order_final_2 as C 
                ON TRIM(CAST(AGYA.CODIGO_PRODUCTO AS VARCHAR(50)))= TRIM(CAST(C.Product_ID_ORACLE AS VARCHAR(50)))     
                AND TRIM(CAST(EXTRACT(YEAR FROM AGYB.AG03FC) AS CHAR(4)) )  = TRIM(CAST(C.COGSYear AS CHAR(4)))
                AND AGYB.CODIGO_AGENCIA= C.Sales_Center 

              LEFT JOIN wrk_global.tmp_t_order_final_1 as CRO 
                ON CAST(AGYA.CODIGO_PRODUCTO AS STRING) = TRIM(CRO.SEGMENT1) 
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,AGYB.AG19ID,CDE.id_tipo
     )a ;




