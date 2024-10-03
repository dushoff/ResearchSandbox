library(lamW)

library(shellpipes)
startGraphics()

a <- 0.01   # attack rate  
h <- 0.1   # handling time
T <- 8     # experiment duration

step <- 40
levels <- 10
reps <- 100
Nvals <- step*(1:levels)
N <- rep(Nvals, each=reps) # initial number of prey

calc <- Nvals - lambertW0(a*h*Nvals*exp(-a*(T - h*Nvals)))/(a*h)

rogers <- function(N, a, h, T){
	return(N - lambertW0(a*h*N*exp(-a*(T - h*N)))/(a*h))
}

calc2 <- rogers(Nvals, a, h, T)
print(data.frame(calc=calc, calc2=calc2))

pred.sim0 <- function(x,a,h){
  prey <- x:1
  eaten <- cumsum(rexp(length(prey),a*prey)+h)
  return(sum(eaten<T))
}

pred.sim <- function(x,a,h){
  sapply(x,function(z) pred.sim0(z,a,h))
}

y <- pred.sim(N,a,h)
plot(N,y)
lines(Nvals, calc)

saveEnvironment()
