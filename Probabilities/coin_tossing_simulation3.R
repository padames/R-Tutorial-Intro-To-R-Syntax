num_samples = 10000
png(file="simsample%02d.png", width=600, height=400)
for (i in 1:60){
  plot.new()
  coin_toss_vector = sample(c("Head", "Tail"), num_samples, replace=T)
  z = cumsum( coin_toss_vector == "Head") / seq(1, num_samples)
  par(bg="white", fg="blue", bty="n")
  plot( z, xlab = "Coin toss", ylab = "Frequency of Heads", type = 'l', 
        col="blue", 
        col.axis="black", 
        col.lab="black",
        ylim=c(0.0,1.0))
  abline( h=0.5, col="red", lty="longdash", lwd=1.2)
}
dev.off()

system("/usr/bin/convert -delay 1 *.png simsample3.gif")

file.remove(list.files(pattern=".png"))


