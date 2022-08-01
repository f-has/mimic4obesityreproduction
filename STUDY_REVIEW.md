# Study Review

Review the chosen study as if you were an academic reviewer.


## Study information


### Title

Severity of Illness Scores May Misclassify Critically Ill Obese Patients*


The title of the study with its digital object identifier (DOI).
Severity of Illness Scores May Misclassify Critically Ill Obese Patients*
doi: 10.1097/CCM.0000000000002868


### Objective(s) of the study

Describe the primary and secondary objectives of the research study:

The primary objective Compared deviation from baseline of pertinent ICU laboratory test results between obese and normal weight patients, adjusted for the severity of illness.

The secondary objective is to see whether these differences significant.

### Dataset(s) used

Describe the dataset used in the original study. Include:

* Dataset name and version: Medical Information Mart for Intensive Care (MIMIC-III) database
* DOI (or link if no DOI available): https://mimic.mit.edu/docs/iii/
* Citation: Johnson AE, Pollard TJ, Shen L, et al: MIMIC-III, a freely accessible
critical care database. Sci Data 2016; 3:160035

* Other relevant information (link to dataset documentation, etc): database has been approved by Institutional Review Boards of Beth Israel Deaconess Medical Center (2001-
P-001699/14) and MIT (No. 0403000206).



## Summarize the paper

Summarize the paper's goals and results in your own words.

Past studies have compared physiological differences between obese and normal weight patients. However, The goal of this study  is to see whether the difference between patients who are normal weight and those who are obese for those in the ICU adjusted for the severity of the illness. 

### Strength(s) of the work

Highlight 3 strengths of the work.

•	The study prefaces  with clearly defining the objective, design, setting, patients, intervention type, measurements and main results, and conclusions. This is crucial when doing a first of the paper as it captures the key points a researcher is interested in when doing literature reviews. 
•	The article is concise, it is well written and easy to follow, references to table/chart values were referenced throughout the results and easy to find. The journal follows natural logical manner in research. Definition of concepts are clearly defined, ie. Scientific reasoning behind what constitutes as normal/obese patients. 
•	The exclusion/inclusion criteria is not only mentioned in the methods of the study, but also re-iterated in a flow chart. This makes it easy to reproduce when determining the final cohort table. 
### Weakness(es) of the work

Highlight 3 weaknesses of the work.
•	Mention of data exclusions mentioned reason behind filtering. This was explained using a flow diagram and text, however, reasoning was not included. Why individuals 16 or under were not included was not mentioned. 
•	Mention of what was done in the case of missing data. However, what the threshold for “too much missing data” is not specified. Study didn’t discuss why “bilirubin”  was not included but stated it was removed because  too much of the data was missing. 
•	Data collection strategies specified, however laboratory studies were reported in the range of median for baseline levels, yet, mean was used when describing results between baseline and ICU levels, assuming non-normality. Moreover, ICU lab results were not reported in the study, which makes reproducing the analysis challenging. 

### Anticipated reproducibility challenges

Describe areas of the paper which appear to lack sufficient detail.
•	Different versions of the mimic database.  It appears that data from mimic 3 and mimic 4 differ in several ways. This would pose issues when trying to locate tables and variables when replicating the study. 
•	Some algorithms appear complicated – ie how severity of illness is classified, in addition, NLP use when classing smoker/non smoker which may lead to challenges. 
## Data extraction
Data was extracted from mimic data base. The variables were extracted using SQL queries. Analysis was done using R.

### Variables
List out the covariates and exposures extracted for the study, e.g. admission source.

The variables included in the study was : 

Age, Gender, Ethnicity, Marital Status, Insurance, Comorbidity Index, BMI, Smoker, Admission type, Source of Admission, ICU admission type, Primary International Classification of Disease version 9 diagnosis, Procedures in the first 24 hr of ICU admission, Severity of illness. 



### Outcome(s)

The outcomes of the study include Baseline characteristics for both normal weight and obese patients. 

White blood Cells, Sodium, mmol/L, Potassium, mmol/L, Blood urea nitrogen mg/dL, bicarbonate mg/dL, Creatinine mg/dL, Platelets X 109/L. 

The difference between ICU and Baseline characteristics between all the variables listed: 

White blood Cells, Sodium, mmol/L, Potassium, mmol/L, Blood urea nitrogen mg/dL, bicarbonate mg/dL, Creatinine mg/dL, Platelets X 109/L. 


### Inclusion/Exclusion criteria

Study inclusion criteria: 
first ICU admission of patients 16 years and older and available documentation of height and
weight, as well laboratory test results at baseline and at ICU admission ranging from (3days-1 year). Included individuals with BMI between 18.5-24.9 and those with BMI greater than or equal to 30. 

Exclusions: 
Anyone with more than one ICU visit and younger than 16. Patients without height or age measurements and anyone who didn’t not have reported laboratory values before admission.
Individuals with BMI less than 18.5 and individuals with BMI between 25-30.

### Outlier handling

Outliers were not processed in this study. No mention in the study

### Missing data handling

Missing data was reported in the supplemental tables. http://links.lww.com/CCM/D72. 
However, Bilirubin was removed from laboratory analysis because a large portion was missing. 


## Results

### Population summary

Provide information about the original study's population: sample size, average mortality, etc. Typically the data is presented in the first table (i.e. Table 1). Select a parsimonious set of descriptors which you will compare your reproduction against. At the very least include the sample size and a summary measure of the outcome(s).

original study's population:

After inclusion and exclusion criteria was applied when patients 16 year old or older were admitted on one occasion the original population dropped to 38,367 from the original population of 62,532. Furthermore patients with lab results within the time frame of at most 1 year to 3 days before ICU admission were considered which reduced population to 3,205. The final inclusion/exclusion criteria of BMI reduced population from 3205 to normal weight patients (769) and obese patients to 1258 to a final total population of 2027. 


### Analysis method

Statistical analysis included using Q-Q plots were used to test the assumption of normality. Normal continuous variables were summarized using mean, non-normal variables. Two means were compared using two sample t-test and median values were assessed using Mann-Whitney test, for categorical variables- chi-square tests were used. 

Absolute values at baseline as well as deviations from baseline were compared between normal weight and obese individuals using multivariable linear regression, which was adjusted for by age, gender, comorbidity index, SAPS-II, SOFA, age, and the ICU values of the laboratory tests

Stepwise backward elimination was used where all variables were fit and the final model was selected where only significant variables. Statistical significance was assessed at the 0.05 level. 

Log base 10 was used for variables violating the modelling assumption linear regression. Model was refit using the transformed values.

The effect of statistically significant deviations between obese and normal weight patients were used. A null model was used to fit using SAPS-II, SOFA, age, and the
ICU values of the laboratory tests. Similarly, a model was fit using SAPS-II, SOFA, age, the
ICU values of the laboratory tests, and laboratory values that appeared statistically significant between normal and obese patients. This was then compared to the null model using the likelihood ratio test. 

### Power calculations (if present)

If a power calculation is present, describe the approach and the assumptions made.

No power calculations were made. 

### Evaluation measures

p-value- 0.05 significance for all tests. Stepwise backward elimination was used for model selection. Non-normal variables were adjusted applying a transformation of log base 10. 

### Sensitivity Analyses

Describe any additional sensitivity analyses performed in the study.

No sensitivity analyses was conducted 
