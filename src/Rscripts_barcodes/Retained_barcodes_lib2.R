library(ggplot2)
library(broman)
#library 2
# data from library 2 with the information about the barcodes (form the 'process_radtags.clone.log' file)
barcode_data_lib2 <- read.table(file ="/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/data/Created_data_lib2/barcode_information_lib2.tsv", header = T)

# output path, here are the figures saved
outputFigures <- ("/mnt/nfs/bioinfdata/home/NIOO/maiten/internship-maite-epigbs2/results/output_data_scripts/Figures_barcodes/")

# making variables to use beautiful colors in the graph 
blue <- brocolors("crayons")["Blue Violet"]
darkblue <- brocolors("crayons")["Blue Gray"]

# making the ggplot for barcode_data_lib2
ggplot(barcode_data_lib2, aes(y= Retained, x= reorder(Barcode, -Retained))) + 
  geom_bar(position="stack", stat="identity", fill= blue, color= darkblue)+ # using nice colors and making it a barplot
  labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 2 retained barcodes") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  geom_text(aes(label = Retained), size = 3, hjust = 0.5, position = position_stack(vjust = 0.5), angle = 90) + # printing the values vertical in the middel of the bar
  ggsave(paste(outputFigures,"Retained_barcodes_lib2.png",sep="")) # saving the figure at the specified location


# making an extra column with percentage
barcode_data_lib2$retained_pct = (barcode_data_lib2$Retained / sum(barcode_data_lib2$Retained)) *100
# rounding off the percentage in the column
round(barcode_data_lib2$retained_pct, digits = 3)

# making the ggplot for barcode_data_lib2 wtih percentage
ggplot(barcode_data_lib2, aes(y= retained_pct, x= reorder(Barcode, -retained_pct))) + 
  geom_bar(position="stack", stat="identity", fill= blue, color= darkblue)+ # using nice colors and making it a barplot
  labs(y = 'percentage of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 2 retained barcodes in percentage") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  geom_text(aes(label = round(retained_pct, digits = 3)), size = 3, hjust = 0.5, position = position_stack(vjust = 0.5), angle = 90)+ # printing the rounded values vertical in the middel of the bar
  ggsave(paste(outputFigures,"Retained_barcodes_percentage_lib2.png",sep="")) # saving the figure at the specified location


#if there is 22 in filename remove the row
barcode_data_lib2_without22 <- barcode_data_lib2[!grepl("22", barcode_data_lib2$Filename),]

# making the ggplot for barcode_data_lib2 without the sample with 22 in the name
ggplot(barcode_data_lib2_without22, aes(y= Retained, x= reorder(Barcode, -Retained))) + 
  geom_bar(position="stack", stat="identity", fill= blue, color= darkblue)+ # using nice colors and making it a barplot
  labs(y = 'number of retained barcodes', x = 'Barcodes') + # giving the labels names
  ggtitle("Library 2 retained barcodes without sample 22") + # giving the plot a title
  scale_x_discrete(guide = guide_axis(angle = 70)) + # the position of the values on the x-as. 0=horizontal, 90= vertical
  theme_minimal()+ # making the background nicer
  geom_text(aes(label = Retained), size = 3, hjust = 0.5, position = position_stack(vjust = 0.5), angle = 90)+ # printing the values vertical in the middel of the bar
  ggsave(paste(outputFigures,"Retained_barcodes_without22_lib2.png",sep="")) # saving the figure at the specified location


