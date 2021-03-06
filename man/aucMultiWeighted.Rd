% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aucMultiWeighted.r
\name{aucMultiWeighted}
\alias{aucMultiWeighted}
\title{Calculate multivariate weighted AUC}
\usage{
aucMultiWeighted(..., weightBySize = FALSE, na.rm = FALSE)
}
\arguments{
\item{...}{A set of two or more objects, each of which can be any of a 1- or 2-column matrix or data frame or a numeric vector. The objects must be listed in order of \emph{expected} probability. For example, you might have a set of predictions for objects you expect to have a low predicted probability (e.g., long-term absences of an animal), a set that you expect to have middle levels of probability (e.g., sites that were recently vacated), and a set for which you expect a high level of predicted probability (e.g., sites that are currently occupied). In this case you should list the cases in order: low, middle, high. If a 2-column matrix or data frame is supplied, then the first column is assumed to represent predictions and the second assumed to represent weights.}

\item{weightBySize}{Logical, if \code{FALSE} then the multivariate measure of AUC will treat all comparisons as equal (e.g., low versus middle will weigh as much as middle versus high), and so will simply be the mean AUC across all possible comparisons. If \code{TRUE} then multivariate AUC is the weighted mean across all possible comparisons where weights are the number of comparisons between each of the two cases. For example, if a set of "low" predictions ("low") has 10 data points, "middle" has 10, and "high" has 20, then the multivariate AUC will be (10 * low + 10 * middle + 20 * high) / (10 + 10 + 20).}

\item{na.rm}{Logical. If \code{TRUE} then remove any cases in \code{...} that are \code{NA}.}
}
\value{
Named numeric vector.
}
\description{
This function calculates a multivariate version of the area under the receiver-operator characteristic curve (AUC). The multivariate version is simply the mean AUC across all possible pairwise AUCs for all cases (based on Hand, DJ and Till, RJ. 2001. A simple generalisation of the area under the ROC curve for multiple class classification problems. \emph{Machine Learning} 45:171-186.).
}
\examples{
set.seed(123)

# no weights
low <- runif(10)^2
middle <- runif(10)
high <- sqrt(runif(20))

aucMultiWeighted(low, middle, high)

# equal weights
low <- matrix(c(low, rep(1, length(low))), ncol=2)
middle <- matrix(c(middle, rep(1, length(middle))), ncol=2)
high <- matrix(c(high, rep(1, length(high))), ncol=2)
aucMultiWeighted(low, middle, high)

# equal weights with weighting by number of comparisons
aucMultiWeighted(low, middle, high, weightBySize=TRUE)

# unequal weights
middle[ , 2] <- ifelse(middle[ , 1] > 0.5, 0.1, 1)
aucMultiWeighted(low, middle, high)

# unequal weights with weighting by number of comparisons
aucMultiWeighted(low, middle, high, weightBySize=TRUE)
}
\seealso{
\code{\link{fpb}}, \code{\link{contBoyce}}, \code{\link[dismo]{evaluate}}, \code{link[enmSdm]{aucWeighted}}
}
