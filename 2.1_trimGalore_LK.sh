#!/bin/bash
#SBATCH --job-name=2.1_trimGalore_LK                                 #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=48:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/2.1_trimGalore_LK.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/2.1_trimGalore_LK.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

# RAW fq directiories
LK_raw_fq="/scratch/ahw22099/FireAnt_GRN/LK_raw_fq"
if [ ! -d $LK_raw_fq ]
then
mkdir -p $LK_raw_fq
fi

# trimmed_fq directories (for output)
LK_trimmed_fq="/scratch/ahw22099/FireAnt_GRçcdN/LK_trimmed_fq"
if [ ! -d $LK_trimmed_fq ]
then
mkdir -p $LK_trimmed_fq
fi

############################# TRIM GALORE ######################################
module load Trim_Galore/0.6.7-GCCcore-11.2.0

################ use trimGalore

#### LK
# files copied from project directory (LK_RNAseq_reformatted)
for file in "$LK_raw_fq"/*.gz
do
trim_galore --fastqc "$file" -o "$LK_trimmed_fq"
done

############################# MULTIQC ##########################################
module load multiqc/1.11-GCCcore-8.3.0-Python-3.8.2
#generate multiqc report on outputted files in trimmed fq dir
multiqc "$LK_trimmed_fq"
############################# END ##############################################
