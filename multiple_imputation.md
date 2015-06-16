#Missing data and multiple imputation

Missing data is a feature of almost all trials, especially those with longitudinal data collection. It takes on a particular importance in the estimation of propensity scores.


##Types of missingness

Depending on the particular study design, data may be missing for a variety of reasons. For example, survey designs may have issues with types of non-response, or data may be recorded incorectly or not recorded. In the current study there are some particular areas of concern for missingness:

1. Part of the data collection was retrospective (2000-2004), therefore the required data may not be available
2. information regarding the patients primary colon surgery or previous chemotherapy may not be available due to time delay or the procedure being performed at other institutions
3. 
 

##Missing completely at Random (MCAR)

If the pattern of missing data does not appear to depend on the particular value (or absence) of another variable, the data may be MCAR. This "random" missingness does not tend to lead to any bias in the estimates, but the loss of information may lead to a loss of power. There may be a small component of MCAR in the current analysis, but it is unlikely to be the primary source of missingness.

##Missing at random (MAR)

MAR is a misnomer in the sense that the data is not missing in a random fashion, but conditional on some other variable. In this setting, if one can "control" for the other variable in some fashion, then the data will be MAR, and it is still possible to generate estimates that are not biased (as in MCAR). 

For a contrived example, patients from outside the metropolitan area are more likely to have missing data regarding the primary tumour. Private patients are more likely to have come from outside the metropolitan area, and so it may appear that missing data on the primary tumour is related to financial status. If however, the probabilty of missing primary data is not related to financial status within each group (metropolitan/non-metropolitan), the data will be MAR. 

##Missing not at random (MNAR)

If neither of the above apply, then the data are MNAR. For example, if patients having laparoscopic surgery are more likely to have recorded intra-operative blood loss parameters (because it is easier to measure), the data are not MNAR.


#Approaches to missing data

##Complete case or "listwise" deletion

This is the default setting for many analyses (and many software packages). If, for example, a multivariate regression model is being created, any patient with a missing variable that is included in the model will be deleted - ie only the "complete cases" are considered. In the best case scenario with data MCAR, this will lead to loss of sample size and power only. If the data are not MCAR, it will lead to biased estimates.

##"Pairwise" deletion

This mechanism, also commonly available in software, makes use of all available cases. However, it is only possible to calculate the covariance of two variables where both are available. This can lead to the situation where different sample sizes are used for each different estimate. This appraoch is not generally recommended.


##Multiple imputation

Whilst alternatives to MI exist, they will be not discussed further for brevity. Under MI, missing values are replaced by estimates drawn from a regression model unique to each subjects missing data pattern. This is usually repeated to generate 3-4 complete data sets made up of the observed data and the imputed data. It holds many similarites to propensity scores, except that instead of modelling the treatment assignment process, we attempt to model the "missingness" process.
