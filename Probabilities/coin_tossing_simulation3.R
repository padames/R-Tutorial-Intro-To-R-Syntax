#!/usr/bin/Rscript

if (!require("pacman")) install.packages("pacman")
pacman::p_load("here")

suppressWarnings(my_proj_path <- here("Probabilities"))

if (!file.exists(file.path(my_proj_path,"animations"))) {
  dir.create(file.path(my_proj_path, "animations"))
}
setwd(file.path(my_proj_path, "animations"))

library(lattice)

num_samples = 10000

png(file="simsample%02d.png", width=600, height=400)
for (i in 1:30){
  coin_toss_vector = sample(c("Head", "Tail"), num_samples, replace=T)
  z = cumsum( coin_toss_vector == "Head") / seq(1, num_samples)
  # data.ct <- data.frame(CoinTossNumber=1:length(z), AvgHeads=z)
  x = seq(1,num_samples)
  
  pp <- xyplot( z ~ x,
                cex = 1.2,
                scales=list(cex=1.2, col="black", relation = "same",
                            x = list(log = 10, at=c(1,10,100,1000,10000), labels=c("1","10","100","1000","10000"))),
                # scales=list(cex=.8, col="red", x = list(log = T), y = list(log = F)),
                main="Trend of average number of Heads as number of coin tosses increases",
                ylab = "Average Number of Heads",
                xlim = c(0.9, num_samples+1),
                xlab = "Number of coin tosses",
                ylim = c(-0.1, 1.1),
                panel = function(x,y) {
                  panel.xyplot(x,y, type = 'l');
                  panel.lines(x=log(1:num_samples), y=rep(0.5,num_samples), col="red")
                }
  )
  print(pp)
  
}
dev.off()

# This section is machine dependent. 
# It assumes we are in an Ubuntu installation with the program convert from ImageMagick

# converting .png file in .gif using ImageMagick
system("/usr/bin/convert -delay 40 *.png coin_toss_sim.gif")

# Remove .png file
file.remove(list.files(pattern=".png"))
