#!/bin/bash
#SBATCH --job-name=gmap_AK2020.sh                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=4			                                            #Single task job
#SBATCH --cpus-per-task=12                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=24:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/gmap_AK2020.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/gmap_AK2020.err.%j		    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL,ARRAY_TASKS                                       #Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --array=0-63

# Load necessary modules
module load GMAP-GSNAP/2023-02-17-GCC-11.3.0

#
ArsenaultKing2020_trimmed_fq="/scratch/ahw22099/FireAnt_GRN/ArsenaultKing2020_trimmed_fq"
if [ ! -d $ArsenaultKing2020_trimmed_fq ]
then
mkdir -p $ArsenaultKing2020_trimmed_fq
fi

gmap_genome_SB="/scratch/ahw22099/FireAnt_GRN/gmap_genome_SB"
if [ ! -d $gmap_genome_SB ]
then
mkdir -p $gmap_genome_SB
fi

SB_genome="/scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB"
if [ ! -d $SB_genome ]
then
mkdir -p $SB_genome
fi

cd $ArsenaultKing2020_trimmed_fq

#make sample list for array job
R_sample_list=($(<AK2020_trimmed_input_list.txt))
R=${R_sample_list[${SLURM_ARRAY_TASK_ID}]}

echo $R

base=`basename "$R" _raw_trimmed.fq.gz`

# Run GMAP-GSNAP
gmap_build -d $SB_genome $SB_genome/GCF_016802725.1_UNIL_Sinv_3.0_genomic.fna
gsnap -d $SB_genome -A sam $R > "$base".gmap.sam
