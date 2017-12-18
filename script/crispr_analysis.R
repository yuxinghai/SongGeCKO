# use this script to get the screen situation, mainly is sgRNA distribution and 
# correlation between NC and screen. 
# input is positioned sample name,and output is two figure 
# author: yuxinghai

dir="/home/yuxh/songlab/赵南/SongGEcKO_zn_2/05_count"
setwd(dir)
samples<-c("A1","B1","A2","B2","A3")
library("dplyr")
library("edgeR")
library("ggplot2")
library("reshape2")
library("scales")

ggpoint <- function(dfs, cond1, cond2, outfile) {
  vmax <- max(c(as.matrix(dfs[, c(cond1, cond2)]))) + 10
  p <- ggplot(data=dfs, aes_string(x=cond1, y=cond2)) +
    geom_point(color="blue", alpha=0.2) +
    #geom_density_2d() +
    theme_bw() +
    ggtitle(sprintf("%s vs %s", cond1, cond2)) +
    scale_x_continuous(
      limits=c(NA, vmax),
      name=sprintf("%s", cond1),
      trans = log10_trans(),
      breaks = trans_breaks("log10", function(x) 10^x),
      labels = trans_format("log10", math_format(10^.x))) +
    scale_y_continuous(
      limits=c(NA, vmax),
      name=sprintf("%s", cond2),
      trans = log10_trans(),
      breaks = trans_breaks("log10", function(x) 10^x),
      labels = trans_format("log10", math_format(10^.x))) +
    theme(
      axis.text.y = element_text(size=12),
      axis.text.x = element_text(size=12))
  ggsave(paste(dir,outfile,sep="/"), p, width=4, height=4)
  p
}

for (i in 1:length(samples)) {
  name <-samples[i]
  input_name <-paste(paste("screen",name,sep = "_"),"csv",sep = ".")
  sa <- read.table(input_name,header = F,sep = "\t",quote = "\"")
  if (i %% 2 != 0) {
    control <- "NC_A1"
    }
  else {
    control <- "NC_B1"
  }
  
  conds <- c(control,name)
  names(sa) <- c("sgRNA", "gene_symbol","seq",conds)
  dcpm <- cpm(as.matrix(sa[,conds]))
  dfcpm <- as.data.frame(dcpm+0.1)
  rownames(dfcpm) <- NULL
  dfm <- melt(dfcpm, measure.vars=1:2, variable.name="conds", value.name="count")
  q <- ggplot(data=dfm, aes(x=count, ..density.., group=conds, colour=conds)) +
    geom_freqpoly(bins=20) +
    #facet_grid(cond ~ .) +
    theme_bw() +
    ggtitle("Distribution of sgRNA counts") +
    scale_x_continuous(name=sprintf("%s","sgRNA count"),
                       trans = log10_trans(),
                       breaks = trans_breaks("log10", function(x) 10^x),
                       labels = trans_format("log10", math_format(10^.x))) +
    theme(
      axis.text.y = element_text(size=12),
      axis.text.x = element_text(size=12))
  print(q)
  ggsave(paste(dir,paste(name,"_histCpm_1.pdf",sep=""),sep="/"), q, width=4, height=3)
  out_name=paste("cpm",control, name,sep="_")
  ggpoint(dfcpm, control, name, paste(out_name,"pdf",sep="."))
  }


# ################# sgrna#############################
#################check if the screen is under standard####################
# setwd(dir)
# A_sgrna<- read.table(file ="A1.sgrna_summary.txt",header = T,sep = "\t",quote = "\"")
# dim(A_sgrna)
# head(A_sgrna,50)
# filter_A_pos <-A_sgrna[A_sgrna$control_count==0,]
# dim(filter_A_pos)
# control <-A_sgrna$control_count
# level <-rep(1,length(control))
# tapply(control,level,function(x) {return(quantile(x,prob=c(0.1,0.9)))})
# ##################

# #  0.03202667 >0.5%
# B_sgrna<- read.table(file ="B.sgrna_summary.txt",header = T,sep = "\t",quote = "\"")
# dim(B_sgrna)
# head(B_sgrna,50)
# filter_B_pos <-B_sgrna[B_sgrna$control_count==0,]
# dim(filter_B_pos)
# 2094/65383
# 
# 
# control <-B_sgrna$control_count
# level <-rep(1,length(control))
# tapply(control,level,function(x) {return(quantile(x,prob=c(0.1,0.9)))})



