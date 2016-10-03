exp <- read.table("D:/OneDrive/Dropbox/Research/BitGuard/evaluation/R/experiment1.dat", header=TRUE, sep="\t")

max_y <- 10500
min_y <- min(exp)
min_x = 0
max_x = 10000000
xrange <- c(9765.625,39062.5,156250,1250000,10000000)
plot_colors <- c("blue","red","forestgreen","orange")
pdf("experiment1.pdf",height=4.3, width =8.5)
plot(xrange, exp$X1, type="o", col=plot_colors[1], 
     #xlim=c(min_x,max_x),
     ylim=c(min_y,max_y), 
     axes=FALSE, ann=FALSE,log="x")

#axis(1, at=c(9765.625,39062.5,156250,1250000,10000000), lab=xrange)
axis(1, at=c(1,10,100,1000,10000,100000,1000000,10000000), lab=c(1,10,100,1000,10000,100000,1000000,10000000))
axis(2, at=c(0,2000,4000,6000,8000,10000,12000), lab=c(0,2000,4000,6000,8000,10000,12000))

# Create box around plot
box()

lines(xrange,exp$X10, type="o", pch=22, lty=1,  col=plot_colors[2])

lines(xrange,exp$X100, type="o", pch=23, lty=1, col=plot_colors[3])

lines(xrange,exp$X1000, type="o", pch=24, lty=1, col=plot_colors[4])

title(xlab= "SEU Injection Frequency (Hz)", col.lab=rgb(0,0,0))
title(ylab= "Maximum Correct Sequence Number", col.lab=rgb(0,0,0))

legend(2000000, 10000, 
       c("Call Delay = 1 ms","Call Delay = 10 ms","Call Delay = 100 ms","Call Delay = 1000 ms"), 
       cex=0.8, 
       col=plot_colors, 
       pch=21:24, 
       lty=1);

#legend(6.8, 2.4, names(bitmask), cex=1.1, col=plot_colors, 
#       pch=21:23, lty=1);

grid()

# Turn off device driver (to flush output to png)
dev.off()

