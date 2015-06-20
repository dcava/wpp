#Missing data and multiple imputation

Missing data is a feature of almost all trials, especially those with longitudinal data collection. It takes on a particular importance in the estimation of propensity scores.


##Types of missingness

Depending on the particular study design, data may be missing for a variety of reasons. For example, survey designs may have issues with types of non-response, or data may be recorded incorectly or not recorded. In the current study there are some particular areas of concern for missingness:

1. Part of the data collection was retrospective (2000-2004), therefore the required data may not be available
2. information regarding the patients primary colon surgery or previous chemotherapy may not be available due to time delay or the procedure being performed at other institutions
3. data may simply not have been collected at the appropriate time (eg bloodloss not measured during a case)
4. 

 

##Missing completely at Random (MCAR)

If the pattern of missing data does not appear to depend on the particular value (or absence) of another variable, the data may be MCAR. This "random" missingness does not tend to lead to any bias in the estimates, but the loss of information may lead to a loss of power. There may be a small component of MCAR in the current analysis, but it is unlikely to be the primary source of missingness.

##Missing at random (MAR)

MAR is a misnomer in the sense that the data is not missing in a random fashion, but conditional on some other variable. In this setting, if one can "control" for the other variable in some fashion, then the data will be MAR, and it is still possible to generate estimates that are not biased (as in MCAR). 

For a contrived example, patients from outside the metropolitan area are more likely to have missing data regarding the primary tumour. Private patients are more likely to have come from outside the metropolitan area, and so it may appear that missing data on the primary tumour is related to financial status. If however, the probabilty of missing primary data is not related to financial status within each group (metropolitan/non-metropolitan), the data will be MAR. 

##Missing not at random (MNAR)

If neither of the above apply, then the data are MNAR. For example, if patients having laparoscopic surgery are more likely to have recorded intra-operative blood loss parameters (because it is easier to measure), the data are not MNAR.

---

In figure X, the patterns of missing data are displayed. For most variables, there are very few missing data points. There is a cluster of observations for which much of the data from the primary is missing (primary TNM stageing information) including the timing of the primary surgery. A little over half of these subjects were collected retrospectively from prior to 2004. A reasonable assumption is this cluster is MAR - the missingness is conditional on the "era" of surgery.

#Approaches to missing data

##Complete case or "listwise" deletion

This is the default setting for many analyses (and many software packages). If, for example, a multivariate regression model is being created, any patient with a missing variable in the model will be deleted - ie only the "complete cases" are considered. In the best case scenario with data MCAR, this will lead to loss of sample size and power only. Additionally, if multiple different analyses are performed with different variables, each may have a different sample size and include different subsets. If the data are not MCAR, it will lead to biased estimates.

##"Pairwise" deletion

This mechanism, also commonly available in software, makes use of all available cases. However, it is only possible to calculate the covariance of two variables where both are available. This can lead to the situation where different sample sizes are used for each different estimate. This appraoch is not generally recommended.

##Single imputation techniques

Various techniques exist for the simple replacement of missing values. This includes techniques such as "hot deck imputation", "mean substitution" and "regression substitution". In general these techniques should be avoided. In the situation of MCAR, they add no further information, but by artifically increasing the sample size, the standard error is underestimated and they may distort the relationships betwen variables. For data not MCAR, they will lead to bias of estimates including the mean.

##Multiple imputation

Whilst various alternatives to MI exist, they will be not discussed further for brevity. Popularised by Rubin, under MI, missing values are replaced by estimates drawn from a model unique to each missing entry. This is usually repeated to generate 3-4 complete data sets made up of the observed data and the imputed data with some random or "stochastic" component introduced each time. It holds some similarites in concept to propensity scores, except that instead of modelling the treatment assignment process, we attempt to model the "missingness" process.

The general pattern of MI use is:

- start with an incomplete dataset
- generate multiple (3-5) imputed datasets
- perform analysis on each dataset individually in the normal "complete case" fashion
- pool the results taking into account the additional variance introduced by the spread of estimates

The reasoning behind generating multiple datasets is that each will contain a different set of imputed values drawn from a distribution of plausible values (although the non-missing data will be identical). The spread of the missing data estimates will give a guide as to the uncertainty involved in the imputed value and includes the variance related to conventional sampling and the additional variance related to the missing data.


##MICE - Multivariate imputation by chained equations

MICE approaches MI by "fully conditional specification" that specifies the imputation model on a variable-by-variable basis. This is in contrast to other approaches where an attempt may be made to specify a joint multivariate model of missingness for the dataset. It is a Markov chain Monte Carlo (MCMC) method that builds up a multivariate model by specifying a multiple conditional models for each variable.

As each missing variable is modelled separately, a model must be chosen that is appropriate depending on variable type. For example, continous, positive variables may require a Gaussian (normal) model, categorical variables a logistic-based model etc. MICE allows this to be specified for each variable. For simplicity, the current analysis uses the same flexible model for all variables "CART". This is a Classification and Regression Tree model that should now be familiar as being similar to the underlying algorithm in GBM. It copes well with both continous and categorical variables and requires little further tuning.

> As per [Van Buren (Jstat)], there are seven important choices to be made in imputation:
> 
> 1. Is the MAR assumption plausible?
> 2. What form will the imputation model take for each variable?
> 3. Which variables should act as predictors for the msising data?
> 4. Should we impute variables that are functions of other variables (eg BMI as a function of height and weight)
> 5. What order should the variables be imputed?
> 6. Setup and number of iterations
> 7. Number of imputed data sets



