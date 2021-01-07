# @author: Maite van den Noort
# @Date: 19-11-2020
# @function: makes ggplots of the duplicated percentage from library 1. 
library(data.table)    
library(dplyr)
library(tidyverse)
library(reshape2)
library(ggplot2)

# input library1 duplication percentage 
datalib1 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/Data_maite/Dublication_percentage_lib1.tsv")

# order library1 
orderedlib1 <- datalib1[order(datalib1$V1),]

# change the column names
names(orderedlib1)[names(orderedlib1) == "V1"] <- "sample_names"
names(orderedlib1)[names(orderedlib1) == "V2"] <- "dups"
colnames(orderedlib1)

# making subsets for every crick/watson strands from every sample form library1
lib1crick1 <- orderedlib1[grepl("Crick.1", orderedlib1$sample_name),]
lib1crick2 <- orderedlib1[grepl("Crick.2", orderedlib1$sample_name),]
lib1watson1 <- orderedlib1[grepl("Watson.1", orderedlib1$sample_name),]
lib1watson2 <- orderedlib1[grepl("Watson.2", orderedlib1$sample_name),]

# making subset for the sample names, which makes it easier/clearer for the new table (library1dups)
Sample_nameslib1 <- data.frame(do.call('rbind', strsplit(as.character(lib1crick1$sample_names),'-',fixed=TRUE)))
names(Sample_nameslib1)[names(Sample_nameslib1) == "X1"] <- "sample_names"
names(Sample_nameslib1)[names(Sample_nameslib1) == "X2"] <- "crick_watson"

# making a new table with the subsets from library1
library1dups <- data.table(Sample_names=Sample_nameslib1$sample_names, Crick1_dups=lib1crick1$dups, Crick2_dups=lib1crick2$dups, Watson1_dups=lib1watson1$dups, Watson2_dups=lib1watson2$dups)

# reshape the table, for an good figure
lib1dups <- melt(library1dups, id.var="Sample_names")

# create the figure with stackbar for library1
ggplot(lib1dups, aes(fill=variable, y=value, x= Sample_names)) + 
  geom_bar(position="stack", stat="identity")+
  labs(y = 'duplicate percentage', x = 'sample names') + 
  ggtitle("Library 1 duplicate percentage") +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") +
  scale_fill_manual(values = c("skyblue", "cyan3", "blueviolet", "pink"))

# create the figure with stackbar for library 1 from highest value to lowest
ggplot(lib1dups, aes(fill=variable, y=value, x= reorder(Sample_names, -value))) + 
  geom_bar(position="stack", stat="identity")+
  labs(y = 'duplicate percentage', x = 'sample names') +
  ggtitle("Library 1 From higest duplicate percentage to lowest") +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") +
  scale_fill_manual(values = c("skyblue", "cyan3", "blueviolet", "pink"))

# create the figure with stackbar for library 1 with A and B from the same sample next to each other
lib1dups$Sample_names <- factor(lib1dups$Sample_names,levels = c("A27_1","B27_1","A1_0","B1_0","A13_2","B13_2","A2_2","B2_2",
                                                                 "A22_1","B22_1","A30_1","B30_1","A30_2","B30_2","A33_2","B33_2",
                                                                 "A42_1","B42_1","A47_2","B47_2","A48_2","B48_2","A9_1","B9_1"))

ggplot(lib1dups, aes(fill=variable, y=value, x=Sample_names)) + 
  geom_bar(position="stack", stat="identity")+
  labs(y = 'duplicate percentage', x = 'sample names') + 
  ggtitle("Library 1 duplicate percentage with A and B from the same sample next to each other") +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") +
  scale_fill_manual(values = c("skyblue", "cyan3", "blueviolet", "pink"))