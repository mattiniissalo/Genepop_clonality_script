#Import the data to R
install.packages("tidyverse", repos="https://cloud.r-project.org")
mydata <- read.table("output.txt", header=FALSE, col.names=c("Sample1","Sample2","hethet_pc"))
df <- data.frame(x=mydata$Sample1, y=mydata$Sample2, z=mydata$hethet_pc)
library(tidyr)
write.csv(spread(df, y, z), "output.csv")
mydata <- mydata[order(mydata$hethet_pc), ]
pdf("dot_plot_of_all_hethet_comparisons.pdf")
plot(mydata$hethet_pc)
dev.off()