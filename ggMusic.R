library(ggplot2); theme_set(theme_bw())
library(GGally)
library(dplyr)

library(shellpipes)

spot <- csvRead()

print(names(spot))

print(ggplot(spot)
	+ aes(valence_percent, energy_percent)
	+ geom_point()
	+ geom_smooth(method="lm")
)

print(ggplot(spot)
	+ aes(valence_percent, bpm)
	+ geom_point()
	+ geom_smooth(method="lm")
)

jump <- (spot |> transmute(
	energy=energy_percent
	, valence=valence_percent
	, bpm=bpm
	, energy_ratio=energy/bpm
	, danceability_percent
))

ggpairs(jump)
