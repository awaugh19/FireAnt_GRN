#!/bin/bash
#SBATCH --job-name=interpro_sinv                               #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=48:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/interpro_sinv.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/interpro_sinv.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

module load InterProScan/5.64-96.0-foss-2022b

cd /scratch/ahw22099/FireAnt_GRN/proteomes

interproscan.sh -i GCF_016802725.1_UNIL_Sinv_3.0_protein.faa -o GCF_016802725.1_UNIL_Sinv_3.0_protein_interpro_out.tsv -f TSV 
