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

# Define directories
SB_genome="/scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB"
if [ ! -d $SB_genome ]; then
    mkdir -p $SB_genome
fi

# Build index using gmapindex
echo "Building GMAP index..."
gmapindex -d UNIL_Sinv_3.4_SB -D $SB_genome -P $SB_genome/UNIL_Sinv_3.4_SB.genomecomp $SB_genome/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna

echo "Aligning reads using GSNAP..."
gsnap -d UNIL_Sinv_3.4_SB -A sam /scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/Sb-vs-SB_CNV_genes_Sinv.fasta  > /scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/Sb-vs-SB_CNV_genes_Sinv.gmap.sam

echo "Job completed."
