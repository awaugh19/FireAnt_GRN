#!/bin/bash
#SBATCH --job-name=blastp_sinv_dmel                                 #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=48:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/1.1_cp_proj_scratch_AK2020.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/1.1_cp_proj_scratch_AK2020.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

module load BLAST+/2.13.0-gompi-2022a

cd /scratch/ahw22099/FireAnt_GRN/proteomes/primary_transcripts

### Make databases
# For Drosophila melanogaster
makeblastdb -in GCF_000001215.4_Release_6_plus_ISO1_MT_protein.faa -dbtype prot -out dmel_db

# For Solenopsis invicta
makeblastdb -in GCF_016802725.1_UNIL_Sinv_3.0_protein.faa -dbtype prot -out sinv_db

#### BLASTP
#Run blastp to compare the protein sequences from dmel against the database created from the sinv genome
blastp -query GCF_000001215.4_Release_6_plus_ISO1_MT_protein.faa -db sinv_db -out dmel_vs_sinv_blastp.out -evalue 1e-3 -outfmt 6 -max_target_seqs 1

#Run blastp to compare the protein sequences from sinv against the database created from the dmel genome
blastp -query GCF_016802725.1_UNIL_Sinv_3.0_protein.faa -db dmel_db -out sinv_vs_dmel_blastp.out -evalue 1e-3 -outfmt 6 -max_target_seqs 1
