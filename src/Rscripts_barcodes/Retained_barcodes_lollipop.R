# @author: Maite van den Noort
# @Date: 05-01-2021
# @function: makes ggplot (lollipop plot) of the retained reads from library 1 and 2. 
library(ggplot2)
library(tidyr)

# data from library 1 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib1 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/data/Created_data_lib1/barcode_information_lib1.tsv", header = T)
# data from library 2 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib2 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/data/Created_data_lib2/barcode_information_lib2.tsv", header = T)

# output path, here are the figures saved
outputFigures <- ("/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/results/output_data_scripts/Figures_barcodes/")

# merging the table together by barcode
merged <- merge(barcode_data_lib1, barcode_data_lib2, by = "Barcode")

# caculate the percentage of each number retained barcode per library
sum_lib1 <- sum(merged$Retained.x)
sum_lib2 <- sum(merged$Retained.y)
merged$library1 <- (merged$Retained.x/sum_lib1)*100
merged$library2 <- (merged$Retained.y/sum_lib2)*100
# making library2 negative to show it nicer in the plot
merged$library2 <- merged$library2*-1

# the data is transferred to another form, with all the values in Retained.norm
data_long <- pivot_longer(merged, cols =c(library1, library2), values_to = "Retained.norm")
# indicate the different levels (libraries)
levels(data_long$Retained.norm) <- c("library 1", "library 2")
# chaning the name of the comlumn name into Retained_librarys
names(data_long)[names(data_long) == "name"] <- "Retained_librarys"

# making the ggplot (lolliplot) from the data
ggplot(data_long, aes(Retained.norm, Barcode)) +
  geom_segment(aes(x = 0, y = Barcode, xend = Retained.norm, yend = Barcode), color = "grey50") +
  geom_point(aes(color = Retained_librarys), size = 2.7) + # here he knows that there are library 1 and 2 with a different collor with te size 2.7
  scale_fill_discrete(name = "Retained library's", labels = c("library 1", "library 2")) +
  ggtitle("Retained reads per library") +
  labs(x = 'percentage of retained barcodes', y = 'Barcodes') +
  geom_vline(xintercept = 0, size = 0.2) # adding a vertical line on position 0 with the size 0.2
  #+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_lib1_and_2_lollipop.png",sep="")) # saving the figure at the specified location




