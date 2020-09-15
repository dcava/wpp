plotdata <- as.data.frame(cbind(asam=c(bal.dx.ave.wt$unw$std.eff.sz, bal.dx.ave.wt$wtd$std.eff.sz), p=c(bal.dx.ave.wt$unw$p, bal.dx.ave.wt$wtd$p), kspval =c(bal.dx.ave.wt$unw$ks.pval, bal.dx.ave.wt$wt$ks.pval), wt = rep(c("unw", "wtd"), each=27), vars=rep(rownames(dx.ave.wt$desc$unw$bal.tab$results), times=2)), stringsAsFactors = F)

plotdata$sig <- as.factor(as.numeric(plotdata$p <=0.05))
plotdata$sig <- car::Recode(plotdata$sig, 'NA=0')
plotdata$asam <- as.numeric(plotdata$asam)
plotdata$wt <- as.factor(plotdata$wt)
plotdata$vars <- as.factor(plotdata$vars)
plotdata$kspval <- as.numeric(plotdata$kspval)
plotdata$p <- as.numeric(plotdata$p)

plotdata %>% group_by(wt) %>% mutate(rk=row_number(kspval)) -> plotdata


##Balance plot
balplot <- ggplot(plotdata, aes(wt, abs(asam), shape=sig, group=vars)) + 
  geom_point(aes(size=2)) + 
  geom_line() +
  geom_hline(aes(yintercept=0.2), linetype=2, alpha=0.5) +
  geom_hline(aes(yintercept=0.4), linetype=2, alpha=0.25) +
  scale_shape_manual(values=c(1,17), labels=c("p>0.05", "p<0.05"), "") +
  scale_size_continuous(guide=FALSE) +
  theme_bw() +
  ylab("Absolute standard difference") +
  xlab("") +
  scale_x_discrete(labels=c("Unweighted", "Weighted")) +
  ggtitle("Change in effect size")

##########
#QQ-plot
qqbalplot <- ggplot(plotdata, aes(rk, kspval, shape=wt)) + 
  geom_point() + 
  geom_segment(data=plotdata, aes(x=0, y=0, xend=max(rk), yend=1), linetype=2, colour="grey50") +
  scale_shape_manual(values=c(1,17), labels=c("Unweighted", "Weighted"), "") +
  scale_x_continuous(breaks=seq(0,30,by=5)) +
  ylab("KS test p-values") +
  xlab("Rank of p-value for pre-treatment variables") +
  ggtitle("Quantile-Quantile plot of observed p-values") +
  theme_bw()
