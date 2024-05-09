#!/bin/bash
#SBATCH --job-name=exonerate_CNV
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=24gb
#SBATCH --time=24:00:00
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/exonerate_CNV.log.%j
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV/exonerate_CNV.err.%j
#SBATCH --mail-user=ahw22099@uga.edu
#SBATCH --mail-type=END,FAIL

# Load necessary modules
module load Exonerate/2.4.0-GCC-12.2.0

# Change to working directory
cd /scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV

# Define input files
QUERY_FASTA="Sb-vs-SB_CNV_genes_Sinv.fasta"
TARGET_FASTA="GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna"

# Function to extract gene sequences
extract_genes() {
    awk '/^>/ {OUT=substr($0,2) ".fasta"}; {print >> OUT; close(OUT)}' $QUERY_FASTA
}

# Extract gene sequences into individual files
extract_genes

# Iterate over each gene fasta file and run exonerate
for gene_file in *.fasta; do
    gene_name=$(basename "$gene_file" .fasta)
    OUTPUT_FILE="${gene_name}_exonerate_output.txt"
    exonerate --model est2genome --showtargetgff --showalignment --showvulgar --bestn 5 \
    --query "$gene_file" --target $TARGET_FASTA --verbose 1 > "$OUTPUT_FILE"
    echo "Exonerate alignment for $gene_name completed. Results are saved in $OUTPUT_FILE"
done
