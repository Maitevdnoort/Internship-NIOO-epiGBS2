[Fig1]: ./Pictures/Internship-Maite-epiGBS2/MicrosoftTeams-image__2_.png "library(ggpubr)"

# All commands that are excuted in the commandline
## Error pipeline library(ggpubr)
The error prevented the report.md from being completed.  
The error was about the R library `ggpubr`  
Excuted commands:  
`conda activate /mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane2_denovo8/epigbs2/.snakemake/conda/7d295ce0`  
`R`  
When you have completed this, you will enter an R environment, where you can perform R.

![][Fig1]

## Making a new file 
Making a new file named  barcode_inforamtion.txt with the lines 10 to 100 from a big file named process_radtags.clone.log  
`sed -n -e '10,100p' process_radtags.clone.log > barcode_inforamtion.txt`  

## Merging files together
As we mentioned earlier, there is also a way append files to the end of an existing file. Type the cat command followed by the file or files you want to add to the end of an existing file. Then, type two output redirection symbols (>>) followed by the name of the existing file you want to add to.  
`cat file5.txt >> file4.txt`  
