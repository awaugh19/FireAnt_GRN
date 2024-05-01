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
#module load SAMtools/1.17-GCC-12.2.0


# Define variables
GENOME_FASTA="/scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna"
INDEX_NAME="UNIL_3.0_gmap_genome"
INDEX_DIR="/scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB/"
READS_FASTA="/scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/Sb-vs-SB_CNV_genes_Sinv.fasta"
OUTPUT_SAM="/scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/Sb-vs-SB_CNV_genes_Sinv.sam"

# Step 1: Build the GSNAP index for the reference genome
gmap_build -d $INDEX_NAME -k 15 -D $INDEX_DIR $GENOME_FASTA

# Step 2: Run GSNAP for mapping
gsnap -d $INDEX_NAME -D $INDEX_DIR -A sam $READS_FASTA > $OUTPUT_SAM
