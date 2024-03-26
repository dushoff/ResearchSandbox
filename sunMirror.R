
deg <- pi/180
refract <- 1.33
travel <- 45*deg
sun <- 27.6*deg

h <- 1.8
reach <- 2.4
depth <- 5.5

θ_inc <- atan(reach/h)
θ_ref <- asin(sin(θ_inc)/refract)

print(θ_inc/deg)
print(θ_ref/deg)

d <- reach + depth*tan(θ_ref) 

print(d)

######################################################################

quit()

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
