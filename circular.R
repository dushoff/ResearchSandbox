## A 0.43-mm-diameter circular hole is illuminated by light of wavelength 529 nm. 
## What is the width of the central maximum on a screen located 2.59 m behind the slit?

## Units
m = 1
mm = 1e-3*m
nm = 1e-9*m

## https://www.physicsforums.com/threads/what-is-the-width-please-take-a-look-at-my-work.597868/
λ = 556*nm
L = 3.45*m
w = 0.484*mm

## Miriam
λ = 529*nm
L = 2.59*m
w = 0.43*mm

## Naive
(2*λ*L/w)/mm

## Add slit
(2*λ*L/w + w)/mm

## https://en.wikipedia.org/wiki/Fraunhofer_diffraction
α = 1.22*λ/w
print(d_disk <- L*sin(α)/mm)

## Bessel
(2.44*λ*L/w)/mm

## Half-Bessel
(1.22*λ*L/w)/mm

