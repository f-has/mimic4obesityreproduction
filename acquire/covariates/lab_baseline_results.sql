--Generate baseline laboratory results 

WITH t1 AS (SELECT 
coh_fin.stay_id
, AVG(case when itemid in (51300,51301,51753) THEN valuenum ELSE NULL END) AS avgwbc_baseline--last one is chemistry
--use blood chemistry
, AVG (case when itemid in (50983) THEN valuenum ELSE NULL END) AS  avgsodium_baseline
, AVG (case when itemid in (50971) THEN valuenum ELSE NULL END) AS  avgpotassium_baseline
, AVG (case when itemid in (51006) THEN valuenum ELSE NULL END) AS  avgbun_baseline
, AVG (case when itemid in (50882) THEN valuenum ELSE NULL END) AS  avgbic_baseline
, AVG (case when itemid in (50912) THEN valuenum ELSE NULL END) AS  avgcreatinine_baseline--1.creatinine 2.Creatinine, Whole Blood
, AVG(case when itemid = 51265 THEN valuenum ELSE NULL END) AS  avgplatelets_baseline
FROM `final-project-2022-354718.Obs.final_cohort` AS coh_fin
INNER JOIN `physionet-data.mimic_core.admissions` adm
ON coh_fin.hadm_id = adm.hadm_id
INNER JOIN `physionet-data.mimic_hosp.labevents` le
ON coh_fin.subject_id = le.subject_id
WHERE le.charttime BETWEEN DATETIME_SUB(adm.admittime, INTERVAL '1' YEAR) AND DATETIME_SUB(adm.admittime, INTERVAL '3' DAY) 
GROUP BY coh_fin.subject_id, coh_fin.hadm_id, coh_fin.stay_id,adm.admittime
ORDER BY coh_fin.stay_id)

--add bmi group 
SELECT t1.stay_id,coh_fin.subject_id, coh_fin.bmi_group
,avgwbc_baseline,t1.avgsodium_baseline,t1.avgpotassium_baseline,	t1.avgbun_baseline,	avgbic_baseline
,avgcreatinine_baseline, avgplatelets_baseline
FROM t1 
LEFT JOIN `final-project-2022-354718.Obs.final_cohort` AS coh_fin
ON  t1.stay_id= coh_fin.stay_id 

