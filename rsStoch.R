library(ggplot2) # load ggplot
theme_set(theme_bw())
library(dplyr)
library(macpan2)

library(shellpipes)

rpcall("rsStoch.Rout rsStoch.pipestar rsStoch.R rsStoch.rds")

defaultSpecs <- rdsRead()
input <- list(vaxprop_l=0.5,vaxprop_h=0.9)
newparams <- list(vaxprop_l = input$vaxprop_l[1]
                  , vaxprop_h = input$vaxprop_h[1])
specs <- mp_tmb_update(defaultSpecs, default=newparams)

nsims <- 100

time_steps = 200 ## Days

outputs <- c("incidence_l", "incidence_h")

# simulator objects
seir_det = mp_simulator(
  model = specs
  , time_steps = time_steps
  , outputs = outputs
)

seir_stoch = mp_simulator(
  model = mp_euler_multinomial(specs)
  , time_steps = time_steps
  , outputs = outputs
)

## wrapper for stochastic simulations
ssfun <- function(x){
  # set.seed(x)
  dd <- (mp_trajectory(seir_stoch)
         %>% mutate(NULL
                    , iter = x
         )
  )
}

detf <- (mp_trajectory(seir_det)
         %>% mutate(NULL
                    , iter = 0
         )
)

incdf <- (bind_rows(lapply(1:nsims, ssfun), detf)
          |> mutate(VaccineCoverage_l = newparams$vaxprop_l
                    , VaccineCoverage_h = newparams$vaxprop_h
                    , Isol = newparams$isol
                    , Isoh = newparams$isoh
                    , pref = newparams$pref
          )
)

## Takes in the simulated stochastic simulations and plot it

alpha <- 0.01
## over <- 10
## alpha <- something about the number of simulatiosn

simdat <- incdf 

gg <- (ggplot(simdat, aes(time,value,group=interaction(iter,matrix),color=matrix))
       + geom_line(alpha=alpha)
       # + geom_line()
       + geom_line(data=simdat |> filter(iter==0))
       + scale_color_manual(values=c("blue","red"))
       + theme(legend.position = "none")
)

print(gg)

print(simdat|>filter(iter==1) == simdat|>filter(iter==2))
