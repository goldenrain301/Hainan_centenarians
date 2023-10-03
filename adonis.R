library("vegan")
args <- commandArgs(T)
#args <- c("profile.for_analysis.txt","group.list","envir_com.txt")
species_profile <- as.data.frame(t(read.table(args[1],header = T,sep = "\t",row.names = 1,check.names = F,quote = "")))##读取物种组成表
group=read.table(args[2],header=F,row.names=1,sep="\t",check.names=F)#分组文件
species_profile=species_profile[rownames(group),]
env <- read.table(args[3],header = T,sep = "\t",row.names = 1,check.names = T,quote = "")#临床指标或理化指标等因素
env2 <- read.table(args[3],header = T,sep = "\t",row.names = 1,check.names = F,quote = "")

env <- env[rownames(group),]

env = env[which(complete.cases(env)),]
env2 <- env2[rownames(group),]
env2 = env2[which(complete.cases(env2)),]
envname_lables=as.data.frame(colnames(env2))
rownames(envname_lables)=colnames(env)
rownames=gsub("X","",rownames(env))
rownames(env)=rownames
species_profile=species_profile[rownames,]
rownames(species_profile)
envname <- colnames(env)
set.seed(71)
n <- length(envname)
formula_Independent <- paste(envname,collapse="+")
formula_Independent
ttable <- adonis(as.formula(paste0("vegdist(species_profile,method='bray') ~ ",formula_Independent)),data = env,permutations = 999)
write.table(ttable$aov.tab,"adonis.txt",sep = "\t")
value_R2 <- ttable$aov.tab[envname,"R2"]
value_Df<-ttable$aov.tab[envname,"Df"]
value_SumsOfSqs<-ttable$aov.tab[envname,"SumsOfSqs"]
value_MeanSqs <-ttable$aov.tab[envname,"MeanSqs"]
value_F.Model<-ttable$aov.tab[envname,"F.Model"]
names(value_R2) <- envname

value_p <- ttable$aov.tab[envname,"Pr(>F)"]

pdf("adonis.pdf",8,10)
par(mar=c(4,14,2,2))
data.plot=as.matrix(t(sort(value_R2)))
colnames(data.plot)=envname_lables[rownames(as.matrix(sort(value_R2))),1]
library(RColorBrewer)
color_group=read.table("color.txt",header=F,row.names=1,sep="\t",check.names=F)#分组文件
a <- brewer.pal(10,"Set3")
names(a) <- sort(unique(color_group[colnames(data.plot),]))
unique(color_group[colnames(data.plot),])
colors <- a[color_group[colnames(data.plot),]]

tmp = c()
for( i in ttable$aov.tab[colnames(data.plot),6]){
  if (i<0.01 & 0.001<i){
    tmp <- c(tmp , "**")
  }else if(0< i & i <=0.001){
    tmp <- c(tmp , "***")
  }else if(0.01< i & i<=0.05){
    tmp <- c(tmp , "*")
  }else if(0.05< i & i <=0.111){
    tmp <- c(tmp , ".")
  }else{
    tmp <- c(tmp , "")
  }
}

colnames(data.plot) = gsub("XQNS","Serum uric acid,SUA",colnames(data.plot))
colnames(data.plot) = gsub("XQJG","Serum creatinine,SCr",colnames(data.plot))
colnames(data.plot) = gsub("HCY","Homocysteine,Hcy",colnames(data.plot))
colnames(data.plot) = gsub("CFYDB","CRP",colnames(data.plot))
colnames(data.plot) = gsub("BTC3","C3",colnames(data.plot))
colnames(data.plot) = gsub("BTC4","C4",colnames(data.plot))
colnames(data.plot) = gsub("FBG","Fasting blood-glucose",colnames(data.plot))
colnames(data.plot) = gsub("X25..OH.D3","1,25-(OH)2-D3",colnames(data.plot))
colnames(data.plot) = gsub("HDL.C","HDL-C",colnames(data.plot))
colnames(data.plot) = gsub("Operation.history","Operation history",colnames(data.plot))
colnames(data.plot) = gsub("GDS.15","GDS-15",colnames(data.plot))
colnames(data.plot) = gsub("MEDI.LITE","MEDI-LITE",colnames(data.plot))
colnames(data.plot) = gsub("LDL.C","LDL-C",colnames(data.plot))

barplot(data.plot[1,],horiz = T,las=1,border = T,xlab = "",col = colors,xlim = c(0,0.05))
text(y=seq(from=1,to = 41,by=1.19),x=0.045,cex=3,tmp)
#===================

mtext("Species", font = 2, col = "gray20")
dev.off()

data.output=cbind(value_Df,value_SumsOfSqs,value_MeanSqs,value_F.Model,value_R2,value_p)
rownames(data.output)=colnames(env2)
colnames(data.output)=c("Df","SumsOfSqs","MeanSqs","F.Model","R2","Pr(>F)")
data.output=as.data.frame(data.output)
data.output[,6]
data.output$qFDR= p.adjust(data.output[,6], method = "fdr", n = length(data.output[,6]))
data.output
write.table(data.output[order(data.output[,1],decreasing = T),],file = "adonis.txt",col.names = NA,quote = F,sep = "\t")



