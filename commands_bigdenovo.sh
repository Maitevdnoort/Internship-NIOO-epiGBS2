# In this file are all the commands used for the step creating a big de novo in the material en methodes of the report.

# 1.
#merging the Watson_R1.fq.gz file from de demultiplexed reads from library 1 and library 2. This results in one Watson_R1.fq.gz file in the output #directory output_demultiplex from the big de novo. 
Cat "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/Watson_R1.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/Watson_R1.fq.gz" > "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/big_de_novo/output_big_denovo/output_demultiplex/Watson_R1.fq.gz"	
# 2.
#merging the Watson_R2.fq.gz file from de demultiplexed reads from library 1 and library 2. This results in one Watson_R2.fq.gz file in the output #directory output_demultiplex from the big de novo.
Cat "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/Watson_R2.fq.gz " "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/Watson_R2.fq.gz " > "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/big_de_novo/output_big_denovo/output_demultiplex/Watson_R2.fq.gz "
# 3.
#merging the Crick_R1.fq.gz file from de demultiplexed reads from library 1 and library 2. This results in one Crick_R1.fq.gz file in the output #directory output_demultiplex from the big de novo.
Cat "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/Crick_R1.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/Crick_R1.fq.gz" > "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/big_de_novo/output_big_denovo/output_demultiplex/Crick_R1.fq.gz"	
# 4.
#merging the Crick_R2.fq.gz file from de demultiplexed reads from library 1 and library 2. This results in one Crick_R2.fq.gz file in the output #directory output_demultiplex from the big de novo.
Cat "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/Crick_R2.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/Crick_R2.fq.gz" > "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/big_denono/big_de_novo/output_big_denovo/output_demultiplex/Crick_R2.fq.gz"	
