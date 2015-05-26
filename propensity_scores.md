#Propensity scores

The PS is a balancing score - those with the same PS have similar distributions of measured confounders given the PS (JCE article). Therefore, if certain assumptions hold (no unmeasured confounding) ,etc) conditioning on the PS allows  one to estimate the average treatment effect.

A full PS based analysis involves a number of steps:

1. Identifying the important covariates over which balance must be obtained
2. Selecting the estimand of interest (ATE/ATT) 
3. Using an appropriate modelling technique to derive the PS from the data
4. Select the technique through which the samples will be compared (matching, stratification, IPTW, covariate adjustment, CBPS, etc)
5. Check the balance obtained using an appropriate metric
6. Estimate the treatment effect (usually via regression modelling)

Research into the use of PS in medical literature shows a rapid increase in its use - understandably given the potential benefits - but most authors do not provide sufficient information related to the above steps, particularly 1-5. The bulk of the medical literature focusses on the methods of estimating the treatment effect, which in reality is the simplest part of the analysis. The absence of information regarding the PS model specification means the reader is limited in their ability to assess the validity and generalisability of the analysis.




##Notes:

- JCE article with Sanni Ali et al
-

