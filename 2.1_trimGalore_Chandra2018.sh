#!/bin/bash
#SBATCH --job-name=2.1_trimGalore_Chandra2018                                 #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=24:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/2.1_trimGalore_Chandra2018.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/2.1_trimGalore_Chandra2018.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

# RAW fq directiories
Chandra2018_raw_fq="/scratch/ahw22099/FireAnt_GRN/Chandra2018_raw_fq"
if [ ! -d $Chandra2018_raw_fq ]
then
mkdir -p $Chandra2018_raw_fq
fi

Chandra2018_trimmed_fq="/scratch/ahw22099/FireAnt_GRN/Chandra2018_trimmed_fq"
if [ ! -d $Chandra2018_trimmed_fq ]
then
mkdir -p $Chandra2018_trimmed_fq
fi

############################# TRIM GALORE ######################################
module load Trim_Galore/0.6.7-GCCcore-11.2.0

################ use trimGalore

#### ARSENAULT & KING ET AL 2020
# files downloaded using fastq-dump from SRA-Toolkit
for file in "$Chandra2018_raw_fq"/*.gz
do
trim_galore --fastqc "$file" -o "$Chandra2018_trimmed_fq"
done



############################# MULTIQC ##########################################
module load multiqc/1.11-GCCcore-8.3.0-Python-3.8.2
#generate multiqc report on outputted files in trimmed fq dir
multiqc "$Chandra2018_trimmed_fq"
############################# END ##############################################
