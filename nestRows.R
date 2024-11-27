
library(dplyr)

nestRows <- function(v, lev){
	if (lev <1) return(NULL)
	if (lev <= 1) return(data.frame(v1=v))
	lab <- paste0("v", lev)
	f <- nestRows(v, lev-1)
	l <- list()
	for (e in 1:length(v)){
		l[[e]] <- f
		l[[e]][[lab]] <- v[[e]]
	}
	return(bind_rows(l))
}

triProd

## nestRows(0:2, 4)
