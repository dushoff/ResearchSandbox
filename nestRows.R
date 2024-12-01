
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

triProd <- function(v){
	w <- v
	for (i in 2:length(v))
		w <- c(w, v[[i-1]]*v[i:length(v)])
	return(w)
}


r <- nestRows(c(-1, 1), 4)
