
spot <- read.csv("spotify.csv")

totalsongs <- length(spot$bpm)

#calculate test statistic
s <- sd(spot$bpm)
xbar <- mean(spot$bpm)
t_stat <- ((xbar-124)/(sqrt(s^2/totalsongs)))
print(t_stat)

#calcuate p value
p_val_bpm <- pt(t_stat, totalsongs-1)
print(p_val_bpm)

hyp <- 124
alpha <- 0.05
t.test(x=spot$bpm,conf.level=0.90)
t.test(x=spot$bpm-hyp,conf.level=0.90)

ci_int <- t.test(x=spot$bpm,conf.level=0.90)$conf.int
print(ci_int)

# find confidence interval (2)
crit_value <- qt(alpha/2, 123, lower.tail = FALSE)

CI_low <- xbar - crit_value * s / sqrt(totalsongs)
CI_high <- xbar + crit_value * s / sqrt(totalsongs)

print (c(low=CI_low, high=CI_high), digits = 3)
