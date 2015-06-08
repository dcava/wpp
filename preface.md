# Preface

## Role
This project was an extension of a clinical research project conceived by Dr Nicholas O'Rourke and the primary author Dr Joel Lewin to compare the long term outcomes of laparoscopic and open surgery for colorectal cancer with liver metastases. As a consultant hepatopancreaticobiliary surgeon at the Royal Brisbane and Women's Hospital where the research was undertaken, I contributed patients and acted as the supervising author and biostatistician for the project. I oversaw the experimental design and data collection phase, and subsequently performed all data tidying, statistical modelling and analysis and co-authored the final paper for journal submission. I also assisted Dr Lewin in preparing a report for presentation at an international meeting (IHPBA 2014, Seoul, Korea) where he was recipient of the "Best Oral presentation" award as well as the ANZHPBA Travelling Scholarship.

The focus of the project was using modern techniques to reduce bias due to observed confounders in an observational cohort comparison study where a randomised controlled trial has proved difficult to perform.

The project consists of the submitted manuscript, and a detailed statistical supplement and online repository for the code used for statistical analysis.

## Reflections

### Communication
The majority of research reported in surgical journals contain relatively simple analyses. Communicating the results of this project was difficult, both in convincing the reviewers of the statistical merit of our approach, and then presenting it in a way that was understandable to an audience with  basic statistical knowledge. Propensity scores (PS), inverse probability of treatment weighting (IPTW), multiple imputation (MI) for missing data and machine learning techniques such as generalised boosted models (GBM) are all relatively new concepts for this audience and there was an element of education involved in completing the project.

Initial collaboration with the database designer Dr Richard Bryant was undertaken to clarify the patient and variable subset required to complete the project. Throughout the project, Dr Lewin and I 



### Work patterns/planning

The project was planned in 2013 with data acquisition taking place across 2014. Our initial deadline was presentation of results at the IHPBA 2014 meeting in Korea. For this presentation, IPTW using propensity scores generated using GBMs was the basis for a weighted survival analysis on a "complete-case" basis. Subsequently, it was felt that the final manuscript should contain a more principled approach to missing data and a more clear methodology for propensity score generation. 

There was regular collaboration with my colleagues Dr's O'Rourke and Lewin with weekly face-to-face meetings. The project was completed whilst I worked full-time as a surgeon and as such, time management was challenging. 



### Statistical principles, methods and computing

The dataset used for the project was a prospectively maintained database of all liver surgery performed at three large Brisbane hospitals by 5 surgeons. Data was prospectively entered from 2004 and retrospectively added from 2000-2004. The database was designed to describe a large amount of surgical detail for each procedure and incorporate follow-up to allow estimation of patient survival.

We aimed to compare long-term survival outcomes (overall and recurrence free) for patients treated for a subset of patients with the same disease (liver metastases from colorectal cancer) by two methods - laparoscopic (keyhole or minimally invasive surgery) and open surgery. As the two groups have significant differences in baseline covariates due to selection bias, methods were required to reduce this bias as much as possible to allow a valid comparison. Missing data is a part on any long term database, and a principled approach to managing this problem was required. A number of important statistical techniques were used and will be discussed:

1. Propensity scores
2. Inverse probability of treatment weighting
3. Generalised boosted modelling
4. Multiple imputation for missing data
5. Survival analysis using multiple-imputed, weighted data
6. Double-robust analyses

Propensity score methods had not previously been encountered during my studies and a considerable amount of research was required to ensure that we employed a valid methodology. IPTW was chosen over matching techniques as we wanted to be able to make causal statements about the marginal effects of the treatment (laparoscopic surgery) under conditions as close to a randomised controlled trial as possible. Traditionally, main effects logistic regression has been used to estimate propensity scores, however many recent trials attest to the benefit of employing machine learning techniques (such as GBM). This is largely due to the strong assumptions of parametric logistic models, especially main effects models where no consideration is given to non-additivity or non-linearity which can lead to significant bias.

GBM's have robust capabilities to model missing data and the original plan was to use GBM's for both propensity score estimation and subsequent Cox proportional hazards modelling. The decision was made to move to MI for missing data management, followed by GBM propensity score estimation, and subsequent weighted Cox proportional hazards modelling. This was largely because GBM's by nature don't provide "coefficients" for variables as do "standard" Cox models, and explaining yet another non-standard methodology to the surgical audience was felt to be too difficult.

#### Computing

R [@ R citation] was chosen for all statistical analyses due its flexibility and the availability of packages dedicated to the more complex parts of this analysis (GBM, MI). Additionally, the excellent report-generating functionality included with RStudio [@ RStudio citation] enabled an efficient workflow, including the capability to publish most details of the analysis online via a “literate programming” approach.

The dataset was stored securely on a local computer and the remainder of the analysis code, figures and other output were stored on [github][1], with some other items stored on a shared Dropbox. The use of github facilitated a secure, auditable, version controlled workflow



## Teamwork


## Ethical considerations

There were a number of ethical considerations in conducting this trial. Firstly, there is a weight of 

## Other

[1]:	https://github.com/dcava/wpp