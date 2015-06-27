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
