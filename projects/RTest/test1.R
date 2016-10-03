# TODO: Add comment
# 
# Author: yang
###############################################################################

setwd("/home/yang/Dropbox/Research/BitGuard/projects/RTest/")

#Cycles<-7372800 * 100 / 1000
stack_usage_matrix <- as.matrix(data.frame(read.table('result.txt')))
print(stack_usage_matrix)
#plot(x,y)
#pdf("stack_usage.pdf", width=8, height=5.5)
plot(round(stack_usage_matrix [1,]), round(stack_usage_matrix[2,], 3), type = "o", lwd=2, pch=6, col = "blueviolet", ylim = c(0.2,120), ylab = "Simulation Speed (MHz)", xlab = "Network Size", xaxt="n", yaxt="n", log="xy")
par(new=TRUE)
plot(round(stack_usage_matrix [1,]), round(stack_usage_matrix[3,], 3), type = "o", lwd=2, pch=8, col = "brown", ylim = c(0.2,120),ylab = "Simulation Speed (MHz)", xlab = "Network Size", xaxt="n", yaxt="n", log="xy")
axis(1, at=round(stack_usage_matrix [1,]), cex.axis=1)
axis(2, at=c(0.1, 0.5), cex.axis=0.8)
axis(2, at=c(1, 5, 10, 20, 50, 100), cex.axis=0.8)