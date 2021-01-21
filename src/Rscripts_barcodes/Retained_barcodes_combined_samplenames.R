# @author: Maite van den Noort
# @Date: 30-12-2020, last update: 7-01-2021
# @function: makes ggplots with watson and crick together (combined) about the retained barcodes
# shows it per sample name.
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
Watson1 <- barcode_data_lib1[grepl("Watson", barcode_data_lib1$Filename),]
Crick1 <- barcode_data_lib1[grepl("Crick", barcode_data_lib1$Filename),]
Watson2 <- barcode_data_lib2[grepl("Watson", barcode_data_lib2$Filename),]
Crick2 <- barcode_data_lib2[grepl("Crick", barcode_data_lib2$Filename),]
# making new tabels with one columns of two tables into a watson table and a crick table
WC1 <- data.table(Watson1$Retained+Crick1$Retained)
WC2 <- data.table(Watson2$Retained+Crick2$Retained)
# bind watson and crick together
WatsonCrick <- rbind(WC1, WC2)
# bind the two datasets together
data = rbind(barcode_data_lib1, barcode_data_lib2)
# here it is ensured that we only have all samples once by just grabbing the watson samples
data <- data[grepl("Watson", data$Filename),]

# making a new table with all the information necessary for the plots
datalib1and2 <- data.table(Barcode = data$Barcode, Filename = data$Filename, Retained = WatsonCrick$V1)

# making subsets for every sample name from every sample form library1
lib1A <- datalib1and2[grepl("^A", datalib1and2$Filename),]
lib1B <- datalib1and2[grepl("^B", datalib1and2$Filename),]
lib2C <- datalib1and2[grepl("^C", datalib1and2$Filename),]
lib2D <- datalib1and2[grepl("^D", datalib1and2$Filename),]
lib1A$Filename <- gsub("-Watson", "",lib1A$Filename)
lib1A$Filename <- gsub("^A", "", lib1A$Filename)

# making an extra column with percentage for both librarys
lib1A$Retained_pct1 = (lib1A$Retained / sum(lib1A$Retained)) *100
lib1B$Retained_pct2 = (lib1B$Retained / sum(lib1B$Retained)) *100
lib2C$Retained_pct3 = (lib2C$Retained / sum(lib2C$Retained)) *100
lib2D$Retained_pct4 = (lib2D$Retained / sum(lib2D$Retained)) *100
lib1A$Barcodes <- paste(lib1A$Barcode, "|", lib1B$Barcode, "|", lib1A$Filename)

# making a new table with all the information necessary for the plots
datalib <- data.table(Barcode = lib1A$Barcodes , Retained1 = lib1A$Retained, Retained2 = lib1B$Retained, Retained3 = lib2C$Retained, Retained4 = lib2D$Retained)

# making a new table with all the information necessary for the plots with percentage
datalib1and2per <- data.table(Barcode = lib1A$Barcodes, Retainedper1 = lib1A$Retained_pct1, Retainedper2 = lib1B$Retained_pct2, Retainedper3 = lib2C$Retained_pct3, Retainedper4 = lib2D$Retained_pct4)

datalib1and2per1 <- data.table(Barcode = lib1A$Barcode, Retainedper1 = lib1A$Retained_pct1,Retainedper3 = lib2C$Retained_pct3)
datalib1and2per2 <- data.table(Barcode = lib1B$Barcode, Retainedper2 = lib1B$Retained_pct2,Retainedper4 = lib2D$Retained_pct4)

# reshape the table, for an good figure
lib1and2retained <- melt(datalib, id.var="Barcode")
# reshape the table, for an good figure with percentage
lib1and2retainedper <- melt(datalib1and2per, id.var="Barcode")
lib1and2retainedper1 <- melt(datalib1and2per1, id.var="Barcode")
lib1and2retainedper2 <- melt(datalib1and2per2, id.var="Barcode")

# making the ggplot for barcode_data_lib1 and 2 together in percentage ordered by sample names A and C(dodge)
ggplot(lib1and2retainedper1, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(width=0.7, position = position_dodge(width=0.6), stat="identity", color ="gray")+ # using nice colors and making it a dogde barplot with weidth 0.6
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes in percentage combined, sample A and B (dodge)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample C")) + #changing the labels in the legend
  #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
  geom_text(aes(label = round(value, digits = 2)), size = 3, hjust = 0, position = position_dodge2(width = 0.5), angle = 90) # printing the values vertical in the middel of the bar
+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_lib1_and_2_combined_sampleAC_dodge.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together in percentage ordered by sample names B and D(dodge)
ggplot(lib1and2retainedper2, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(width=0.7, position = position_dodge(width=0.6), stat="identity", color ="gray")+ # using nice colors and making it a dogde barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes in percentage combined, sample B and D (dodge)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_discrete(name = "Retained samples", labels = c("sample B", "sample D")) + #changing the labels in the legend
  #scale_fill_manual(values = c("#7CAE00", "#C77CFF")) + # give the different values a nice color
  geom_text(aes(label = round(value, digits = 2)), size = 3, hjust = 0, position = position_dodge2(width = 0.5), angle = 90) # printing the values vertical in the middel of the bar
+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_lib1_and_2_combined_sampleBD_dodge.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together ordered by sample names (dodge)
# ggplot(lib1and2retained, aes(y= value, fill= variable, x= Barcode)) + 
#   geom_bar(width=0.7, position = position_dodge(width=0.6), stat="identity", color ="gray")+ # using nice colors and making it a dogde barplot
#   labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
#   ggtitle("Library 1 and 2 retained barcodes combined(dodge)") + # giving the plot a title
#   scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
#   theme_minimal()+ # making the background nicer
#   scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample B", "sample C", "sample D")) + #changing the labels in the legend
#   #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
#   geom_text(aes(label = value), size = 3, hjust = 0, position = position_dodge2(width = 0.5), angle = 90) # printing the values vertical in the middel of the bar
# +  ggsave(paste(outputFigures,"Retained_barcodes_sample_names_combined_dodge.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together in percentage ordered by sample names (dodge)
ggplot(lib1and2retainedper, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(width=0.7, position = position_dodge(width=0.6), stat="identity", color ="gray")+ # using nice colors and making it a dogde barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes in percentage combined (dodge)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample B", "sample C", "sample D")) + #changing the labels in the legend
  #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
  geom_text(aes(label = round(value, digits = 2)), size = 3, hjust = 0, position = position_dodge2(width = 0.5), angle = 90) # printing the values vertical in the middel of the bar
+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_lib1_and_2_combined_dodge.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together ordered by sample names (stacked)
# ggplot(lib1and2retained, aes(y= value, fill= variable, x= Barcode)) + 
#   geom_bar(position="stack", stat="identity", color ="gray")+ # using nice colors and making it a stacked barplot
#   labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
#   ggtitle("Library 1 and 2 retained barcodes combined (stacked)") + # giving the plot a title
#   scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
#   theme_minimal()+ # making the background nicer
#   scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample B", "sample C", "sample D")) + #changing the labels in the legend
#   #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
#   geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") # printing the values horizontal in the middel of the bar
# +  ggsave(paste(outputFigures,"Retained_barcodes_sample_names_combined_stacked.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together in percentage ordered by sample names (stacked)
ggplot(lib1and2retainedper, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(position="stack", stat="identity", color ="gray")+ # using nice colors and making it a stacked barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes in percentage combined (stacked)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_discrete(name = "Retained samples", labels = c("sample A", "sample B", "sample C", "sample D")) + #changing the labels in the legend
  #scale_fill_manual(values = c("skyblue", "purple", "yellow", "red")) + # give the different values a nice color
  geom_text(aes(label = round(value, digits = 2)), size = 3, hjust = 0.5, vjust = 3, position = "stack") # printing the values horizontal in the middel of the bar
#+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_sample_names_combined_stacked.png",sep="")) # saving the figure at the specified location
