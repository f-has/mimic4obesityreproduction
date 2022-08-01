Replicating a study in MIMIC-IV
This folder contains code for replicating a study on Severity of Illness Scores May Misclassify
Critically Ill Obese Patients

Deliberato RO1, Ko S, Komorowski M, Armengol de La Hoz MA, Frushicheva MP, Raffa JD2, Johnson AEW2, Celi LA, Stone DJ


The study showed after analysis that suggest that the deviations in all SOFA and SAPS laboratory values from baseline to the most abnormal value in the first 24hours of ICU stay are significantly higher in obese patients.

The code here reproduces this study in the MIMIC-IV database. All code was newly written based upon the description of the study in the published paper.In the case where items were not clear, decisions were made based on best judgement, the original code was used when items were unclear in the study. As the original study was performed in MIMIC-III, the patients in this study distinct, and this can be considered a replication of the original study.

Requirements
In order to run the code, you must:

Have a Google account authenticated to access MIMIC-IV via BigQuery.
Access to google colab
Running the study
Open the Statistical_Analysis_Python.ipynb notebook in Google Colaboratory.
Run the .py file from the command line.
Step through the Statistical_Analysis_Python.ipynb notebook.

Modifications
There are a few differences between our reproduction and the original study. Notably:
Final cohort selection criteria, laboratory SOFA/SAPSII variables, and model building.