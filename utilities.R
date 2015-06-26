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