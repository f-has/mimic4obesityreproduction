-- Retrieve ICD-9 Diagnosis

WITH t1 AS 
(SELECT coh_fin.subject_id, coh_fin.hadm_id, coh_fin.bmi_group, di.icd_code, di.icd_version,d_di.long_title
---classify disease diagnosis into groups using first 3 numbers in icd_code
--classify Sepsis, including pneumonia for ICD 9
,CASE WHEN CAST(LEFT(di.icd_code,3) AS INT) BETWEEN 480 AND 487 

THEN "Sepsis, including pneumonia"

--Classify Cardiovascular disease for ICD 9
 WHEN CAST(LEFT(di.icd_code,3) AS INT)= 429
THEN "Cardiovascular disease"

--Classify respiratory condition for ICD 9 and 10
WHEN CAST(LEFT(di.icd_code,3) AS INT) BETWEEN 460 AND 519 

THEN "Other respiratory condition"

--Classify Neurlogocial condition for ICD 9 and 10
WHEN CAST(LEFT(di.icd_code,3) AS INT) BETWEEN 290 AND 319 
THEN "Neurolooical condition"
ELSE "Other" 
END AS ICD_diagnosis
FROM `final-project-2022-354718.Obs.final_cohort` AS coh_fin
LEFT JOIN   `physionet-data.mimic_hosp.diagnoses_icd` di
ON coh_fin.hadm_id=di.hadm_id
LEFT JOIN  `physionet-data.mimic_hosp.d_icd_diagnoses` d_di
ON di.icd_code = d_di.icd_code
WHERE di.icd_version=9 AND di.seq_num=1
--remove external causes of morbidity 
AND di.icd_code NOT LIKE '%V%' )



, t2 AS 
(SELECT coh_fin.subject_id, coh_fin.hadm_id,coh_fin.bmi_group,di.icd_code, di.icd_version,d_di.long_title,
---classify disease diagnosis into groups using first 3 numbers in icd_code
--classify Sepsis, including pneumonia for ICD 10  
CASE WHEN 
REGEXP_CONTAINS(LEFT(di.icd_code,3),'^J1[0-9]') 
THEN "Sepsis, including pneumonia"

--Classify Cardiovascular disease for ICD 10
 WHEN (REGEXP_CONTAINS(LEFT(di.icd_code,3), 'I51'))
OR (REGEXP_CONTAINS(LEFT(di.icd_code,3), 'I25'))
THEN "Cardiovascular disease"
--Classify respiratory condition for ICD 9 and 10
WHEN 
REGEXP_CONTAINS(LEFT(di.icd_code,3),('^J[0-9][0-9].*')) 
THEN "Other respiratory condition"

--Classify Neurlogocial condition for ICD 9 and 10
WHEN REGEXP_CONTAINS(LEFT(di.icd_code,3), '^F[0-9][0-9].*')
THEN "Neurolooical condition"
ELSE "Other" 
END AS ICD_diagnosis
FROM `final-project-2022-354718.Obs.final_cohort` AS coh_fin
LEFT JOIN   `physionet-data.mimic_hosp.diagnoses_icd` di
ON coh_fin.hadm_id=di.hadm_id
LEFT JOIN  `physionet-data.mimic_hosp.d_icd_diagnoses` d_di
ON di.icd_code = d_di.icd_code
WHERE di.icd_version=10 AND di.seq_num=1
--remove external causes of morbidity 
AND di.icd_code NOT LIKE '%V%' )


#union ICD 9 and ICD 10 

SELECT *
  FROM t1
 UNION ALL
 SELECT *
  FROM t2



