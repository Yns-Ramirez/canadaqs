CREATE VIEW IF NOT EXISTS WRK_GLOBAL.V_PRODUCTS_CB

AS

SELECT 											
     P.Legalentity_ID AS Legalentity_ID		
     ,A.SEGMENT1 AS Product_ID	
     ,A.DESCRIPTION AS Product_Name	
     ,C.CATEGORY_ID AS Category_ID	
     ,CASE WHEN FN.DESCRIPTION IS NULL THEN C.SEGMENT1 ELSE FN.DESCRIPTION END AS Market_Name					
     ,CASE WHEN FN.DESCRIPTION IS NULL THEN C.SEGMENT2 ELSE FNC.DESCRIPTION END AS GB_Category_Name					
     ,CASE WHEN FN.DESCRIPTION IS NULL THEN C.SEGMENT5 ELSE FNB.DESCRIPTION END AS Trade_Brand_Name				
     ,CASE WHEN FN.DESCRIPTION IS NULL THEN C.SEGMENT4 ELSE FNS.DESCRIPTION END AS SubCategory_Name				
     ,CASE WHEN FN.DESCRIPTION IS NULL THEN C.SEGMENT3 ELSE FNL.DESCRIPTION END AS Category_Name   				
     ,PRIMARY_UNIT_OF_MEASURE AS Base_Unit_Of_Measure
     ,UNIT_WEIGHT AS Net_Weight	
     ,CASE WHEN A.SEGMENT1 = '121616' AND cast(A.ATTRIBUTE13 as string) = 'KG' THEN cast(0 as string) ELSE A.ATTRIBUTE13 END AS Gross_Weight
     ,A.ATTRIBUTE3 AS UPC
     ,WEIGHT_UOM_CODE AS Weight_UOM
     ,1 AS Pieces_UOM
     ,TRIM(COALESCE(FVL.ATTRIBUTE12,cast(0 as string))) AS Standard_Pack
     ,TRIM(COALESCE(FVL.ATTRIBUTE16,cast(0 as string))) AS Each_By_Case
     ,B.CATEGORY_SET_ID AS Category_Set_ID
	 ,case when CONVFAC.CROSS_REFERENCE is null then cast(0 as string) else CONVFAC.CROSS_REFERENCE end AS Conversion_Factor
     ,UOM.UNIT_OF_MEASURE AS Unit_Of_Measure
     ,UOM.CONVERSION_RATE AS Conversion_Rate
     ,A.ITEM_TYPE AS Item_Type
FROM erp_pgbari_sz.MTL_SYSTEM_ITEMS_B_INV A
INNER JOIN erp_pgbari_sz.MTL_ITEM_CATEGORIES_INV B
ON A.ORGANIZATION_ID = B.ORGANIZATION_ID
AND A.INVENTORY_ITEM_ID= B.INVENTORY_ITEM_ID
INNER JOIN erp_pgbari_sz.MTL_CATEGORIES_B_INV C
ON  B.CATEGORY_ID=C.CATEGORY_ID
INNER JOIN STG_CANADA_VIEWS.v_PLANTS P
ON  A.ORGANIZATION_ID = P.ORGANIZATION_ID
AND P.LegalEntity_id IN ('191')
LEFT OUTER JOIN (SELECT A.CROSS_REFERENCE_TYPE
                        ,C.SEGMENT1
                        ,B.INVENTORY_ITEM_ID
                        ,B.CROSS_REFERENCE
                        ,B.DESCRIPTION
                  FROM erp_pgbari_sz.mtl_cross_reference_types_inv A
                      ,erp_pgbari_sz.mtl_cross_references_b_inv b
                      ,erp_pgbari_sz.mtl_system_items_b_inv C
                  WHERE A.CROSS_REFERENCE_TYPE = B.CROSS_REFERENCE_TYPE
                  AND B.INVENTORY_ITEM_ID = C.INVENTORY_ITEM_ID
                  AND cast(C.ORGANIZATION_ID as string) = '85'
                  AND A.CROSS_REFERENCE_TYPE = 'MTL_CB_PRODUCT') CONVFAC
ON CONVFAC.SEGMENT1 = A.SEGMENT1
LEFT JOIN (SELECT inventory_item_id, UNIT_OF_MEASURE, conversion_rate FROM erp_pgbari_sz.mtl_uom_conversions_inv WHERE DISABLE_DATE IS NULL GROUP BY 1,2,3) UOM ON A.INVENTORY_ITEM_ID= UOM.INVENTORY_ITEM_ID											
LEFT JOIN
         (											
          SELECT											
          F.INVENTORY_ITEM_ID
          ,F.ORGANIZATION_ID
          ,M.ATTRIBUTE12
          ,M.ATTRIBUTE16
          FROM erp_pgbari_sz.mtl_system_items_fvl_apps F
          INNER JOIN
                   (
                    SELECT											
                     INVENTORY_ITEM_ID
                     ,MAX(ATTRIBUTE12) AS ATTRIBUTE12
                     ,MAX(ATTRIBUTE16) AS ATTRIBUTE16
                    FROM erp_pgbari_sz.mtl_system_items_fvl_apps
                    GROUP BY 1
                   )M ON F.INVENTORY_ITEM_ID = M.INVENTORY_ITEM_ID
          ) FVL ON A.INVENTORY_ITEM_ID = FVL.INVENTORY_ITEM_ID AND A.ORGANIZATION_ID = FVL.ORGANIZATION_ID
     LEFT JOIN
             (								
              SELECT VAL.FLEX_VALUE, VAL.DESCRIPTION
              FROM erp_pgbari_sz.fnd_flex_values_vl_apps val, erp_pgbari_sz.fnd_flex_value_sets_apps flex
              WHERE 1 = 1
              AND val.flex_value_set_id = flex.flex_value_set_id
              AND flex.FLEX_VALUE_SET_NAME = 'TUR_MARKET'
              GROUP BY 1,2
             ) FN ON C.SEGMENT1 = FN.FLEX_VALUE
    LEFT JOIN
            (
             SELECT VAL.FLEX_VALUE, VAL.DESCRIPTION
             FROM erp_pgbari_sz.fnd_flex_values_vl_apps val, erp_pgbari_sz.fnd_flex_value_sets_apps flex
             WHERE 1 = 1
             AND val.flex_value_set_id = flex.flex_value_set_id
             AND flex.FLEX_VALUE_SET_NAME = 'TUR_CATEGORY'
             GROUP BY 1,2
            ) FNC ON C.SEGMENT2 = FNC.FLEX_VALUE
    LEFT JOIN
            (
             SELECT VAL.FLEX_VALUE, VAL.DESCRIPTION
             FROM erp_pgbari_sz.fnd_flex_values_vl_apps val, erp_pgbari_sz.fnd_flex_value_sets_apps flex
             WHERE 1 = 1
             AND val.flex_value_set_id = flex.flex_value_set_id
             AND flex.FLEX_VALUE_SET_NAME = 'TUR_BRAND'
             GROUP BY 1,2
            ) FNB ON C.SEGMENT5 = FNB.FLEX_VALUE
    LEFT JOIN
            (
             SELECT VAL.FLEX_VALUE, VAL.DESCRIPTION
             FROM erp_pgbari_sz.fnd_flex_values_vl_apps val, erp_pgbari_sz.fnd_flex_value_sets_apps flex
             WHERE 1 = 1
             AND val.flex_value_set_id = flex.flex_value_set_id
             AND flex.FLEX_VALUE_SET_NAME = 'TUR_SUB_LINE'
             GROUP BY 1,2
            ) FNS ON C.SEGMENT4 = FNS.FLEX_VALUE
    LEFT JOIN
            (
             SELECT VAL.FLEX_VALUE, VAL.DESCRIPTION
             FROM erp_pgbari_sz.fnd_flex_values_vl_apps val, erp_pgbari_sz.fnd_flex_value_sets_apps flex
             WHERE 1 = 1
             AND val.flex_value_set_id = flex.flex_value_set_id
             AND flex.FLEX_VALUE_SET_NAME = 'TUR_LINE'
             GROUP BY 1,2
            ) FNL ON C.SEGMENT3 = FNL.FLEX_VALUE
     INNER JOIN
               (
                    SELECT
                          P.Legalentity_ID
                         ,N.CATEGORY_ID
                         ,A.SEGMENT1
                         ,N.CATEGORY_SET_ID
                    FROM
                         (
                              SELECT ORGANIZATION_ID, INVENTORY_ITEM_ID,CATEGORY_ID,CATEGORY_SET_ID,LAST_UPDATE_DATE
                              FROM erp_pgbari_sz.mtl_item_categories_inv
                              GROUP BY 1,2,3,4,5
                         )N
                         INNER JOIN
                                   (
                                        SELECT INVENTORY_ITEM_ID, MAX(LAST_UPDATE_DATE) AS LAST_UPDATE_DATE FROM erp_pgbari_sz.mtl_item_categories_inv
                                        GROUP BY 1
                                  )M ON N.INVENTORY_ITEM_ID = M.INVENTORY_ITEM_ID AND N.LAST_UPDATE_DATE = M.LAST_UPDATE_DATE
                         INNER JOIN STG_CANADA_VIEWS.v_PLANTS P ON N.ORGANIZATION_ID = P.ORGANIZATION_ID
                         INNER JOIN (SELECT INVENTORY_ITEM_ID, SEGMENT1 FROM  erp_pgbari_sz.mtl_system_items_b_inv GROUP BY 1,2)A ON N.INVENTORY_ITEM_ID= A.INVENTORY_ITEM_ID
                    GROUP BY 1,2,3,4
               ) CAT ON
                         P.Legalentity_ID = CAT.Legalentity_ID
                     AND C.CATEGORY_ID = CAT.CATEGORY_ID
                     AND A.SEGMENT1 = CAT.SEGMENT1
                     AND B.CATEGORY_SET_ID = CAT.CATEGORY_SET_ID
WHERE C.SEGMENT3 IS NOT NULL
AND A.ORGANIZATION_ID <> 914
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22
;