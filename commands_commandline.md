# Handy commands
## Making a new file 
Making a new file named  barcode_inforamtion.txt with the lines 10 to 100 from a big file named process_radtags.clone.log  
`sed -n -e '10,100p' process_radtags.clone.log > barcode_inforamtion.txt`  

## Merging files together
Merging files together by appending one file under the other. And creating a new file with the two files in it:
`cat file1.txt file2.txt > newbigfile1plus2.txt`  

## Check for silly characters 
To check files for silly charaters you don't want in your file you can use the following command: 
`cat -A filename`  
You can also remove those characters with the following command:
`dos2unix filename`  

## Showing only a few lines of a zipped file
If you want to show only a few lines of a zipped file without oped the whole fil use this command:
`zcat filename | sed -n 'regeln;regeln;einderegelq'`  

## Making links
To link files to other directories without copieing the whole file:
`ln -s "path to my files" "path to link, where I want them"`  


## Error pipeline library(ggpubr)
The error prevented the report.md from being completed.  
The error was about the R library `ggpubr`  
Excuted commands:  
`conda activate /mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane2_denovo8/epigbs2/.snakemake/conda/7d295ce0`  
`R`  
When you have completed this, you will enter an R environment, where you can perform R.
