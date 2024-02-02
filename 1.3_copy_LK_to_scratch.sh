#!/bin/bash
#SBATCH --job-name=1.3_cp_proj_scratch_LK                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=48:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/home/ahw22099/Alignment_to_UNIL_3.4/1.3_cp_proj_scratch_LK.log.%j			    #Standard output
#SBATCH --error=/home/ahw22099/Alignment_to_UNIL_3.4/1.3_cp_proj_scratch_LK.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

#### 3 ####
#scp ahw22099@xfer.gacrc.uga.edu:/project/bghlab/LK_RNAseq_reformatted_dir/LK_RNAseq_reformatted.tar.gz\
#/scratch/ahw22099/UNIL_3.4_Alignment/

# tar -zxvf /scratch/ahw22099/UNIL_3.4_Alignment/LK_RNAseq_reformatted_dir/LK_RNAseq_reformatted.tar.gz\
# /scratch/ahw22099/UNIL_3.4_Alignment/

LK_raw_fq="/scratch/ahw22099/UNIL_3.4_Alignment/LK_raw_fq"
if [ ! -d $LK_raw_fq ]
then
mkdir -p $LK_raw_fq
fi

fq_ids="B_mBB_1.R1.fastq.gz \
B_mBB_1.R2.fastq.gz \
B_mBB_2.R1.fastq.gz \
B_mBB_2.R2.fastq.gz \
B_mBB_3.R1.fastq.gz \
B_mBB_3.R2.fastq.gz \
B_mBB_4.R1.fastq.gz \
B_mBB_4.R2.fastq.gz \
B_mBB_5_merge.R1.fastq.gz \
B_mBB_5_merge.R2.fastq.gz \
B_mBB_6_merge.R1.fastq.gz \
B_mBB_6_merge.R2.fastq.gz \
B_mBB_7.R1.fastq.gz \
B_mBB_7.R2.fastq.gz \
B_mpBB_10.R1.fastq.gz \
B_mpBB_10.R2.fastq.gz \
B_mpBB_11_merge.R1.fastq.gz \
B_mpBB_11_merge.R2.fastq.gz \
B_mpBB_12.R1.fastq.gz \
B_mpBB_12.R2.fastq.gz \
B_mpBB_13_merge.R1.fastq.gz \
B_mpBB_13_merge.R2.fastq.gz \
B_mpBB_14_merge.R1.fastq.gz \
B_mpBB_14_merge.R2.fastq.gz \
B_mpBB_15.R1.fastq.gz \
B_mpBB_15.R2.fastq.gz \
B_mpBB_16.R1.fastq.gz \
B_mpBB_16.R2.fastq.gz \
B_pBB_1.R1.fastq.gz \
B_pBB_1.R2.fastq.gz \
B_pBB_2.R1.fastq.gz \
B_pBB_2.R2.fastq.gz \
B_pBB_3.R1.fastq.gz \
B_pBB_3.R2.fastq.gz \
B_pBB_4.R1.fastq.gz \
B_pBB_4.R2.fastq.gz \
B_pBB_5_merge.R1.fastq.gz \
B_pBB_5_merge.R2.fastq.gz \
B_pBB_6_merge.R1.fastq.gz \
B_pBB_6_merge.R2.fastq.gz \
B_pBB_7_merge.R1.fastq.gz \
B_pBB_7_merge.R2.fastq.gz \
B_pBL_1.R1.fastq.gz \
B_pBL_1.R2.fastq.gz \
B_pBL_2.R1.fastq.gz \
B_pBL_2.R2.fastq.gz \
B_pBL_3.R1.fastq.gz \
B_pBL_3.R2.fastq.gz \
B_pBL_4.R1.fastq.gz \
B_pBL_4.R2.fastq.gz \
B_pBL_5.R1.fastq.gz \
B_pBL_5.R2.fastq.gz \
B_pBL_6_merge.R1.fastq.gz \
B_pBL_6_merge.R2.fastq.gz \
B_pBL_7_merge.R1.fastq.gz \
B_pBL_7_merge.R2.fastq.gz \
G_mBB_1.R1.fastq.gz \
G_mBB_1.R2.fastq.gz \
G_mBB_3.R1.fastq.gz \
G_mBB_3.R2.fastq.gz \
G_mBB_5.R1.fastq.gz \
G_mBB_5.R2.fastq.gz \
G_mBB_6.R1.fastq.gz \
G_mBB_6.R2.fastq.gz \
G_mBB_7.R1.fastq.gz \
G_mBB_7.R2.fastq.gz \
G_mBB_8.R1.fastq.gz \
G_mBB_8.R2.fastq.gz \
G_mpBB_10.R1.fastq.gz \
G_mpBB_10.R2.fastq.gz \
G_mpBB_11.R1.fastq.gz \
G_mpBB_11.R2.fastq.gz \
G_mpBB_13.R1.fastq.gz \
G_mpBB_13.R2.fastq.gz \
G_mpBB_14.R1.fastq.gz \
G_mpBB_14.R2.fastq.gz \
G_mpBB_15.R1.fastq.gz \
G_mpBB_15.R2.fastq.gz \
G_mpBB_17.R1.fastq.gz \
G_mpBB_17.R2.fastq.gz \
G_pBB_1.R1.fastq.gz \
G_pBB_1.R2.fastq.gz \
G_pBB_3.R1.fastq.gz \
G_pBB_3.R2.fastq.gz \
G_pBB_5.R1.fastq.gz \
G_pBB_5.R2.fastq.gz \
G_pBB_6.R1.fastq.gz \
G_pBB_6.R2.fastq.gz \
G_pBB_7.R1.fastq.gz \
G_pBB_7.R2.fastq.gz \
G_pBB_8.R1.fastq.gz \
G_pBB_8.R2.fastq.gz \
G_pBL_1.R1.fastq.gz \
G_pBL_1.R2.fastq.gz \
G_pBL_3.R1.fastq.gz \
G_pBL_3.R2.fastq.gz \
G_pBL_5.R1.fastq.gz \
G_pBL_5.R2.fastq.gz \
G_pBL_6.R1.fastq.gz \
G_pBL_6.R2.fastq.gz \
G_pBL_7.R1.fastq.gz \
G_pBL_7.R2.fastq.gz \
G_pBL_8.R1.fastq.gz \
G_pBL_8.R2.fastq.gz"

cd /scratch/ahw22099/UNIL_3.4_Alignment/LK_RNAseq_reformatted
cp $fq_ids /scratch/ahw22099/UNIL_3.4_Alignment/LK_raw_fq
