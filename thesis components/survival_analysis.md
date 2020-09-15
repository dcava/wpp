#Survival analysis

#Background

#Recurrent event models

As opposed to the quite clearly demarcated outcome of "death", most cancer research also deals with the concept of recurrent disease. We can imagine a patients "journey" through their illness as starting with a diagnosis, having some treatment, being in remission, having recurrent disease, further treatment, followed by remission, etc. Of course, at any stage, the patient may succumb either to their disease or to another cause of death, or they may be lost to follow-up. Followed long enough of course, everyone will die of something. This is often referred to as the illness-death model.

The ideal model to deal with the movement of patients through these different states is a multi-state model. This is a very flexible survival model that relies on Markov processes to model the transitions between states. Unfortunately, there is limited software to combine propensity score weighted data with multi-state models, and the current analysis deals with relatively few patients who had recurrent events. Therefore, the decision was made to pursue a simpler model based on Cox proportional hazards.

#Proportional hazards recurrent event models

Most people are familiar with Cox proportional hazards models which have become the defacto standard for multivariate survival modelling. These models can be extended to manage recurrent events in a number of different ways. In each of these models, the data is broken up into time intervals defined by study entry, event times and death/censoring. For each interval, each subject is represented by a separate line such that if subjects have multiple events, they will be represented multiple times - the so called "counting process model". There are multiple different approaches, but the following model was used in the current analysis.


##Prentice, Williams and Peterson (PWP) conditional model

In this model, an additional variable is required to monitor the event number - often called the stratum. These are conditional models and represent the more realistic scenario whereby a subject cannot be at risk for event number two until event one has occurred (as opposed to other models where subjects are at risk for any event throughout the follow-up period). There are two strains of this model which relate to the time periods used. In one scenario, time is counted from study entry to event and continues counting throughout follow-up. In the other, follow-up begins again at zero following each event ("gap time"). There is no "correct" model here, the different treatments of time relate to a different desired interpretation.

The gap-time model holds interest for the investigation of recurrence in colorectal cancer. These patients have defined treatment events, usually punctuated by "remission" where no detectable disease is present and treatment is effectively completed. This model allows us to examine event specific estimates - ie is there a different in recurrence rates following one recurrence as compared with the third?

##Weighted, multiply imputed data

Following missing data management and propensity score generation, we are presented with five imputed, weighted datasets to analyse instead of the usual one. Additionally, any analysis must now take into account the additinal variance introduced by both MI and PS. Thankfully, software exists that makes this process relatively straightforward. Using the `survey` and `mitools` packages for `R`, we can create a survey design that takes into account the clustered nature of the PS dataset and will create the appropriate design for each individual dataset and wrap it up into a coherent object. When that object is used for further analysis, the package can combine the results of indivudal analysis with the appropriate adjustments (Rubin's rules) for multiple imputation.


