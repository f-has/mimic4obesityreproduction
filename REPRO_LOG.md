# Conclusion for reproduction

The following is a logbook/ultimate conclusion for a reproduction of a published scientific study. Feel free to add/remove sections as you find them useful.

## Title
Reproduction  Study of Severity of Illness Scores May Misclassify Critically Ill Obese Patients*


Reproduction  Study of Severity of Illness Scores May Misclassify Critically Ill Obese Patients*
10.5281/zenodo.6862922

## Known differences

Specify changes to the data processing and/or methodology which are known to you. For each difference, describe: (1) the original study approach, (2) the reproduction approach, (3) the justification for the change. If possible, classify the differences as major (could impact the result of the study) or minor (unlikely to change the result of the study).

--Baseline demographic 

-Hospital admission type:

The original study:
For admission type had 2 categories - Elective, Emergency,Urgent 
The reproduced study:
I opted to include "Other" category when grouping outcomes. 
The reasoning behind this was becasue MIMIC IV has more categories, and there was no indication if that category was present in MIMIC III, to ensure data is not being incorrectly classsified when using CASE WHEN function I opted to include "Other" Category. 
It could impact the summary statistics of the reproduced study in a minor way.
 
-ICU admission type:

The original Study: 
Had 3 groups -Cardiac surgery recovery unit, Medical ICU, Surgical ICU/trauma ICU/coronary care unit
The reproduced Study: 
Had more groups, we categorized ICU admission type (Cardiac surgery recovery unit,Medical ICU, Surgical ICU/trauma ICU/coronary care unit) -- added neuro group
Medical/Surgical Intensive Care Unit (MICU/SICU) group as MICU and Neuro stepdown and Neuro Intermediate grouped as Neuro.  Surgical Intensive Care Unit (Neuro SICU) grouped with SICU
The reasoning behind it  was to ensure the categories were grouped as similarily as the original study. The discrepancies can be a result of changes in the new database. It could impact the summary statistics of the reproduced study in a minor way.

-Procedures of mechanical ventilation:

The original study: 
The procedures within the first 24 hours include mechanical ventilation - in this study I there is no explanation of what is considered mechanical ventilation.
The reproduced study:  
Tracheostomy and invasive ventialtion are grouped together as mechanical ventilation as invasive ventilation is considered is a new classification for mechanical ventilation.
This may impact the count of individuals who underwent mechanical ventilation in a slight way. 

-logistic regression testing the effect of variables on hospital mortality:

The original study: A null (baseline) model was fit composed of SAPS-II, SOFA, age, and the ICU values of the laboratory tests. 
The significant variables in the study were : wbc, log_bun, and log_cr.
The reporoduced study: The reproduced included all models that were significant from the linear regression model. This would impact whether 
This would impact the statistical analysis, the effect on hospital mortality of any statistically
significant deviations found comparing the obese and normal weight groups would be different since the reproduced study has more variables present in the study.


## Unknown differences

Specify changes to the data processing and/or methodology which *may* have occurred, but you are unable to confirm due to ambiguity in the original material studied. For each difference, describe (1) the most specific reference to the approach in the original study, if possible, and (2) the approach taken in the reproduction.


-Baseline Laboratory results: 

-The original study : 
for the cohort creation. Some of the challenges I faced included categorizing baseline laboratory results. In the original study. There was no mention of which type of lab result was included (blood, gas, urine, stool), the orignal study could have used all three when classifying whether the individual had met the window for baseline laboratory results. The study also didn't mention what was done
Reproduced study:
I chose to utilize any blood chemistry measurement lab result that fell within the window and who's measurement units were those reported in the study. In addition, I also added the additional clause requirement that all baseline laboratory results in study have to fall within that window for a subject id to qualify in the cohort. 
The reasoning for this is because the study failed to mention this, so in order to have a consistent method across all baseline lab measurements this would result in a difference in the comparison of baseline laboratory results between normal weight and obeses patients.
I believe this may have a major impact on the study because this is critical outcome variable and I am assuming that the study used blood measurments. 


-ICU laboratory results within first 24 hours:

The original study:
In the original study the study mentions using the most abnormal result for the laboratory result taken within the first 24 hours. No mention of max or min value used
The reproduced study: 
I opted for using the maximum baseline laboratory value for each variable used in the study. 
This may have negative impacts when measuring the difference between baseline and ICU lab results. It will also impact the multiple linear regression conducted in the statistical analysis. 


-Primary International Classification of Disease version 9 diagnosis:

The original study:
In the original study- there is no mention of the what the primary diagnosis is. Since one individual can have multiple diagnosis. 
The reproduced study:
There are two classification methods used in MIMIC IV. In the reproduced study we used both and used ICD diagnosis to classify 4 groups- Sepsis, including pneumonia, Cardiovascular disease,Other respiratory condition, Neurological condition, other. 
The impact of this would be a slight change in the classification, it may lead to an incorrectly classifying the categories.



-SOFA AND SAPSII 
The original- The laboratory parameters included in SAPS-II scorring and SOFA
The reproduced study- we took the average of the SOFA AND SAPS score for averaged for each stay_id.
This will have an impact when building out regression model as we will adjust for this in our reproduction.

## Comparison of population

A table comparing the population measures between the original and the reproduction.

| Medicare/Medicaid                                          | 497 (65)         | 184 (44)       | 709 (56)         | 341 (41)         |
|------------------------------------------------------------|------------------|----------------|------------------|------------------|
| Private/other                                              | 272 (35)         | 240 (57)       | 549 (44)         | 497 (59)         |
| Comorbidity index (median, IQR)                            | 5 (0-10)         | 5 (3-6)        | 2 (0-7)          | 5(3-6)           |
| BMI (kg/m²), (median, IQR)                                 | 23.1 (21.3-24.1) | 23 (21.7-24.3) | 34.3 (31.9-38.2) | 34.1 (31.6-37.3) |
| Smoker, yes, n (%)                                         | 379 (49)         | NA             | 649 (52)         | NA               |
| Admission type, n (%)                                      |                  |                |                  |                  |
| Elective                                                   | 321 (42)         | 56 (13)        | 752 (60)         | 87 (10)          |
| Emergency                                                  | 433 (56)         | 38 (9)         | 491 (39)         | 41 (5)           |
| Urgent                                                     | 15(2)            | 32(8)          | 15 (1)           | 67 (8)           |
| Other                                                      | NA               | 298(70)        | NA               | 643(77)          |
| Emergency room                                             | 310 (40)         | 16 (4)         | 319 (25)         | 7 (8)            |
| Physician referral                                         | 367 (48)         | 365 (86)       | 822 (65)         | 762 (91)         |
| Other, n (%)                                               | 92 (12)          | 43 (10)        | 117 (10)         | 69(8)            |
| Cardiac surgery recovery unit                              | 300 (39)         | 300 (71)       | 726 (58)         | 654 (78)         |
| Medical ICU                                                | 286 (38)         | 29 (7)         | 272 (22)         | 54 (6)           |
| Surgical ICU/trauma CU/coronary care unit                  | 183 (23)         | 89 (20)        | 260 (20)         | 129 (15)         |
| Neurological  unit                                         | NA               | 6 (1)          | NA               | 1(0.001)         |
| Sepsis, including pneumonia                                | 110 (14)         | 3(0.7)         | 188 (15)         | 2(0.3)           |
| Cardiovascular disease                                     | 357 (46)         | 49(12)         | 528 (42)         | 138(17.6)        |
| Other respiratory condition                                | 49 (7)           | 6(1.5)         | 50 (4)           | 16(2)            |
| Neurological condition                                     | 47 (6)           | 0(0)           | 88 (7)           | 0(0)             |
| Other                                                      | 206 (27)         | 350(86)        | 404 (32)         | 628(80)          |
| Mechanical ventilation                                     | 453 (59)         | 453 (59)       | 937 (74)         | 431 (51)         |
| Vasopressors                                               | 346 (45)         | 346 (45)       | 731 (58)         | 518 (62)         |
| Renal replacement therapy                                  | 32 (4)           | 2  (4)         | 35 (3)           | 10 (1.2)         |
| Simplified Acute Physiology score version Il (median, IQR) | 35 (27-45) -     | 34 (27-41)     | 32 (25.2-40)     | 33.5 (27.0-42.0) |
| Sequential Organ Failure Assessment score (median, IQR)    | 4 (2-6)          | 3.6 (2.5-4.9)  | 4 (2-6)          | 3.5 (2.9-5.4)    |


## Comparison of results

A table of the evaluation measures comparing the results in the original study and the reproduction. Also include the final size of the cohort, proportion of individuals excluded, and other important summary measures for the study.

Evaluation measure | Original Study | Reproduction

Baseline measurements:

| Variables                       | Baseline Normal Original | Baseline Normal reproduced | Baseline Obese Original | Obese reproduced | Original p-value | Reproduced P-value |
| ------------------------------- | ------------------------ | -------------------------- | ----------------------- | ---------------- | ---------------- | ------------------ |
| WBC x 109/L, median (IQR)       | 7.3 (5.6-9.5)            | 6.6 (5.5-8.3)              | 7.4 (6-9.1)             | 7.42(6-8.7)      | 0.39             | < 0.001            |
| Sodium, mmol/L, median (IQR)    | 139 (136-141)            | 139 (137-141)              | 140 (137-141)           | 140 (137-141)    | < 0.001          | < 0.19             |
| Potassium, mmol/L, median (IQR) | 4.2+0.5                  | 4.2(4-4.5)                 | 4.2+0.4                 | 4.2(4-4.5)       | 0.63             | 0.96               |
| BUN, mg/dL, median (IQR)        | 18.5 (14-25)             | 17(14-22)                  | 18.4 (15-24.4)          | 18(15-23)        | 0.49             | 0.02               |
| BIC, mg/dL, median (IQR)        | 27 (25-28.7)             | 27 (25-29)                 | 27 (25-28.5)            | 26 (24-28)       | 0.73             | < 0.001            |
| Creatinine, mg/dL, median (IQR) | 0.9 (0.7-1.2)            | 0.9 (0.7-1.2)              | 1 (0.8-1.2)             | 1 (0.8-1.2)      | 0.06             | 0.05               |
| Platelets x 10%/L, median (IQR) | 245 (189-315)            | 222 (183-270)              | 231 (186-284)           | 212 (175-256)    | < 0.001          | 0.03               |

Deviation Measurements 

| Variables                          | Deviation Normal Original | Deviation Baseline Normal reproduced | Deviation Obese original | Deviation Obese reproduced | Deviation Original p-value | Deviation Reproduced P-value |
| ---------------------------------- | ------------------------- | ------------------------------------ | ------------------------ | -------------------------- | -------------------------- | ---------------------------- |
| WBC x 109/L, mean + SD             | 5 (5.9)                   | 7.8(6.1)                             | 6.4+5.9                  | 8.9 (5.5)                  | < 0.001                    | < 0.001                      |
| Sodium, mmol/L, mean + SD          | \-2.6(4.3)                | 0.4(3.6)                             | \-3.2+3.6                | 0.2(5.5)                   | 0.003                      | 0.3                          |
| Potassium, mmol/L, mean + SD       | 0.8(1.1)                  | 0.3(0.6)                             | 1+0.9                    | 0.4(0.6)                   | 0.001                      | < 0.001                      |
| Log (BUN, mg/dl), mean +1 SD       | 0.02(0.2)                 | \-0.03 ( 0.2)                        | 0.01+0.2                 | \-0.02 ( 0.2)              | 0.26                       | 0.11                         |
| BIC, mg/dL, mean +1 SD             | \-4(4.1)                  | \-2.52 ( 3.3)                        | \-4+3.6                  | \-1.89 (3.0)               | 0.8                        | 0.002                        |
| Log (creatinine, mg/dL), mean + SD | 0.01(0.2)                 | \-0.03 ( 0.2)                        | 0.03+0.2                 | 0.02(0.1)                  | 0.05                       | < 0.001                      |
| Platelets x 109/L, mean + SD       | \-75(119)                 | \-51 (64)                            | \-70.679                 | \-35 (50)                  | 0.37                       | < 0.001                      |

TABLE 3. Multivariable Linear Regression of
Laboratory Deviation (Δ = ICU – Baseline)

| Variables                        | Original Study : Adjusted Difference in Deviation (ICU - Baseline) Between Obese and Normal Weight Individuals (95% CI) | original p-value | Reproduce study: Adjusted Difference in Deviation (ICU - Baseline) Between Obese and Normal Weight Individuals (95% CI) | reproduced pvalue |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------- |
| WBC, x 109/L                     | 0.80 (0.27-1.33)                                                                                                        | 0.003            | 0.25(-0.08 to 0.58)                                                                                                     | 0.14              |
| Sodium, mmol/L                   | \-0.06 (-0.40 to 0.28)                                                                                                  | 0.712            | 0.04 (-0.14 to 0.23)                                                                                                    | 0.66              |
| Potassium, mmol/L                | 0.01 (-0.07 to 0.09)                                                                                                    | 0.857            | 0.05(0.02 to 0.08)                                                                                                      | 0.001             |
| log (blood urea nitrogen, mg/dL) | 0.01 (0.00-0.02)                                                                                                        | 0.014            | 0.008 ( 0 to 0.016)                                                                                                     | 0.043             |
| Bicarbonate, mg/dL               | \-0.19 (-0.50 to 0.13)                                                                                                  | 0.254            | 0.03( -0.12 to 0.18)                                                                                                    | 0.658             |
| log (creatinine, mg/dL)          | 0.03 (0.02-0.05)                                                                                                        | 0.001            | \-0.26 (-0.31 to -0.21)                                                                                                 | <0.001            |
| Platelets, x109/L                | 4.94 (-2.48 to 12.36)                                                                                                   | 0.192            | 5.8  (2.61 to 8.94)                                                                                                     | <0.001            |
|  

## Conclusion(s) regarding reproducibility

Highlight specific challenges faced during the reproduction attempt which could be improved upon in the future.


Some of the main challenges faced were during the cohort selection. The paper failed to clearly clarify how some of the criteria were defined 
during the cohort selection. 
For instance the exclusions for the laboratory measurements were challenging to understand. In the original study, it isn't clear what 
laboratory measurement type was used for the inclusion. Certain variables like potassium, sodium, creatinine are measured in blood chemistry, 
urine, blood gas. Moreover, the lab events had multiple measurements for each variable. I opted to stick with blood chemistry as the main criteria 

For what measurment was used. Similarily, the study failed to mention whether all laboratory measurements had to be measured within the time window recorded in the study or just some variables. For each individual to classify as the final cohort, all subjects had to have every measurement present in the time frame. 

Another challenge was the smoker criteria. The orignal study used NLP to detect presence of smoker. The MIMIC IV database didn't have a notes section and patients, hospital, and ICU schemas didn't have an area for this. In addition, I also removed this variable from the reproduced study as it is not used during analysis. 


Another challenge throughout the study was the baseline demographics table replication. Much of the study failed to mention how variables were grouped, and this was very unclear throughout the paper. It required looking into distinct values and original documentations for each variable who's categories deviated from the original study. This not only created issues during the exploratory analysis, it led to further  challenges during statisitcal analysis as variables like severity score , ICU and ICD procedures were over estimated/underestimated which had various statistical tests run on them.

ICU laboratory measurements used in the original study indicated using to most abnormal value for each SOFA AND SAPSII measurement, I used the maximum value for each measurement. However, the study used a mixture of both depending on the variable. 

I think some things that could be improved within the study would be clarifying the above variables in detail for any individual interested in replicating the study. The statistical analysis carried out in the study would have been more accurate and representative for the study. Similarily, another approach to improve reproducibility reasoning behind using certain methodologies. This would address any missing gaps/details the reader had during the initial reproduction. 



