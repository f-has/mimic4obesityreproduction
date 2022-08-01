--Baseline Demographics and group variables into respective categories

WITH t1 AS (SELECT adm.subject_id, adm.hadm_id,ie.stay_id, pat.gender,age.age,adm.ethnicity, adm.admittime,adm.dischtime,adm.marital_status
,adm.insurance,adm.admission_type, ie.first_careunit, adm.admission_location,adm.hospital_expire_flag 
FROM `physionet-data.mimic_core.admissions` adm
INNER JOIN `physionet-data.mimic_derived.age` age
ON adm.subject_id=age.subject_id
INNER JOIN `physionet-data.mimic_core.patients` pat
ON adm.subject_id=pat.subject_id
INNER JOIN `physionet-data.mimic_icu.icustays` ie
ON adm.hadm_id=ie.hadm_id
ORDER BY subject_id, hadm_id)

--categorize variables to match categories in study
--remove column used to group categories and duplicates
,t2 AS ( SELECT DISTINCT * EXCEPT(marital_status,insurance,admission_type,admission_location,
first_careunit)

 --categorize marital status into married, (single/divorced/seperated), other/unknown
,CASE WHEN t1.marital_status = "MARRIED" THEN "Married"
WHEN t1.marital_status = "DIVORCED" THEN "Single/divorced/separated"
ELSE "other/unknown" END AS marital_status_fin

-- categorize insurance type as Medicare/Medicaid or Private/other
,CASE WHEN t1.insurance IN ("Medicare","Medicaid") THEN "Medicare/Medicaid"
ELSE "Private/Other" END AS insurance_fin

-- Categorize Admission type as Elective, Emergency,Urgent , Other)--- add other
,CASE WHEN t1.admission_type IN("DIRECT EMER.","EW EMER.") THEN "Emergency" 
WHEN t1.admission_type = "URGENT" THEN "Urgent"
WHEN t1.admission_type = "ELECTIVE" THEN "Elective"
ELSE "Other" END AS admission_type_fin

-- Categorize Source of Admission (Emergency room,Physician referral,Other)
,CASE WHEN t1.admission_location = "EMERGENCY ROOM" THEN "Emergency room"
WHEN t1.admission_location = "PHYSICIAN REFERRAL" THEN "Physician referral"
ELSE "Other" END AS source_of_admission_fin

-- Categorize ICU admission type (Cardiac surgery recovery unit,Medical ICU, Surgical ICU/trauma ICU/coronary care unit) -- added neuro
--Medical/Surgical Intensive Care Unit (MICU/SICU) group as MICU and Neuro stepdown and Neuro Intermediate grouped as Neuro Surgical Intensive Care Unit (Neuro SICU) grouped with SICU
,CASE WHEN t1.first_careunit = "Cardiac Vascular Intensive Care Unit (CVICU)" THEN "Cardiac surgery recovery unit"
WHEN t1.first_careunit IN ("Medical Intensive Care Unit (MICU)","Medical/Surgical Intensive Care Unit (MICU/SICU)" ) 
THEN "Medical ICU"
WHEN  t1.first_careunit  IN ("Neuro Stepdown","Neuro Intermediate") THEN "Neuro"
ELSE "Surgical ICU/trauma ICU/coronary care unit" END AS icu_adm_type_fin
FROM t1
)


--retrieve comborbidity index using charlson comorbidity index
,t3 AS
(SELECT hadm_id AS hadm_id2, charlson_comorbidity_index 
 FROM `physionet-data.mimic_derived.charlson` )


--MERGE Final cohort with final demographic (t2) and  comorbidity index using charlson to get final demographic for cohort on stay_id and hadm_id
,t4 AS (SELECT * EXCEPT (hadm_id2)
FROM `final-project-2022-354718.Obs.final_cohort` AS coh_fin
LEFT JOIN t2
ON coh_fin.stay_id=t2.stay_id
LEFT JOIN t3
ON t2.hadm_id=t3.hadm_id2
)


SELECT * FROM  t4



