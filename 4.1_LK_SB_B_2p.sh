#!/bin/bash
#SBATCH --job-name=LK_SB_B_mBB_2p.sh                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=32gb			                                            #Total memory for job
#SBATCH --time=96:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/home/ahw22099/Alignment_to_UNIL_3.4/LK_SB_B_mBB_2p.log.%j			    #Standard output
#SBATCH --error=/home/ahw22099/Alignment_to_UNIL_3.4/LK_SB_B_mBB_2p.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)


LK_trimmed_fq="/scratch/ahw22099/UNIL_3.4_Alignment/LK_trimmed_fq"
if [ ! -d $LK_trimmed_fq ]
then
mkdir -p $LK_trimmed_fq
fi

STAR_genome_SB="/scratch/ahw22099/UNIL_3.4_Alignment/LK_STAR_genome_SB"
if [ ! -d $STAR_genome_SB ]
then
mkdir -p $STAR_genome_SB
fi


SB_genome="/scratch/ahw22099/UNIL_3.4_Alignment/UNIL_Sinv_3.4_SB"
if [ ! -d $SB_genome ]
then
mkdir -p $SB_genome
fi

################## STAR ##################
module load STAR/2.7.10b-GCC-11.3.0

##2nd pass
LK_STAR_SB="/scratch/ahw22099/UNIL_3.4_Alignment/LK_STAR_SB"
if [ ! -d $STAR_SB ]
then
mkdir -p $STAR_SB
fi

FirstPass_SB="/scratch/ahw22099/UNIL_3.4_Alignment/LK_STAR_SB/1p_out"

SecondPass_SB="/scratch/ahw22099/UNIL_3.4_Alignment/LK_STAR_SB/2p_out"
if [ ! -d $SecondPass_SB ]
then
mkdir -p $SecondPass_SB
fi

cd $LK_trimmed_fq
for base in \
B_mBB_1 \
B_mBB_2 \
B_mBB_3 \
B_mBB_4 \
B_mBB_5_merge \
B_mBB_6_merge \
B_mBB_7

do
  R1=$LK_trimmed_fq/${base}.R1_val_1.fq.gz
  R2=$LK_trimmed_fq/${base}.R2_val_2.fq.gz

STAR \
--readFilesCommand zcat \
--runThreadN 8 \
--quantMode GeneCounts \
--genomeDir $STAR_genome_SB \
--readFilesIn $R1 $R2 \
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNoverLmax 0.05 \
--alignIntronMin 20 \
--alignIntronMax 1000000 \
--genomeLoad NoSharedMemory \
--outSAMtype BAM SortedByCoordinate \
--outSAMstrandField intronMotif \
--outSAMattrIHstart 0 \
--outFileNamePrefix $SecondPass_SB/"$base".SB2pass. \
--limitBAMsortRAM 30000000000 \
--sjdbFileChrStartEnd \
$FirstPass_SB/B_mBB_1.SB1pass.SJ.out.tab \
$FirstPass_SB/B_mBB_2.SB1pass.SJ.out.tab \
$FirstPass_SB/B_mBB_3.SB1pass.SJ.out.tab \
$FirstPass_SB/B_mBB_4.SB1pass.SJ.out.tab \
$FirstPass_SB/B_mBB_5_merge.SB1pass.SJ.out.tab \
$FirstPass_SB/B_mBB_6_merge.SB1pass.SJ.out.tab \
$FirstPass_SB/B_mBB_7.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBB_1.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBB_2.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBB_3.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBB_4.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBB_5_merge.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBB_6_merge.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBB_7_merge.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBL_1.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBL_2.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBL_3.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBL_4.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBL_5.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBL_6_merge.SB1pass.SJ.out.tab \
$FirstPass_SB/B_pBL_7_merge.SB1pass.SJ.out.tab \
$FirstPass_SB/G_mBB_1.SB1pass.SJ.out.tab \
$FirstPass_SB/G_mBB_3.SB1pass.SJ.out.tab \
$FirstPass_SB/G_mBB_5.SB1pass.SJ.out.tab \
$FirstPass_SB/G_mBB_6.SB1pass.SJ.out.tab \
$FirstPass_SB/G_mBB_7.SB1pass.SJ.out.tab \
$FirstPass_SB/G_mBB_8.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBB_1.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBB_3.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBB_5.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBB_6.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBB_7.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBB_8.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBL_1.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBL_3.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBL_5.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBL_6.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBL_7.SB1pass.SJ.out.tab \
$FirstPass_SB/G_pBL_8.SB1pass.SJ.out.tab
done
