library(shellpipes)
rpcall("rsaRe.Rout rsaRe.R resources/rsaRe.rds")
library(dplyr)
library(tidyr)

r <- rdsRead()

names(r)

days <- (r
	%>% select(date, wave)
	%>% distinct()
)

## Check that wave nests in date
stopifnot(
	days %>% nrow 
	== days %>% select(date) %>% nrow
)

tdata <- (r
	%>% transmute(date=date
		, inc_1=cnt, inc_2=reinf
		, susc_1=sus_1 + sus_2u
		, susc_2=sus_2
	)
	%>% pivot_longer(-date)
	%>% separate(name, c("class", "group"))
)

gdata <- full_join(tdata, days)

saveVars(days, tdata, gdata)
