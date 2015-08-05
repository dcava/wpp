#library(grid)
#library(scales)

#Vars
timeby = 365.25  #set times
xlabs = "Time(years)"
xlims = c(0,1826.25)
ylims = c(0,1)
leg.pos = "right"
ystratalabs <- c("Open(1st)", "Open(2+)", "Laparoscopic(1st)", "Laparoscopic(2+)")
ystrataname <- ""
m <- max(nchar(ystratalabs))


times <- seq(0, max(xlims), by = timeby)


####KM - rfs by index
rfs_km <- survfit(Surv(gaptime, (rec==1|cens==1))~lap + strata(index) +cluster(id_patients), weights = stable.w, midata$imputations$psate1)
df.rfs <- tidy(rfs_km)
d <- length(levels(df.rfs$strata))

###Data for confidence bars
timesci <- seq(0,max(rfs_km$time), by= timeby*2)
conf.data <- summary(rfs_km, times=timesci, scale=365.25)
conf.data <- with(list.flatten(conf.data), data.frame(time=time, survival=surv, lower=lower, upper=upper, strata=strata))
conf.data <- conf.data %>% filter(time!=0)


######
#Plot#
######

rfs_curve <- ggplot() +
  geom_step(data=df.rfs, aes(time, (1-estimate), linetype = strata, colour=strata), size = 0.7) +
  theme_bw() +
  scale_x_continuous(xlabs, breaks = times, limits = xlims, labels=c("0", "1", "2", "3", "4", "5")) +
  scale_y_continuous("Percent recurrence or death", limits = c(0, 1), labels=percent) +
  scale_linetype_manual(labels = ystratalabs, breaks = names(rfs_km$strata), values=c(1,1,2,2,1,1,2,2)) +
  scale_color_manual(labels = ystratalabs, breaks = names(rfs_km$strata), values=alpha(c("grey20", "grey50", "grey20", "grey50","grey20", "grey50", "grey20", "grey50"), c(1,0.5,1,0.5,1,0.5,1,0.5))) +
  scale_shape_manual(guide=FALSE, values=c(1,1,2,2)) + 
  scale_alpha(guide=FALSE) +
  theme(panel.grid.minor = element_blank(),
        legend.text = element_text(size=rel(1.5)),
        legend.position = c(ifelse(m < 10, .1, .2),ifelse(d < 4, 0.8, .3)),
        # MOVE LEGEND HERE [first is x dim, second is y dim]
        legend.key = element_rect(colour = NA),
        plot.margin = unit(c(0, 1, .5,ifelse(m < 10, 1.5, 2.5)),"lines"),
        axis.text = element_text(size=rel(1.7)),
        axis.title.x = element_text(vjust = 0.5),
        axis.title = element_text(size=rel(1.15)),
        title = element_text(size=rel(1.75))) +
  labs(linetype = ystrataname, colour=ystrataname) +
  ggtitle("Cumulative percent with event") + 
  #Error bars section below
  geom_errorbar(data=conf.data, aes(x=time*365.25, ymin=(1-lower), ymax=(1-upper), linetype=strata, colour=strata), width=1, position=position_dodge(width = 40)) + 
  geom_point(data=conf.data, aes(x=time*365.25, y=1-survival, shape=strata), position = position_dodge(width = 40)) 