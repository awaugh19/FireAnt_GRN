#!/bin/bash
#SBATCH --job-name=2.1.2_trimGalore_LK                                 #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=48:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/2.1.2_trimGalore_LK.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/2.1.2_trimGalore_LK.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --array=0-52
# RAW fq directiories
LK_raw_fq="/scratch/ahw22099/FireAnt_GRN/LK_raw_fq"
if [ ! -d $LK_raw_fq ]
then
mkdir -p $LK_raw_fq
fi

# trimmed_fq directories (for output)
LK_trimmed_fq="/scratch/ahw22099/FireAnt_GRN/LK_trimmed_fq"
if [ ! -d $LK_trimmed_fq ]
then
mkdir -p $LK_trimmed_fq
fi

############################# TRIM GALORE ######################################
module load Trim_Galore/0.6.7-GCCcore-11.2.0

cd /scratch/ahw22099/FireAnt_GRN/LK_raw_fq

R1_sample_list=($(<LK_raw_input_list_1.txt))
R2_sample_list=($(<LK_raw_input_list_2.txt))
R1=${R1_sample_list[${SLURM_ARRAY_TASK_ID}]}
R2=${R2_sample_list[${SLURM_ARRAY_TASK_ID}]}

################ use trimGalore
trim_galore --fastqc --paired -o "$LK_trimmed_fq" "$R1" "$R2"


module load MultiQC/1.14-foss-2022a
#generate multiqc report on outputted files in trimmed fq dir
multiqc "$LK_trimmed_fq"
############################# END ##############################################
