
forward <- function(mu, p, S){
	N <- S/p
	return((mu*sqrt(p)/2)*(N-1)/(p*N-1))
}

simple <- function(L, mu, S){
	return((mu/(2*L))^2)
}

good <- function(L, mu, S){
	return(uniroot(χ))
}

mu <- 2e-4
p <- 0.2

L <- forward(mu, p, S=200)
simple(L, mu, S=200)

L <- forward(mu, p, S=20)
simple(L, mu, S=20)


