TRUNCATE TABLE STG_CANADA.T_PRODUCTS_CB;

-- Inserting values into STG_CANADA.T_PRODUCTS_CB, using view STG_CANADA_VIEWS.V_PRODUCTS_CB

INSERT INTO STG_CANADA.T_PRODUCTS_CB
select 
cast(legalentity_id as VARCHAR(10)) as legalentity_id,
cast(product_id as VARCHAR(30)) as product_id,
cast(product_name as VARCHAR(50)) as product_name,
cast(category_id as INTEGER) as category_id,
cast(market_name as VARCHAR(50)) as market_name,
cast(gb_category_name as VARCHAR(50)) AS gb_category_name,
cast(trade_brand_name as VARCHAR(50)) AS trade_brand_name,
cast(subcategory_name as VARCHAR(50)) AS subcategory_name,
cast(category_name as VARCHAR(50)) AS category_name,
cast(base_unit_of_measure as VARCHAR(10)) AS base_unit_of_measure,
cast(net_weight as FLOAT) AS net_weight,
cast(gross_weight as FLOAT) AS gross_weight,
cast(upc as VARCHAR(20)) AS upc,
cast(weight_uom as VARCHAR(10)) AS weight_uom,
cast(pieces_uom as VARCHAR(10)) AS pieces_uom,
cast(standard_pack as FLOAT) AS standard_pack,
cast(each_by_case as VARCHAR(50)) AS each_by_case,
cast(category_set_id as BIGINT) AS category_set_id,
cast(conversion_factor as FLOAT) AS conversion_factor,
cast(unit_of_measure as VARCHAR(25)) AS unit_of_measure,
cast(conversion_rate as FLOAT) AS conversion_rate,
cast(item_type as VARCHAR(30)) AS item_type
FROM WRK_GLOBAL.V_PRODUCTS_CB;
