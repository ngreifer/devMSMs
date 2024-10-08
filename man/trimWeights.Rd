% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trimWeights.R
\name{trimWeights}
\alias{trimWeights}
\title{Trim IPTW balancing weights, if needed}
\usage{
trimWeights(weights, at = 0, lower = FALSE, verbose = FALSE, save.out = FALSE)
}
\arguments{
\item{weights}{list of IPTW weights output from \code{\link[=createWeights]{createWeights()}}}

\item{at}{\code{numeric}; either the quantile of the weights above which
weights are to be trimmed. A single number between .5 and 1, or the number
of weights to be trimmed (e.g., \code{at = 3} for the top 3 weights to be
set to the 4th largest weight).}

\item{lower}{\code{logical}; whether also to trim at the lower quantile
(e.g., for \code{at = .9}, trimming at both .1 and .9, or for \code{at = 3},
trimming the top and bottom 3 weights). Default is \code{FALSE} to only trim the higher weights.}

\item{verbose}{(optional) TRUE or FALSE indicator for printing output to console.
default is FALSE.}

\item{save.out}{(optional) Either logical or a character string. If \code{TRUE},
it will output the result to a default file name within \code{home_dir} set in \code{initMSM()}. You can load the data with \code{x <- readRDS(file)}.
To use a non-default file name, specify a character string with the file name. It will save relative to \code{home_dir}.
There might be naming conflicts where two objects get saved to the same file. In these cases, users should specify a custom name.
default is FALSE.}
}
\value{
a list containing \code{\link[WeightIt:weightitMSM]{WeightIt::weightitMSM()}} output. It is the length
of the number of datasets (1 for a data.frame or the number of imputed datasets).
}
\description{
Trims IPTW balancing weights with heavy right tails by populating all weight
values above a given quantile with the weight value of that quantile.
}
\examples{
library(devMSMs)
data <- data.frame(
  ID = 1:50,
  A.1 = rnorm(n = 50),
  A.2 = rnorm(n = 50),
  A.3 = rnorm(n = 50),
  B.1 = rnorm(n = 50),
  B.2 = rnorm(n = 50),
  B.3 = rnorm(n = 50),
  C = rnorm(n = 50),
  D.3 = rnorm(n = 50)
)
obj <- initMSM(
  data,
  exposure = c("A.1", "A.2", "A.3"),
  ti_conf = c("C"),
  tv_conf = c("B.1", "B.2", "B.3", "D.3")
)
f <- createFormulas(obj, type = "short")

w <- createWeights(data = data, formulas = f)
tw <- trimWeights(w, at = 0.975)
print(tw)
plot(tw)

trimWeights(w, at = 0.975, lower = TRUE)

}
\seealso{
\code{\link[WeightIt:trim]{WeightIt::trim()}},
\url{https://search.r-project.org/CRAN/refmans/WeightIt/html/trim.html} which
this function wraps
}
