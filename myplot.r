# !/usr/bin/R

workdir <- "/home/sa/Documents/R"
datafile <- file.path(workdir,"myplot.csv")
data <- read.csv(datafile, stringsAsFactors=FALSE)

## Labels defining subgroups are a little indented!
subgps <- c(2,4,6,8,10,12,14,16,17)
##data$factors[subgps] <- paste("  ",data$factors[subgps]) 
 
## Combine the count and percent column
np <- ifelse(!is.na(data$mean), paste(data$mean," (",data$low,"-",data$high,")",sep=""), NA)
 
## The rest of the columns in the table. 
tabletext <- cbind(c("Factors","\n",data$factors), 
                    c("OR(95% CI)","\n",np), 
                    c("P Value","\n",data$p.value))

library(forestplot)
png(file.path(workdir,"myplot.png"),width=1920, height=1080)
xticks<-c(0,30,60,90,120,150)
##xticks<-c(0,1,5,15)
##xticks<-c(0,1,30,100,150)
forestplot(labeltext=tabletext, graph.pos=2, 
           mean=c(NA,NA,data$mean), 
           lower=c(NA,NA,data$low), upper=c(NA,NA,data$high),
           ##title="Hazard Ratio",
           xlab="  ",
           hrzl_lines=list("1" = gpar(lwd=1, col="#99999922"), 
                          "3" = gpar(lwd=120, lineend="butt", columns=c(2:4), col="#99999922"),
                          "7" = gpar(lwd=120, lineend="butt", columns=c(2:4), col="#99999922"),
                          "11" = gpar(lwd=120, lineend="butt", columns=c(2:4), col="#99999922"),
                          "15" = gpar(lwd=120, lineend="butt", columns=c(2:4), col="#99999922"),
                          "19" = gpar(lwd=120, lineend="butt", columns=c(2:4), col="#99999922")),
           txt_gp=fpTxtGp(label=gpar(cex=3),
                              ticks=gpar(cex=3),
                              xlab=gpar(cex = 3),
                              title=gpar(cex = 3)),
	   xticks=xticks,
	   ##attr(my_ticks,"labels"<-(0,1,50,100,148)),
           col=fpColors(box="black", lines="black", zero = "gray50"),
           zero=30, cex=0.9, lineheight = "auto", boxsize=0.5, colgap=unit(6,"mm"),
           lwd.ci=2, ci.vertices=TRUE, ci.vertices.height = 0.4)
dev.off()
