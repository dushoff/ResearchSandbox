library(shellpipes)
library(magrittr)

(targetname()
	%>% sub("date_", "", .)
	## %>% as.Date()
) %>% print %>% rdsSave
