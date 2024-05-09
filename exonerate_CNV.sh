#!/bin/bash
#SBATCH --job-name=exonerate_CNV.sh
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

cd /scratch/ahw22099/FireAnt_GRN/Fontana2020_CNV
# Define input files
QUERY_FASTA="Sb-vs-SB_CNV_genes_Sinv.fasta"
TARGET_FASTA="GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna"
OUTPUT_FILE="exonerate_output.txt"

# Run exonerate
exonerate --model est2genome --showtargetgff --showalignment --showvulgar --bestn 1 --query $QUERY_FASTA --target $TARGET_FASTA > $OUTPUT_FILE

# Print completion message
echo "Exonerate alignment completed. Results are saved in $OUTPUT_FILE"
