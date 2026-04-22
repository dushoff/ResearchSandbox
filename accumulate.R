library(macpan2)
library(dplyr)
library(tidyr)
library(ggplot2);theme_set(theme_bw())

set.seed(20260512)

I0 <- 10
N <- 1e4
ts <- 300
out = c("S", "I", "check")

comp <- function(flow, def, time_steps){
	spec = mp_tmb_model_spec(
	  during = flow
	  , default = def
	)

	det_sim <- mp_trajectory(
		mp_simulator(model = mp_euler(spec)
		, time = time_steps
		, outputs = out
	)) |> pivot_wider(id_cols=time, names_from=matrix)

	detf <- det_sim |> mutate(iter = "0")

	print(summary(detf))

	stochf <- mp_trajectory(mp_simulator(model = mp_discrete_stoch(spec)
		, time = time_steps
		, outputs = out
	)) |> pivot_wider(id_cols=time, names_from=matrix)

	print(summary(stochf))
}

## flow diagram specification
manualFlow = list(
	incrate ~ beta * I / N 
	, inc ~ 0
	, mp_per_capita_flow("S", "inc", "incrate", "incidence")
	, mp_per_capita_flow("I", "R", "gamma", "recovery")
	, I ~ I + inc
	, A ~ A + inc
	, check ~ A+S
)

simpleFlow = list(
	incrate ~ beta * I / N 
	, mp_per_capita_flow("S", "I", "incrate", "incidence")
	, mp_per_capita_flow("I", "R", "gamma", "recovery")
	, mp_inflow("A", "incrate*S", "accumulate")
	, check ~ A+S
)

fakeFlow = list(
	inc ~ beta * I / N 
	, res ~ S
  , mp_per_capita_flow("S", "I", "inc", "incidence")
  , mp_per_capita_flow("I", "R", "gamma", "recovery")
  , mp_per_capita_flow("res", "A", "inc","acc")
  , check ~ A+S
)


## default values for quantities required to run simulations
default = list(
    beta = 0.8
  , gamma = 0.1	## recovery rate
  , N = N     ## total population size (constant in this model)
  , S = N-I0
  , I = I0
  , R = 0
  , A = 0
)

## This is the way we think you would do it “right” -- the deterministic version looks right (check should stay constant, since we accumulate everyone who leaves the S box)
comp(simpleFlow, default, time_steps=300)

## This is manual -- it works fine (and is also a little better conceptually, because it's using a single flow for inc, not sure if there's meant to be a macpan way to have a flow go to multiple places). But the key here s that mp_inflow seems just wrong.
comp(manualFlow, default, time_steps=300)

## This is a hack to show that, even though we do expect stochastic fluctuations in the simple model, the realized fluctuations are the wrong order of magnitude there (the hack shows the expected order of magnitude)
comp(fakeFlow, default, time_steps=300)

