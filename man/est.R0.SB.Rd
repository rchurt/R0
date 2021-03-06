\name{est.R0.SB}
\alias{est.R0.SB}
\title{Estimate the time dependent reproduction number using a Bayesian approach}
\description{Estimate the time dependent reproduction number using a Bayesian approach. All known data are used as a prior for next iteration (see Details).}
\usage{est.R0.SB(epid, GT, t = NULL, begin = NULL, end = NULL, date.first.obs = NULL, 
    time.step = 1, force.prior = FALSE, checked = FALSE, ...)}
\arguments{
  \item{epid}{the epidemic curve}
  \item{GT}{generation time distribution}
  \item{t}{Time at which epidemic was observed}
  \item{begin}{At what time estimation begins. Just there for "plot" purposes, not actually used}
  \item{end}{At what time estimation ends. Just there for "plot" purposes, not actually used}
  \item{date.first.obs}{Optional date of first observation, if t not specified}
  \item{time.step}{Optional. If date of first observation is specified, number of day between each incidence observation}
  \item{force.prior}{Set to any custom value to force the initial prior as a uniform distribution on [0;value]}
  \item{checked}{Internal flag used to check whether integrity checks were ran or not.}
  \item{\dots}{parameters passed to inner functions}
}
\details{For internal use. Called by est.R0.

Initial prior is an unbiased uniform distribution for R, between 0 and the maximum of incid(t+1) - incid(t). 
For each subsequent iteration, a new distribution is computed for R, using the previous output as new prior.

CI is achieved by a cumulated sum of the R posterior distribution, and corresponds to the 2.5\% and 97.5\% thresholds}
\value{A list with components:
\item{R}{vector of R values.}
\item{conf.int}{95\% confidence interval for estimates.}
\item{proba.Rt}{A list with successive distribution for R throughout the outbreak.}
\item{GT}{generation time distribution}
\item{epid}{the epidemic curve}
\item{begin}{At what time estimation begins. Just there for "plot" purposes, not actually used}
\item{begin.nb}{Index of begin date for the fit.}
\item{end}{At what time estimation ends. Just there for "plot" purposes, not actually used}
\item{end.nb}{Index of end date for the fit.}
\item{pred}{Predictive curve based on most-likely R value.}
\item{data.name}{Name of the data used in the fit.}
\item{call}{Complete call used to generate results.}
\item{method}{Method for estimation.}
\item{method.code}{Internal code used to designate method.}}
\references{Bettencourt, L.M.A., and R.M. Ribeiro. "Real Time Bayesian Estimation of the Epidemic Potential of Emerging Infectious Diseases." PLoS One 3, no. 5 (2008): e2185.}
\author{Pierre-Yves Boelle, Thomas Obadia}
\note{This is the implementation of the method provided by Bettencourt & Ribeiro (2008).}



\examples{#Loading package
library(R0)

## Data is taken from the paper by Nishiura for key transmission parameters of an institutional
## outbreak during 1918 influenza pandemic in Germany)

data(Germany.1918)
mGT <- generation.time("gamma", c(3,1.5))
SB <- est.R0.SB(Germany.1918, mGT)

## Results will include "most likely R(t)" (ie. the R(t) value for which the computed probability 
## is the highest), along with 95\% CI, in a data.frame object
SB
# Reproduction number estimate using  Real Time Bayesian  method.
# 0 0 2.02 0.71 1.17 1.7 1.36 1.53 1.28 1.43 ...

SB$Rt.quant
# Date R.t. CI.lower. CI.upper.
# 1  1918-09-29 0.00      0.01      1.44
# 2  1918-09-30 0.00      0.01      1.42
# 3  1918-10-01 2.02      0.97      2.88
# 4  1918-10-02 0.71      0.07      1.51
# 5  1918-10-03 1.17      0.40      1.84
# 6  1918-10-04 1.70      1.09      2.24
# 7  1918-10-05 1.36      0.84      1.83
# 8  1918-10-06 1.53      1.08      1.94
# 9  1918-10-07 1.28      0.88      1.66
# 10 1918-10-08 1.43      1.08      1.77
# ...

## "Plot" will provide the most-likely R value at each time unit, along with 95CI
plot(SB)
## "Plotfit" will show the complete distribution of R for 9 time unit throughout the outbreak
plotfit(SB)}
