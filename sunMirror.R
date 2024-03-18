
xlab="\u2113"

print(xlab)

deg <- pi/180
refract <- 1.33
travel <- 45*deg
sun <- 27.6*deg

## What is the angle of the incident beam (striking the water) from the vertical?
## This is the answer that Miriam got
## sin(snell) = refract*sin(travel)
snell <- asin(refract*sin(travel))
print(snell/deg)

## Incident vs. horizontal
incident <- 90*deg - snell
print(incident/deg)

## The normal vector to the mirror is halfway between the sunbeam angle and the incident angle
## But the reflected beam could keep going past the raft, or be reflected back to where it came from!
## We assume it's being reflected back.
## (28-20)/2
normal <- (sun - incident)/2

answer <- 90*deg + normal

print(answer/deg)
