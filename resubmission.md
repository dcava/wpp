Reviewer: 1

Comments
--------

*2. Covariate balance. The purpose of the analysis is to try and account
for selection bias between treatment groups and the authors have
attempted to do this. There are clear and expected differences between
the laparoscopic and open groups at baseline prior to adjustment.
Particularly relevant is that in the open group there were 3 times as
many major resections, more tumours in difficult locations, twice as
many bilateral lesions, and larger lesions which were greater in number
etc.*

This is indeed the case and the reason for performing any PS based
analysis is to manage these differences. It is also the same situation
with the many recent studies exploring the laparoscopic vs open question
employing matching techniques based on the PS. The crucial question is
that whilst there may be more patients in the open group with major
resections, difficult locations etc, is sufficient balance of patients
possible to allow valid comparison? The beauty of the IPTW method is
that whilst in our early experience, the groups were disparate, over
recent years, laparoscopy has encompassed the whole gamut of resections
(especially in the colorectal metastases group where concomitant
vascular or bile duct resection in our population was unnecessary) and
the entire population is available for comparison.

*After propensity score weighting, these differences persist, albeit to
a lesser extent. I put it to the authors that while the analysis has
reduced the selection bias, bias still exists.*

Based on the particular covariates chosen we would respectfully argue
that the differences that exist in the IPTW population are not
significant - although the formal assessment of this is always
challenging. We have now included more information regarding our
assessment of balance. We would agree that "major resection" status
appears to retain a larger difference, even though by the statistics
presented it is not "significant". We explain our management of this
below in more detail and have added some of this detail to the paper.

Of course, the reviewer makes the important point that neither this
analysis nor any other non-randomised controlled trial can account for
unmeasured bias, as we state in our conclusion. It should be stressed
that even randomisation does not eliminate all baseline differences
between groups - it only makes those differences theoretically due to
chance.

An additional method used to assess both how well specified our
propensity score model is and to further control for any residual bias,
was to perform a "doubly robust" multi-variate analysis (not presented
for brevity). In this model, after McCaffrey et al
(2013)[^1^](https://paperpile.com/c/EOPTNl/3VCi), we consider standard
bias values less than 0.2 to be small (and not requiring further
adjustment), \< 0.4, moderate (and therefore requiring at least further
assessment) and 0.6 or above large, indicating complete failure of
balance and need for an alternative. No pre-treatment covariates had
bias \> 0.242 after weighting. Those with standard bias after
weighting \> 0.2 (major resection, bilateral lesions, lesion count,
N-stage) were then added to an IPTW multivariate cox regression model to
control for any residual significant bias. It did not result in any
significant differences in the coefficient for laparoscopy for either OS
or RFS, so we left out these details from the original manuscript.
Details regarding this have now been included in an expanded discussion
about multi-variate regression and explained below. Doubly robust
analysis has been verified by multiple authors as reducing remaining
bias and increasing efficiency of the model as well as addressing
mis-specification of either the PS model or the multivariate model.

*One is used to seeing PS full matching techniques, for instance, where
covariate balance is much better than this.*

This point is important (although we would argue that the balance is
quite good), and perhaps we have not explained the reasoning adequately.
Part of the issue is the different estimand used ATT vs ATE. Matching
provides an intuitive framework for assessing covariate balance, but by
definition uses the equivalent of an "ATT" estimand. This is an entirely
valid approach but we felt it had some limitations for the purposes of
our analysis. The major issues are generalisability and over-estimation
of treatment effect. As it finds matches from the control group that are
similar to the treatment group, it only allows conclusions to be made
based on these particular patients’ characteristics. This often results
in better balance, but many control patients are not matched to treated
patients. This does not allow general statements of causation to be
made. All one could conclude using an ATT estimand approach is that
patients who had open resections ***that have similar pre-treatment
baseline covariates*** to those who had laparoscopic resections could
have had laparoscopic resections with equivalent outcomes.

This has been shown by many groups already, and is not the same
statement as one could make after a randomised control trial - that
*any* patient who had an open resection could have had a laparoscopic
resection with equivalent outcomes.

IPTW based on the PS using ATE as an estimand allows us to take that
extra step further and imagine if all possible patients who had an open
operation could have been treated laparoscopically (and for some - eg
high lesion number, bilateral, major - this probability is low but
non-zero) what would the outcome have been? The difference is subtle,
but important, and it leads to more difficulty in generating balance in
the groups which we think is more reflective of the real world. If we
use the ATT estimand, the group balance is slightly improved but at the
cost of a very large reduction in effective sample size. The effective
control group sample size using the ATE method is n=106 post weighting.
The control group using the ATT method has an effective size of n=52.

Some authors would suggest that the effect size is then somewhat
overstated (because the effective control group is greatly restricted).
Details and a direct comparison of methods could be made available in a
supplement.

<span id="h.30j0zll" class="anchor"></span>Our dataset represents an
initial highly selected group for laparoscopy, progressively followed by
an "all comers" approach in recent years. In restricting the patients to
mCRC, we have effectively excluded patients requiring vascular or
biliary resection/reconstruction, but including almost all forms of
liver resection - from small non-anatomical wedge resections to extended
hepatectomies. There are many ways to analyse this data, but by choosing
weighting with an ATE estimand, we allow all the data to have some
impact. Alternatives such as stratifying on era, on major resection, etc
are valid, but leads to smaller groups with few events and therefore
difficulty in making robust conclusions.

-   To summarise: The ATE of a treatment is the comparison of mean
    outcomes had the *entire* population been observed under the one
    treatment, versus had the *entire* population been observed under
    the other treatment - this is not possible to achieve with most
    matching techniques and requires weighting techniques, as used here.

We believe ATE is of more interest compared with ATT's if either
treatment potentially might be offered to every member of the
population. We hoped to demonstrate that whilst the statistical
techniques used here are somewhat new to the surgical arena, they are
well worn in other areas of science and have a number of important
advantages. Matching frequently results in loss of a significant
proportion of the control group (as is the case here) which, whilst
entirely valid, limits the generalisability of the
results.[^2^](https://paperpile.com/c/EOPTNl/qLT8)

*The Kolmogarov-Smirnov p-values are pretty irrelevant - a significant
difference is not required for a given covariate to significantly affect
conclusions drawn. Why did the analysis not result in better balance?
Can this be optimised? Have the authors performed sensitivity analyses
to estimate the effect of these differences on conclusions? Should this
be discussed as a limitation of the study?*

We would respectfully disagree that the K-S p-values are irrelevant, as
the same statistics are used to assess the balance in matching on PS,
but agree that in isolation they have limited value (it was included as
a single marker of balance for brevity). We would agree entirely that no
single statistic is useful for "proving" balance, as "no measure of
balance is a monotonic function of bias"
[^3^](https://paperpile.com/c/EOPTNl/3jzt). Indeed many authors report
that no formal statistical comparison (in terms of “p-values” etc)
should be made to assess balance. To better illustrate the balance
achieved in this cohort, we have added several diagnostic plots which we
initially excluded for brevity. The focus for assessing balance in both
this method and in other PS based methods is in observing the
standardised bias remaining after balancing. The general rules of thumb
were presented above (\< 0.2 small, \<0.4 moderate, \> 0.6 large ). One
can then use either t-tests and p-values (where the distribution is
thought to be normal) or K-S and K-S p-values where they are not (none
of the continuous covariates in our population were normally
distributed) to compare means after balancing. More important is the
actual size of the standardised bias rather than its statistical
significance as discussed above.

Following the reviewers comments regarding balance, we made some
adjustments to the PS model. The main change was removal of the
Basingstoke predictive index from the model and its replacement by its
component variables. This did not result in significant changes to
balance, but we feel that it is more appropriate as the BPI has not been
validated on our patients, and including all the variables separately
allows them to be modelled more appropriately without making that
assumption. Additionally, we added a variable that classified the timing
of the liver resection in relation to the primary resection. We feel
that this model is more inclusive of all possible important
pre-treatment covariates.

A number of sensitivity analyses were performed by intentionally
mis-specifying the PS model to examine the effect of hidden bias, and
double-robust regression was performed as described above.

*3. Missing data. It is not easy to see exactly how many patients had
complete data. From table 2, can it be concluded that 12% of the open
group and 6% of the lap group had missing max lesion diameter?
Presumably the gradient-boosted logistic regression technique meant that
these patients could be included in the analysis, when normally they
couldn't or imputation would be needed? This needs explained and the
results of the analysis included as an appendix table.*

This is the case and the implications of missing data are discussed in
the paper. As we briefly discuss, exclusion of patients with missing
data will lead to invalid results and most standard statistical packages
will use casewise deletion to exclude incomplete cases during regression
analysis. Generalised boosting models (GBM) can deal with missing data
without imputation (based on partitioning), such that the PS can be
estimated on the observed data set. The initial paper as presented used
direct GBM methods to deal with the missing data, however, it becomes
difficult with current software to present the output of generalised
boosted analogues of Cox regression for survival analysis (although it
is possible), and therefore following the reviewers comments (and the
inclusion of new multivariate analyses), we have used a multiply imputed
dataset in the re-submitted paper. Additional information has been
provided regarding our missing data in the paper and we hope this is now
clarified.

*4. GBM. I think given this is pretty novel, supporting information
should be provided to reassure readers. Reporting it, as mentioned
above, is essential. How does the model perform? Can the authors
reassure us about how well it fitted the data? How does it compare to
standard logistic regression, for instance, in terms of ROC or similar.*

There are some important issues raised here. First, the use of c-index
(area under ROC of logistic regression model) is controversial in the
setting of PS estimation even when simple logistic regression is used.
This is because the c-index is not suitable for detecting confounders
omitted from the model and a high c-index (thought to be desirable)
often indicates non-overlap of propensity scores. The purpose of the
logistic model here must be separated from its usual use in multivariate
conditioning or estimation. In PS estimation, parsimony is not essential
(and in fact not desirable) and scores such as the c-index (ROC) or
Hosmer-Lemeshow test, whilst providing some information about model fit,
do not ensure balance. A better idea of balance can be achieved by
analysing the "standardised bias" - which is analogous to the effect
size. Sometimes called 'd', or average standardised absolute mean
difference (ASAM), it compares the mean of the covariate between the two
groups and divides by the sample standard deviation. This can be
examined before and after weighting and we have now provided this
information in more detail. For categorical variables, the differences
in proportions of each level of the covariate are compared.
[^4,5^](https://paperpile.com/c/EOPTNl/oaoD+aASE)

*The package looks to have various diagnostic options, can these be
reported?*

We considered providing further information regarding GBM’s. One problem
is that it is reasonably technical and we thought it not entirely
suitable for the article text - perhaps we could supply details in an
appendix or supplement? Suffice it to say that GBM techniques are in
widespread use outside medicine. One of the originators of the technique
won a prestigious international mathematics prize for its invention and
it is used by companies such as Yahoo for ranking search results, and is
also the basis of most facial recognition systems.

Recent studies of PS score estimation show that in terms of bias
reduction and mean-squared error, machine learning methods such as GBM
outperform simple logistic regression models. Indeed outside the
surgical literature, which is relatively new to the use of PS, logistic
regression has been replaced by numerous other techniques including GBM
and more complex model-selection variants of logistic regression. GBM is
a natural extension to logistic regression; it still uses a logistic
loss function, and still relies on regression.

In the setting of calculating the PS, it is used to optimise the model
based on the pre-operative covariates, however unlike logistic
regression:

-   GBM is a non-parametric, predictive modelling algorithm that uses
    > both classification and regression.

-   It is a type of "decision tree" algorithm or machine learning
    > technique for regression.

-   It is robust:

    -   Deals with missing values directly by modelling.

    -   Eliminates the need for scaling or normalisation. This is rarely
        > (if ever) discussed in most medical literature, but scaling,
        > centring and normalising continuous variables is commonly
        > required for accurate models

    -   Handles perfectly correlated variables - important in variable
        > selection for PS as many of the variables are closely
        > correlated but still need to be included.

GBM estimation involves an iterative process with multiple regression
trees to capture complex and non-linear relationships between treatment
assignment and the pre-treatment covariates.

We have provided a modicum of additional information regarding GBM's in
the paper, as well as clarifying how they were used to generate the
propensity scores (and providing extensive references). We feel that
directly providing more technical detail in a clinical journal may
detract from the main message and therefore would suggest that a
supplement be linked with greater detail if required.

*5. Weighted univariate outcomes: Can the unweighted results be included
in table 4 for comparison. Is positive margin frequency weighted?
Wouldn't expected whole numbers if it was?*

The unweighted results are now included. All the weighting is done via
sample weighting and normalised back to the size of the sample,
therefore whole numbers are possible.

*6. Weighted multivariate outcomes: Should this be reported in a table?
Does the technique used mean the Cox PH analysis only includes the
survival function and the weightings, and doesn't include any
predictors?*

We aimed to provide a univariate estimate of treatment effect alone. No
multivariate analysis has been done as we are not attempting to generate
a predictive model or score, but assess the difference in outcome based
on treatment alone. Multivariate cox-proportional hazards models were
used in a "double-robust" analysis to ensure that the small residual
differences present after weighting did not impact on the treatment
effect - this had been clarified in the paper.

*So it is not possible to report the influence (in terms of hazard
ratio) of predictors? But analyses of this sort are usually controlled
for covariates beyond that used in the weighting, which only considers
pre-op covariates? I'd be happy with just a better explanation of how
the final models work.*

It is indeed possible to perform any multivariate analysis one would
wish to do - the analysis is performed as a normal regression.. As said
above, we were not trying to generate a predictive model of outcomes
conditioned on various post-treatment variables (by assessing their
individual contributions), but assessing the "warts and all" difference
between the open and laparoscopic groups assuming the groups are now
similar.

Based on the reviewers comments however, a multivariate CoxPH model has
been provided.

*7. In the figures, the survival functions cross, so the assumption of
proportional hazards is violated so CPH can't be relied upon?
Assumptions checked?*

The survival curves are weighted Kaplan-Meier curves, not predicted
CoxPH curves - hence the crossover. The hazard ratio reported on the
curve is the result of the double-robust weighted CoxPH. Assumptions of
proportionality have been assessed in the multivariate and double-robust
models without issue.

References:

1\. [McCaffrey DF, Griffin BA, Almirall D, Slaughter ME, Ramchand R,
Burgette LF. A tutorial on propensity score estimation for multiple
treatments using generalized boosted models.
](http://paperpile.com/b/EOPTNl/3VCi)[*Stat
Med*](http://paperpile.com/b/EOPTNl/3VCi)[.
2013](http://paperpile.com/b/EOPTNl/3VCi)[.
](http://paperpile.com/b/EOPTNl/3VCi)[**32**](http://paperpile.com/b/EOPTNl/3VCi)[:3388–414.](http://paperpile.com/b/EOPTNl/3VCi)

2\. [Curtis LH, Hammill BG, Eisenstein EL, Kramer JM, Anstrom KJ. Using
inverse probability-weighted estimators in comparative effectiveness
analyses with observational databases.
](http://paperpile.com/b/EOPTNl/qLT8)[*Med
Care.*](http://paperpile.com/b/EOPTNl/qLT8)[
2007](http://paperpile.com/b/EOPTNl/qLT8)[.
](http://paperpile.com/b/EOPTNl/qLT8)[**45**](http://paperpile.com/b/EOPTNl/qLT8)[:S103–7.](http://paperpile.com/b/EOPTNl/qLT8)

3\. [Sekhon JS. Multivariate and Propensity Score Matching Software with
Automated Balance Optimization: The Matching Package for R. 2008.
Available from:
](http://paperpile.com/b/EOPTNl/3jzt)<http://papers.ssrn.com/sol3/papers.cfm?abstract_id=1009044>

4\. [Harder VS, Stuart EA, Anthony JC. Propensity score techniques and
the assessment of measured covariate balance to test causal associations
in psychological research.
](http://paperpile.com/b/EOPTNl/oaoD)[*Psychol
Methods*](http://paperpile.com/b/EOPTNl/oaoD)[.
2010](http://paperpile.com/b/EOPTNl/oaoD)[.
](http://paperpile.com/b/EOPTNl/oaoD)[**15**](http://paperpile.com/b/EOPTNl/oaoD)[:234–49.](http://paperpile.com/b/EOPTNl/oaoD)

5\. [Heinze G, Jüni P. An overview of the objectives of and the
approaches to propensity score analyses.
](http://paperpile.com/b/EOPTNl/aASE)[*Eur Heart
J*](http://paperpile.com/b/EOPTNl/aASE)[.
2011.](http://paperpile.com/b/EOPTNl/aASE)[
](http://paperpile.com/b/EOPTNl/aASE)[**32**](http://paperpile.com/b/EOPTNl/aASE)[:1704–8.](http://paperpile.com/b/EOPTNl/aASE)
