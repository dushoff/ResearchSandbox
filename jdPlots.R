spot <- read.csv("spotify.csv")

names(spot)
attach(spot)

summary(lm(in_apple_charts~in_spotify_charts))

quit()

mtab <- table(released_month)
month <- as.numeric(names(mtab))
monthly_releases <- as.numeric(mtab)
plot(
	month, monthly_releases
	, type="o"
)

boxplot(liveness_percent ~ released_month)

plot(
	valence_percent, danceability_percent
)

hist(bpm)

quit()

maxStreams <- max(streams, na.rm=TRUE)
print(maxStreams)

plot(
	in_spotify_charts, streams, col="darkblue"
	, log="xy"
	, ylim = c(1e7, maxStreams)
)
points(in_apple_charts, streams, col="violetred1")

quit()

energy_ratio <- energy_percent/bpm

boxplot(bpm~key)
boxplot(bpm~mode)
boxplot(bpm~factor(released_month))
boxplot(energy_percent~key)
boxplot(energy_percent~mode)
boxplot(energy_percent~factor(released_month))
boxplot(energy_ratio~key)
boxplot(energy_ratio~mode)
boxplot(energy_ratio~factor(released_month))


ytab <- table(released_year)
print(ytab)

year <- as.numeric(names(ytab))
released <- as.numeric(ytab)

plot(
	year, released
	, log="y"
	, type="b"
)
