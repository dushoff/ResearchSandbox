n <- 4
tri <- n*(n-1)/2
mult <- 0.995
mult <- 1
eps <- 1e-6

symMat <- function(x, n, mult=1) {
	M <- diag(n)
	M[lower.tri(M)] <- mult*x
	M <- M + t(M) - diag(n)
	return(M)
}

symDet <- function(x, n, mult=1){
	return(det(symMat(x, n, mult)))
}

symEv <- function(x, n, mult=1){
	return(eigen(symMat(x, n, mult))$values)
}

corners <- (replicate(tri, c(-1,1), simplify = FALSE)
	|> do.call(what = expand.grid)
)

det <- apply(corners, 1, \(x) symDet(unlist(x), n=n, mult=mult))
plus <- apply(corners, 1, \(x) (tri+sum(unlist(x)))/2)
ev <- apply(corners, 1, \(x) symEv(unlist(x), n=n, mult=mult))
evframe <- as.data.frame(t(ev))
print(evframe[[n]])

print(corners[abs(evframe[[n]])<eps, ])
quit()

print(evframe[order(evframe[[n]]), ] |> unique())

print(data.frame(det, plus))

print(corners)
sum(det>0)
sum(det>1)

for (w in which(det>1)){
	print(symMat(unlist(corners[w, ]), n))
}

for (w in which(det>0 & det<1)){
	print(symMat(unlist(corners[w, ]), n))
}
