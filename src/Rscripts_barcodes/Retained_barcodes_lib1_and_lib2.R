# @author: Maite van den Noort
# @Date: 16-12-2020
# @function: makes ggplots of the retained reads from library 1 and 2. 
library(data.table)    
library(dplyr)
library(tidyverse)
library(reshape2)
library(ggplot2)
# data from library 1 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib1 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/data/Created_data_lib1/barcode_information_lib1.tsv", header = T)
# data from library 2 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib2 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/data/Created_data_lib2/barcode_information_lib2.tsv", header = T)

# output path, here are the figures saved
outputFigures <- ("/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/results/output_data_scripts/Figures_barcodes/")

# making an extra column with percentage for both librarys
barcode_data_lib1$Retained_pct1 = (barcode_data_lib1$Retained / sum(barcode_data_lib1$Retained)) *100
barcode_data_lib2$Retained_pct2 = (barcode_data_lib2$Retained / sum(barcode_data_lib2$Retained)) *100

# making a new table with all the information necessary for the plots
datalib1and2 <- data.table(Barcode = barcode_data_lib1$Barcode,Retained1 = barcode_data_lib1$Retained, Retained2 = barcode_data_lib2$Retained)
# making a new table with all the information necessary for the plots with percentage
datalib1and2per <- data.table(Barcode = barcode_data_lib1$Barcode,Retainedper1 = barcode_data_lib1$Retained_pct1, Retainedper2 = barcode_data_lib2$Retained_pct2)

# reshape the table, for an good figure
lib1and2retained <- melt(datalib1and2, id.var="Barcode")
# reshape the table, for an good figure with percentage
lib1and2retainedper <- melt(datalib1and2per, id.var="Barcode")

# making the ggplot for barcode_data_lib1 and 2 together (dodge)
ggplot(lib1and2retained, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(width=0.7, position = position_dodge(width=0.6), stat="identity", color ="gray")+ # using nice colors and making it a dogde barplot
  labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes (dodge)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_manual(values = c("skyblue", "purple")) + # give the different values a nice color
  geom_text(aes(label = value), size = 3, hjust = 0, position = position_dodge2(width = 1), angle = 90) # printing the values vertical in the middel of the bar
+  ggsave(paste(outputFigures,"Retained_barcodes_lib1_and_2_dodge.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together in percentage (dodge)
ggplot(lib1and2retainedper, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(width=0.7, position = position_dodge(width=0.6), stat="identity", color ="gray")+ # using nice colors and making it a dogde barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes in percentage (dodge)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_manual(values = c("skyblue", "purple")) + # give the different values a nice color
  geom_text(aes(label = round(value, digits = 2)), size = 3, hjust = 0, position = position_dodge2(width = 1), angle = 90) # printing the values vertical in the middel of the bar
+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_lib1_and_2_dodge.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together (stacked)
ggplot(lib1and2retained, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(position="stack", stat="identity", color ="gray")+ # using nice colors and making it a stacked barplot
  labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes (stacked)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_manual(values = c("skyblue", "purple")) + # give the different values a nice color
  geom_text(aes(label = value), size = 3, hjust = 0.5, vjust = 3, position = "stack") # printing the values horizontal in the middel of the bar
+  ggsave(paste(outputFigures,"Retained_barcodes_lib1_and_2_stacked.png",sep="")) # saving the figure at the specified location

# making the ggplot for barcode_data_lib1 and 2 together in percentage (stacked)
ggplot(lib1and2retainedper, aes(y= value, fill= variable, x= Barcode)) + 
  geom_bar(position="stack", stat="identity", color ="gray")+ # using nice colors and making it a stacked barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 and 2 retained barcodes in percentage (stacked)") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  scale_fill_manual(values = c("skyblue", "purple")) + # give the different values a nice color
  geom_text(aes(label = round(value, digits = 2)), size = 3, hjust = 0.5, vjust = 3, position = "stack") # printing the values horizontal in the middel of the bar
+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_lib1_and_2_stacked.png",sep="")) # saving the figure at the specified location
