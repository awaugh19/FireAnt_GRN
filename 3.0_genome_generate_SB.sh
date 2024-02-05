#!/bin/bash
#SBATCH --job-name=3.0_genome_generate_SB.sh                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8                                        #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=24:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/3.0_genome_generate_SB_3.0.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/3.0_genome_generate_SB_3.0.err.%j		    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

STAR_genome_SB="/scratch/ahw22099/FireAnt_GRN/STAR_genome_SB"
if [ ! -d $STAR_genome_SB ]
then
mkdir -p $STAR_genome_SB
fi

SB_genome="/scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB"
if [ ! -d $SB_genome ]
then
mkdir -p $SB_genome
fi

################## STAR ##################
module load STAR/2.7.10b-GCC-11.3.0
########### SB ############
################ acquire genome fastas and gff ####################
module load gffread/0.12.7-GCCcore-11.2.0

# ## SB gff
curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/802/725/GCF_016802725.1_UNIL_Sinv_3.0/GCF_016802725.1_UNIL_Sinv_3.0_genomic.gff.gz | \
gunzip -c > "$SB_genome"/GCF_016802725.1_UNIL_Sinv_3.0_genomic.gff
gffread -T "$SB_genome"/GCF_016802725.1_UNIL_Sinv_3.0_genomic.gff \
 -o "$SB_genome"/GCF_016802725.1_UNIL_Sinv_3.0_genomic.gtf

curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/802/725/GCF_016802725.1_UNIL_Sinv_3.0/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna.gz | \
gunzip -c > "$SB_genome"/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna
################## STAR ##################
module load STAR/2.7.10b-GCC-11.3.0
########### SB ###########
#GENOME GENERATE
time STAR \
--runMode genomeGenerate \
--runThreadN 8 \
--genomeSAindexNbases 13 \
--genomeDir $STAR_genome_SB \
--genomeFastaFiles $SB_genome/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna \
--sjdbGTFfile $SB_genome/GCF_016802725.1_UNIL_Sinv_3.0_genomic.gtf
#
