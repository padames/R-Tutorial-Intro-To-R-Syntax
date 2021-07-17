num_samples = 10000
for (i in 1:10) {
  coin_toss_vector = sample(c("Head", "Tail"), num_samples, replace=T)
  z = cumsum( coin_toss_vector == "Head") / seq(1, num_samples)
  par(bg="blue", fg="white", bty="n")
  plot( z, xlab = "Coin toss", ylab = "Frequency of Heads", type = 'l', 
        col="yellow", 
        col.axis="white", 
        col.lab="white",
        ylim=c(0.0,1.0))
  abline( h=0.5, col="red", lty="longdash", lwd=1.2)
  Sys.sleep(1)
}
