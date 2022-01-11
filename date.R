library(shellpipes)
library(magrittr)

(targetname()
	%>% sub("_date$", "", .)
	%>% as.Date()
) %>% rdsSave()
