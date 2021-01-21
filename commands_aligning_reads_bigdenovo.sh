# In this file are all the commands used for the step aligning the reads from lib 1 and lib 2 on the big de novo. This file has also been mentioned i#n the material en methodes of the report there.

# 1.
#This ensures that there is a link to the output_demulitplex directory of the original library 1 output
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library1/output_lib1/"	
# 2.
#This ensures that there is a link to the output_demulitplex directory of the original library 2 output
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library2/outputlib2/"

# 3.
#This ensures that there is a link to the created big de novo reference file to lib1
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/big_de_novo/output_big_denovo/output_denovo/consensus_cluster.renamed.fa" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library1/output_lib1/output_denovo/"	
# 4.
#This ensures that there is a link to the created big de novo reference file to lib2
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/big_de_novo/output_big_denovo/output_denovo/consensus_cluster.renamed.fa" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library2/outputlib2/output_denovo/"

# 5.
#This ensures that there is a link to the unassembled R1 reads from library 1
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_denovo/Unassembled.R1.watson.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library1/output_lib1/output_denovo/"	
# 6.
#This ensures that there is a link to the unassembled R2 reads from library 1
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_denovo/Unassembled.R2.crick.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library1/output_lib1/output_denovo/"	
# 7.
#This ensures that there is a link to the assembled reads from library 1
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_denovo/Assembled.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library1/output_lib1/output_denovo/"	

# 8.
#This ensures that there is a link to the unassembled R1 reads from library 2
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_denovo/Unassembled.R1.watson.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library2/outputlib2/output_denovo/"
# 9.
#This ensures that there is a link to the unassembled R2 reads from library 2
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_denovo/Unassembled.R2.crick.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library2/outputlib2/output_denovo/"
# 10.
#This ensures that there is a link to the assembled reads from library 2
Ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_denovo/Assembled.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/library2/outputlib2/output_denovo/"



