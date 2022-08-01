--ICU Procedures in the first 24 hr of ICU admission (Mechanical ventilation,Vasopressors,Renal replacement therapy)

--t1 to gather measurements for first 24 for mechanical ventilation 

WITH t1 AS 
(SELECT distinct (ve.stay_id)
--rank to determine first icu stay_id
, ROW_NUMBER () OVER (PARTITION BY ve.stay_id order by ve.starttime) AS icustay_id_order
--rank to determine if mechanical ventilation was conducted within first 24 hours
,CASE WHEN ve.starttime  BETWEEN
DATETIME_SUB(ie.intime, INTERVAL '24' HOUR) AND DATETIME_ADD(ie.intime, INTERVAL '24' HOUR) THEN 1
ELSE 0 END AS  first_24 
FROM `physionet-data.mimic_derived.ventilation` ve
LEFT JOIN `physionet-data.mimic_icu.icustays` ie
ON ve.stay_id = ie.stay_id
--Pull only ventstatus that is mechanical ventilation 
WHERE ventilation_status = "InvasiveVent" OR ventilation_status= "Tracheostomy")

--SELECT first ICU visit FROM mechanical ventilation taken within the first 24hours **

,t2 AS (SELECT t1.stay_id, coh_fin.bmi_group, 
CASE WHEN icustay_id_order = 1 AND first_24 = 1
THEN 'Y' ELSE 'N' END AS mech_vent
FROM `final-project-2022-354718.Obs.final_cohort`  coh_fin 
LEFT JOIN t1
ON t1.stay_id = coh_fin.stay_id)

--SELECT first day rrt and join to cohort final ***

,t3 AS (SELECT coh_fin.stay_id,coh_fin.bmi_group,
CASE WHEN rrt.dialysis_present=1 THEN 'Y' ELSE 'N' END AS rrt
FROM `final-project-2022-354718.Obs.final_cohort`  coh_fin 
LEFT JOIN `physionet-data.mimic_derived.first_day_rrt` rrt
ON coh_fin.stay_id = rrt.stay_id
)



--t4 to gather amount of Vassopressors for first 24  
-- This query extracts durations of vasopressor administration. It groups together any administration of the below list of drugs and selects uses starttime of vasopressor to determine whether vassopressor was given to subject. 


--  norepinephrine `physionet-data.mimic_derived.norepinephrine` 
--  epinephrine `physionet-data.mimic_derived.epinephrine`` 
--  phenylephrine `physionet-data.mimic_derived.phenylephrine`
--  vasopressin `physionet-data.mimic_derived.vasopressin`
--  dopamine  `physionet-data.mimic_derived.dopamine`
--  dobutamine `physionet-data.mimic_derived.dobutamine`
--  milrinone `physionet-data.mimic_derived.milrinone`


-- union all the above tables 

,t4 AS (
  SELECT * 
  FROM `physionet-data.mimic_derived.norepinephrine`
  
  UNION ALL
SELECT *
FROM `physionet-data.mimic_derived.epinephrine`

  UNION ALL
  SELECT *
FROM `physionet-data.mimic_derived.phenylephrine` 

UNION ALL
SELECT *
FROM `physionet-data.mimic_derived.vasopressin`

UNION ALL
SELECT *
FROM  `physionet-data.mimic_derived.dopamine`

UNION ALL
SELECT *
FROM `physionet-data.mimic_derived.dobutamine`

UNION ALL
SELECT *
FROM `physionet-data.mimic_derived.milrinone`
)


--filter to only include those within 24hours of ICU admission 

, t5 AS (SELECT  t4.stay_id, t4.starttime,ie.intime
FROM t4
LEFT JOIN `physionet-data.mimic_icu.icustays` ie 
ON t4.stay_id = ie.stay_id
WHERE t4.starttime BETWEEN DATETIME_SUB (ie.intime, INTERVAL '24' HOUR) AND DATETIME_ADD(ie.intime, INTERVAL '24' HOUR) 
)

---select maximum value 
,t6 AS (SELECT stay_id, MAX(starttime) as max_start
FROM t5
GROUP BY stay_id
)

--FIND subjects that were given vassopressors with the final cohort. **

,t7 AS (
  SELECT coh_fin.stay_id ,t6.max_start, coh_fin.bmi_group,
  CASE WHEN max_start IS NOT NULL THEN 'Y' ELSE 'N' END AS vassopressor
  FROM `final-project-2022-354718.Obs.final_cohort`  coh_fin 
  LEFT JOIN  t6
  ON coh_fin.stay_id = t6.stay_id 
)



--select t2, t3, t7 to generate tables for mechanical ventilation, renal replacement therapy, vassopressors 
SELECT* FROM t3










