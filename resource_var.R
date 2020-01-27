library("here")
source(here("..","R_files","posPlots.r"))
source(here("AccFunc.r"))
source(here("Aesth.r"))
library("cplots")
library("circular")
library("ggplot2")
# library("tidyverse")
library("data.table")
# combine ggplot and base
library("reshape2")
library("cowplot")

# Time intervals
nYearInt<-48
timeRang<-as.circular(seq(0,2*pi,length.out = nYearInt))
# Resource range

resorRange<-seq(0,1,length.out = nYearInt)

contourData<-do.call(rbind,lapply(timeRang,FUN = dresourDist,
                                  resource=resorRange,scalar=2,sigma=0.1,
                                  kappa=1))
par(plt=posPlot())
resDist<-~filled.contour(
  x = as.numeric(timeRang),
  y = resorRange,
  z = contourData,
  plot.axes = {
    axis(1,
         at = seq(0, 2 * pi, length.out = 5)[1:4],
         labels=seasons,cex.axis=0.5,las=2)
    axis(2, at = seq(0, 1, length.out = 5))
  },
  key.axes = axis(4,cex.axis=0.7))


randResour <-
  sapply(
    as.circular(seq(0, 2 * pi, length.out = 12)),
    rresourDist,
    scalar = 2,
    sigma = 0.1,
    kappa = 1
  )

oneSample<-data.table(randResour,time=as.circular(seq(0,2*pi,length.out = 12)))
oneSample$EnvCue<-EnvCue(oneSample$randResour,sigma = 0.1)
oneSample$month<-c("January","February","March","April","May","June","July",
                   "August","September","October","November","December")
oneSample[,month:=as.factor(month)]
oneSample[,time:=NULL]
str(oneSample)

longOneSample<-melt(oneSample,id.vars = "month",
                    variable.name = "Measure")
longOneSample[,month:=as.circular(seq(0,2*pi,length.out = 12))[month]]

with(oneSample,{
  par(plt=posPlot(),las=1)
  matplot(y=cbind(randResour,EnvCue),x=time,type="l",lwd = 3,ylab = "",
          xaxt="n",lty = 1)
  axis(1,at=seq(0,2*pi,length.out = 5)[1:4],labels = seasons)
  legend("topright",legend = c("Resource abundance",
                               "Environmental cue"),
         lwd=3,col=c("black","red"))
})


BarPlotSolo <-
  ggplot(longOneSample, aes(x = month, y = value, fill = Measure)) +       
  # Note that id is a factor. If x is numeric, there is some space between the first bar
  
  # This add the bars with a blue color
  geom_bar(stat = "identity", fill = alpha("blue", 0.6)) +
  
  # Limits of the plot = very important. The negative value controls the size of the inner circle, the positive one is useful to add size over each bar
  ylim(-0.5, 1.5) +
  
  # Custom the theme: no axis title and no cartesian grid
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2, 4), "cm")
    # This remove unnecessary margin around plot
  ) +
  
  # This makes the coordinate polar instead of cartesian.
  coord_polar(start = 0)
BarPlotSolo
p

seasAng <- as.circular(seq(0,2*pi,length.out = 5))[1:4]
seasAng<-seasAng+rep((seasAng[2])/2,4)

sampleResCue<-ggplot(longOneSample, aes(x = month, y = value, fill=Measure)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values=c("#999999", "#E69F00"),
                    name = "", labels = c("Res. abundance","Env. cue"))+ 
    coord_polar() + 
  theme_minimal() +
  theme(
    axis.text.x = element_blank() ,
    axis.title = element_blank(),
    #panel.grid = element_blank(),
    plot.margin = unit(rep(0.5,4), "cm"),
    legend.position="top"
    
  ) +
  annotate(geom="text", x=seasAng, y=max(longOneSample$value), label=seasons,
           color="red")


sampleResCue

plot_grid(resDist, sampleResCue, labels = c("A", "B"),rel_widths = c(1.5,1) )  




  
  
  