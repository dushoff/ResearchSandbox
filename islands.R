library(shellpipes)

## Two interchangeable styles of storing a colored grid
gridVec <- function(m){
	v <- as.vector(t(m))
	attr(v, "cols") <- ncol(m)
	return(v)
}

gridMat <- function(v){
	m <- matrix(v, ncol=attr(v,"cols"), byrow=TRUE)
	return(m)
}

## Construct a grid adjacency matrix (and a wrapper to pass a grid object)
gridAdj <- function(r, c){
	gs <- r*c
	m <- matrix(nrow=gs, ncol=gs)
	for(i in 1:gs){
		for(j in 1:gs){
			diff <- abs(i-j)
			m[[i,j]] <- ifelse(diff==0 | diff==1 | diff==c, 1, 0)
		}
	}
	return(m)
}

gridgrid <- function(v){
	c <- attr(v, "cols")
	return(gridAdj(length(v)/c, c))
}

## Construct a connectivity matrix (connect through positive entries)
gridconn <- function(v){
	dvn <- diag(ifelse(v==0, 0, 1))
	gg <- gridgrid(v)
	return(dvn %*% gg %*% dvn)
}

## Construct a full connectivity matrix by Boolean matrix multiplication
gridfull <- function(v){
	gc <- gridconn(v)
	gf <- gc
	c <- attr(v, "cols")
	r <- length(v)/c
	circ <- r+c-2
	if (circ>=2)
		for (i in 2:circ){
			gf <- gf %*% gc
			gf <- ifelse(gf==0, 0, 1)
		}
	return(gf)
}

countIslands <- function(v){
	gf <- gridfull(v)
	gl <- apply(gf, 1, function(v) return(min(which(v==1))))
	return(length(unique(gl))-1)
}

### Example
print(
	tsvRead(col_names=FALSE)
	|> as.matrix()
	|> gridVec()
	|> countIslands()
)
