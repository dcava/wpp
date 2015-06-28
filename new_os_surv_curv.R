library(grid)
library(scales)
library(broom)

#Vars
timeby = 365.25  #set times for years
xlabs = "Time(years)"
xlims = c(0,3653)
ylims = c(0,1)
leg.pos = "right"
ystratalabs <- c("Open", "Laparoscopic")
ystrataname <- ""
m <- max(nchar(ystratalabs))

times <- seq(0, max(xlims), by = timeby)

####Kaplan-Meier
os_svy <- survfit(Surv(cens_time, cens)~lap+cluster(id_patients), weights = stable.w, midata$imputations$psate1, subset=index==1)

df <- tidy(os_svy)
df$strata <- as.factor(df$strata)
d <- length(levels(df$strata))

###Data for confidence bars
timesci <- seq(0,max(os_svy$time), by= timeby*2)
conf.data <- summary(os_svy, times=timesci, scale=365.25)
conf.data <- with(list.flatten(conf.data), data.frame(time=time, survival=surv, lower=lower, upper=upper, strata=strata))
conf.data <- conf.data %>% filter(time!=0)

#HR
cox <- exp(spm(doublerobust.full)[1,c("est", "lo 95", "hi 95")])
hr <- paste("HR = ", round(cox[1],2))
ci <- paste("95% CI: ", round(cox[2],2), "-", round(cox[3],2))

######
#PLot#
######

os_curve <- ggplot() +
  geom_step(data=df, aes(time, (1-estimate), linetype = strata), size = 0.7) +
  theme_bw() +
  theme(axis.title.x = element_text(vjust = 0.5)) +
  scale_x_continuous(xlabs, breaks = times, limits = xlims, labels=c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9","10")) +
  scale_y_continuous("Percent died", limits = c(0, 1), labels=percent) +
  scale_linetype_manual(labels = c("Open", "Laparoscopic"), breaks=c("lap=0", "lap=1"), values=c(1,2,1,2)) +
  scale_shape_discrete(guide=FALSE) +
  scale_colour_manual(guide=FALSE, values=c("grey40", "grey40")) +
  theme(panel.grid.minor = element_blank()) +
  theme(legend.position = c(ifelse(m < 10, .1, .2),ifelse(d < 4, 0.8, .3))) +    # MOVE LEGEND HERE [first is x dim, second is y dim]
  theme(legend.key = element_rect(colour = NA)) +
  theme(legend.text = element_text(size=rel(1.5))) + 
  labs(linetype = ystrataname) +
  theme(plot.margin = unit(c(0, 1, .5,ifelse(m < 10, 1.5, 2.5)),"lines")) +
  ggtitle("Overall survival (Kaplan-Meier estimate)") + 
  geom_errorbar(data=conf.data, aes(x=time*365.25, ymin=(1-lower), ymax=(1-upper), linetype=strata, colour=strata), width=1, position=position_dodge(width = 40)) +
  geom_point(data=conf.data, aes(time*365.25, 1-survival, shape=strata), position = position_dodge(width = 40)) +
  annotate("text",x = 0.8 * 3652.5,y = 0.15,label = hr, size=rel(4.5)) +
  annotate("text",x = 0.8 * 3652.5,y = 0.12,label = ci, size=rel(4.5))

