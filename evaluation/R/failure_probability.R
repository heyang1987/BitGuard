# TODO: Add comment
# 
# Author: jonas
###############################################################################

setwd("/home/yang/Dropbox/Research/BitGuard/evaluation/")

f=seq(0, 200000000, 50000)
#p=ifelse(f<200000, 0.0093109 * f / f, 2.6 * 10 ^ (-16) * f ^ 2 - 2.6 * 10 ^ (-11) * f + 0.00931)
p=ifelse(f<200000, 0.0093109 * f / f, 1 - 0.9906890130353818 ^ (f / 10 ^ 5) + 0.9906890130353818 ^ (f / 10 ^ 5) * (1 - 0.9971804511278195 ^ (f / 10 ^ 5) - 3 * 4.41658657923003 / 10 ^ 7))

pdf("failure_probability.pdf", width=8, height=5.5)

plot(f, p, type = "l", lwd=2, pch=6, col = "blueviolet", ylim = c(0,1), ylab = "Failure Probability", xlab = "SEU Injection Rate", log="x")
#geom_vline(xintercept=c(0,200000), linetype="dotted")
abline(v=150000,lty=2)

#plot(round(stack_usage_matrix [1,]), round(stack_usage_matrix[2,], 3), type = "o", lwd=2, pch=6, col = "blueviolet", ylim = c(0.2,120), ylab = "Simulation Speed (MHz)", xlab = "Network Size", xaxt="n", yaxt="n", log="xy")
#par(new=TRUE)
#plot(round(stack_usage_matrix [1,]), round(stack_usage_matrix[3,], 3), type = "o", lwd=2, pch=8, col = "brown", ylim = c(0.2,120),ylab = "Simulation Speed (MHz)", xlab = "Network Size", xaxt="n", yaxt="n", log="xy")
#axis(1, at=round(stack_usage_matrix [1,]), cex.axis=0.8)
#axis(2, at=c(0.1, 0.5), cex.axis=0.8)
#axis(2, at=c(1, 5, 10, 20, 50, 100), cex.axis=0.8)

dev.off();
