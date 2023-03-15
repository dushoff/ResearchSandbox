set.seed(2255)

time <- sample(1:6, 10, replace=TRUE)

print(time)

ind <- rowsum(rep(1,length(time)), time)[,1]

print(ind)

surv <- rev(cumsum(rev(ind)))

print(surv)

data.frame(time=time
	, numEvents = ind[as.character(time)]
	, survivors = surv[as.character(time)]
) 
