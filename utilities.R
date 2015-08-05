spm <- function(impresults) {
  summary(pool(as.mira(impresults)))
}

plotdf <- function (impresult) {
  if (class(impresult)=="coxph") {
    plotout <- tidy(impresult)
    plotout %<>%
      select(
        term,
        estimate, 
        conf.low, 
        conf.high,
        std.error = robust.se,
        p.value)
    return(plotout)
  } else {
    plotout <- data.frame(spm(impresult))
    plotout %<>%
    transmute(
      term = rownames(plotout),
      estimate=est, 
      conf.low=lo.95, 
      conf.high = hi.95,
      std.error = se,
      p.value = `Pr...t..`,
      fmi=round(fmi, 2))
  return(plotout)
}
}

mi.ci <- function(poolscalar) {
  #Take the pooled scalar values for survival and generate 95% CIs
  df.ps <- with(poolscalar, list(df = df, est = qbar, var=t))
  mult <- qt(0.95, df=df.ps$df)
  upper <- round(df.ps$est + mult*sqrt(df.ps$var), 3)
  lower <- round(df.ps$est - mult*sqrt(df.ps$var), 3)
  return(str_c("5yr OS: ", round(df.ps$est,3), " (95% CI ", lower, "-", upper, ")"))
}

lichtrubin <- function(fit){
  ## pools the p-values of a one-sided test according to the Licht-Rubin method
  ## this method pools p-values in the z-score scale, and then transforms back 
  ## the result to the 0-1 scale
  ## Licht C, Rubin DB (2011) unpublished
  if (!is.mira(fit)) stop("Argument 'fit' is not an object of class 'mira'.")
  fitlist <- fit$analyses
  if (!inherits(fitlist[[1]], "htest")) stop("Object fit$analyses[[1]] is not an object of class 'htest'.")
  m <- length(fitlist)
  p <- rep(NA, length = m)
  for (i in 1:m) p[i] <- fitlist[[i]]$p.value
  z <- qnorm(p)  # transform to z-scale
  num <- mean(z)
  den <- sqrt(1 + var(z))
  pnorm( num / den) # average and transform back
}

pool.km <- function(km.mira.object) {
  results <- vector("list")
    for (i in c("median", "LCL", "UCL")){
      km.mira.object %>%
        list.apply(summary) %>%
        list.map(table) %>%
        data.frame() %>%
        select(contains(i)) %>%
        rowMeans(na.rm = T) %>%
        {
          round(./365.25*12,1)
        } -> results[[i]]
    }
  data.frame(results)
  }

pool.5yr <- function(km.mira.object) {
  results <- vector("list")
  for (i in c("surv", "std.err")){
    km.mira.object %>%
      list.apply(summary, times=1826.25) %>% 
      list.select(i) %>% 
      list.flatten() %>% 
      list.rbind() %>% 
      data.frame() -> results[[i]]
  }
 results
}

cavcombine <- function(dk, df, display = TRUE) 
  #dk = vector of chi-squared values, df = degrees of freedom
  #My variant of the miceadds::micombine.chisquare function
{
  M <- length(dk)
  mean.dk <- mean(dk)
  sdk.square <- var(sqrt(dk))
  Dval <- (mean.dk/df - (1 - 1/M) * sdk.square)/(1 + (1 + 1/M) * 
                                                   sdk.square)
  df2 <- (M - 1)/df^(3/M) * (1 + M/(M + 1/M)/sdk.square)^2
  pval <- pf(Dval, df1 = df, df2 = df2, lower.tail = F)
  chisq.approx <- Dval * df
  p.approx <- 1 - pchisq(chisq.approx, df = df)
  res <- c(D = Dval, p = pval, df = df, df2 = df2, chisq.approx = chisq.approx, 
           p.approx = p.approx)
  if (display) {
    message("Combination of Chi Square Statistics for Multiply Imputed Data\n")
    message(paste("Using", M, "Imputed Data Sets\n"))
    message(paste("F(", df, ",", round(df2, 2), ")", "=", 
                  round(Dval, 3), "     p=", round(pval, 5), sep = ""), "\n")
    message(paste("Chi Square Approximation Chi2(", df, ")", 
                  "=", round(chisq.approx, 3), "     p=", round(p.approx, 
                                                                5), sep = ""), "\n")
  }
  invisible(res)
}

summary.MIresult<-function(object,...,alpha=0.05, logeffect=FALSE){
  #My version of the MIresult summary function, easy to use with knitr
  #message("Multiple imputation results:\n")
  #lapply(object$call, function(a) {cat("      ");print(a)})
  out<-data.frame(results=coef(object), se=sqrt(diag(vcov(object))))
  crit<-qt(alpha/2,object$df, lower.tail=FALSE)
  out$"(lower"<-out$results-crit*out$se
  out$"upper)"<-out$results+crit*out$se
  out$"missInfo" <-paste(round(100*object$missinfo), "%")
  return(out)
}

stable.weights <- function (ps1, stop.method = NULL, estimand = NULL) 
{
  if (class(ps1) == "ps") {
    if (is.null(estimand)) 
      estimand <- ps1$estimand
    if (!(estimand %in% c("ATT", "ATE"))) 
      stop("estimand must be either \"ATT\" or \"ATE\".")
    if (estimand != ps1$estimand) {
      warning("Estimand specified for get.weights() differs from the estimand used to fit the ps object.")
    }
    if (length(stop.method) > 1) 
      stop("More than one stop.method was selected.")
    if (!is.null(stop.method)) {
      stop.method.long <- paste(stop.method, ps1$estimand, 
                                sep = ".")
      i <- match(stop.method.long, names(ps1$w))
      if (is.na(i)) 
        stop("Weights for stop.method=", stop.method, 
             " and estimand=", estimand, " are not available. Please a stop.method and used when fitting the ps object.")
    }
    else {
      warning("No stop.method specified.  Using ", names(ps1$ps)[1], 
              "\n")
      
      i <- 1
    }
    if (estimand == "ATT") {
      w <- with(ps1, treat + (1 - treat) * ps[[i]]/(1 - 
                                                      ps[[i]]))
      return(w)
    }
    else if (estimand == "ATE") {
      w <- with(ps1, ifelse(treat==1, (mean(ps[[i]]))/ps[[i]], (mean(1-ps[[i]]))/(1-ps[[i]])))
      return(w)
    }
  }
}