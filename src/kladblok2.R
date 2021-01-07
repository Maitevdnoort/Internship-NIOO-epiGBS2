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

# making a new table for lib1, with an extra culumn which is named as id with value 1
barcode_data_lib1$retainedprc <- (barcode_data_lib1$Retained/sum(barcode_data_lib1$Retained))*100
barcode_data_lib2$retainedprc <- (barcode_data_lib2$Retained/sum(barcode_data_lib2$Retained))*100
#barcode_data_lib2$retainedprc <- barcode_data_lib2$retainedprc*-1
databarcode <- merge(barcode_data_lib1, barcode_data_lib2, by= "Barcode")
#dataretained <- data.table(Barcode = databarcode$Barcode, Retainedprc1 = databarcode$retainedprc.x, Retainedprc2= databarcode$retainedprc.y)


data <- gather(databarcode, key = "library", value = "Retained", round(databarcode$Retainedprc1,2), round(databarcode$Retainedprc2, 2), factor_key = TRUE)

ggplot(data, aes(Retained, y = Barcode)) +
  geom_segment(aes(x = 0, xend = Retained, y = Barcode, yend = Barcode), color = "grey50") +
  geom_point(aes(color=library))

#-------------------------------------------------------------------------------------------------------------------
library(ggplot2)
library(tidyr)

# data from library 1 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib1 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/data/Created_data_lib1/barcode_information_lib1.tsv", header = T)
# data from library 2 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib2 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/data/Created_data_lib2/barcode_information_lib2.tsv", header = T)

# output path, here are the figures saved
outputFigures <- ("/mnt/nfs/bioinfdata/home/NIOO/fleurg/projects/Maite")

# making a new table for lib1, with an extra culumn which is named as id with value 1
merged <- merge(barcode_data_lib1, barcode_data_lib2, by = "Barcode")

sum_lib1 <- sum(merged$Retained.x)
sum_lib2 <- sum(merged$Retained.y)
merged$library1 <- (merged$Retained.x/sum_lib1)*100
merged$library2 <- (merged$Retained.y/sum_lib2)*100
merged$library2 <- merged$library2*-1

data_long <- pivot_longer(merged, cols =c(library1, library2), values_to = "Retained.norm")

#data_long <- pivot_longer(merged, names_to = "Retained.norm", Retained.x.norm, Retained.y.norm , values_ptypes = interger()) #, Total, Total.x:Total.y, NoRadTag, NoRadTag.x:NoRadTag.y, Retained, Retained.x:Retained.y)
levels(data_long$Retained.norm) <- c("library 1", "library 2")
names(data_long)[names(data_long) == "name"] <- "Retained_librarys"

ggplot(data_long, aes(Retained.norm, Barcode)) +
  geom_segment(aes(x = 0, y = Barcode, xend = Retained.norm, yend = Barcode), color = "grey50") +
  geom_point(aes(color = Retained_librarys)) +
  scale_fill_discrete(name = "Retained library's", labels = c("library 1", "library 2")) +
  ggtitle("Retained reads per library") +
  labs(x = 'percentage of retained barcodes', y = 'Barcodes')

#-------------------------------------------------------------------------------
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

# making an extra column with percentage
barcode_data_lib1$Retained_pct1 = (barcode_data_lib1$Retained / sum(barcode_data_lib1$Retained)) *100
barcode_data_lib2$Retained_pct2 = (barcode_data_lib2$Retained / sum(barcode_data_lib2$Retained)) *100

# making a new table for lib1, with an extra culumn which is named as id with value 1
datalib1and2 <- data.table(Barcode = barcode_data_lib1$Barcode, Filename = barcode_data_lib1$Filename, Retainedlib1 = barcode_data_lib1$Retained, Retainedlib2 = barcode_data_lib2$Retained, Retained_pct1 = barcode_data_lib1$Retained_pct1, Retained_pct2 = barcode_data_lib2$Retained_pct2)

# ggplot/lollipop plot: Library 1 and 2, percentage of retained reads
ggplot(datalib1and2 , aes(x = Barcode, xend = Barcode, y=Retained_pct1, yend=Retained_pct2)) +
  geom_segment( aes(x=Barcode, xend=Barcode, y=Retained_pct1, yend=Retained_pct2), color = "darkgray", show.legend = TRUE ) +
  geom_point( aes(x=Barcode, y=Retained_pct1), color="violet", size=2.5, show.legend = T) +
  geom_point( aes(x=Barcode, y=Retained_pct2), color="skyblue", size=2.5, show.legend = T ) +
  coord_flip()+
  ggtitle("Library 1 and 2, Retained reads in percentage") +
  labs(subtitle = "Library 1 in violet, Library 2 in skyblue")+
  xlab("Barcodes") +
  ylab("Retained reads in percentage")
+  ggsave(paste(outputFigures,"percentage_Retained_barcodes_lib1_and_2_lollipop.png",sep="")) # saving the figure at the specified location


# ggplot/lollipop plot: Library 1 and 2, number of retained reads
ggplot(datalib1and2) +
  geom_segment( aes(x=Barcode, xend=Barcode, y=Retainedlib1, yend=Retainedlib2), show.legend = TRUE, color = "darkgray") +
  geom_point( aes(x=Barcode, y=Retainedlib1), color="violet", size=2.5 ) +
  geom_point( aes(x=Barcode, y=Retainedlib2), color="skyblue", size=2.5 ) +
  coord_flip()+
  labs(title = "Number of retained reads from lib 1 and 2") +
  labs(subtitle = "Library 1 in violet, Library 2 in skyblue")+
  xlab("Barcodes") +
  ylab("Retained reads")+
  theme(legend.position="right")
+  ggsave(paste(outputFigures,"Retained_barcodes_lib1_and_2_lollipop.png",sep="")) # saving the figure at the specified location


