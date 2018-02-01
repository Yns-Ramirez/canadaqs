TRUNCATE TABLE STG_CANADA.T_CUSTOMERS_CB;


-- Inserting values into STG_CANADA.T_CUSTOMERS_CB, using view WRK_GLOBAL.V_CUSTOMERS_CB

Insert into STG_CANADA.T_CUSTOMERS_CB 
select 

cast(customeroracle_id as int) as customeroracle_id,
cast(`location` as varchar(50)) as `location`,
cast(customerar_id as varchar(50)) as customerar_id,
cast(account_number as varchar(50)) as account_number,
cast(customersap_id as varchar(50)) as customersap_id,
cast(customer_name as varchar(50)) as customer_name,
cast(site_use_code as varchar(50)) as site_use_code,
cast(ship_to_customer_name as varchar(50)) as ship_to_customer_name,
cast(account_name as varchar(50)) as account_name,
cast(store as varchar(50)) as store,
cast(banner_customeroracle_id as int) as banner_customeroracle_id,
cast(banner_customersap_id as varchar(50)) as banner_customersap_id,
cast(banner_customer_name as varchar(50)) as banner_customer_name,
cast(regional_customeroracle_id as int) as regional_customeroracle_id,
cast(regional_customersap_id as varchar(50)) as regional_customersap_id,
cast(regional_customer_name as varchar(50)) as regional_customer_name,
cast(national_customeroracle_id as int) as national_customeroracle_id,
cast(national_customersap_id as varchar(50)) as national_customersap_id,
cast(national_customer_name as varchar(50)) as national_customer_name,
cast(channel_id as varchar(50)) as channel_id,
cast(customer_group as varchar(50)) as customer_group,
cast(address as varchar(50)) as address,
cast(city as varchar(50)) as city,
cast(postal_code as varchar(50)) as postal_code,
cast(country_name as varchar(50)) as country_name,
cast(province as varchar(50)) as province,
cast(org_id as int) as org_id,
cast(salesflag as char(1)) as salesflag
from WRK_GLOBAL.V_CUSTOMERS_CB;
