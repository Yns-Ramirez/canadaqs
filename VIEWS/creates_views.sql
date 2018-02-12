drop view if exists dwh_opererp_global.hz_cust_accounts;
drop view if exists dwh_opererp_global.hz_cust_acct_sites_all;
drop view if exists dwh_opererp_global.hz_parties;
drop view if exists dwh_opererp_global.hz_party_sites;
drop view if exists dwh_opererp_global.hz_cust_site_uses_all;
drop view if exists dwh_opererp_global.hz_locations;

CREATE view dwh_opererp_global.hz_cust_accounts
AS
  SELECT cust_account_id,
         party_id,
         Coalesce(Substr(last_update_date, 1, 10), '1900-01-01')
            last_update_date,
         Substr(last_update_date, 12, 8)
            last_update_date_h,
         account_number,
         last_updated_by,
         Coalesce(Substr(creation_date, 1, 10), '1900-01-01')
         creation_date,
         Substr(creation_date, 12, 8)
            creation_date_h,
         created_by,
         last_update_login,
         request_id,
         program_application_id,
         program_id,
         Coalesce(Substr(program_update_date, 1, 10), '1900-01-01')
            program_update_date,
         Substr(program_update_date, 12, 8)
            program_update_date_h,
         Coalesce(Substr(wh_update_date, 1, 10), '1900-01-01')
         wh_update_date
            ,
         Substr(wh_update_date, 12, 8)
            wh_update_date_h,
         attribute_category,
         attribute1,
         attribute2,
         attribute3,
         attribute4,
         attribute5,
         attribute6,
         attribute7,
         attribute8,
         attribute9,
         attribute10,
         attribute11,
         attribute12,
         attribute13,
         attribute14,
         attribute15,
         attribute16,
         attribute17,
         attribute18,
         attribute19,
         attribute20,
         global_attribute_category,
         global_attribute1,
         global_attribute2,
         global_attribute3,
         global_attribute4,
         global_attribute5,
         global_attribute6,
         global_attribute7,
         global_attribute8,
         global_attribute9,
         global_attribute10,
         global_attribute11,
         global_attribute12,
         global_attribute13,
         global_attribute14,
         global_attribute15,
         global_attribute16,
         global_attribute17,
         global_attribute18,
         global_attribute19,
         global_attribute20,
         orig_system_reference,
         status,
         customer_type,
         customer_class_code,
         primary_salesrep_id,
         sales_channel_code,
         order_type_id,
         price_list_id,
         subcategory_code,
         tax_code,
         fob_point,
         freight_term,
         ship_partial,
         ship_via,
         warehouse_id,
         payment_term_id,
         tax_header_level_flag,
         tax_rounding_rule,
         coterminate_day_month,
         primary_specialist_id,
         secondary_specialist_id,
         account_liable_flag,
         restriction_limit_amount,
         current_balance,
         password_text,
         high_priority_indicator,
         Coalesce(Substr(account_established_date, 1, 10), '1900-01-01')
            account_established_date,
         Substr(account_established_date, 12, 8)
            account_established_date_h,
         Coalesce(Substr(account_termination_date, 1, 10), '1900-01-01')
            account_termination_date,
         Substr(account_termination_date, 12, 8)
            account_termination_date_h,
         Coalesce(Substr(account_activation_date, 1, 10), '1900-01-01')
            account_activation_date,
         Substr(account_activation_date, 12, 8)
            account_activation_date_h,
         credit_classification_code,
         department,
         major_account_number,
         hotwatch_service_flag,
         hotwatch_svc_bal_ind,
         Coalesce(Substr(held_bill_expiration_date, 1, 10), '1900-01-01')
            held_bill_expiration_date,
         Substr(held_bill_expiration_date, 12, 8)
            held_bill_expiration_date_h,
         hold_bill_flag,
         high_priority_remarks,
         Coalesce(Substr(po_effective_date, 1, 10), '1900-01-01')
            po_effective_date,
         Substr(po_effective_date, 12, 8)
            po_effective_date_h,
         Coalesce(Substr(po_expiration_date, 1, 10), '1900-01-01')
            po_expiration_date,
         Substr(po_expiration_date, 12, 8)
            po_expiration_date_h,
         realtime_rate_flag,
         single_user_flag,
         watch_account_flag,
         watch_balance_indicator,
         geo_code,
         acct_life_cycle_status,
         account_name,
         deposit_refund_method,
         dormant_account_flag,
         npa_number,
         pin_number,
         Coalesce(Substr(suspension_date, 1, 10), '1900-01-01')
            suspension_date,
         Substr(suspension_date, 12, 8)
            suspension_date_h,
         write_off_adjustment_amount,
         write_off_payment_amount,
         write_off_amount,
         source_code,
         competitor_type,
         comments,
         dates_negative_tolerance,
         dates_positive_tolerance,
         date_type_preference,
         over_shipment_tolerance,
         under_shipment_tolerance,
         over_return_tolerance,
         under_return_tolerance,
         item_cross_ref_pref,
         ship_sets_include_lines_flag,
         arrivalsets_include_lines_flag,
         sched_date_push_flag,
         invoice_quantity_rule,
         pricing_event,
         account_replication_key,
         Coalesce(Substr(status_update_date, 1, 10), '1900-01-01')
            status_update_date,
         Substr(status_update_date, 12, 8)
            status_update_date_h,
         autopay_flag,
         notify_flag,
         last_batch_id,
         org_id,
         object_version_number,
         created_by_module,
         application_id,
         selling_party_id,
         To_date(From_unixtime(Unix_timestamp()))                   storeday
  FROM   erp_pgbari_sz.hz_cust_accounts_ar;



CREATE view dwh_opererp_global.hz_cust_acct_sites_all
AS
  SELECT cust_acct_site_id,
         cust_account_id,
         party_site_id,
         Coalesce(Substr(last_update_date, 1, 10), '1900-01-01')
            last_update_date,
         Substr(last_update_date, 12, 8)
            last_update_date_h,
         last_updated_by,
         Coalesce(Substr(creation_date, 1, 10), '1900-01-01')
         creation_date,
         Substr(creation_date, 12, 8)
            creation_date_h,
         created_by,
         last_update_login,
         request_id,
         program_application_id,
         program_id,
         Coalesce(Substr(program_update_date, 1, 10), '1900-01-01')
            program_update_date,
         Substr(program_update_date, 12, 8)
            program_update_date_h,
         Coalesce(Substr(wh_update_date, 1, 10), '1900-01-01')
         wh_update_date
            ,
         Substr(wh_update_date, 12, 8)
            wh_update_date_h,
         attribute_category,
         attribute1,
         attribute2,
         attribute3,
         attribute4,
         attribute5,
         attribute6,
         attribute7,
         attribute8,
         attribute9,
         attribute10,
         attribute11,
         attribute12,
         attribute13,
         attribute14,
         attribute15,
         attribute16,
         attribute17,
         attribute18,
         attribute19,
         attribute20,
         global_attribute_category,
         global_attribute1,
         global_attribute2,
         global_attribute3,
         global_attribute4,
         global_attribute5,
         global_attribute6,
         global_attribute7,
         global_attribute8,
         global_attribute9,
         global_attribute10,
         global_attribute11,
         global_attribute12,
         global_attribute13,
         global_attribute14,
         global_attribute15,
         global_attribute16,
         global_attribute17,
         global_attribute18,
         global_attribute19,
         global_attribute20,
         orig_system_reference,
         status,
         org_id,
         bill_to_flag,
         market_flag,
         ship_to_flag,
         customer_category_code,
         language                                                   language_1,
         key_account_flag,
         tp_header_id,
         ece_tp_location_code,
         service_territory_id,
         primary_specialist_id,
         secondary_specialist_id,
         territory_id,
         territory,
         translated_customer_name,
         object_version_number,
         created_by_module,
         application_id,
         To_date(From_unixtime(Unix_timestamp()))                   storeday
  FROM   erp_pgbari_sz.hz_cust_acct_sites_all_ar ;


  CREATE view dwh_opererp_global.hz_parties
AS
  SELECT party_id,
         party_number,
         party_name,
         party_type,
         validated_flag,
         last_updated_by,
         Coalesce(Substr(creation_date, 1, 10), '1900-01-01')
         creation_date,
         Substr(creation_date, 12, 8)
            creation_date_h,
         last_update_login,
         request_id,
         program_application_id,
         created_by,
         Coalesce(Substr(last_update_date, 1, 10), '1900-01-01')
            last_update_date,
         Substr(last_update_date, 12, 8)
            last_update_date_h,
         program_id,
         Coalesce(Substr(program_update_date, 1, 10), '1900-01-01')
            program_update_date,
         Substr(program_update_date, 12, 8)
            program_update_date_h,
         Coalesce(Substr(wh_update_date, 1, 10), '1900-01-01')
         wh_update_date
            ,
         Substr(wh_update_date, 12, 8)
            wh_update_date_h,
         attribute_category,
         attribute1,
         attribute2,
         attribute3,
         attribute4,
         attribute5,
         attribute6,
         attribute7,
         attribute8,
         attribute9,
         attribute10,
         attribute11,
         attribute12,
         attribute13,
         attribute14,
         attribute15,
         attribute16,
         attribute17,
         attribute18,
         attribute19,
         attribute20,
         attribute21,
         attribute22,
         attribute23,
         attribute24,
         global_attribute_category,
         global_attribute1,
         global_attribute2,
         global_attribute4,
         global_attribute3,
         global_attribute5,
         global_attribute6,
         global_attribute7,
         global_attribute8,
         global_attribute9,
         global_attribute10,
         global_attribute11,
         global_attribute12,
         global_attribute13,
         global_attribute14,
         global_attribute15,
         global_attribute16,
         global_attribute17,
         global_attribute18,
         global_attribute19,
         global_attribute20,
         orig_system_reference,
         sic_code,
         hq_branch_ind,
         customer_key,
         tax_reference,
         jgzz_fiscal_code,
         duns_number,
         tax_name,
         person_pre_name_adjunct,
         person_first_name,
         person_middle_name,
         person_last_name,
         person_name_suffix,
         person_title,
         person_academic_title,
         person_previous_last_name,
         known_as,
         person_iden_type,
         person_identifier,
         group_type,
         country,
         address1,
         address2,
         address3,
         address4,
         city,
         postal_code,
         state,
         province,
         status,
         county,
         sic_code_type,
         total_num_of_orders,
         total_ordered_amount,
         Coalesce(Substr(last_ordered_date, 1, 10), '1900-01-01')
            last_ordered_date,
         Substr(last_ordered_date, 12, 8)
            last_ordered_date_h,
         url,
         email_address,
         do_not_mail_flag,
         analysis_fy,
         fiscal_yearend_month,
         employees_total,
         curr_fy_potential_revenue,
         next_fy_potential_revenue,
         year_established,
         gsa_indicator_flag,
         mission_statement,
         organization_name_phonetic,
         person_first_name_phonetic,
         person_last_name_phonetic,
         language_name,
         category_code,
         reference_use_flag,
         third_party_flag,
         competitor_flag,
         salutation,
         known_as2,
         known_as3,
         known_as4,
         known_as5,
         duns_number_c,
         object_version_number,
         created_by_module,
         application_id,
         To_date(From_unixtime(Unix_timestamp()))                   storeday
  FROM   erp_pgbari_sz.hz_parties_ar ;



CREATE view dwh_opererp_global.hz_party_sites
AS
  SELECT party_site_id,
         party_id,
         location_id,
         Coalesce(Substr(last_update_date, 1, 10), '1900-01-01')
            last_update_date,
         Substr(last_update_date, 12, 8)
            last_update_date_h,
         party_site_number,
         last_updated_by,
         Coalesce(Substr(creation_date, 1, 10), '1900-01-01')
         creation_date,
         Substr(creation_date, 12, 8)
            creation_date_h,
         created_by,
         last_update_login,
         request_id,
         program_application_id,
         program_id,
         Coalesce(Substr(program_update_date, 1, 10), '1900-01-01')
            program_update_date,
         Substr(program_update_date, 12, 8)
            program_update_date_h,
         Coalesce(Substr(wh_update_date, 1, 10), '1900-01-01')
         wh_update_date
            ,
         Substr(wh_update_date, 12, 8)
            wh_update_date_h,
         attribute_category,
         attribute1,
         attribute2,
         attribute3,
         attribute4,
         attribute5,
         attribute6,
         attribute7,
         attribute8,
         attribute9,
         attribute10,
         attribute11,
         attribute12,
         attribute13,
         attribute14,
         attribute15,
         attribute16,
         attribute17,
         attribute18,
         attribute19,
         attribute20,
         global_attribute_category,
         global_attribute1,
         global_attribute2,
         global_attribute3,
         global_attribute4,
         global_attribute5,
         global_attribute6,
         global_attribute7,
         global_attribute8,
         global_attribute9,
         global_attribute10,
         global_attribute11,
         global_attribute12,
         global_attribute13,
         global_attribute14,
         global_attribute15,
         global_attribute16,
         global_attribute17,
         global_attribute18,
         global_attribute19,
         global_attribute20,
         orig_system_reference,
         Coalesce(Substr(start_date_active, 1, 10), '1900-01-01')
            start_date_active,
         Substr(start_date_active, 12, 8)
            start_date_active_h,
         Coalesce(Substr(end_date_active, 1, 10), '1900-01-01')
            end_date_active,
         Substr(end_date_active, 12, 8)
            end_date_active_h,
         region,
         mailstop,
         customer_key_osm,
         phone_key_osm,
         contact_key_osm,
         identifying_address_flag,
         language                                                   language_1,
         status,
         party_site_name,
         addressee,
         object_version_number,
         created_by_module,
         application_id,
         actual_content_source,
         To_date(From_unixtime(Unix_timestamp()))                   storeday
  FROM   erp_pgbari_sz.hz_party_sites_ar;


 create view if not exists dwh_opererp_global.hz_cust_site_uses_all
as
select
      site_use_id
     ,cust_acct_site_id
     ,coalesce(substr(last_update_date,1,10),'1900-01-01') as last_update_date
     ,substr(last_update_date,12,8) as last_update_date_h
     ,last_updated_by
     ,coalesce(substr(creation_date,1,10),'1900-01-01') as creation_date
     ,substr(creation_date,12,8) as creation_date_h
     ,created_by
     ,site_use_code
     ,primary_flag
     ,status
     ,`location`
     ,last_update_login
     ,contact_id
     ,bill_to_site_use_id
     ,orig_system_reference
     ,sic_code
     ,payment_term_id
     ,gsa_indicator
     ,ship_partial
     ,ship_via
     ,fob_point
     ,order_type_id
     ,price_list_id
     ,freight_term
     ,warehouse_id
     ,territory_id
     ,attribute_category
     ,attribute1
     ,attribute2
     ,attribute3
     ,attribute4
     ,attribute5
     ,attribute6
     ,attribute7
     ,attribute8
     ,attribute9
     ,attribute10
     ,request_id
     ,program_application_id
     ,program_id
     ,coalesce(substr(program_update_date,1,10),'1900-01-01') as program_update_date
     ,substr(program_update_date,12,8) as program_update_date_h
     ,tax_reference
     ,sort_priority
     ,tax_code
     ,attribute11
     ,attribute12
     ,attribute13
     ,attribute14
     ,attribute15
     ,attribute16
     ,attribute17
     ,attribute18
     ,attribute19
     ,attribute20
     ,attribute21
     ,attribute22
     ,attribute23
     ,attribute24
     ,attribute25
     ,coalesce(substr(last_accrue_charge_date,1,10),'1900-01-01') as last_accrue_charge_date
     ,substr(last_accrue_charge_date,12,8) as last_accrue_charge_date_h
     ,coalesce(substr(second_last_accrue_charge_date,1,10),'1900-01-01') as second_last_accrue_charge_date
     ,substr(second_last_accrue_charge_date,12,8) as sec_last_accrue_charge_date_h
     ,coalesce(substr(last_unaccrue_charge_date,1,10),'1900-01-01') as last_unaccrue_charge_date
     ,substr(last_unaccrue_charge_date,12,8) as last_unaccrue_charge_date_h
     ,coalesce(substr(second_last_unaccrue_chrg_date,1,10),'1900-01-01') as second_last_unaccrue_chrg_date
     ,substr(second_last_unaccrue_chrg_date,12,8) as sec_last_unaccrue_chrg_date_h
     ,demand_class_code
     ,org_id
     ,tax_header_level_flag
     ,tax_rounding_rule
     ,coalesce(substr(wh_update_date,1,10),'1900-01-01') as wh_update_date
     ,substr(wh_update_date,12,8) as wh_update_date_h
     ,global_attribute1
     ,global_attribute2
     ,global_attribute3
     ,global_attribute4
     ,global_attribute5
     ,global_attribute6
     ,global_attribute7
     ,global_attribute8
     ,global_attribute9
     ,global_attribute10
     ,global_attribute11
     ,global_attribute12
     ,global_attribute13
     ,global_attribute14
     ,global_attribute15
     ,global_attribute16
     ,global_attribute17
     ,global_attribute18
     ,global_attribute19
     ,global_attribute20
     ,global_attribute_category
     ,primary_salesrep_id
     ,finchrg_receivables_trx_id
     ,dates_negative_tolerance as date_negative_tolerance
     ,dates_positive_tolerance
     ,date_type_preference
     ,over_shipment_tolerance
     ,under_shipment_tolerance
     ,item_cross_ref_pref
     ,over_return_tolerance
     ,under_return_tolerance
     ,ship_sets_include_lines_flag
     ,arrivalsets_include_lines_flag
     ,sched_date_push_flag
     ,invoice_quantity_rule
     ,pricing_event
     ,gl_id_rec
     ,gl_id_rev
     ,gl_id_tax
     ,gl_id_freight
     ,gl_id_clearing
     ,gl_id_unbilled
     ,gl_id_unearned
     ,gl_id_unpaid_rec
     ,gl_id_remittance
     ,gl_id_factor
     ,tax_classification
     ,object_version_number
     ,created_by_module
     ,application_id
     ,to_date(from_unixtime(unix_timestamp())) as storeday
from erp_pgbari_sz.hz_cust_site_uses_all_ar;


CREATE view dwh_opererp_global.hz_locations
AS
  SELECT location_id,
         Coalesce(Substr(last_update_date, 1, 10), '1900-01-01')
            last_update_date,
         Substr(last_update_date, 12, 8)
            last_update_date_h,
         last_updated_by,
         Coalesce(Substr(creation_date, 1, 10), '1900-01-01')
         creation_date,
         Substr(creation_date, 12, 8)
            creation_date_h,
         created_by,
         last_update_login,
         request_id,
         program_application_id,
         program_id,
         Coalesce(Substr(program_update_date, 1, 10), '1900-01-01')
            program_update_date,
         Substr(program_update_date, 12, 8)
            program_update_date_h,
         Coalesce(Substr(wh_update_date, 1, 10), '1900-01-01')
         wh_update_date
            ,
         Substr(wh_update_date, 12, 8)
            wh_update_date_h,
         attribute_category,
         attribute1,
         attribute2,
         attribute3,
         attribute4,
         attribute5,
         attribute6,
         attribute7,
         attribute8,
         attribute9,
         attribute10,
         attribute11,
         attribute12,
         attribute13,
         attribute14,
         attribute15,
         attribute16,
         attribute17,
         attribute18,
         attribute19,
         attribute20,
         global_attribute_category,
         global_attribute1,
         global_attribute2,
         global_attribute3,
         global_attribute4,
         global_attribute5,
         global_attribute6,
         global_attribute7,
         global_attribute8,
         global_attribute9,
         global_attribute10,
         global_attribute11,
         global_attribute12,
         global_attribute13,
         global_attribute14,
         global_attribute15,
         global_attribute16,
         global_attribute17,
         global_attribute18,
         global_attribute19,
         global_attribute20,
         orig_system_reference,
         country,
         address1,
         address2,
         address3,
         address4,
         city,
         postal_code,
         state,
         province,
         county,
         address_key,
         address_style,
         validated_flag,
         address_lines_phonetic,
         apartment_flag,
         po_box_number,
         house_number,
         street_suffix,
         apartment_number,
         secondary_suffix_element,
         street,
         rural_route_type,
         rural_route_number,
         street_number,
         building,
         floor                                                      floor_1,
         suite,
         room,
         postal_plus4_code,
         time_zone,
         overseas_address_flag,
         post_office,
         position                                                   position_1,
         delivery_point_code,
         location_directions,
         Coalesce(Substr(address_effective_date, 1, 10), '1900-01-01')
            address_effective_date,
         Substr(address_effective_date, 12, 8)
            address_effective_date_h,
         Coalesce(Substr(address_expiration_date, 1, 10), '1900-01-01')
            address_expiration_date,
         Substr(address_expiration_date, 12, 8)
            address_expiration_date_h,
         address_error_code,
         clli_code,
         dodaac,
         trailing_directory_code,
         language                                                   language_1,
         life_cycle_status,
         short_description,
         description,
         content_source_type,
         loc_hierarchy_id,
         sales_tax_geocode,
         sales_tax_inside_city_limits,
         fa_location_id,
         object_version_number,
         created_by_module,
         application_id,
         timezone_id,
         geometry_status_code,
         actual_content_source,
         To_date(From_unixtime(Unix_timestamp())) storeday
  FROM   erp_pgbari_sz.hz_locations_ar;


-----vistas necesaria para GL_TMA_CB------------------------------------------------------------------------------------------------

CREATE VIEW DWH_OPERERP_GLOBAL.gl_je_lines
AS
SELECT je_header_id, je_line_num,
       coalesce(substr(last_update_date, 1, 10), '1900-01-01') last_update_date,
       substr(last_update_date, 12, 8) last_update_date_h,
       last_updated_by, ledger_id, code_combination_id,
       period_name, coalesce(substr(effective_date, 1, 10), '1900-01-01') effective_date,
       substr(effective_date, 12, 8) effective_date_h,
       status,
       coalesce(substr(creation_date, 1, 10), '1900-01-01') creation_date,
       substr(creation_date, 12, 8) creation_date_h, created_by,
       last_update_login, entered_dr,
       entered_cr,
       accounted_dr,
       accounted_cr,
       description,
       line_type_code,
       reference_1,
       reference_2,
       reference_3,
       reference_4,
       reference_5,
       attribute1,
       attribute2,
       attribute3,
       attribute4,
       attribute5,
       attribute6,
       attribute7,
       attribute8,
       attribute9,
       attribute10,
       attribute11,
       attribute12,
       attribute13,
       attribute14,
       attribute15,
       attribute16,
       attribute17,
       attribute18,
       attribute19,
       attribute20,
       context,
       context2,
       coalesce(substr(invoice_date, 1, 10), '1900-01-01') invoice_date,
       substr(invoice_date, 12, 8) invoice_date_h,
       tax_code,
       invoice_identifier,
       invoice_amount,
       no1,
       stat_amount,
       ignore_rate_flag,
       context3,
       ussgl_transaction_code,
       subledger_doc_sequence_id,
       context4,
       subledger_doc_sequence_value,
       reference_6,
       reference_7,
       gl_sl_link_id,
       gl_sl_link_table,
       reference_8,
       reference_9,
       reference_10,
       global_attribute_category,
       global_attribute1,
       global_attribute2,
       global_attribute3,
       global_attribute4,
       global_attribute5,
       global_attribute6,
       global_attribute7,
       global_attribute8,
       global_attribute9,
       global_attribute10,
       jgzz_recon_status_11i jgzz_recon_status,
       coalesce(substr(jgzz_recon_date_11i, 1, 10), '1900-01-01') jgzz_recon_date,
       substr(jgzz_recon_date_11i, 12, 8) jgzz_recon_date_h, jgzz_recon_id_11i,
       jgzz_recon_ref_11i,
       jgzz_recon_context_11i,
       taxable_line_flag,
       tax_type_code, tax_code_id,
       tax_rounding_rule_code,
       amount_includes_tax_flag,
       tax_document_identifier,
       coalesce(substr(tax_document_date, 1, 10), '1900-01-01') tax_document_date,
       substr(tax_document_date, 12, 8) tax_document_date_h, tax_customer_name,
       tax_customer_reference,
       tax_registration_number,
       tax_line_flag, tax_group_id,
       to_date(from_unixtime(unix_timestamp())) storeday FROM erp_pgbari_sz.gl_je_lines_gl;

CREATE VIEW DWH_OPERERP_GLOBAL.gl_je_headers
AS
SELECT je_header_id,
       coalesce(substr(last_update_date, 1, 10),
       '1900-01-01') last_update_date,
        substr(last_update_date, 12, 8) last_update_date_h,
        last_updated_by, ledger_id, je_category, je_source,
        period_name, name, currency_code,
        status,
        coalesce(substr(date_created, 1, 10), '1900-01-01') date_created,
        substr(date_created, 12, 8) date_created_h, accrual_rev_flag,
        multi_bal_seg_flag,
        actual_flag, tax_status_code,
        conversion_flag,
        coalesce(substr(creation_date, 1, 10), '1900-01-01') creation_date,
        substr(creation_date, 12, 8) creation_date_h,
        created_by,
        last_update_login,
        encumbrance_type_id,
        budget_version_id,
        balanced_je_flag,
        balancing_segment_value,
        je_batch_id,
        from_recurring_header_id,
        unique_date,
        coalesce(substr(earliest_postable_date, 1, 10), '1900-01-01') earliest_postable_date,
        substr(earliest_postable_date, 12, 8)
        earliest_postable_date_h,
        coalesce(substr(posted_date, 1, 10),'1900-01-01') posted_date,
        substr(posted_date, 12, 8) posted_date_h,
        coalesce(substr(accrual_rev_effective_date, 1, 10), '1900-01-01') accrual_rev_effective_date,
        substr(accrual_rev_effective_date, 12, 8) accrual_rev_effective_date_h,
        accrual_rev_period_name,
        accrual_rev_status,
        accrual_rev_je_header_id,
        accrual_rev_change_sign_flag,
        description,
        control_total,
        running_total_dr,
        running_total_cr,
        running_total_accounted_dr,
        running_total_accounted_cr,
        currency_conversion_rate,
        currency_conversion_type,
        coalesce(substr(currency_conversion_date, 1, 10), '1900-01-01') currency_conversion_date,
        substr(currency_conversion_date, 12, 8) currency_conversion_date_h,
        external_reference,
        parent_je_header_id,
        reversed_je_header_id,
        originating_bal_seg_value,
        intercompany_mode,
        dr_bal_seg_value,
        cr_bal_seg_value,
        attribute1,
        attribute2,
        attribute3,
        attribute4,
        attribute5,
        attribute6,
        attribute7,
        attribute8,
        attribute9,
        attribute10,
        context,
        global_attribute_category,
        global_attribute1,
        global_attribute2,
        global_attribute3,
        global_attribute4,
        global_attribute5,
        global_attribute6,
        global_attribute7,
        global_attribute8,
        global_attribute9,
        global_attribute10,
        ussgl_transaction_code,
        ontext2,
        doc_sequence_id,
        doc_sequence_value,
        jgzz_recon_context,
        jgzz_recon_ref,
        to_date(from_unixtime(unix_timestamp())) storeday
        FROM erp_pgbari_sz.gl_je_headers_gl;
