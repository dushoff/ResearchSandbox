
curve(dnbinom(1,mu=0.5,size=x),log="x",from=1,to=1e18)
abline(h=dpois(1,lambda=0.5),col=2,lty=2)
text(1,dpois(1,lambda=0.5)+0.02,"Poisson",col=2,pos=4)

