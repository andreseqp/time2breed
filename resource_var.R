
install.packages("cplots")
library("cplots")
library("circular")

randCirc<-rwrappednormal(10000,mu = circular(0),rho = 0.3)

weeks<-as.circular(seq(0,2*pi,length.out = 48))
ResourceAbundExpect<-rwrappednormal(48,mu = circular(0),rho = 0.1)

plot(randCirc, pch=16,
     col="blue", stack=T, shrink=1.2, bins=720, ticks=T)
chist(randCirc,radius = 0.2)

str(pigeons)

plot(dvonmises(circular(seq(0,2*pi,length.out = 100)),mu = circular(pi),kappa = 1)
     ~seq(0,2*pi,length.out = 100),xaxt="n")
axis(1,at = weeks,labels = 1:48)

resourDist<-function(time,resource,mut=pi,scalar=10,kappa=10,sigma=0.1){
  mu<-scalar*dvonmises(circular(time),mu = mut,kappa = kappa)
  prob<-dnorm(resource,mu,sd = sigma)
  return(prob)
}

dvonmises(circular(pi),mu = pi,kappa = 10)
dnorm(1.24,1.24)
resourDist(time=pi,resource = 6,mut = pi,10,sigma = 0.8,scalar = 10)
5*dvonmises(circular(pi),mu = pi,kappa = 10)

