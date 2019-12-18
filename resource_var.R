library("here")
source(here("..","R_files","posPlots.r"))
library("cplots")
library("circular")
library("ggplot2")
library("tidyverse")
library("truncnorm")
library("reshape2")
seasons<-c("winter", "spring", "summer", "autumn")

# Time intervals
weeks<-as.circular(seq(0,2*pi,length.out = 48))
timeRang<-as.circular(seq(0,2*pi,length.out = 100))
# Resource range
resorRange<-seq(0,1,length.out = 48)

contourData<-do.call(rbind,lapply(weeks,FUN = resourDist,
                                  resource=resorRange,scalar=1,sigma=0.5,
                                  kappa=2))
par(plt=posPlot())
filled.contour(
  x = as.numeric(weeks),
  y = resorRange,
  z = contourData,
  plot.axes = {
    axis(1,
         at = seq(0, 2 * pi, length.out = 5)[1:4],
         labels=seasons)
    axis(2, at = seq(0, 1, length.out = 5))
  }
)

randResour <-
  sapply(
    as.circular(seq(0, 2 * pi, length.out = 24)),
    rresourDist,
    scalar = 1,
    sigma = 0.1,
    kappa = 2
  )

oneSample<-data.frame(randResour,time=as.circular(seq(0,2*pi,length.out = 24)))

oneSample$EnvCue<-EnvCue(oneSample$randResour,sigma = 0.1)
longOneSample<-dcast(oneSample,)

with(oneSample,{
  par(plt=posPlot(),las=1)
  matplot(y=cbind(randResour,EnvCue),x=time,type="l",lwd = 3,ylab = "",
          xaxt="n",lty = 1)
  axis(1,at=seq(0,2*pi,length.out = 5)[1:4],labels = seasons)
  legend("topright",legend = c("Resource abundance",
                               "Environmental cue"),
         lwd=3,col=c("black","red"))
})


p <- ggplot(oneSample, aes(x=time, y=randResour,fill=)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  
  # This add the bars with a blue color
  geom_bar(stat="identity", fill=alpha("blue", 0.3)) +
  
  # Limits of the plot = very important. The negative value controls the size of the inner circle, the positive one is useful to add size over each bar
  ylim(-1,1.5) +
  
  # Custom the theme: no axis title and no cartesian grid
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2,4), "cm")     
    # This remove unnecessary margin around plot
  ) +
  
  # This makes the coordinate polar instead of cartesian.
  coord_polar(start = 0)
p


  