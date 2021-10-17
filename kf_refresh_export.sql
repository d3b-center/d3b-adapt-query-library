--Need to setup .pgpass with credentials before the psql command below
psql -w -h kf-dataservice-postgres-prd.kids-first.io -U youngnm kfpostgresprd -f kf_refresh_export.sql
--sequencing_experiment
\copy (select uuid,created_at,modified_at,external_id,experiment_date,experiment_strategy,library_name,library_strand,is_paired_end::text,platform,instrument_model,max_insert_size,mean_insert_size,mean_depth,total_reads,mean_read_length,sequencing_center_id,kf_id,visible::text,library_prep,library_selection from sequencing_experiment where kf_id in (select distinct sequencing_experiment_id from sequencing_experiment_genomic_file where genomic_file_id in (select distinct kf_id from genomic_file where kf_id in (select distinct genomic_file_id from biospecimen_genomic_file where biospecimen_id in (select distinct kf_id from biospecimen where participant_id in (select distinct kf_id from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF'))))))) to 'data/sequencing_experiment.csv' with csv header
--sequencing_experiment_genomic_file
\copy (select uuid,created_at,modified_at,visible::text,sequencing_experiment_id,genomic_file_id,external_id,kf_id from sequencing_experiment_genomic_file where genomic_file_id in (select distinct kf_id from genomic_file where kf_id in (select distinct genomic_file_id from biospecimen_genomic_file where biospecimen_id in (select distinct kf_id from biospecimen where participant_id in (select distinct kf_id from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF')))))) to 'data/sequencing_experiment_genomic_file.csv' with csv header
--genomic_file
\copy (select uuid,latest_did,created_at,modified_at,external_id,data_type,file_format,is_harmonized::text,reference_genome,controlled_access::text,availability,kf_id,visible::text,paired_end from genomic_file where kf_id in (select distinct genomic_file_id from biospecimen_genomic_file where biospecimen_id in (select distinct kf_id from biospecimen where participant_id in (select distinct kf_id from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF'))))) to 'data/genomic_file.csv' with csv header
--biospecimen_genomic_file
\copy (select uuid,created_at,modified_at,genomic_file_id,biospecimen_id,kf_id,visible::text,external_id from biospecimen_genomic_file where biospecimen_id in (select distinct kf_id from biospecimen where participant_id in (select distinct kf_id from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF')))) to 'data/biospecimen_genomic_file.csv' with csv header
--biospecimen
\copy (select uuid,created_at,modified_at,external_sample_id,external_aliquot_id,source_text_tissue_type,composition,source_text_anatomical_site,age_at_event_days,source_text_tumor_descriptor,shipment_origin,analyte_type,concentration_mg_per_ml,volume_ul,shipment_date,uberon_id_anatomical_site,ncit_id_tissue_type,ncit_id_anatomical_site,spatial_descriptor,participant_id,sequencing_center_id,kf_id,dbgap_consent_code,visible::text,consent_type,method_of_sample_procurement,duo_ids from biospecimen where participant_id in (select distinct kf_id from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF'))) to 'data/biospecimen.csv' with csv header
--participant
\copy (select uuid,created_at,modified_at,external_id,family_id,is_proband::text,race,ethnicity,gender,study_id,alias_group_id,kf_id,visible::text,affected_status::text,diagnosis_category,species from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF')) to 'data/participant.csv' with csv header
--biospecimen_diagnosis
\copy (select uuid,created_at,modified_at,diagnosis_id,biospecimen_id,kf_id,visible::text,external_id from biospecimen_diagnosis where diagnosis_id in (select distinct kf_id from diagnosis where participant_id in (select distinct kf_id from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF')))) to 'data/biospecimen_diagnosis.csv' with csv header
--diagnosis
\copy (select uuid,created_at,modified_at,external_id,source_text_diagnosis,diagnosis_category,source_text_tumor_location,age_at_event_days,mondo_id_diagnosis,icd_id_diagnosis,uberon_id_tumor_location,ncit_id_diagnosis,spatial_descriptor,participant_id,kf_id,visible::text from diagnosis where participant_id in (select distinct kf_id from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF'))) to 'data/diagnosis.csv' with csv header
--outcome
\copy (select uuid,created_at,modified_at,external_id,vital_status,disease_related,age_at_event_days,participant_id,kf_id,visible::text from outcome where participant_id in (select distinct kf_id from participant where study_id in ('SD_BHJXBDQK','SD_M3DBXD12', 'SD_8Y99QZJJ','SD_78B1EQ4Z','SD_6G58HHSX','SD_DYPMEHHF'))) to 'data/outcome.csv' with csv header