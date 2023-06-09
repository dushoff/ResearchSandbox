library(deSolve)                # Load libary to be used for numerical integration

library(shellpipes)

startGraphics()

sirstep <- function(t,y,parms){
  with(c(as.list(y),parms),{
    dSdt <- birth*N - beta*S*I/N
    dIdt <- beta*S*I/N - gamma*I - death*I
    # Note: Population size is constant, so don't need to specify dRdt
    list(c(dSdt,dIdt))
  })
}

sir <- function(init, t, p){
	return(data.frame(lsoda(
		y=init, times=t, func=sirstep, parms=p
	)))
}

N0 <- 7780000
L <- 60*365.25
ts <- sir(
	init=c(S = 0.065*N0, I = 20.5)
	, t= seq(0, 365, 0.1)
	, p = c(beta = 3.6, gamma = 1/5, birth=1/L, death=1/L, N = N0)
)


plot(ts$time,               # Time on the x axis
     ts$I,                  # Number infected (I) on the y axis
     xlab = "Time in days",     # Label the x axis
     ylab = "Number infected",  # Label the y axis
     main = "Measles in New York",    # Plot title
     xlim = c(0,400),           #
     type = "l",                # Use a line plot
     bty = "n")                 # Remove the box around the plot
