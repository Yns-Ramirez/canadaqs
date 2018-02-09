drop table if exists APP_INTELCOMERCIAL_DM.DISTRIBUTOR_ACCOUNT_BT_ST;

CREATE table if not exists APP_INTELCOMERCIAL_DM.DISTRIBUTOR_ACCOUNT_BT_ST
AS
SELECT 
      a.BillToNumber
     ,b.BillToNumber2          
     ,b.BillToName1
     ,b.BillToAddress1
     ,b.BillToAddress2
     ,b.BillToCity
     ,b.BillToStateProv
     ,b.BillToZipCode 
     ,b.BillToCountry                
     ,a.ShipToNumber          
     ,cast(if(1=1,null,null)as int) AS ShipToSiteNumber
     ,a.ShipToName1
     ,a.ShipToAddress1
     ,a.ShipToAddress2
     ,a.ShipToCity
     ,a.ShipToStateProv
     ,a.ShipToZipCode 
     ,a.ShipToCountry                
FROM
     (
          SELECT 
                HCSUA.`LOCATION`                         AS BILLTONUMBER
               ,HCA.ACCOUNT_NUMBER                     AS SHIPTONUMBER          
               ,COALESCE(HCA.ACCOUNT_NAME,'UNASSIGNED')AS SHIPTONAME1
               ,HLO.ADDRESS1                           AS SHIPTOADDRESS1
               ,HLO.ADDRESS2                           AS SHIPTOADDRESS2
               ,HLO.CITY                               AS SHIPTOCITY
               ,HLO.PROVINCE                           AS SHIPTOSTATEPROV
               ,HLO.POSTAL_CODE                        AS SHIPTOZIPCODE 
               ,HPB.COUNTRY                            AS SHIPTOCOUNTRY                
          FROM DWH_OPERERP_GLOBAL.HZ_CUST_ACCOUNTS HCA                       
                ,DWH_OPERERP_GLOBAL.HZ_CUST_ACCT_SITES_ALL      HCASA             
                ,DWH_OPERERP_GLOBAL.HZ_PARTIES HPB                                
                ,DWH_OPERERP_GLOBAL.HZ_PARTIES HPR                                
                ,DWH_OPERERP_GLOBAL.HZ_PARTIES HPN                                
                ,DWH_OPERERP_GLOBAL.HZ_PARTY_SITES PS       
                ,DWH_OPERERP_GLOBAL.HZ_CUST_SITE_USES_ALL HCSUA      
                ,DWH_OPERERP_GLOBAL.HZ_LOCATIONS HLO     
               WHERE HCA.PARTY_ID = HPB.PARTY_ID                                  
                 AND HCA.PARTY_ID = HPR.PARTY_ID                                  
                 AND HCA.PARTY_ID = HPN.PARTY_ID                                  
                 AND HCA.PARTY_ID = PS.PARTY_ID                                   
                 AND HCA.CUST_ACCOUNT_ID = HCASA.CUST_ACCOUNT_ID                                   
                 AND HCASA.CUST_ACCT_SITE_ID = HCSUA.CUST_ACCT_SITE_ID 
                 AND HCASA.ORG_ID = HCSUA.ORG_ID      
                 AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID     
                 AND PS.LOCATION_ID = HLO.LOCATION_ID     
                 AND HCASA.ORG_ID IN (SELECT ORGANIZATION_ID FROM STG_CANADA_VIEWS.V_PLANTS WHERE LEGALENTITY_ID IN ('191') GROUP BY 1 )     
     )A
     INNER JOIN
               (
                    SELECT 
                          HCSUA.`LOCATION`                         AS BILLTONUMBER
                         ,HCA.ACCOUNT_NUMBER                     AS BILLTONUMBER2          
                         ,COALESCE(HCA.ACCOUNT_NAME,'UNASSIGNED')AS BILLTONAME1
                         ,HLO.ADDRESS1                           AS BILLTOADDRESS1
                         ,HLO.ADDRESS2                           AS BILLTOADDRESS2
                         ,HLO.CITY                               AS BILLTOCITY
                         ,HLO.PROVINCE                           AS BILLTOSTATEPROV
                         ,HLO.POSTAL_CODE                        AS BILLTOZIPCODE 
                         ,HPB.COUNTRY                            AS BILLTOCOUNTRY                
                    FROM DWH_OPERERP_GLOBAL.HZ_CUST_ACCOUNTS HCA                       
                          ,DWH_OPERERP_GLOBAL.HZ_CUST_ACCT_SITES_ALL      HCASA             
                          ,DWH_OPERERP_GLOBAL.HZ_PARTIES HPB                                
                          ,DWH_OPERERP_GLOBAL.HZ_PARTIES HPR                                
                          ,DWH_OPERERP_GLOBAL.HZ_PARTIES HPN                                
                          ,DWH_OPERERP_GLOBAL.HZ_PARTY_SITES PS       
                          ,DWH_OPERERP_GLOBAL.HZ_CUST_SITE_USES_ALL HCSUA      
                          ,DWH_OPERERP_GLOBAL.HZ_LOCATIONS HLO     
                         WHERE HCA.PARTY_ID = HPB.PARTY_ID                                  
                           AND HCA.PARTY_ID = HPR.PARTY_ID                                  
                           AND HCA.PARTY_ID = HPN.PARTY_ID                                  
                           AND HCA.PARTY_ID = PS.PARTY_ID                                   
                           AND HCA.CUST_ACCOUNT_ID = HCASA.CUST_ACCOUNT_ID                                   
                           AND HCASA.CUST_ACCT_SITE_ID = HCSUA.CUST_ACCT_SITE_ID 
                           AND HCASA.ORG_ID = HCSUA.ORG_ID      
                           AND PS.PARTY_SITE_ID = HCASA.PARTY_SITE_ID     
                           AND PS.LOCATION_ID = HLO.LOCATION_ID     
                           AND HCASA.ORG_ID IN (SELECT ORGANIZATION_ID FROM STG_CANADA_VIEWS.V_PLANTS WHERE LEGALENTITY_ID IN ('191') GROUP BY 1 )     
               )B ON A.SHIPTONUMBER = B.BILLTONUMBER
WHERE SHIPTONAME1 LIKE '%WENDY%';
