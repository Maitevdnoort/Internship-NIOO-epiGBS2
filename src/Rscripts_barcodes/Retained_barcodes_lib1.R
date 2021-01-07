library(ggplot2)
library(broman)
#library 1
# data from library 1 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib1 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/data/Created_data_lib1/barcode_information_lib1.tsv", header = T)

# output path, here are the figures saved
outputFigures <- ("/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/results/output_data_scripts/Figures_barcodes/")

# making variables to use beautiful colors in the graph 
blue <- brocolors("crayons")["Cornflower"]
darkblue <- brocolors("crayons")["Blue Gray"]

# making the ggplot for barcode_data_lib1
ggplot(barcode_data_lib1, aes(y= Retained, x= reorder(Barcode, -Retained))) + 
  geom_bar(position="stack", stat="identity", fill= blue, color= darkblue)+ # using nice colors and making it a barplot
  labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 retained barcodes") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  geom_text(aes(label = Retained), size = 3, hjust = 0.5, position = position_stack(vjust = 0.5), angle = 90) + # printing the values vertical in the middel of the bar
  ggsave(paste(outputFigures,"Retained_barcodes_lib1.png",sep="")) # saving the figure at the specified location


# making an extra column with percentage
barcode_data_lib1$retained_pct = (barcode_data_lib1$Retained / sum(barcode_data_lib1$Retained)) *100
# rounding off the percentage in the column
round(barcode_data_lib1$retained_pct, digits = 3)

# making the ggplot for barcode_data_lib1 with percentage
ggplot(barcode_data_lib1, aes(y= retained_pct, x= reorder(Barcode, -retained_pct))) + 
  geom_bar(position="stack", stat="identity", fill= blue, color= darkblue)+ # using nice colors and making it a barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 retained barcodes in percentage") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  geom_text(aes(label = round(retained_pct, digits = 3)), size = 3, hjust = 0.5, position = position_stack(vjust = 0.5), angle = 90)+ # printing the rounded values vertical in the middel of the bar
  ggsave(paste(outputFigures,"Retained_barcodes_percentage_lib1.png",sep="")) 


# if there is 22 in the column Filename remove the row
barcode_data_lib1_without22 <- barcode_data_lib1[!grepl("22", barcode_data_lib1$Filename),]

# making the ggplot for barcode_data_lib1 without the sample with 22 in the name
ggplot(barcode_data_lib1_without22, aes(y= Retained, x= reorder(Barcode, -Retained))) + 
  geom_bar(position="stack", stat="identity", fill= blue, color= darkblue)+ # using nice colors and making it a barplot
  labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 1 retained barcodes without sample 22") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  geom_text(aes(label = Retained), size = 3, hjust = 0.5, position = position_stack(vjust = 0.5), angle = 90)+ # printing the values vertical in the middel of the bar
  ggsave(paste(outputFigures,"Retained_barcodes_without22_lib1.png",sep="")) # saving the figure at the specified location


