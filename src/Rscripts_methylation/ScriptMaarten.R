# @author: Maarten Postuma (edited by: Maite van den Noort)
# @Date: unknown (Date edited: 19-11-2020)
# @function: Making ggplots to compare two different methylation.bed files (made with the same reference or denovo)
library(ggplot2)

# Input: 1: fisrt methylation.bed file, 2: second methylation.bed file, 3: ouput file, here are the ggplot saved
args<-c("/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/mapping/methylation.bed", 
        "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane2_denovo8/epigbs2/output/mapping/methylation.bed", 
        "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_data_scripts/Figures_methylation_(maarten)/output_denovo8_datalane2/")

# variables are made with the different files/directorys 
inputlib1<-args[1]
inputlib2<-args[2]
outputFigures<-args[3]

# determine of the mode is reference of de novo. If there is an NA in the file it is de novo
mode<-"ref"
if(is.na(mode)==T){
  mode<-"denovo"
}

# read the two files as tables
lib1<-read.table(inputlib1,h=T,stringsAsFactors = F) 
lib1<-lib1[lib1$samples_called>0,]
lib2<-read.table(inputlib2,h=T,stringsAsFactors = F)
lib2<-lib2[lib2$samples_called>0,]

# making lists with the data from the tables above  (don't get the -c(1,2,3))
lib1[] <- lapply(lib1, gsub, pattern = "None", replacement = NA, fixed = TRUE)
lib1[-c(1,2,3)] <- lapply(lib1[-c(1,2,3)], function(x) as.numeric(as.character(x)))
lib2[] <- lapply(lib2, gsub, pattern = "None", replacement = NA, fixed = TRUE)
lib2[-c(1,2,3)] <- lapply(lib2[-c(1,2,3)], function(x) as.numeric(as.character(x)))


# making the column pos nummeric
lib2$pos<-as.numeric(lib2$pos)
# making a new column named loci, with chr and pos "paste" behind each other
lib2$loci<-paste(lib2$chr,lib2$pos)
lib1$loci<-paste(lib1$chr,lib1$pos)

# I don't know what he is doing here
lib2<-lib2[duplicated(lib2$loci)==F,]
lib1<-lib1[duplicated(lib1$loci)==F,]

if(mode=="ref"){
  lociLib2<-paste(lib2$chr,lib2$pos)# does this only if the mode is reference, making variable newloci, with chr and pos "paste" behind each other
}else{ # why pos -4 ?
  lociLib2<-paste(lib2$chr,lib2$pos-4)# does this only if the mode is de novo, making variable newloci, with chr and pos (-4) "paste" behind each other
}
lociLib1<-paste(lib1$chr,lib1$pos) #making variable oldloci, with chr and pos "paste" behind each other

# see which loci's are the same in both tables (methylation.bed files)
lociLib2Shared<-which(lociLib2%in%lociLib1)
lociLib1Shared<-which(lociLib1%in%lociLib2)

# print some things:
print(sum(lociLib1%in%lociLib2))
print(length(lociLib1))
print(length(lociLib2))

# making a new table named nSites, with all sites from the two input files and the shared sites
nSites<-data.frame(method=c("lane8_denovo8","lane2_denovo8","shared"),sites=
                     c(length(unique(lociLib1)),length(unique(lociLib2)),sum(lociLib1%in%lociLib2)))

# making a plot of the table nSites, and saves it in the given location (see line 6)
ggplot(nSites,aes(x=method,y=sites,label=sites))+geom_label()+
  ggsave(paste(outputFigures,"Mappinglane8_denovo8vslane2_denovo8sites.png"))

# as.vector: Converts a distributed matrix (lib2) into a non-distributed vector (nlib2).
nlib2<-as.vector(lib2[lociLib2Shared,grep("methylated",colnames(lib2))])
totlib2<-as.vector(lib2[lociLib2Shared,grep("total",colnames(lib2))])

# as.vector: Converts a distributed matrix (lib1) into a non-distributed vector (nlib1).
nlib1<-as.vector(lib1[lociLib1Shared,grep("methylated",colnames(lib1))])
totlib1<-as.vector(lib1[lociLib1Shared,grep("total",colnames(lib1))])

# sums rows and put it in a variable
totSiteLib1<-rowSums(totlib1,na.rm=T)
totSiteLib2<-rowSums(totlib2,na.rm=T)
nMethSiteLib1<-rowSums(nlib1,na.rm=T)
nMethSiteLib2<-rowSums(nlib2,na.rm=T)

# making variables with the nMethods divided by the totMethods
fracLib2<-nlib2/totlib2
fracLib1<-nlib1/totlib1

# making a new table for the plots below
dataPlot<-data.frame(totLib1=totSiteLib1,totLib2=totSiteLib2,
                     fracLib1=nMethSiteLib1/totSiteLib1,fracLib2=nMethSiteLib2/totSiteLib2)

# calculations for plotting (>300 = filter)
test<-dataPlot[dataPlot$totLib1>300,]
perc<-sum(abs(test$fracLib2-test$fracLib1)<0.01)/length(test$fracLib1)

# don't understand what he is doing here
percentageDifference<-data.frame(diff=c(0.001,0.005,0.01,0.05,0.1,0.2,0.3,0.4,0.5,0.6,0.7),perc=NA)
for(i in percentageDifference$diff){
  percentageDifference$perc[percentageDifference$diff==i]<-
    round(sum(abs(test$fracLib2-test$fracLib1)<i)/length(test$fracLib1),digits = 3)*100
}

# ggplot for the difference in fraction between the two methylation files in a plot
ggplot(percentageDifference,aes(x=log10(diff),y=perc))+geom_point()+
  xlab("Difference in fraction methylation")+ylab("Percentage of sites with lower difference")+
  ggsave(paste(outputFigures,"Mappinglane8_denovo8vslane2_denovo8difference.png",sep=""))
write.table(percentageDifference,"percDiffMapping.tsv")

# ggplot for the fraction methylated per site per file with filter: >300
ggplot(dataPlot[dataPlot$totLib1>300,],aes(x=fracLib2,y=fracLib1))+geom_point(alpha=0.01)+
  xlab("fraction methylated per site lane2_denovo8")+ylab("fraction methylated per site lane8_denovo8")+
  ggsave(paste(outputFigures,"fractionMethylatedFilter.png",sep=""))

# ggplot for the coverage per site from the two files with log10
ggplot(dataPlot,aes(x=log10(totLib2),y=log10(totLib1)))+geom_point(alpha=0.01)+
  xlab("log10coverage per site lane2_denovo8")+ylab("log10coverage per site lane8_denovo8")+
  ggsave(paste(outputFigures,"log10coverage.png",sep=""))

# ggplot for the fraction methylated per site per file 
ggplot(dataPlot,aes(x=fracLib2,y=fracLib1))+geom_point(alpha=0.01)+
  xlab("fraction methylated per site lane2_denovo8")+ylab("fraction methylated per site lane8_denovo8")+
  ggsave(paste(outputFigures,"fractionMethylated.png",sep=""))


