% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calibration.R
\name{robyn_calibrate}
\alias{robyn_calibrate}
\title{Robyn Calibration Function - BETA}
\usage{
robyn_calibrate(
  df_curve = NULL,
  curve_type = NULL,
  force_shape = NULL,
  hp_bounds = NULL,
  max_trials = 10,
  max_iters = 2500,
  loss_min_step_rel = 1e-04,
  loss_stop_rel = 0.05,
  burn_in_rel = 0.1,
  sim_n = 30,
  hp_interval = 0.5,
  quiet = FALSE,
  ...
)
}
\arguments{
\item{df_curve}{data.frame. Requires two columns named spend and response.
Recommended sources of truth are Halo R&F or Meta conversion lift.}

\item{curve_type}{Character. Currently only allows "saturation_reach_hill"
and only supports Hill function.}

\item{force_shape}{Character. Allows c("c", "s") with default NULL that's no
shape forcing. It's recommended for offline media to have "c" shape, while
for online can be "s" or NULL. Shape forcing only works if hp_bounds is null.}

\item{hp_bounds}{list. Currently only allows Hill for saturation. Ranges
for alpha and gamma are provided as Hill parameters. If NULL, hp_bounds takes
on default ranges.}

\item{max_trials}{integer. Different trials have different starting point
and provide diversified sampling paths. Default to 10.}

\item{max_iters}{integer. Loss is minimized while iteration increases.
Default to 2500.}

\item{loss_min_step_rel}{numeric. Default to 0.01 and value is between 0-0.1.
0.01 means the optimisation is considered converged if error minimization is
<1 percent of maximal error.}

\item{loss_stop_rel}{numeric. Default is 0.05 and value is between 0-0.5.
0.05 means 5 percent of the max_iters is used as the length of iterations to
calculate the mean error for convergence.}

\item{burn_in_rel}{numeric. Default to 0.1 and value is between 0.0.5. 0.1
means 10 percent of iterations is used as burn-in period.}

\item{sim_n}{integer. Number of simulation for plotting fitted curve.}

\item{hp_interval}{numeric. Default to 0.95 and is between 0.8-1. 0.95 means
2.5 - 97.5 percent percentile are used as parameter range for output.}

\item{quiet}{Boolean. Keep messages off?}

\item{...}{Additional parameters passed to \code{robyn_outputs()}.}
}
\value{
List. Class: \code{curve_out}. Contains the results of all trials
and iterations modeled.
}
\description{
\code{robyn_calibrate()} consumes source of truth or proxy data for
saturation or adstock curve estimation. This is an experimental feature and
can be used independently from Robyn's main model.
}
\examples{
\dontrun{
# Dummy input data for Meta spend. This is derived from Halo's reach & frequency data.
# Note that spend and response need to be cumulative metrics.
data("df_curve_reach_freq")

# Using reach saturation from Halo as proxy
curve_out <- robyn_calibrate(
  df_curve = df_curve_reach_freq,
  curve_type = "saturation_reach_hill"
)
# For the simulated reach and frequency dataset, it's recommended to use
# "reach 1+" for gamma lower bound and "reach 10+" for gamma upper bound
facebook_I_gammas <- c(
  curve_out[["curve_collect"]][["reach 1+"]][["hill"]][["gamma_best"]],
  curve_out[["curve_collect"]][["reach 10+"]][["hill"]][["gamma_best"]])
print(facebook_I_gammas)
}
}
