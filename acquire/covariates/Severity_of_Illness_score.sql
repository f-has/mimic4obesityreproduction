---SAPS AND SOFA SCORES to caclculate severity of illness--take average of the sapsii and sofa score and group by average

WITH t1 AS 
(SELECT coh_fin.stay_id, AVG(sofa.sofa_24hours) as sofa_score, AVG(saps.sapsii) as sapsii_score
from `final-project-2022-354718.Obs.final_cohort` AS coh_fin
left join physionet-data.mimic_derived.sapsii saps
ON coh_fin.stay_id = saps.stay_id
left join `physionet-data.mimic_derived.sofa` sofa
ON coh_fin.stay_id = sofa.stay_id
GROUP BY coh_fin.stay_id)

--PULL BMI group
SELECT t1.stay_id, t1.sapsii_score,t1.sofa_score, coh_fin.bmi_group
FROM t1 
LEFT JOIN `final-project-2022-354718.Obs.final_cohort` AS coh_fin
ON t1.stay_id=coh_fin.stay_id

