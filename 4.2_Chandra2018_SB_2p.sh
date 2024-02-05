#!/bin/bash
#SBATCH --job-name=4.2_Chandra2018_SB_2p.sh                                 #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=4			                                            #Single task job
#SBATCH --cpus-per-task=12                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=24:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/4.2_AK2020_SB_2p.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/4.2_AK2020_SB_2p.err.%j		    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL,ARRAY_TASKS                                       #Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --array=0-19

################## STAR ##################
module load STAR/2.7.10b-GCC-11.3.0
########### SB ############


Chandra2018_trimmed_fq="/scratch/ahw22099/FireAnt_GRN/Chandra2018_trimmed_fq"
if [ ! -d $Chandra2018_trimmed_fq ]
then
mkdir -p $Chandra2018_trimmed_fq
fi

STAR_genome_SB="/scratch/ahw22099/FireAnt_GRN/STAR_genome_SB"
if [ ! -d $STAR_genome_SB ]
then
mkdir -p $STAR_genome_SB
fi

SB_genome="/scratch/ahw22099/FireAnt_GRN/UNIL_Sinv_3.4_SB"
if [ ! -d $SB_genome ]
then
mkdir -p $SB_genome
fi

##1st pass
Chandra2018_STAR_SB="/scratch/ahw22099/FireAnt_GRN/Chandra2018_STAR_SB"
if [ ! -d $Chandra2018_STAR_SB ]
then
mkdir -p $Chandra2018_STAR_SB
fi

FirstPass_SB="/scratch/ahw22099/FireAnt_GRN/Chandra2018_STAR_SB/1p_out"
if [ ! -d $FirstPass_SB ]
then
mkdir -p $FirstPass_SB
fi


cd $Chandra2018_trimmed_fq

#make sample list for array job
R_sample_list=($(<Chandra2018_trimmed_input_list.txt))
R=${R_sample_list[${SLURM_ARRAY_TASK_ID}]}

echo $R

base=`basename "$R" _raw_trimmed.fq.gz`

SecondPass_SB="/scratch/ahw22099/FireAnt_GRN/Chandra2018_STAR_SB/2p_out"
if [ ! -d $SecondPass_SB ]
then
mkdir -p $SecondPass_SB
fi

STAR \
--readFilesCommand zcat \
--runThreadN 8 \
--quantMode GeneCounts \
--genomeDir $STAR_genome_SB \
--readFilesIn $R \
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
--sjdbFileChrStartEnd $FirstPass_SB/SRR7209532.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209533.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209534.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209535.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209536.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209537.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209538.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209539.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209540.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209541.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209542.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209543.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209544.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209545.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209546.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209547.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209548.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209549.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209550.SB1pass.SJ.out.tab \
$FirstPass_SB/SRR7209551.SB1pass.SJ.out.tab 
