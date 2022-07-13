-- Select relevant columns from cbtn_all for pilot format and implement logic to hide treatment info for non-Initial CNS records.
with minimal_report as (
select distinct
    "CBTN Subject ID",
    "Gender",
    "Race",
    "Ethnicity",
    "Last Known Clinical Status",
    "Age at Last Known Clinical Status",
    "Diagnosis Type",
    "Age at Diagnosis"::int,
    "CBTN Specimen Group ID",
    "Diagnosis",
    "Other Diagnosis Description",
    "Tumor Location",
    "Tumor Location Other",
    "Metastasis",
    "Metastasis Location(s)",
    "Metastasis Location Other",
    case when "Diagnosis Type" like 'Deceased%' then 'Deceased' else "Follow up Event" end as "Follow up Event",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Surgery"  end as "Surgery" ,
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Extent of Tumor Resection" end as "Extent of Tumor Resection",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Radiation" end as "Radiation",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Age at Radiation Start" end as "Age at Radiation Start" ,
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Age at Radiation Stop" end as "Age at Radiation Stop",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Completed Radiation Dose" end as "Completed Radiation Dose",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Completed Dose Measurement" end as "Completed Dose Measurement",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Completed Total Radiation Focal Dose" end as "Completed Total Radiation Focal Dose",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Focal Dose Measurement" end as "Completed Focal Radiation Dose",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Radiation Site" end as "Radiation Site",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Radiation Type" end as "Radiation Type",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Chemotherapy" end as "Chemotherapy",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Age at Chemotherapy Start" end as "Age at Chemotherapy Start" ,
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Age at Chemotherapy Stop" end as "Age at Chemotherapy Stop",
    case when "Diagnosis Type" <> 'Initial CNS Tumor' then 'Not Available' else "Autologous Stem Cell Transplant" end as "Autologous Stem Cell Transplant",
    "Cancer Predispositions",
    "Cancer Predispositions Other",
    "event_order"::int
from vankurenn_dev_schema_reporting.cbtn_all
where "CBTN Subject ID" in (
    -- Add C ID list here
)
order by "CBTN Subject ID", "Age at Diagnosis"::int, event_order::int asc

)

-- Need to update to Initial records not excluded
select * from minimal_report
where "Follow up Event" in ('Diagnosis', 'Deceased', 'Not Applicable')
or ("Surgery" not in ('Not Available','Not Applicable')
or "Radiation" not in ('Not Available','Not Applicable')
or "Chemotherapy" not in ('Not Available', 'Not Applicable') )