randMat <- function(seed, r, c){
	set.seed(seed)
	return(matrix(
		runif(r*c), nrow=r
	))
}

size <- function(m){
	return(sum(m^2))
}

invGen <- function(g){
	b <- g%*%t(g)
	return(solve(b)%*%g)
}

G <- randMat(seed=3, r=2, c=6)
GG <- invGen(G)
GGG <- invGen(GG)

size(G-GGG)
