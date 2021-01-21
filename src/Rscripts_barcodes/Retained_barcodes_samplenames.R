# @author: Maite van den Noort
# @Date: 28-12-2020
# @function: makes ggplots of the retained reads from library 1 and 2, showed by sample names. 
library(data.table)    
library(dplyr)
library(tidyverse)
library(reshape2)
library(ggplot2)
# data from library 1 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib1 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/maite-internship-epigbs/data/Created_data_lib1/barcode_information_lib1.tsv", header = T)
# data from library 2 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib2 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/maite-internship-epigbs/data/Created_data_lib2/barcode_information_lib2.tsv", header = T)

# output path, here are the figures saved
outputFigures <- ("/mnt/nfs/bioinfdata/home/NIOO/maiten/maite-internship-epigbs/results/output_data_scripts/Figures_barcodes/")

# making subsets for every crick/watson strands from every sample form library1
lib1A <- barcode_data_lib1[grepl("^A", barcode_data_lib1$Filename),]
lib1B <- barcode_data_lib1[grepl("^B", barcode_data_lib1$Filename),]
lib2C <- barcode_data_lib2[grepl("^C", barcode_data_lib2$Filename),]
lib2D <- barcode_data_lib2[grepl("^D", barcode_data_lib2$Filename),]

# making an extra column with percentage for both librarys
lib1A$Retained_pct1 = (lib1A$Retained / sum(lib1A$Retained)) *100
lib1B$Retained_pct2 = (lib1B$Retained / sum(lib1B$Retained)) *100
lib2C$Retained_pct3 = (lib2C$Retained / sum(lib2C$Retained)) *100
lib2D$Retained_pct4 = (lib2D$Retained / sum(lib2D$Retained)) *100

# making a new table with all the information necessary for the plots
datalib1and2 <- data.table(Barcode = lib1A$Barcode, Retained1 = lib1A$Retained, Retained2 = lib1B$Retained, Retained3 = lib2C$Retained, Retained4 = lib2D$Retained)
# making a new table with all the information necessary for the plots with percentage
datalib1and2per <- data.table(Barcode = lib1A$Barcode, Retainedper1 = lib1A$Retained_pct1, Retainedper2 = lib1B$Retained_pct2, Retainedper3 = lib2C$Retained_pct3, Retainedper4 = lib2D$Retained_pct4)
# reshape the table, for an good figure
lib1and2retained <- melt(datalib1and2, id.var="Barcode")
# reshape the table, for an good figure with percentage
lib1and2retainedper <- melt(datalib1and2per, id.var="Barcode")

# making the ggplot for barcode_data_lib1 and 2 together ordered by sample names (dodge)
ggplot(lib1and2retained, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(width=0.7, position = position_dodge(width=0.6), stat="identity", color ="gray")+ # using nice colors and making it a dogde barplot
  labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes (dodge)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample B", "sample C", "sample D")) + #changing the labels in the legend
  #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
  geom_text(aes(label = value), size = 3, hjust = 0, position = position_dodge2(width = 1), angle = 90) # printing the values vertical in the middel of the bar
+  ggsave(paste(outputFigures,"Retained_barcodes_sample_names_dodge.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together in percentage ordered by sample names (dodge)
ggplot(lib1and2retainedper, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(width=0.7, position = position_dodge(width=0.6), stat="identity", color ="gray")+ # using nice colors and making it a dogde barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes in percentage (dodge)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample B", "sample C", "sample D")) + #changing the labels in the legend
  #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
  geom_text(aes(label = round(value, digits = 2)), size = 3, hjust = 0, position = position_dodge2(width = 1), angle = 90) # printing the values vertical in the middel of the bar
+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_lib1_and_2_dodge.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together ordered by sample names (stacked)
ggplot(lib1and2retained, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(position="stack", stat="identity", color ="gray")+ # using nice colors and making it a stacked barplot
  labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes (stacked)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample B", "sample C", "sample D")) + #changing the labels in the legend
  #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
  geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") # printing the values horizontal in the middel of the bar
+  ggsave(paste(outputFigures,"Retained_barcodes_sample_names_stacked.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together in percentage ordered by sample names (stacked)
ggplot(lib1and2retainedper, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(position="stack", stat="identity", color ="gray")+ # using nice colors and making it a stacked barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes in percentage (stacked)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample B", "sample C", "sample D")) + #changing the labels in the legend
  #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
  geom_text(aes(label = round(value, digits = 2)), size = 3, hjust = 0.5, vjust = 3, position = "stack") # printing the values horizontal in the middel of the bar
+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_sample_names_stacked.png",sep="")) # saving the figure at the specified location
