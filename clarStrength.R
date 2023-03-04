
library(ggplot2); theme_set(theme_bw(base_size=14))
library(dplyr)

library(shellpipes)
startGraphics(height=5)

## cutoff = 1 is fixed for now
largeEffect=1.3
smallEffect=0.5
tinyEffect = 0.1
smallVar = 0.2
medVar = 0.4
largeVar = 0.7
hugeVar = 1.2
span = 2

vget = Vectorize(get)

vr <- (
	read.table(header=TRUE, strip.white=TRUE, sep=":", text="
		pic : val : unc : atext
		PL : largeEffect : smallVar : Clearly large|and positive
		PU : largeEffect : largeVar : Clearly positive,|maybe large
		PS : smallEffect : smallVar : Clearly positive|and not large
		US : tinyEffect : medVar : Maybe positive,|clearly small
		UU : smallEffect : largeVar : Not both large|and negative
		nopower : tinyEffect : hugeVar : Should have|done a power|analysis first
	")
)

## (vr %>% mutate_if(is.character, as.factor) %>% summary)

## quit()

vf <- (vr
	%>% mutate(NULL
		, pic = factor(pic, levels=rev(pic))
		, val = vget(val)
		, unc = vget(unc)
		, lwr = val-unc
		, upr = val+unc
		, atext = gsub('\\|', '\n', atext)
	)
)

print(ggplot(vf)
	+ aes(pic, val)
	+ geom_point()
	+ geom_errorbar(aes(ymin=lwr, ymax=upr), width=0.1)
	+ coord_flip()
	+ geom_hline(yintercept=0)
	+ geom_hline(yintercept=c(-1, 1), lty=2)
	+ scale_y_continuous(limits=c(-span, span)
		, breaks = -1:1
		, labels = c("cutoff", 0 , "cutoff")
	)
	+ scale_x_discrete(labels=rev(vf$atext))
	+ xlab("")
	+ ylab("")
)

