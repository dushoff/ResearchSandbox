set.seed(428)

## A function to fill a contiguous area of length cLen with as many blocks as possible of length bLen, with random spacers as needed. Returns the starting point of blocks of length bLen
rBlocks <- function(cLen, bLen){
	numBlocks <- floor(cLen/bLen)
	extra <- cLen %% bLen
	d <- data.frame(
		type = c(rep("b", numBlocks), rep("x", extra))
		, l = c(rep(bLen, numBlocks), rep(1, extra))
	)
	all <- numBlocks+extra
	d <- d[sample(1:all), ]
	d$start <- (c(0, cumsum(d$l)[-all])) + 1
	return(d$start[d$type=="b"])
}

rBlocks(400, 31)

