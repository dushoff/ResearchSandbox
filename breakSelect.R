library(dplyr)

library(shellpipes)

(tsvRead()
	%>% select(-note)
) %>% tsvSave()
