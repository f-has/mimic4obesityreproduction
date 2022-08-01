WITH t1 AS (SELECT ie.subject_id, ie.hadm_id, ie.stay_id,age.admittime
--create exclusion/inclusion criteria  for age (exclude anyone younger than 16)
,CASE WHEN age.anchor_age >= 16 THEN 0 ELSE 1 END AS exclude_non_adult
--rank by intime
,ROW_NUMBER() over (partition by ie.subject_id order by ie.intime) as icustay_id_order
FROM `physionet-data.mimic_icu.icustays` ie
INNER JOIN `physionet-data.mimic_derived.age` age
ON ie.hadm_id = age.hadm_id)

--**create exclusion/inclusion criteria for multiple readmission (exclude anyone with more than 1 readmission-keep first icu visit)
,t2 AS
(SELECT * EXCEPT (icustay_id_order), CASE WHEN t1.icustay_id_order=1 THEN 0 ELSE 1 END AS exclude_readmission
FROM t1)


--SELECT relevant lab results prior to admission ( white blood cells,sodium, platelets, potasium, creatinine, BUN, AND bicarbonate)
,t3 as (SELECT DISTINCT subject_id, hadm_id,charttime,itemid
from `physionet-data.mimic_hosp.labevents`
--use complete blood count, and blood chemistry
where itemid in (51753,51300,51301,51265,50983,50971,51006,50912,50882)  AND valuenum IS NOT NULL
--filter by hadm_id null because values taken before hospital admission 
AND hadm_id IS NULL
)

--partition first day lab results, using first hadm
,t3_temp AS( 
  SELECT adm.admittime,adm.subject_id,adm.hadm_id
  ,ROW_NUMBER() over (PARTITION BY  adm.subject_id order by adm.admittime) as hadm_id_order
  FROM `physionet-data.mimic_core.admissions` adm
)


---select first hospital admission so we can use first admission recorded per patient to calculate results
,t3_temp2 AS (SELECT * FROM t3_temp
WHERE hadm_id_order=1)


--Create exclusion/inclusion criteria for lab results within (1yr before admission-3days before admission)(exclude without requirements)

,t4_temp AS 
(SELECT t3_temp2.subject_id, t3_temp2.hadm_id,t3.charttime,t3_temp2.admittime,t3.itemid
,CASE WHEN t3.charttime BETWEEN
DATETIME_SUB(t3_temp2.admittime, INTERVAL '1' YEAR) AND DATETIME_SUB(t3_temp2.admittime, INTERVAL '3' DAY) THEN 0 ELSE 1
END AS exclude_lab_result
FROM t3_temp2
INNER JOIN t3
ON t3_temp2.subject_id = t3.subject_id)


-----group lab results by subject ID, then select subjects where exclusion avg column is zero- or all lab results are present

,t4_temp2 AS 
(
  SELECT subject_id, SUM(exclude_lab_result) AS tot_ex_lab
  FROM t4_temp
  GROUP BY subject_id
)

--add exclusion column ***

,t4 AS (
  SELECT subject_id, 
  CASE WHEN tot_ex_lab=0 THEN 0 ELSE 1 END AS exclude_lab_result
  FROM t4_temp2
)

---select admission weight and daily weight measurement- weight durations

,t5 AS
(
SELECT
c.subject_id,c.stay_id
, c.charttime, ie.intime
, c.valuenum as weight
FROM `physionet-data.mimic_icu.chartevents` c
--Join to get inntime for icustay
LEFT JOIN `physionet-data.mimic_icu.icustays` ie
ON c.stay_id = ie.stay_id
WHERE c.valuenum IS NOT NULL
AND c.itemid in (
226512 -- Admit Wt
, 224639 -- Daily Weight ) AND c.valuenum > 0
) 
)
 

--filter to include weights within 24hours only
, t6 AS (
SELECT subject_id,weight
FROM t5
WHERE t5.charttime BETWEEN
DATETIME_SUB(t5.intime, INTERVAL '24' HOUR) AND DATETIME_ADD(t5.intime, INTERVAL '24' HOUR) 
)

-- take mean weight by subject_id create exclusion/inclusion criteria for lab results for weight- include all (0)

,t7 AS
(SELECT t6.subject_id, AVG(t6.weight) AS avg_weight
  FROM T6
  GROUP BY t6.subject_id
)

--Create Exclusion/Inclusion Criteria for weight 
,t8 AS 
(SELECT *,
CASE WHEN avg_weight IS NOT NULL THEN 0 ELSE 1 END AS exclude_weight
FROM t7
)

--Select  max height measured (in cm) during admission and create exclusion/inclusion criteria for height.
,t9 AS (SELECT h.subject_id AS sub_id,MAX(h.height) as height
FROM `physionet-data.mimic_derived.height` h
group by sub_id)

--Create exclusion criteria for height
,t10 AS 
(SELECT *,
CASE WHEN height is NOT NULL THEN 0 ELSE 1 END AS exclude_height
FROM t9)

--Calculate BMI using  average weight and join weight table
,t11 AS
(SELECT * EXCEPT(sub_id)
FROM t8
FULL JOIN t10
ON t8.subject_id=t10.sub_id
WHERE avg_weight is not null and height is not null)

,t12 as
(SELECT *, t11.avg_weight/(t11.height*t11.height/10000) as bmi
FROM t11)

--group normal weight as 1, overweight as 2 

,t13 AS

(SELECT *,
CASE WHEN bmi >= 18.5 AND bmi < 24.999999999 THEN 0
WHEN bmi >= 30 THEN 1
ELSE NULL END AS bmi_group
FROM t12)

--**Create exclusion criteria for BMI- table includes exclude_height and exclude_weight
,t14 AS
(SELECT *
,CASE WHEN bmi_group IS NOT NULL THEN 0 ELSE 1 END AS exclude_bmi
FROM t13)

,coh_temp AS--merge tables and select final cohort--
(SELECT t2.subject_id, t2.hadm_id, t2.stay_id,t2.admittime,t2.exclude_non_adult,t2.exclude_readmission
,t4.exclude_lab_result,t14.exclude_weight, t14.exclude_height,t14.exclude_bmi, t14.bmi_group,bmi
from t2
LEFT JOIN t14 
ON t2.subject_id=t14.subject_id
LEFT JOIN t4
ON t2.subject_id=t4.subject_id
)
---select final cohort-- all exclude features =0 
,coh_fin AS (
  SELECT DISTINCT * FROM coh_temp
  WHERE 
  exclude_non_adult=0 AND exclude_readmission=0 AND exclude_lab_result=0
  AND exclude_weight=0 AND exclude_height=0 AND exclude_bmi=0
)


--SELECT * FROM coh_fin

SELECT * 
FROM coh_fin





