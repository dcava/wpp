# Inverse probability of treatment weighted analysis

You may just want to go [here](https://dcava.github.io/wpp/).

In the field of surgery, evaluating and comparing treatments via the gold standard of a randomised controlled trial is not always feasible. Comparing laparoscopic ("keyhole" or "minimally invasive" surgery) with standard open surgery is particularly challenging due to difficulties with blinding and, in many cases, a perceived lack of equipoise.

In the absence of an RCT, techniques are available that can reduce the impact of observable sources of bias. Regression is often used to produce treatment effect estimates. However, if the groups are significantly different in some covariates and there exist interactions and non-linear relationships, these estimates will be biased. Propensity score(PS) techniques have been used in the social sciences for many years, but are not widely used or understood in the surgical literature. PS-based analyses are, however, becoming increasingly popular in the surgical literature due to there ability to remove bias from observed confounders. There are a variety of methods whereby the propensity score can be used to estimate treatment effects: matching, stratification, covariate adjustment and inverse probability of treatment weighting (IPTW).

This site will host the statistical supplement for the above paper including details to reproduce the analysis using R.

Importantly, the exact results presented in the following supplement may differ slightly from those reported in Lewin et al due to differences in the missing value imputation and propensity scoring process (both procedures rely on underlying random number generation), however the magnitude of change should be small and the overall conclusions unchanged.

[R/](R/) Contains all the scripts and code (currently not awesomely documented!)

[thesis components](thesis components/) Contains the components for my Masters thesis with some statistical background that may be of some interest.

[docs/](docs/) Contains material for the [web site](https://dcava.github.io/wpp/) and is not likely to be very interesting.
