library(shellpipes)
rpcall("rsaRePrep.Rout rsaRePrep.R rsaRe.rda")
library(dplyr)
library(tidyr)

loadEnvironments()

adata <- (tdata
	%>% pivot_wider(names_from=class, values_from=value)
	%>% full_join(days)
)

summary(adata %>% mutate_if(is.character, as.factor))

## Check that there are no infections when there are no susceptibles
stopifnot(
	adata %>% filter(susc==0) %>% pull(inc) %>% range
	== c(0, 0)
)

rdsSave(adata %>% filter(susc>0))

