#!/bin/bash
#SBATCH --job-name=gmap_CNV.sh
#SBATCH --partition=batch
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=12
#SBATCH --mem=24gb
#SBATCH --time=24:00:00
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/gmap_CNV.log.%j
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/gmap_CNV.err.%j
#SBATCH --mail-user=ahw22099@uga.edu
#SBATCH --mail-type=END,FAIL

# Load necessary modules
module load GMAP-GSNAP/2023-02-17-GCC-11.3.0
module load SAMtools/1.17-GCC-12.2.0

cd /scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB
samtools faidx GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna

gmap_build -D /scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB \
-d GCF_016802725.1_UNIL_Sinv_3.0 GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna.fai

gmap_out="/scratch/ahw22099/FireAnt_GRN/gmap_out"
if [ ! -d $gmap_out ]
then
mkdir -p $gmap_out
fi

gsnap -D /scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB -N 0 \
-A sam -d /scratch/ahw22099/FireAnt_GRN/Sb-vs-SB_CNV_genes_Sinv.fq
