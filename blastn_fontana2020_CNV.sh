#!/bin/bash
#SBATCH --job-name=blastn_fontana2020_CNV                                 #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=48:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/blastn_fontana2020_CNV.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/blastn_fontana2020_CNV.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

module load BLAST+/2.13.0-gompi-2022a

cd /scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV

### Make databases
# For Fontana 2020 CNV genes
makeblastdb -in Sb-vs-SB_CNV_genes_Sinv.fasta -dbtype nucl -out fontana_db

# For Solenopsis invicta
makeblastdb -in /scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna -dbtype nucl -out sinv_db

#### BLASTN
#Run blastp to compare the protein sequences from fontana CNV fasta against the database created from the sinv genome
blastn -query Sb-vs-SB_CNV_genes_Sinv.fasta -db sinv_db -out qFontana_vs_dSinv_blastn.out -evalue 1e-5 -outfmt 6 -perc_identity 90

#Run blastp to compare the protein sequences from sinv against the database created from the fontana CNV fasta
blastn -query /scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna -db fontana_db -out qSinv_vs_dFontana_blastn.out -evalue 1e-5 -outfmt 6 -perc_identity 90
