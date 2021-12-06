library(rstan)

## load("../data/data_newyork_timeseries_d68.rda")

standata <- list(
  N=nrow(data_newyork_timeseries_d68),
  positive=data_newyork_timeseries_d68$positive,
  total=data_newyork_timeseries_d68$total,
  sensitivity=0.871,
  specificity=0.861
)

model <- stan_model("../stanmodel/basemodel.stan")

stanfit_newyork_basemodel <- sampling(model,
                              data = standata,
                              iter = 2000,
                              chains = 4,
                              seed=101)

save("stanfit_newyork_basemodel", file="stanfit_newyork_basemodel.rda")
