# TODO: Add comment
# 
# Author: yang
###############################################################################


#setwd('C:/Users/jonas/Downloads/formatted_8')
setwd("/home/yang/Dropbox/Research/BitGuard/projects/R-Project/")

#XnpCount_8_0_new<- as.matrix(data.frame( read.table('XnpCount_8_0_new.txt', header=T)))

#mean(XnpCount_8_0_new [,2])


#XnpCount_16_0_new<- as.matrix(data.frame( read.table('XnpCount_16_0_new.txt', header=T)))

#mean(XnpCount_16_0_new [,2])


Cycles<-7372800 * 100 / 1000


stack_usage<- as.matrix(data.frame( read.table('result_summary_2-64.txt', header=T)))
stack_usage


stack_usage_matrix <- rbind(c(2, 4, 8, 16, 32, 64), matrix( c(
						performance_2to64[1,],
						performance_2to64[2,]
				), nrow = 2, ncol=6, byrow = TRUE))

stack_usage_matrix

round(stack_usage_matrix, 3)
round(stack_usage_matrix [1,])

pdf("performance_2to64.pdf", width=8, height=5.5)

plot(round(stack_usage_matrix [1,]), round(stack_usage_matrix[2,], 3), type = "o", lwd=2, pch=6, col = "blueviolet", ylim = c(0.2,120), ylab = "Simulation Speed (MHz)", xlab = "Network Size", xaxt="n", yaxt="n", log="xy")
#axis(1, at=round(performance_2to64_matrix [1,]))
#axis(2, at=c(0.1, 0.5))
#axis(2, at=c(1, 5, 10, 20, 50, 100))
par(new=TRUE)
plot(round(stack_usage_matrix [1,]), round(stack_usage_matrix[3,], 3), type = "o", lwd=2, pch=8, col = "brown", ylim = c(0.2,120),ylab = "Simulation Speed (MHz)", xlab = "Network Size", xaxt="n", yaxt="n", log="xy")
axis(1, at=round(stack_usage_matrix [1,]), cex.axis=0.8)
axis(2, at=c(0.1, 0.5), cex.axis=0.8)
axis(2, at=c(1, 5, 10, 20, 50, 100), cex.axis=0.8)

legend(20, 80, c("D-SnapSim","SnapSim"), lwd=c(2,2), pch =c(6,8), col=c("blueviolet","brown"))

dev.off();



