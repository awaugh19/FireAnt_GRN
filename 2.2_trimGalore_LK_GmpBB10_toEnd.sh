#!/bin/bash
#SBATCH --job-name=2.2_trimGalore_LK_GmpBB10_toEnd                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=72:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/home/ahw22099/Alignment_to_UNIL_3.4/2.2_trimGalore_LK_GmpBB10_toEnd.log.%j			    #Standard output
#SBATCH --error=/home/ahw22099/Alignment_to_UNIL_3.4/2.2_trimGalore_LK_GmpBB10_toEnd.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

# RAW fq directiories
LK_raw_fq="/scratch/ahw22099/UNIL_3.4_Alignment/LK_raw_fq"
if [ ! -d $LK_raw_fq ]
then
mkdir -p $LK_raw_fq
fi

# trimmed_fq directories (for output)
LK_trimmed_fq="/scratch/ahw22099/UNIL_3.4_Alignment/LK_trimmed_fq"
if [ ! -d $LK_trimmed_fq ]
then
mkdir -p $LK_trimmed_fq
fi

############################# TRIM GALORE ######################################
module load Trim_Galore/0.6.7-GCCcore-11.2.0

################ use trimGalore

#### LK
cd $LK_raw_fq
for base in \
B_mBB_1 \
B_mBB_2 \
B_mBB_3 \
B_mBB_4 \
B_mBB_5_merge \
B_mBB_6_merge \
B_mBB_7 \
G_mBB_1 \
G_mBB_3 \
G_mBB_5 \
G_mBB_6 \
G_mBB_7 \
G_mBB_8 \
B_pBB_1 \
B_pBB_2 \
B_pBB_3 \
B_pBB_4 \
B_pBB_5_merge \
B_pBB_6_merge \
B_pBB_7_merge \
G_pBB_1 \
G_pBB_3 \
G_pBB_5 \
G_pBB_6 \
G_pBB_7 \
G_pBB_8 \
B_pBL_1 \
B_pBL_2 \
B_pBL_3 \
B_pBL_4 \
B_pBL_5 \
B_pBL_6_merge \
B_pBL_7_merge \
G_pBL_1 \
G_pBL_3 \
G_pBL_5 \
G_pBL_6 \
G_pBL_7 \
G_pBL_8 \
B_mpBB_10 \
B_mpBB_11 \
B_mpBB_12 \
B_mpBB_13 \
B_mpBB_14 \
B_mpBB_15 \
B_mpBB_16 \
G_mpBB_10 \
G_mpBB_11 \
G_mpBB_13 \
G_mpBB_14 \
G_mpBB_15 \
G_mpBB_17
do
  R1=$LK_raw_fq/${base}.R1.fastq.gz
  R2=$LK_raw_fq/${base}.R2.fastq.gz
  trim_galore --fastqc --paired -o "$LK_trimmed_fq" "$R1" "$R2"
done

############################# MULTIQC ##########################################
module load MultiQC/1.14-foss-2022a
multiqc "$LK_trimmed_fq"
############################# END ##############################################
