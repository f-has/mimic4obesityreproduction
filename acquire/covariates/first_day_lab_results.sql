--table generates final cohort first day lab results for wbc,platelets, sodium, potassium, BUN, creatinine,BIC

SELECT  coh_fin.stay_id,coh_fin.bmi_group, lab_first.wbc_max as icu_wbc, lab_first.platelets_max as icu_platelets, --select max value for each variable
lab_first.sodium_max as icu_NA, lab_first.potassium_max as icu_k, lab_first.bun_max as icu_BUN, 
lab_first.creatinine_max as icu_Cr, lab_first.bicarbonate_max as icu_BIC
FROM `final-project-2022-354718.Obs.final_cohort`  coh_fin 
LEFT JOIN `physionet-data.mimic_derived.first_day_lab` lab_first
ON coh_fin.stay_id = lab_first.stay_id
