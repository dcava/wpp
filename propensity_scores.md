
# Propensity scores

The propensity score is the probability of receiving a particular treatment conditional on some set of observed baseline variables. It was originally described by Rosenbaum and Rubin (1983) and is part of the “Potential outcomes framework”. The PS is a balancing score - those patients with the same PS have similar distributions of measured confounders (in this instance, baseline, pre-operative characteristics) given the PS [JCE article](). Therefore, if certain assumptions hold, conditioning on the PS allows the average treatment effect to be estimated. This is a major potential advantage, as estimating causal effects from observational studies with non-equivalent groups is a task often faced by researchers in the surgical community. 

The two main assumptions in PS analyses are:
1. no unmeasured confounding
2. every subject has a non-zero probability of receiving either treatment

In fact, these same assumptions underly regression based approaches but are often not stated explicitly. The first assumption is difficult to prove, and sensitivity analysis may be the only means of clarifying the extent to which all possible confounders have been included.

In a randomised controlled trial we can directly estimate the treatment effect by comparing the outcomes in the treatment group to that in the control group - knowing that the groups do not differ in any systematic way due to randomisation. This is not possible in observational studies, even when great care is taken in the design phase to minimise bias in treatment assignment.

Regression (in its various forms) is perhaps the most commonly used technique for multivariate comparisons in the surgical literature. Regression is an excellent platform for modelling relatively small differences between groups, however, in the presence of:
- large differences in covariates between comparison groups,
- a large number of covariates with a small number of outcome events,
- covariates that have complex, non-linear, non-additive relationships with the outcome

regression will be biased.

In this setting, a PS analysis divides the process in two. First, the selection process itself is modelled producing the propensity score. Second, the score is used in some way to estimate the treatment effect. There are a number of advantages to this process.
- often there are a large number of variables for which we wish to “adjust”, but we are only interested in the effect of the treatment or a small subset - ie the majority are a “nuisance”
- research suggests that in survival analyses, at least 10 events (deaths/recurrences) should be observed for every variable included in the regression model to allow adequate adjustment - this will be very difficult to achieve if all baseline variables are included
- separation of the “causal” question ("Does treatment X lead to better Y?") from the modelling approach ()
- it can be easier to ascertain if the PS model is correctly specified
- 

A full PS based analysis involves a number of steps:

##1. Identify the important covariates over which balance must be obtained
##2. Select the estimand of interest (ATE or ATT) 
##3. Use an appropriate modelling technique to derive the PS from the data
##4. Select the technique through which the samples will be compared (matching, stratification, IPTW, covariate adjustment, CBPS, etc)
##5. Check the balance obtained using appropriate metrics
##6. Estimate the treatment effect

Research into the use of PS in medical literature shows a rapid increase in its use - understandably given the potential benefits - but most authors do not provide sufficient information related to the above steps, particularly 1-5. The bulk of the medical literature focusses on the methods of estimating the treatment effect, the parameter of most clinical interest (eg survival, risk ratio, etc). The absence of information regarding the PS model specification means the reader is limited in their ability to assess the validity and generalisability of this effect.


# 1. Identifying the covariates

There has been a great deal of discussion, but not a lot of clear guidelines, for selection of covariates for PS estimation. One possibility is to include all measured baseline covariates, only baseline covariates that are associated with treatment assignment, only covariates that affect the outcome, or all covariates that affect both treatment assignment and outcome. Of course the PS model should not include variables that may be modified by or measured after treatment assignment.

Perhaps counterintuitively, some studies [Brookhart 2006] suggest that it is more important to include all baseline variables that affect the outcome (including those that also affect treatment assignment), and that including variables that affect only treatment assignment may decrease the precision of the estimate.

To some extent, expert opinion guided by current research is the driving force for appropriate model makeup.



# 2. Selecting the estimand of interest

The majority of PS based analyses in the surgical literature involve matching on the PS. Almost invariably, this leads to estimation of the “average treatment effect for the **treated**" or **ATT**. This estimates the effect of treatment on patients who actually received the treatment. This is often desirable if your overall population contains patients for whom the treatment would not be applicable. A relevant example may be ...

In contrast, the "average treatment effect" or **ATE**, is the average effect of moving the entire population from untreated to treated - ie the same effect that one aims to estimate in a randomised controlled trial.

Under the conditions of an RCT, the ATT and the ATE will be the same, as the treated and untreated populations should not differ in any systematic way (although randomisation does not remove *all* differences between populations).

For the comparison of laparoscopic to open surgery for the management of colorectal liver metastases, a number of case-matched and PS-matched studies have successfully shown no clear difference in short and long term outcomes. A recent excellent meta-analysis [Geller][2] combined many of these to draw the conclusion that the laparoscopic approach is safe and effective, however, it had to be qualified by the oft heard “carefully selected patients” and due to the limitations of matching, was only truly applicable for those with a small number of mCRC lesions. For this reason, we chose to estimate the ATE to provide a more generalisable result.


# 3. Modelling the PS

The most common way to estimate the PS in the surgical literature is by using logistic regression with or without higher order and interaction terms. In their recent analysis of nearly 300 articles using PS techniques in the medical literature, Sanni Ali et al found that only 5.7% included information regarding interaction/higher-order terms, and only 2.4% reported the PS model itself. It is important to draw a distinction between how a logistic regression model is usually created and used (to parsimoniously estimate conditional effects) and its use in estimating the PS. 

In the usual creation of a regression model, one might include all variables that were important in univariate analysis, and step-wise remove those that are thought to have a limited impact on the overall estimate based on some estimate of “goodness or fit”. This is not necessarily desirable in PS models, as even variables with small relative influence may still lead to an improved “fit” and a better estimate of the PS. Similarly, “main effects” are often the only effects modelled and interactions are ignored, thus assuming that all variables have independent, linear relationships with the log-odds of being selected for treatment (“interaction” occurs when the effect of one variable  varies depending on the value of a second variable). This is not likely to be a realistic assumption, and can lead to significant bias in PS estimation. In the example of the present study, lesion count and lesion size could be assumed to effect survival **and** treatment selection (making them confounders). Clearly, however, the impact of lesion size will be different depending on lesion count, i.e. the difference between one small lesion and ten small lesions is not likely to be easily expressed in linear terms and they will almost certainly “interact”.

Additionally, many of the statistics used to estimate the quality of a model (e.g. Hosmer-Lemeshow test) ...

To overcome some of these difficulties, many researches have turned to machine learning approaches. An algorithmic approach is used that models the relationship between the outcome and the predictor without making assumptions about the specific form of the data model (in logistic regression the conditional distribution is a Bernoulli distribution and the probabilities of an outcome given the predictors follows a logistic function/distribution). This approach has been shown to be superior to logistic regression in PS estimation by a number of authors [Lee](). There are many possible ML approaches but Generalised Boosted modelling (GBM) was chosen for its availability, reliability and history of successful application. 

## GBM

> What follows is a very simplified introduction to GBM methods, please see  [citation][4] for more detailed information. 

Generalised boosted modelling (also called gradient boosted machines) is an “ensemble method” of machine learning. That is, it uses multiple different learning algorithms to generate better performance. With any type of regression there are “residuals” or the errors that remain as outcomes are not perfectly predicted based on the model. GBM iteratively fits a regression model to the data and then models the residuals with regression trees to try and improve the fit. This allows the algorithm to search through a huge potential space of solutions including interaction terms and higher-order terms. Multiple aspects of the algorithm can be tuned for the specific requirements of the problem at hand. 


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

In most circumstances, it would seem that matching without replacement provides good performance without introducing the complexity in estimating standard errors that occurs if subjects are used multiple times. This is particularly true in the usual circumstance of observational trials in surgical techniques where “control” patients are available in abundance. If access to untreated patients is limited, or a subset of the treated patients are difficult to match, matching with replacement may be necessary. 


2. Matching technique - greedy or optimal?

In greedy matching, a treated subject is chosen at random and the untreated subject with the closest PS is matched. The process is then repeated until all treated subjects are matched. The matching occurs even when an untreated subject may potentially match a later treated subject more precisely (hence the “greedy”).

Optimal matching attempts to minimise the overall differences of the PS within pairs - thus some matches may be slightly worse than “greedy”, but in general they will be better. In reality, it appears to make little practical difference which technique is used.

3. Match selection - nearest neighbour with or without calliper distance?

Nearest neighbour matching will choose the nearest available match without imposing any particular limit on how close that match needs to be. As such, all treated subjects will be matched, but the quality of the match may be variable. This leads to a situation where the variance is minimised (because the largest sample is used) but the estimate may be somewhat biased. By contrast, using a specific “calliper” allows the match to specify a limit on how “far apart” two subjects can be and still form a match. In this setting, some treated subjects may not be matched (because an untreated subject that is similar enough may not be available) and therefore the sample is smaller, but the estimate is less biased as the subjects are more closely comparable. 


## Inverse probability of treatment weighting


## Notes:

- JCE article with Sanni Ali et al
-

[2]:	%60
[4]:	%20%20
[5]:	%20