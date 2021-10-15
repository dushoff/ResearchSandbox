
set.seed(1040)

thresholdDis <- 0.2 ## Our standard for success is that we are confident there are fewer infections than this
hypDis <- 0.1 ## We must make an assumption about the real risk of infection from TIM
trials <- 100
size <- seq(20, 120, by=10)

success <- function(dis, animals, t){
	return(prop.test(dis, animals)$conf.int[[2]] < t)
}

## Do one experiment
experiment <- function(hyp, thresh, animals){
	dis <- rbinom(1, animals, hyp)
	return(success(dis, animals, thresholdDis))
}

## Do many experiments

repExpt <- function(hyp, thresh, animals, trials){

	res <- logical(trials)

	for(t in 1:trials){
		res[[t]] <- experiment(hyp, thresh, animals)
	}
	return(mean(res))
}

## Test many sizes

powerRange <- function(hyp, thresh, trials, size){
	pow <- numeric(length(size))
	for (i in 1:length(size)){
		pow[[i]] <- repExpt(hyp, thresh, animals=size[[i]], trials)
	}
	return(pow)
}

p <- powerRange(hypDis, thresholdDis, trials, size)

plot(size, p)
