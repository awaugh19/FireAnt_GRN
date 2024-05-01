#!/bin/bash
#SBATCH --job-name=gmap_AK2020.sh
#SBATCH --partition=batch
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=12
#SBATCH --mem=24gb
#SBATCH --time=24:00:00
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/gmap_AK2020.log.%j
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/gmap_AK2020.err.%j
#SBATCH --mail-user=ahw22099@uga.edu
#SBATCH --mail-type=END,FAIL,ARRAY_TASKS
#SBATCH --array=0-63

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

# Define input file list
R_sample_list=($(<AK2020_trimmed_input_list.txt))
R=${R_sample_list[${SLURM_ARRAY_TASK_ID}]}

echo "Input file: $R"

# Run GSNAP
base=$(basename "$R" _raw_trimmed.fq.gz)
echo "Base name: $base"

echo "Aligning reads using GSNAP..."
gsnap -d UNIL_Sinv_3.4_SB -A sam --gunzip $R > "$base".gmap.sam

echo "Job completed."
