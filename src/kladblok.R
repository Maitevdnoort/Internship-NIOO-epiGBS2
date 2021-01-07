# @author: Maite van den Noort
# @Date: 16-12-2020
# @function: makes ggplots of the retained reads from library 1 and 2. 
library(data.table)    
library(dplyr)
library(tidyverse)
library(reshape2)
library(reshape)
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

ggplot(lib1and2retained, aes(y= value, x= Barcode, color= variable,)) + 
geom_segment( aes(y= value, yend = value, xend= Barcode, x= Barcode), show.legend = TRUE, stat = "identity", color = "gray" ) +
  geom_point( aes(x=Barcode, y=value), color="violet", size=2.5 ) +
  geom_point( aes(x=Barcode, y=value), color= "red", size=2.5 ) +
  coord_flip()+
  ggtitle("Library 1 and 2, Retained reads") +
  xlab("Barcodes") +
  ylab("number of Retained reads")
