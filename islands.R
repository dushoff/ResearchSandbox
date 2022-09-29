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

## BROKEN
## Construct a grid adjacency matrix (and a wrapper to pass a grid object)
gridAdj <- function(r, c){
	gs <- r*c
	m <- matrix(nrow=gs, ncol=gs)
	for(irow in 1:r){
		for(icol in 1:c){
			i <- (irow-1)*c+icol
			for(jrow in 1:r){
				for(jcol in 1:c){
					j <- (jrow-1)*c+jcol
					dist <- abs(irow-jrow) + abs(icol-jcol)
					m[[i,j]] <- as.numeric(dist<=1)
				}
			}
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
	gl <- apply(gf, 1, function(v) return(suppressWarnings(min(which(v==1)))))
	gl[gl==Inf] <- NA
	gl <- ifelse(is.na(gl), 0, as.numeric(as.factor(gl)))
	attr(gl, "cols") <- attr(v, "cols")
	return(gl)
}

### Example
(
	tsvRead(col_names=FALSE)
	|> as.matrix()
	|> gridVec()
	|> countIslands()
	|> gridMat()
	|> as.data.frame()
	|> tsvSave(col_names=FALSE)
)
