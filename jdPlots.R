spot <- read.csv("spotify.csv")

names(spot)
attach(spot)

late_release <- released_year[released_year>2010] + 0.5
hist(late_release)

colors <- c("red", "blue")

bhist <- hist(bpm)

bpm_group <- cut(bpm, bhist$breaks)
print(bpm_group)
levels(bpm_group) <- bhist$mids
bpm_mid <- as.numeric(bpm_group)

bpm_mode_table <- table(mode, bpm_group)

print(bpm_mode_table)

barplot(bpm_mode_table, 
        beside = FALSE, 
        col = colors, 
        ylab = "Number of Songs", 
        xlab = "BPM", 
		  ylim = c(0, 140),
        main = "Distribution of BPM by Mode"

)


summary(lm(in_apple_charts~in_spotify_charts))

mtab <- table(released_month)
print(mtab)
month <- as.numeric(names(mtab))
monthly_releases <- as.numeric(mtab)

print(data.frame(month, monthly_releases))

plot(
	month, monthly_releases
	, type="b"
	, ylim = c(0, max(monthly_releases))
)

boxplot(energy_percent ~ released_month)

plot(
	valence_percent, danceability_percent
)


maxStreams <- max(streams, na.rm=TRUE)
print(maxStreams)

plot(
	in_spotify_charts, streams, col="darkblue"
	## , log="xy"
	, ylim = c(1e7, maxStreams)
)
points(in_apple_charts, streams, col="violetred1")


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
