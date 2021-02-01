# @author: Maite van den Noort
# @Date: 08-11-2020, last modified: 20-01-2021
# @function: makes ggplot (lollipop plot) of the retained reads from library 1 and 2. 
library(ggplot2)
library(tidyr)

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
data1 <- barcode_data_lib1[grepl("Watson", barcode_data_lib1$Filename),]
data2 <- barcode_data_lib2[grepl("Watson", barcode_data_lib2$Filename),]
data1$Filename1 <- gsub("-Watson", "", data1$Filename)
data1$Filename1 <- gsub("^A", "A-C", data1$Filename1)
data1$Filename1 <- gsub("^B", "B-D", data1$Filename1)

data1$WC <- Watson1$Retained+Crick1$Retained
data2$WC <- Watson2$Retained+Crick2$Retained
# merging the table together by barcode
merged <- merge(data1, data2, by = "Barcode")

# to know which is library1 and which is library2
merged$library1 <- merged$WC.x
merged$library2 <- merged$WC.y
# making library2 negative to show it nicer in the plot
merged$library2 <- merged$library2*-1

# the data is transferred to another form, with all the values in Retained.norm
data_long <- pivot_longer(merged, cols =c(library1, library2), values_to = "Retained.norm")
# indicate the different levels (libraries)
levels(data_long$Retained.norm) <- c("library 1", "library 2")
# chaning the name of the comlumn name into Retained_librarys
names(data_long)[names(data_long) == "name"] <- "Retained_librarys"

# making the ggplot (lolliplot) from the data (watson and crick together (combined))
ggplot(data_long, aes(Retained.norm, Filename1)) +
  geom_segment(aes(x = 0, y = Filename1, xend = Retained.norm, yend = Filename1), color = "grey50") +
  geom_point(aes(color = Retained_librarys), size = 2.7) + # here he knows that there are library 1 and 2 with a different collor with te size 2.7
  scale_fill_discrete(name = "Retained library's", labels = c("library 1", "library 2")) +
  ggtitle("Retained reads per library combined") +
  labs(x = 'percentage of retained barcodes', y = 'Filenames') +
  geom_vline(xintercept = 0, size = 0.2) # adding a vertical line on position 0 with the size 0.2
+  ggsave(paste(outputFigures,"number_Retained_barcodes_lib1_and_2_lollipop.png",sep="")) # saving the figure at the specified location






