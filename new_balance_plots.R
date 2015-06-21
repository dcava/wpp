dx.names <- psresults[[1]]$gbm.obj$var.names
ballist <- vector('list')
dxlist <- vector('list')
plotlist <- vector('list')

for (i in 1:5) {
  name <- paste("psate",i,sep="")
  dxlist[[name]] <- dx.wts(impweights[[i]]$weights, data=impdata[[i]], vars=dx.names, estimand="ATE", treat.var = "lap")
  bal.dx.wt <- bal.table(dxlist[[i]])
  ballist[[name]] <-  list(unw=bal.dx.wt$unw, wtd=bal.dx.wt[[2]])
  plotdata <- as.data.frame(cbind(asam=c(ballist[[i]]$unw$std.eff.sz, ballist[[i]]$wtd$std.eff.sz), p=c(ballist[[i]]$unw$p, ballist[[i]]$wtd$p), kspval =c(ballist[[i]]$unw$ks.pval, ballist[[i]]$wt$ks.pval), wt = rep(c("unw", "wtd"), each=length(rownames(dxlist[[i]]$desc$unw$bal.tab$results))), vars=rep(rownames(dxlist[[i]]$desc$unw$bal.tab$results), times=2)), stringsAsFactors = F)
  plotdata$sig <- as.factor(as.numeric(plotdata$p <=0.05))
  plotdata$sig <- car::Recode(plotdata$sig, 'NA=0')
  plotdata$asam <- as.numeric(plotdata$asam)
  plotdata$wt <- as.factor(plotdata$wt)
  plotdata$vars <- as.factor(plotdata$vars)
  plotdata$kspval <- as.numeric(plotdata$kspval)
  plotdata$p <- as.numeric(plotdata$p)
  plotdata %>% group_by(wt) %>% mutate(rk=row_number(kspval)) -> plotdata
  plotlist[[name]] <- plotdata
}


balplotlist <- vector('list')
qqplotlist <- vector('list')
for (i in 1:5) {
  

##Balance plot
  name <- paste("psate",i,sep="")
  balplotlist[[name]] <- ggplot(plotlist[[i]], aes(wt, abs(asam), shape=sig, group=vars)) + 
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
  ggtitle(paste0("Change in effect size - imputed set ", i))

##########
#QQ-plot
  qqplotlist[[name]] <- ggplot(plotlist[[i]], aes(rk, kspval, shape=wt)) + 
  geom_point() + 
  geom_segment(data=plotlist[[i]], aes(x=0, y=0, xend=max(rk), yend=1), linetype=2, colour="grey50") +
  scale_shape_manual(values=c(1,17), labels=c("Unweighted", "Weighted"), "") +
  scale_x_continuous(breaks=seq(0,30,by=5)) +
  ylab("KS test p-values") +
  xlab("Rank of p-value for pre-treatment variables") +
  ggtitle(paste0("Quantile-Quantile plot of observed p-values - imputed set ", i)) +
  theme_bw()

}