# @author: Maite van den Noort
# @Date: 19-11-2020
# @function: makes a ggplot of the duplicated reads from library 2.
library(data.table)
library(dplyr)
library(tidyverse)
library(reshape2)
library(ggplot2)

# input library2 duplication reads 
datalib2 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/Data_maite/Duplication_reads_lib2.tsv") # path to input data

# output path, here are the figures saved
outputFigures <- ("/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/Output data scripts/Figures duplication/")

# order library2
orderedlib2 <- datalib2[order(datalib2$V1),]

# change the column names
names(orderedlib2)[names(orderedlib2) == "V1"] <- "sample_names"
names(orderedlib2)[names(orderedlib2) == "V2"] <- "dups"

# making subsets for every crick/watson strands from every sample form library2
lib2crick1 <- orderedlib2[grepl("Crick.1", orderedlib2$sample_name),]
lib2crick2 <- orderedlib2[grepl("Crick.2", orderedlib2$sample_name),]
lib2watson1 <- orderedlib2[grepl("Watson.1", orderedlib2$sample_name),]
lib2watson2 <- orderedlib2[grepl("Watson.2", orderedlib2$sample_name),]

# making subset for the sample names, which makes it easier/clearer for the new table (library2dups)
Sample_nameslib2 <- data.frame(do.call('rbind', strsplit(as.character(lib2crick1$sample_names),'-',fixed=TRUE)))
names(Sample_nameslib2)[names(Sample_nameslib2) == "X1"] <- "sample_names"
names(Sample_nameslib2)[names(Sample_nameslib2) == "X2"] <- "crick_watson"

# making a new table with the subsets from library2
library2dups <- data.table(Sample_names=Sample_nameslib2$sample_names, Crick1_dups=lib2crick1$dups, Crick2_dups=lib2crick2$dups, Watson1_dups=lib2watson1$dups, Watson2_dups=lib2watson2$dups)

# reshape the table, for an good figure
lib2dups <- melt(library2dups, id.var="Sample_names")

# create the figure with stackbar for library2
ggplot(lib2dups, aes(fill=variable, y=value, x= Sample_names)) + 
  geom_bar(position="stack", stat="identity")+
  labs(y = 'number of duplicate reads', x = 'sample names') + 
  ggtitle("library 2 duplicate reads") +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") +
  scale_fill_manual(values = c("skyblue", "cyan3", "blueviolet", "pink")) +
  ggsave(paste(outputFigures,"Library2_duplicated_reads.png",sep=""))

# create the figure with stackbar for library 2 from highest value to lowest
ggplot(lib2dups, aes(fill=variable, y=value, x= reorder(Sample_names, -value))) + 
  geom_bar(position="stack", stat="identity")+
  labs(y = 'number of duplicate reads', x = 'sample names') +
  ggtitle("library 2 From higest duplicate reads to lowest") +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") +
  scale_fill_manual(values = c("skyblue", "cyan3", "blueviolet", "pink")) +
  ggsave(paste(outputFigures,"Library2_from_higest_duplicated_reads_to_lowest.png",sep=""))


# create the figure with stackbar for library 2 with C and D from the same sample next to each other
lib2dups$Sample_names <- factor(lib2dups$Sample_names,levels = c("C27_1","D27_1","C1_0","D1_0","C13_2","D13_2","C2_2","D2_2",
                                                                 "C22_1","D22_1","C30_1","D30_1","C30_2","D30_2","C33_2","D33_2",
                                                                 "C42_1","D42_1","C47_2","D47_2","C48_2","D48_2","C9_1","D9_1"))

ggplot(lib2dups, aes(fill=variable, y=value, x=Sample_names)) + 
  geom_bar(position="stack", stat="identity")+
  labs(y = 'number of duplicate reads', x = 'sample names') + 
  ggtitle("library 2 duplicate reads with C and D from the same sample next to each other") +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") +
  scale_fill_manual(values = c("skyblue", "cyan3", "blueviolet", "pink")) +
  ggsave(paste(outputFigures,"Library2_duplicated_reads_with_C_and_D.png",sep=""))
