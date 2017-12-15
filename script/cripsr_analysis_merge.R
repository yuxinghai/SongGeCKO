setwd("~/songlab/赵南/SongGeCKO/second/06_mageck/")
A1_gene<- read.table(file ="A1.gene_summary.txt",header = T,sep = "\t",quote = "\"")
head(A1_gene,50)
filter_A_pos <-A1_gene[A1_gene$pos.lfc>0,]
dim(filter_A_pos)# 51 14
tail(filter_A_pos)
write.table(filter_A1_pos, "filter_A_pos.tsv", sep="\t", row.names=F, col.names=T, quote=F)
#filter_A_neg <-A_gene[A_gene$neg.fdr<0.05  & A_gene$neg.lfc<(-0.585),]
#all neg.fdr>0.05
################################
A2_gene<- read.table(file ="A2.gene_summary.txt",header = T,sep = "\t",quote = "\"")
head(A2_gene,50)
filter_A2_pos <-A2_gene[A2_gene$pos.lfc>0,]
dim(filter_A2_pos)# 51 14
tail(filter_A2_pos)
write.table(filter_A2_pos, "filter_A_pos.tsv", sep="\t", row.names=F, col.names=T, quote=F)
#####################################################
B1_gene<- read.table(file ="B1.gene_summary.txt",header = T,sep = "\t",quote = "\"")
head(B1_gene,20)
filter_B1_pos <-B1_gene[B1_gene$pos.lfc>0,]

dim(filter_B1_pos)# 30 14
write.table(filter_B1_pos, "filter_B1_pos.tsv", sep="\t", row.names=F, col.names=T, quote=F)
#filter_B_neg <-B_gene[B_gene$neg.fdr<0.3 & B_gene$neg.lfc<(-0.585),]
#all neg.fdr>0.05

###############################################
B2_gene<- read.table(file ="B2.gene_summary.txt",header = T,sep = "\t",quote = "\"")
head(B2_gene,20)
filter_B2_pos <-B2_gene[B2_gene$pos.lfc>0,]
dim(filter_B2_pos)#48 14
write.table(filter_B2_pos, "filter_B2_pos.tsv", sep="\t", row.names=F, col.names=T, quote=F)
