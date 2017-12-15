setwd("/data5/zhoulab/yuxinghai/SongGeCKO_xyn/results/05_count")
dir="/data5/zhoulab/yuxinghai/SongGeCKO_xyn/results/08_post_mageck_analysis/"
A1 <- read.table("screen_A1.csv",header = F,sep = "\t",quote = "\"")
B1 <- read.table("screen_B1.csv",header = F,sep = "\t",quote = "\"")

conds_A <- c("NC_A1","A1")
names(A1) <- c("sgRNA", "gene_symbol","seq",conds_A)

conds_B <- c("NC_B1","B1")
names(B1) <- c("sgRNA", "gene_symbol","seq",conds_B)

library("dplyr")
library("edgeR")
library("ggplot2")
library("reshape2")
library("scales")


##############################correlation#########################



###########  A  ######################
dcpm <- cpm(as.matrix(A1[, conds_A]))
dfcpm <- as.data.frame(dcpm+0.1)
rownames(dfcpm) <- NULL
head(dfcpm)

dfm <- melt(dfcpm, measure.vars=1:2, variable.name="conds", value.name="count")
q <- ggplot(data=dfm, aes(x=count, ..density.., group=conds, colour=conds)) +
  geom_freqpoly(bins=20) +
  #facet_grid(cond ~ .) +
  theme_bw() +
  ggtitle("Distribution of sgRNA counts") +
  scale_x_continuous(
    name=sprintf("%s", "sgRNA count"),
    trans = log10_trans(),
    breaks = trans_breaks("log10", function(x) 10^x),
    labels = trans_format("log10", math_format(10^.x))) +
  theme(
    axis.text.y = element_text(size=12),
    axis.text.x = element_text(size=12))
q
ggsave(paste(dir,"A_histCpm_1.pdf",sep=""), q, width=4, height=3)



dcpm <- cpm(as.matrix(B1[, conds_B]))
dfcpm <- as.data.frame(dcpm+0.1)
rownames(dfcpm) <- NULL
head(dfcpm)

dfm <- melt(dfcpm, measure.vars=1:2, variable.name="conds", value.name="count")
q <- ggplot(data=dfm, aes(x=count, ..density.., group=conds, colour=conds)) +
  geom_freqpoly(bins=20) +
  #facet_grid(cond ~ .) +
  theme_bw() +
  ggtitle("Distribution of sgRNA counts") +
  scale_x_continuous(
    name=sprintf("%s", "sgRNA count"),
    trans = log10_trans(),
    breaks = trans_breaks("log10", function(x) 10^x),
    labels = trans_format("log10", math_format(10^.x))) +
  theme(
    axis.text.y = element_text(size=12),
    axis.text.x = element_text(size=12))
q
ggsave(paste(dir,"B_histCpm_1.pdf",sep=""), q, width=4, height=3)

###########################correlation heatmap#############################
dfcor <- cor(dfcpm[, conds_A])
dfcor
sampleDistMatrix <- as.matrix( dfcor )
#colnames(sampleDistMatrix) <- NULL   
library(ComplexHeatmap)
library(circlize)
library("RColorBrewer")
pdf(paste(dir,"A_sample distance.pdf"))
colours = colorRampPalette( brewer.pal(9, "Blues"))(255)
Heatmap(sampleDistMatrix,cluster_rows =F,cluster_columns=F,col =colours ,name = "value",heatmap_legend_param = list(color_bar = "continuous"))
dev.off()

################################
head(dfcpm)
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
  ggsave(paste(dir,outfile), p, width=4, height=4)
  p
}
ggpoint(dfcpm, "A1", "A2", "cpm_A2&A1.pdf")
ggpoint(dfcpm, "NC_A1", "A1", "cpm_NC_A1 A1.pdf")
ggpoint(dfcpm, "NC_A1", "NC_A2", "cpm_NC_A2 NC_A1.pdf")
ggpoint(dfcpm, "A2", "NC_A2", "cpm_A2 A1.pdf")


dcpm <- cpm(as.matrix(B[, conds_B]))
dfcpm <- as.data.frame(dcpm+0.1)
ggpoint(dfcpm, "B1", "B2", "cpm_B2&B1.pdf")
ggpoint(dfcpm, "NC_B1", "B1", "cpm_NC_B1 B1.pdf")
ggpoint(dfcpm, "NC_B1", "NC_B2", "cpm_NC_B2 NC_B1.pdf")
ggpoint(dfcpm, "B2", "NC_B2", "cpm_B2 B1.pdf")

################# sgrna#############################
setwd("/data5/zhoulab/yuxinghai/SongGeCKO/file/07_mageck_merge/")
A_sgrna<- read.table(file ="A.sgrna_summary.txt",header = T,sep = "\t",quote = "\"")
dim(A_sgrna)
head(A_sgrna,50)
filter_A_pos <-A_sgrna[A_sgrna$control_count==0,]
dim(filter_A_pos)
control <-A_sgrna$control_count
level <-rep(1,length(control))
tapply(control,level,function(x) {return(quantile(x,prob=c(0.1,0.9)))})
##################
#  10%     90% 
#20.699 198.430 
##################
#  0.03202667 >0.5%
B_sgrna<- read.table(file ="B.sgrna_summary.txt",header = T,sep = "\t",quote = "\"")
dim(B_sgrna)
head(B_sgrna,50)
filter_B_pos <-B_sgrna[B_sgrna$control_count==0,]
dim(filter_B_pos)
2094/65383


control <-B_sgrna$control_count
level <-rep(1,length(control))
tapply(control,level,function(x) {return(quantile(x,prob=c(0.1,0.9)))})
###############
#   10%     90% 
#9.769 274.880
################
