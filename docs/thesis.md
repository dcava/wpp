# Thesis

This is a near final markdown version of the submitted thesis.

# Preface

## Role
This project was an extension of a clinical research project conceived by Dr Nicholas O'Rourke and the primary author Dr Joel Lewin to compare the long term outcomes of laparoscopic and open surgery for colorectal cancer with liver metastases. As a consultant hepatopancreaticobiliary surgeon at the Royal Brisbane and Women's Hospital where the research was undertaken, I contributed patients and acted as the supervising author and biostatistician for the project. I oversaw the experimental design and data collection phase, and subsequently performed all data tidying, statistical modelling and analysis and co-authored the final paper for journal submission to the journal HPB. I also assisted Dr Lewin in preparing a report for presentation at an international meeting (IHPBA 2014, Seoul, Korea) where he was recipient of the "Best Oral presentation" award as well as the ANZHPBA Travelling Scholarship.

The focus of the project was using modern techniques to reduce bias due to observed confounders in an observational cohort comparison study where a randomised controlled trial has proved difficult to perform.

The project consists of the submitted manuscript, a detailed statistical supplement and online repository for the code used for statistical analysis.

## Reflections

Two great challenges during this project has been the use of a relatively new (completely new in the surgical literature) technique of analysis and the difficulties in dealing correctly with missing data. Both of these factors led to a far greater amount of work required than if more common processes were followed for a comparative observational trial. This represents an excellent opportunity however, as most colleagues I spoke with had a strong desire to understand that statistical underpinnings of their research in a better way. Working towards providing as much of the analysis code as possible to allow other researchers to critique and/or re-use it in their own research has been difficult (as it requires a better understanding of my own “product”), but extremely rewarding and I think a highlight of undertaking this project.

### Communication

The majority of research reported in surgical journals contain relatively simple analyses. Communicating the results of this project was difficult, both in convincing the reviewers of the statistical merit of our approach, and then presenting it in a way that was understandable to an audience with basic statistical knowledge. Propensity scores (PS), inverse probability of treatment weighting (IPTW), multiple imputation (MI) for missing data and machine learning techniques such as generalised boosted models (GBM) are all relatively new concepts for this audience and there was an element of education involved in completing the project.

Initial discussions with the database designer Dr Richard Bryant was undertaken to clarify the patient and variable subset required to complete the project. Throughout the project, Dr Lewin and I collaborated on the text of the paper online and had regular face-to-face meetings. Our co-authors assisted and commented on the final drafts and aided in the re-submission of the paper.

The results of this trial have been also been communicated in oral presentations at the International HPBA meeting, as well as several national and local meetings.  


### Work patterns/planning

The project was planned in 2013 with data acquisition taking place across 2014. Our initial deadline was presentation of results at the IHPBA 2014 meeting in Korea. For this presentation, IPTW using propensity scores generated using GBMs was the basis for a weighted survival analysis on a "complete-case" basis. Subsequently, it was felt that the final manuscript should contain a more principled approach to missing data and a more clear methodology for propensity score generation. 

There was regular collaboration with my colleagues Drs O'Rourke and Lewin with weekly face-to-face meetings. The project was completed whilst I worked full-time as a surgeon and as such, time management was challenging. 



### Statistical principles, methods and computing

The dataset used for the project was a prospectively maintained database of all liver surgery performed at three large Brisbane hospitals by 5 surgeons. Data was prospectively entered from 2004 and retrospectively added from 2000-2004. The database was designed to describe a large amount of surgical detail for each procedure and incorporate follow-up to allow estimation of patient survival.

We aimed to compare long-term survival outcomes (overall and recurrence free) for patients treated for a subset of patients with the same disease (liver metastases from colorectal cancer) by two methods - laparoscopic (keyhole or minimally invasive surgery) and open surgery. As the two groups have significant differences in baseline covariates due to selection bias, methods were required to reduce this bias as much as possible to allow a valid comparison. Missing data is a part of any longitudinal database, and a principled approach to managing this problem was required. A number of important statistical techniques were used and will be discussed:

1. Propensity scores
2. Inverse probability of treatment weighting
3. Generalised boosted modelling
4. Multiple imputation for missing data
5. Survival analysis using multiple-imputed, weighted data

Propensity score methods had not previously been encountered during my studies and a considerable amount of research was required to ensure that we employed a valid methodology. IPTW was chosen over matching techniques as we wanted to be able to make causal statements about the marginal effects of the treatment (laparoscopic surgery) under conditions as close to a randomised controlled trial as possible. Traditionally, main effects logistic regression has been used to estimate propensity scores, however many recent trials attest to the benefit of employing machine learning techniques (such as GBM). This is largely due to the strong assumptions of parametric logistic models, especially main effects models where no consideration is given to non-additivity or non-linearity which can lead to significant bias.

GBM's have robust capabilities to model missing data and the original plan was to use GBM's for both propensity score estimation and subsequent Cox proportional hazards modelling. The decision was made to move to MI for missing data management, followed by GBM propensity score estimation, and subsequent weighted Cox proportional hazards modelling. This was largely because GBM's by nature don't provide "coefficients" for variables as do "standard" Cox models, and explaining yet another non-standard methodology to the surgical audience was felt to be too difficult.

The final survival analysis required processing multiply imputed, weighted datasets. A combination of software tools was eventually used to ensure that the data were handled appropriately, especially to take into account the added variance due to the MI and PS.

#### Computing

`R` [R citation] was chosen for all statistical analyses due its flexibility and the availability of packages dedicated to the more complex parts of this analysis (GBM, MI). Additionally, the excellent report-generating functionality included with `RStudio` [RStudio citation] enabled an efficient workflow, including the capability to publish most details of the analysis online via a “literate programming” approach.

The dataset was stored securely on a local computer and the remainder of the analysis code, figures and other output were stored on [github][1], with some other items stored on a shared Dropbox. The use of github facilitated a secure, auditable, version controlled workflow and will hopefully encourage open discussion and reuse of code.


## Teamwork

The statistical analysis was conducted as an individual undertaking, but the overall project required the cooperation of six colleagues. Dr Lewin, the primary author, was a junior doctor in our unit under my supervision both clinically and academically. He had primary responsibility for coordinating and co-authoring the final paper. Dr O’Rourke was heavily involved as initiator and head of unit and Dr Bryant devised and maintains the database. The remainder of our team (Dr’s Nathanson, Chiow and Martin) are my clinical colleagues. We are a close knit team in a sub-speciality surgical unit and meet at least weekly to discuss the current research projects. The clear responsibility for different aspects of the project made for very little difficulty in working together.

## Ethical considerations

The data collection and database are both health district ethics board approved for ongoing use. This particular trial has specific approval by the health district ethics committee.

A specific ethical consideration has been the feasibility of providing the entire dataset in a de-identified fashion to allow reproduction and further analysis of our results. This is an area of considerable interest and not a small amount of ethical controversy. In the absence of specific patient consent for release however, the decision has been taken not to openly publish the data but to maintain its availability on request.


---

# Project Report

# Title: 

Long-term Survival in Laparoscopic vs Open Resection for Colorectal
Liver Metastases: Inverse Probability of Treatment Weighting using
Propensity Scores

## Brisbane, 2014-15

# Context:

This work was completed as a multi-centre, hospital-based observational clinical trial to answer a long-standing question regarding the safety of laparoscopic (keyhole) liver surgery for metastatic colorectal cancer. It arose out of the need to provide the best possible answer to this question in the absence of a randomised controlled trial.

## Contribution of student

I independently undertook the research design, data tidying, statistical analyses and programming, literature review and co-authored and supervised the final manuscript for publication. I was senior author and therefore also acted as supervisor for a junior colleague.

## Statistical issues involved:

- Propensity scores
- Inverse probability of treatment weighting
- Multiple imputation for missing data
- Recurrent event survival analysis
- Performing statistical analyses with imputed, weighted data

## Declaration:

I declare that I have undertaken this project independently as described and have not previously submitted any ccomponent of this work for academic credit.

---

# Statistical supplement

# Appendix A: Background to statistical methods

# Background:

In the field of surgery, evaluating and comparing treatments via the gold standard of a randomised controlled trial is not always feasible. Comparing laparoscopic ("keyhole" or "minimally invasive" surgery) with standard open surgery is particularly challenging due to difficulties with blinding and, in many cases, a perceived lack of equipoise.

Unfortunately, the result is that we are often faced with multiple, usually small (< 100 patients) observational cohort trials. These are plagued with selection bias, as early in the development of new surgical procedures "ideal" patients are selected to minimise the difficulty of the operation. This generally leads to a gross overestimate of treatment effect for the new procedure in early trials. With the passage of time and gaining of experience, the patient populations generally approach each other and the estimate of effect size becomes more reliable. Meta-analysis of these trials can be helpful, but does little to ensure that treatment and control groups don't differ in a systematic way.

This is the current state of affairs with laparoscopic liver surgery. The technique has been in use for approximately 20 years and whilst not "widespread", it is a commonly used technique among specialist liver surgeons. These sub-specialists who perform this surgery on a regular basis, point to the multitude of observational trials showing safety and comparative oncological efficacy (as measured by disease free and overall survival). Indeed, most surgeons utilising the technique would quote a significant improvement in peri-operative outcomes (such as shorter hospital stay, reduced blood loss, pain and wound complications). Among the wider surgical community concerns remain regarding the lack of robust comparative trials that would provide confidence that patient safety and oncological outcomes are not compromised.

There are a wide variety of indications, both benign and malignant, for liver surgery. 

In the absence of an RCT, techniques are available that can reduce the impact of observable sources of bias. Propensity score techniques have been used in the social sciences for many years, but are not widely used or understood in the surgical literature. Naive matching is commonly used, but rarely effective. There are a variety of methods whereby the propensity score can be used to estimate treatment effects: matching, stratification, covariate adjustment and inverse probability of treatment weighting (IPTW).

The use of IPTW using propensity scores should provide balance in baseline characteristics between the laparoscopic (treatment) group and the open (control) group allowing for a more robust comparison of peri-operative and survival outcomes.

# Propensity scores

The propensity score is the probability of receiving a particular treatment conditional on some set of observed baseline variables. It was originally described by Rosenbaum and Rubin (1983) and is part of the “Potential outcomes framework”. The PS is a balancing score - those patients with the same PS have similar distributions of measured confounders given the PS [JCE article](). Therefore, if certain assumptions hold, conditioning on the PS allows the average treatment effect to be estimated. This is a major potential advantage, as estimating causal effects from observational studies with non-equivalent groups is a task often faced by researchers in the surgical community. 

The two main assumptions in PS analyses are:

1. no unmeasured confounding

2. every subject has a non-zero probability of receiving either treatment

In fact, these same assumptions underly regression based approaches but are often not stated explicitly. The first assumption is difficult to prove, and sensitivity analysis may be the only means of clarifying the extent to which all possible confounders have been included.

In a randomised controlled trial we can directly estimate the treatment effect by comparing the outcomes in the treatment group to that in the control group - knowing that the groups do not differ in any systematic way due to randomisation. This is not possible in observational studies, even when great care is taken in the design phase to minimise bias in treatment assignment.

Regression is perhaps the most commonly used technique for multivariate comparisons in the surgical literature. Regression is an excellent platform for modelling relatively small differences between groups, however, in the presence of:

- large differences in covariates between comparison groups,
- 
- a large number of covariates with a small number of outcome events,
- 
- covariates that have complex, non-linear, non-additive relationships with the outcome

regression will be biased.

In this setting, a PS analysis divides the process in two. First, the selection process itself is modelled producing the propensity score. Second, the score is used in some way to estimate the treatment effect. There are a number of advantages to this process.

- often there are a large number of variables for which we wish to “adjust”, but we are only interested in the effect of the treatment itself or a small subset - ie the majority are a “nuisance”
- 
- research suggests that in survival analyses, at least 10 events (deaths/recurrences) should be observed for every variable included in the regression model to allow adequate adjustment - this will be very difficult to achieve if all baseline variables are included [peduzzi 1995]
- 
- separation of the “causal” question ("Does treatment X lead to better Y?") from the modelling approach
- 
- using PS balance diagnostics, it is clear which variables are not balanced between groups and the quality of balance after applying the PS. It is difficult to understand whether regression models have been correctly specified, even goodness-of-fit tests do not indicate successful balancing across groups


A full PS based analysis involves a number of steps:

##1. Identify the important covariates over which balance must be obtained
##2. Select the estimand of interest (ATE or ATT) 
##3. Use an appropriate modelling technique to derive the PS from the data
##4. Select the technique through which the samples will be compared (matching, stratification, IPTW, covariate adjustment, CBPS, etc)
##5. Check the balance obtained using appropriate metrics
##6. Estimate the treatment effect

Research into the use of PS in medical literature shows a rapid increase in its use - understandably given the potential benefits - but most authors do not provide sufficient information related to the above steps, particularly 1-5. The bulk of the medical literature focusses on the methods of estimating the treatment effect, the parameter of most clinical interest (eg survival, risk ratio, etc). The absence of information regarding the PS model specification means the reader is limited in their ability to assess the validity and generalisability of this effect.


# 1. Identifying the covariates

There has been a great deal of discussion, but not a lot of clear guidelines, for selection of covariates for PS estimation. Possibilities are to include all measured baseline covariates, only baseline covariates that are associated with treatment assignment, only covariates that affect the outcome, or all covariates that affect both treatment assignment and outcome. Of course the PS model should not include variables that may be modified by, or measured after, treatment assignment. To some extent, expert opinion guided by current research is the driving force for appropriate model makeup.

Ideally, all available variables would then be included in the PS model, but as will be discussed below, a large number of variables can make traditional logistic regression modelling difficult. This has led to the use of various variable selection rules. Perhaps counterintuitively, some studies [Brookhart 2006] suggest that it is more important to include all baseline variables that affect the outcome (including those that also affect treatment assignment), and that including variables that affect only treatment assignment may decrease the precision of the estimate.

The approach taken in the present study has been to include all variables thought to be important and use a flexible, machine learning approach (GBM) to model the large numbers of variables.


# 2. Selecting the estimand of interest

The majority of PS based analyses in the surgical literature involve matching on the PS. Almost invariably, this leads to estimation of the “average treatment effect for the **treated**" or **ATT**. This estimates the effect of treatment on patients who actually received the treatment. This is often desirable if your overall population contains patients for whom the treatment would not be applicable. A relevant example may be ...

In contrast, the "average treatment effect" or **ATE**, is the average effect of moving the entire population from untreated to treated - ie the same effect that one aims to estimate in a randomised controlled trial.

Under the conditions of an RCT, the ATT and the ATE will be the same, as the treated and untreated populations should not differ in any systematic way (although randomisation does not remove *all* differences between populations).

When using weighting (as in this analysis with IPTW), one way to think about the difference between ATE and ATT is that with ATE the weighted sample will have the same distriution of baseline variables as in the **overall** unweighted sample. With ATT weights, the distribution of baseline variables in the weighted treatment and control groups will only be the same as the unweighted **treated** subjects.

For the comparison of laparoscopic to open surgery for the management of colorectal liver metastases, a number of case-matched and PS-matched studies have successfully shown no clear difference in short and long term outcomes. A recent excellent meta-analysis [Geller][2] combined many of these to draw the conclusion that the laparoscopic approach is safe and effective, however, it had to be qualified by the oft heard “carefully selected patients” and due to the limitations of matching, was only truly applicable for those with a small number of mCRC lesions. For this reason, we chose to estimate the ATE to provide a more generalisable result.


# 3. Modelling the PS

The most common way to estimate the PS in the surgical literature is by using parametric logistic regression. The best techniques generate main effects models and add higher order and interaction terms via an iterative approach. Often however, only main effects models are chosen which may significantly bias the estimate. In their recent analysis of nearly 300 articles using PS techniques in the medical literature, Sanni Ali et al found that only 5.7% included information regarding interaction/higher-order terms, and only 2.4% reported the PS model itself. 

It is important to draw a distinction between how a logistic regression model is usually created and used (to parsimoniously estimate conditional effects) and its use in estimating the PS. 

In the usual creation of a regression model, one might include all variables that were important in univariate analysis, and step-wise remove those that are thought to have a limited impact on the overall estimate based on some estimate of “goodness or fit”. This is not necessarily desirable in PS models, as even variables with small relative influence may still lead to an improved “fit” and a better estimate of the PS. Similarly, “main effects” are often the only effects modelled and interactions are ignored, thus assuming that all variables have independent, linear relationships with the log-odds of being selected for treatment (“interaction” occurs when the effect of one variable  varies depending on the value of a second variable). This is not likely to be a realistic assumption, and can lead to significant bias in PS estimation. 

In the example of the present study, lesion count and lesion size could be assumed to effect survival **and** treatment selection (making them confounders). Clearly, however, the impact of lesion size will be different depending on lesion count, i.e. the difference between one small lesion and ten small lesions is not likely to be easily expressed in linear terms and they will almost certainly “interact”.

Additionally, many of the statistics used to estimate the quality of a model (e.g. Hosmer-Lemeshow test, C-statistic) do not indicate that the PS model is correctly specified or that key confounders have not been omitted. A higher C-statistic does not indicate better balance, as it is measure model fit not covariate balance. This will discussed in more detail in the "Balance diagnostics" section.

To overcome some of these difficulties, many researches have turned to machine learning approaches. An algorithmic approach is used that models the relationship between the outcome and the predictor without making assumptions about the specific form of the data model (in logistic regression the conditional distribution is a Bernoulli distribution and the probabilities of an outcome given the predictors follows a logistic function/distribution). This approach has been shown to be superior to logistic regression in PS estimation by a number of authors [Lee](). There are many possible ML approaches but Generalised Boosted modelling (GBM) was chosen for its availability, reliability and history of successful application. 

## GBM

> What follows is a plain English introduction to GBM methods, please see  [citation][4] for more mathematical treatment. 

Generalised boosted modelling (also called gradient boosted machines) is an “ensemble method” of machine learning, particularly suited to models with a large number of variables.

"Ensemble" means that it adds many simple functions and different learning algorithms to generate better performance. 

In logistic regression we attempt to model the relationship between outcome and predictors in a linear fashion - when the relationship is not linear in some variables, we add interaction terms or modifiy the variable (polynomials, transformations) in some way to "force" linearity. By contrast, GBM allows the relationship to be non linear and models the curve by multiple small functions that are joined together. Each "function" is a regression tree.

Regression trees work by dividing up the data into "branches" based on the variables (eg male/female, chemotherapy/no chemotherapy etc) and creating a regression model within that region. The algorithm then chooses the next variable and repeats the process. With any type of regression there are “residuals” or the errors that remain as outcomes are not perfectly predicted based on the model. Each time, the "best" model is chosen and GBM further models the residuals with regression trees to try and improve the fit. This allows the algorithm to search through a huge potential space of solutions including interaction terms and higher-order terms. Generally, the algorithm has a "stopping" rule. In propensity score estimation we wish to achieve "balance" and therefore the algorithm stops when the average standardised absolute mean difference (ASAM or "d") is minimised.

There are two main parts of the algorithm that need to be tuned to fit the required purpose. "Shrinkage" effectively refers to how "small" the functions should be - ie how many pieces should the curve be divided up into? "Tree depth" or size relates to many many branches the algorthm will travel down and is equivalent to how many levels of interaction one wishes to assess. Both these need to be selected to balance computation time with reductions on bias and improvements in balance. In practice, tree depth should be set between 2-5 and shrinkage should be as small as practical, but generally less than 0.01.

Because of its ability to deal with a very large number of variables, GBM's allow the inclusion of all avaiable pre-treatment covariariates with the algorithm choosing those to include in the final model.

In the current analysis, the twang package [twang, R] is used as a convenient interface to the GBM [gbm package] as detailed in the methods below.



# 4. Technique

Once the PS has been generated, the method of usage needs to be decided. There are four main techniques:

1. Matching
2. Stratification
3. Inverse Probability of treatment weighting (IPWT)
4. Covariate adjustment

Stratification and covariate adjustment are not common in the medical literature and therefore the following discussion will be restricted to matching and IPTW.

## Matching
As its name suggests, matching involves creating matched sets of treated and untreated subjects that share a similar value of the propensity score. The matching may be 1:1 or many to one depending on the circumstances. Once the matching has been performed, the two groups can be compared with the usual techniques employed for statistical analysis (e.g. Cox proportional hazards etc) with some adjustment made for the lack of independence in the samples (this will affect the variance of the estimate).

There are some decisions that need to be made in the matching setup: (see [Austin; Gu and Rosenbaum][5])

1. Matching with or without replacement?

In most circumstances, it would seem that matching without replacement provides good performance without introducing the complexity in estimating standard errors that occurs if subjects are used multiple times. This is particularly true in the usual circumstance of observational trials of surgical techniques where “control” patients are available in abundance. If access to untreated patients is limited, or a subset of the treated patients are difficult to match, matching with replacement may be necessary. 


2. Matching technique - greedy or optimal?

In greedy matching, a treated subject is chosen at random and the untreated subject with the closest PS is matched. The process is then repeated until all treated subjects are matched. The matching occurs even when an untreated subject may potentially match a later treated subject more precisely (hence the “greedy”).

Optimal matching attempts to minimise the overall differences of the PS within pairs - thus some matches may be slightly worse than “greedy”, but in general they will be better. In reality, it appears to make little practical difference which technique is used.

3. Match selection - nearest neighbour with or without calliper distance?

Nearest neighbour matching will choose the nearest available match without imposing any particular limit on how close that match needs to be. As such, all treated subjects will be matched, but the quality of the match may be variable. This leads to a situation where the variance is minimised (because the largest sample is used) but the estimate may be somewhat biased. By contrast, using a specific “calliper” allows the match to specify a limit on how “far apart” two subjects can be and still form a match. In this setting, some treated subjects may not be matched (because an untreated subject that is similar enough may not be available) and therefore the sample is smaller, but the estimate is less biased as the subjects are more closely comparable. 


## Inverse probability of treatment weighting

One potential limitation of matching is the possibility of being unable to match to a significant proportion of the population when the groups are being constructed. Whilst this does not affect the estimates of treatment effect, it does limit their generalisablity. IPTW is an alternative use of the PS when adjusting for confounding. 

Subjects with a high probability of receiving the treatment (based on their pre-treatment covariates ie their PS) will receive a lower weighting. For example, a patient with a solitary liver lesion in an easily accessible segment who received a laparoscopic liver resection would likely receive a lower weighting compared with a patient with a dome liver lesion who had a laparoscopic resection.




#5. Balance

---

#Missing data and multiple imputation

Missing data is a feature of almost all trials, especially those with longitudinal data collection. It takes on a particular importance in the estimation of propensity scores.


##Types of missingness

Depending on the particular study design, data may be missing for a variety of reasons. For example, survey designs may have issues with types of non-response, or data may be recorded incorectly or not recorded. In the current study there are some particular areas of concern for missingness:

1. Part of the data collection was retrospective (2000-2004), therefore the required data may not be available
2. information regarding the patients primary colon surgery or previous chemotherapy may not be available due to time delay or the procedure being performed at other institutions
3. data may simply not have been collected at the appropriate time (eg bloodloss not measured during a case)
4. 

 

## Missing completely at Random (MCAR)

If the pattern of missing data does not appear to depend on the particular value (or absence) of another variable, the data may be MCAR. This "random" missingness does not tend to lead to any bias in the estimates, but the loss of information may lead to a loss of power. There may be a small component of MCAR in the current analysis, but it is unlikely to be the primary source of missingness.

## Missing at random (MAR)

MAR is a misnomer in the sense that the data is not missing in a random fashion, but conditional on some other variable. In this setting, if one can "control" for the other variable in some fashion, then the data will be MAR, and it is still possible to generate estimates that are not biased (as in MCAR). 

For a contrived example, patients from outside the metropolitan area are more likely to have missing data regarding the primary tumour. Private patients are more likely to have come from outside the metropolitan area, and so it may appear that missing data on the primary tumour is related to financial status. If however, the probabilty of missing primary data is not related to financial status within each group (metropolitan/non-metropolitan), the data will be MAR. 

## Missing not at random (MNAR)

If neither of the above apply, then the data are MNAR. For example, if patients having laparoscopic surgery are more likely to have recorded intra-operative blood loss parameters (because it is easier to measure), the data are not MNAR.

---

In figure X, the patterns of missing data are displayed. For most variables, there are very few missing data points. There is a cluster of observations for which much of the data from the primary is missing (primary TNM stageing information) including the timing of the primary surgery. A little over half of these subjects were collected retrospectively from prior to 2004. A reasonable assumption is this cluster is MAR - the missingness is conditional on the "era" of surgery.

# Approaches to missing data

## Complete case or "listwise" deletion

This is the default setting for many analyses (and many software packages). If, for example, a multivariate regression model is being created, any patient with a missing variable in the model will be deleted - ie only the "complete cases" are considered. In the best case scenario with data MCAR, this will lead to loss of sample size and power only. Additionally, if multiple different analyses are performed with different variables, each may have a different sample size and include different subsets. If the data are not MCAR, it will lead to biased estimates.

## "Pairwise" deletion

This mechanism, also commonly available in software, makes use of all available cases. However, it is only possible to calculate the covariance of two variables where both are available. This can lead to the situation where different sample sizes are used for each different estimate. This appraoch is not generally recommended.

## Single imputation techniques

Various techniques exist for the simple replacement of missing values. This includes techniques such as "hot deck imputation", "mean substitution" and "regression substitution". In general these techniques should be avoided. In the situation of MCAR, they add no further information, but by artifically increasing the sample size, the standard error is underestimated and they may distort the relationships betwen variables. For data not MCAR, they will lead to bias of estimates including the mean.

## Multiple imputation

Whilst various alternatives to MI exist, they will be not discussed further for brevity. Popularised by Rubin, under MI, missing values are replaced by estimates drawn from a model unique to each missing entry. This is usually repeated to generate 3-4 complete data sets made up of the observed data and the imputed data with some random or "stochastic" component introduced each time. It holds some similarites in concept to propensity scores, except that instead of modelling the treatment assignment process, we attempt to model the "missingness" process.

The general pattern of MI use is:

- start with an incomplete dataset
- generate multiple (3-5) imputed datasets
- perform analysis on each dataset individually in the normal "complete case" fashion
- pool the results taking into account the additional variance introduced by the spread of estimates

The reasoning behind generating multiple datasets is that each will contain a different set of imputed values drawn from a distribution of plausible values (although the non-missing data will be identical). The spread of the missing data estimates will give a guide as to the uncertainty involved in the imputed value and includes the variance related to conventional sampling and the additional variance related to the missing data.


## MICE - Multivariate imputation by chained equations

MICE approaches MI by "fully conditional specification" that specifies the imputation model on a variable-by-variable basis. This is in contrast to other approaches where an attempt may be made to specify a joint multivariate model of missingness for the dataset. It is a Markov chain Monte Carlo (MCMC) method that builds up a multivariate model by specifying a multiple conditional models for each variable.

As each missing variable is modelled separately, a model must be chosen that is appropriate depending on variable type. For example, continous, positive variables may require a Gaussian (normal) model, categorical variables a logistic-based model etc. MICE allows this to be specified for each variable. For simplicity, the current analysis uses the same flexible model for all variables "CART". This is a Classification and Regression Tree model that should now be familiar as being similar to the underlying algorithm in GBM. It copes well with both continous and categorical variables and requires little further tuning.

For each variable, a set of "predictors" must also be defined that will be used in the model. As a rule, as many available variables should be used and whilst this can be a problem for data with hundreds of variables, it is not an issue in this instance. 

The `mice` package for `R` simplifies many of the steps in MI. It contains functions to assist in predictor selection and diagnostics to ensure the final imputed data sets are sensible.


## Multiple imputation with propensity scores

Obviously estimating PS is best with complete cases, although in practice, there is always missing data. This is especialyl the case as PS models usual include a very large number of variables, a complete case analysis could lead to a substantial reduction in sample size, a biased score and subsequently a biased analysis.

Hill et al [Hill et al] explore this topic in their 2004 paper. They present two appraoches to MI + PS analysis. 

Technique 1

1. Generate multiple imputed datasets
2. For each dataset, calculate the PS
3. Combine the PS across all the datasets
4. Pick matched groups/perform weighting and calculate causal estimates

Technique 2

1. Generate multiple imputed datasets
2. For each dataset, calculate the PS
3. For each dataset, pick matched groups/perform weighting and calculate causal estimates
4. Combine causal estimates across the datasets

---

# Survival analysis

# Background

# Recurrent event models

As opposed to the quite clearly demarcated outcome of "death", most cancer research also deals with the concept of recurrent disease. We can imagine a patients "journey" through their illness as starting with a diagnosis, having some treatment, being in remission, having recurrent disease, further treatment, followed by remission, etc. Of course, at any stage, the patient may succumb either to their disease or to another cause of death, or they may be lost to follow-up. Followed long enough of course, everyone will die of something. This is often referred to as the illness-death model.

The ideal model to deal with the movement of patients through these different states is a multi-state model. This is a very flexible survival model that relies on Markov processes to model the transitions between states. Unfortunately, there is limited software to combine propensity score weighted data with multi-state models, and the current analysis deals with relatively few patients who had recurrent events. Therefore, the decision was made to pursue a simpler model based on Cox proportional hazards.

# Proportional hazards recurrent event models

Most people are familiar with Cox proportional hazards models which have become the defacto standard for multivariate survival modelling. These models can be extended to manage recurrent events in a number of different ways. In each of these models, the data is broken up into time intervals defined by study entry, event times and death/censoring. For each interval, each subject is represented by a separate line such that if subjects have multiple events, they will be represented multiple times - the so called "counting process model". There are multiple different approaches, but the following model was used in the current analysis.


## Prentice, Williams and Peterson (PWP) conditional model

In this model, an additional variable is required to monitor the event number - often called the stratum. These are conditional models and represent the more realistic scenario whereby a subject cannot be at risk for event number two until event one has occurred (as opposed to other models where subjects are at risk for any event throughout the follow-up period). There are two strains of this model which relate to the time periods used. In one scenario, time is counted from study entry to event and continues counting throughout follow-up. In the other, follow-up begins again at zero following each event ("gap time"). There is no "correct" model here, the different treatments of time relate to a different desired interpretation.

The gap-time model holds interest for the investigation of recurrence in colorectal cancer. These patients have defined treatment events, usually punctuated by "remission" where no detectable disease is present and treatment is effectively completed. This model allows us to examine event specific estimates - ie is there a different in recurrence rates following one recurrence as compared with the third?

## Weighted, multiply imputed data

Following missing data management and propensity score generation, we are presented with five imputed, weighted datasets to analyse instead of the usual one. Additionally, any analysis must now take into account the additinal variance introduced by both MI and PS. Thankfully, software exists that makes this process relatively straightforward. Using the `survey` and `mitools` packages for `R`, we can create a survey design that takes into account the clustered nature of the PS dataset and will create the appropriate design for each individual dataset and wrap it up into a coherent object. When that object is used for further analysis, the package can combine the results of indivudal analysis with the appropriate adjustments (Rubin's rules) for multiple imputation.

---

# Appendix B
# Code and working analysis




[1]:	https://github.com/dcava/wpp