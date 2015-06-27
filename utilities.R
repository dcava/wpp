spm <- function(impresults) {
  summary(pool(as.mira(impresults)))
}

plotdf <- function (impresult) {
  plotout <- tidy(spm(impresult))
  plotout %>%
    transmute(
      est=exp(est), 
      lo.95=exp(lo.95), 
      hi.95 = exp(hi.95), 
      fmi=round(fmi, 2))
  row.names(plotout) <- plotout$.rownames
  return(plotout)
}

mi.ci <- function(poolscalar) {
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

