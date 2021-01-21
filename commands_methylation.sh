#This ensures that there is a link to the output_demulitplex directory of the original library 1 output
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane2_denovo8/epigbs2/output/"	
#This ensures that there is a link to the output_demulitplex directory of the original library 2 output
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane8_thenovo2/epiGBS2/Output_lane8_thenovo2/"	

#This ensures that there is a link to the file with de novo of library 1
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_denovo/consensus_cluster.renamed.fa" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane2_denovo8/epigbs2/output/output_denovo/"	
#This ensures that there is a link to the file with de novo of library 2
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_denovo/consensus_cluster.renamed.fa" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane8_thenovo2/epiGBS2/Output_lane8_thenovo2/output_denovo/"	

#This ensures that there is a link to the unassembled R1 reads from library 1
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/Unassembled.R1.watson.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane2_denovo8/epigbs2/output/output_denovo/"	
#This ensures that there is a link to the unassembled R2 reads from library 1
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/Unassembled.R2.crick.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane2_denovo8/epigbs2/output/output_denovo/"	
#This ensures that there is a link to the assembled reads from library 1
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane2/output_demultiplex/Assembled.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane2_denovo8/epigbs2/output/output_denovo/"	

#This ensures that there is a link to the unassembled R1 reads from library 2
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/Unassembled.R1.watson.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane8_thenovo2/epiGBS2/Output_lane8_thenovo2/output_denovo/"	
#This ensures that there is a link to the unassembled R2 reads from library 2
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/Unassembled.R2.crick.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane8_thenovo2/epiGBS2/Output_lane8_thenovo2/output_denovo/"	
#This ensures that there is a link to the assembled reads from library 2
ln -s "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/output_lane8/output_demultiplex/Assembled.fq.gz" "/mnt/nfs/bioinfdata/home/NIOO/maiten/duckweed_epiGBS/lane8_thenovo2/epiGBS2/Output_lane8_thenovo2/output_denovo/"	

