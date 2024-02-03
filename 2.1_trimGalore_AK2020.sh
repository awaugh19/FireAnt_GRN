#!/bin/bash
#SBATCH --job-name=2.1_trimGalore_AK2020                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=24:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/2.1_trimGalore_AK2020.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/2.1_trimGalore_AK2020.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)


ArsenaultKing2020_raw_fq="/scratch/ahw22099/FireAnt_GRN/ArsenaultKing2020_raw_fq"
if [ ! -d $ArsenaultKing2020_raw_fq ]
then
mkdir -p $ArsenaultKing2020_raw_fq
fi


# trimmed_fq directories (for output)
ArsenaultKing2020_trimmed_fq="/scratch/ahw22099/FireAnt_GRN/ArsenaultKing2020_trimmed_fq"
if [ ! -d $ArsenaultKing2020_trimmed_fq ]
then
mkdir -p $ArsenaultKing2020_trimmed_fq
fi

############################# TRIM GALORE ######################################
module load Trim_Galore/0.6.7-GCCcore-11.2.0

################ use trimGalore

#### ARSENAULT & KING ET AL 2020
# files copied from project directory (Data_for_Deposition)
for file in "$ArsenaultKing2020_raw_fq"/*.gz
do
trim_galore --fastqc "$file" -o "$ArsenaultKing2020_trimmed_fq"
done

############################# MULTIQC ##########################################
module load multiqc/1.11-GCCcore-8.3.0-Python-3.8.2
#generate multiqc report on outputted files in trimmed fq dir
multiqc "$ArsenaultKing2020_trimmed_fq"
############################# END ##############################################
