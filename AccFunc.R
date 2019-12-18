## Accesory functions

library("truncnorm")

## Probability density function for the resources

dresourDist<-function(time,resource,mut=pi,scalar=5,kappa=10,sigma=0.1){
  mu<-scalar*dvonmises(circular(time),mu = mut,kappa = kappa)
  prob<-dtruncnorm(resource,mean=mu,sd = sigma,a = 0)
  # prob<-dnorm(resource,mu,sd = sigma)
  return(prob)
}

## Random numbers from the resource distribution

rresourDist<-function(time,mut=pi,scalar=5,kappa=10,sigma=0.1){
  mu<-scalar*dvonmises(circular(time),mu = mut,kappa = kappa)
  rand<-rtruncnorm(1,mean=mu,sd = sigma,a = 0)
  return(rand)
}

EnvCue<-function(resource,sigma=0.1,intercept=0,slope=1){
  return(intercept+resource*slope+rnorm(n = length(resource),sd = sigma))
}
