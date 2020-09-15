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