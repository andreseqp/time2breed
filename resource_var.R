library("here")
source(here("..","R_files","posPlots.r"))
source(here("AccFunc.r"))
library("cplots")
library("circular")
library("ggplot2")
library("tidyverse")
library("truncnorm")
library("data.table")
library("reshape2")
seasons<-c("winter", "spring", "summer", "autumn")

colbars<- c('#d7191c','#fdae61','#2b83ba')

# Time intervals
nYearInt<-48
timeRang<-as.circular(seq(0,2*pi,length.out = nYearInt))
# Resource range
resorRange<-seq(0,1,length.out = nYearInt)

contourData<-do.call(rbind,lapply(timeRang,FUN = dresourDist,
                                  resource=resorRange,scalar=2,sigma=0.1,
                                  kappa=1))
par(plt=posPlot())
filled.contour(
  x = as.numeric(timeRang),
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
    as.circular(seq(0, 2 * pi, length.out = 12)),
    rresourDist,
    scalar = 1,
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



ggplot(longOneSample, aes(month, value, fill=Measure)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))+ 
  coord_polar() + 
  ylim(-0.2, 1.5)+
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(c(-0,-5,-5,-5), "cm"),
    legend.position="top"
  ) 
  


p <- ggplot(longOneSample, aes(x=month, y=value, fill=Measure)) +       
  # Note that id is a factor. If x is numeric, there is some space between the first bar
  geom_col(position = "dodge") +
    ylim(-0.5,1.5) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  ) +
  coord_polar(start = 0) 
   
labels<-data.frame(y=seq(-0.5,0.5,length.out = 5),
                   label=as.character(seq(-0.5,0.5,length.out = 5)))

ggplot()+
    geom_bar(data=longOneSample, aes(fill=Measure, y=value, x=month),
position="dodge", stat="identity")+
  scale_fill_viridis(discrete = T)+
      coord_polar(start = 0)+
    ylim(-0.5,1)+  theme_minimal()  +theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2, 4), "cm")
    # This remove unnecessary margin around plot
  ) +scale_fill_discrete(name="",
                         breaks=c("randResour", "EnvCue"),
                         labels=c("Resource abundance", "Environmental cue"))+
  geom_text (data = labels,
           aes(x = 0.5*pi, y = y, label = label),colour="black")
  
  
  
  