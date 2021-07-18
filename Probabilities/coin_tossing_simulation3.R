#!/usr/bin/r

i_am_on_path <- dirname(rstudioapi::getSourceEditorContext()$path)

if (!file.exists(file.path(i_am_on_path,"animations"))) {
  dir.create(file.path(i_am_on_path, "animations"))
}
setwd(file.path(i_am_on_path, "animations"))

library(lattice)

num_samples = 10000

png(file="simsample%02d.png", width=600, height=400)
for (i in 1:30){
  coin_toss_vector = sample(c("Head", "Tail"), num_samples, replace=T)
  z = cumsum( coin_toss_vector == "Head") / seq(1, num_samples)
  x = seq(1,num_samples)
  pp <- xyplot( z ~ x,
                scales=list(cex=.8, col="red", x = list(log = T), y = list(log = F)),
                main="Trend of average number of Heads as number of coin tosses increases",
                ylab = "Average Number of Heads",
                xlim = c(1, num_samples),
                xlab = "Number of coin tosses",
                ylim = c(0, 1),
                panel = function(x, y) {
                  panel.xyplot(x,y, type = 'l');
                  panel.lines(x=log10(1:num_samples), y=rep(0.5,num_samples), col="red")
                }
  )
  print(pp)
}
dev.off()

# converting .png file in .gif using ImageMagick
system("/usr/bin/convert -delay 40 *.png coin_toss_sim.gif")

# Remove .png file
file.remove(list.files(pattern=".png"))
