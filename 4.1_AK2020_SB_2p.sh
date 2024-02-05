#!/bin/bash
#SBATCH --job-name=4.1_AK2020_SB_2p.sh                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=4			                                            #Single task job
#SBATCH --cpus-per-task=12                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=24:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/4.1_AK2020_SB_2p.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/4.1_AK2020_SB_2p.err.%j		    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL,ARRAY_TASKS                                       #Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --array=0-63

################## STAR ##################
module load STAR/2.7.10b-GCC-11.3.0
########### SB ############


ArsenaultKing2020_trimmed_fq="/scratch/ahw22099/FireAnt_GRN/ArsenaultKing2020_trimmed_fq"
if [ ! -d $ArsenaultKing2020_trimmed_fq ]
then
mkdir -p $ArsenaultKing2020_trimmed_fq
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
ArsenaultKing2020_STAR_SB="/scratch/ahw22099/FireAnt_GRN/ArsenaultKing2020_STAR_SB"
if [ ! -d $LK_STAR_SB ]
then
mkdir -p $LK_STAR_SB
fi

FirstPass_SB="/scratch/ahw22099/FireAnt_GRN/ArsenaultKing2020_STAR_SB/1p_out"
if [ ! -d $FirstPass_SB ]
then
mkdir -p $FirstPass_SB
fi


cd $ArsenaultKing2020_trimmed_fq

#make sample list for array job
R_sample_list=($(<AK2020_trimmed_input_list.txt))
R=${R_sample_list[${SLURM_ARRAY_TASK_ID}]}

echo $R

base=`basename "$R" _raw_trimmed.fq.gz`

SecondPass_SB="/scratch/ahw22099/FireAnt_GRN/ArsenaultKing2020_STAR_SB/2p_out"
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
--sjdbFileChrStartEnd \
$FirstPass_SB/104AB.SB1pass.SJ.out.tab \
$FirstPass_SB/104AO.SB1pass.SJ.out.tab \
$FirstPass_SB/104DB.SB1pass.SJ.out.tab \
$FirstPass_SB/104DO.SB1pass.SJ.out.tab \
$FirstPass_SB/104GB.SB1pass.SJ.out.tab \
$FirstPass_SB/104GO.SB1pass.SJ.out.tab \
$FirstPass_SB/107AB.SB1pass.SJ.out.tab \
$FirstPass_SB/107AO.SB1pass.SJ.out.tab \
$FirstPass_SB/107EB.SB1pass.SJ.out.tab \
$FirstPass_SB/107EO.SB1pass.SJ.out.tab \
$FirstPass_SB/107GB.SB1pass.SJ.out.tab \
$FirstPass_SB/107GO.SB1pass.SJ.out.tab \
$FirstPass_SB/15AB.SB1pass.SJ.out.tab \
$FirstPass_SB/15AO.SB1pass.SJ.out.tab \
$FirstPass_SB/15DB.SB1pass.SJ.out.tab \
$FirstPass_SB/15DO.SB1pass.SJ.out.tab \
$FirstPass_SB/15GB.SB1pass.SJ.out.tab \
$FirstPass_SB/15GO.SB1pass.SJ.out.tab \
$FirstPass_SB/16CB.SB1pass.SJ.out.tab \
$FirstPass_SB/16CO.SB1pass.SJ.out.tab \
$FirstPass_SB/16DB.SB1pass.SJ.out.tab \
$FirstPass_SB/16DO.SB1pass.SJ.out.tab \
$FirstPass_SB/16GB.SB1pass.SJ.out.tab \
$FirstPass_SB/16GO.SB1pass.SJ.out.tab \
$FirstPass_SB/19AB.SB1pass.SJ.out.tab \
$FirstPass_SB/19AO.SB1pass.SJ.out.tab \
$FirstPass_SB/19DB.SB1pass.SJ.out.tab \
$FirstPass_SB/19DO.SB1pass.SJ.out.tab \
$FirstPass_SB/19GB.SB1pass.SJ.out.tab \
$FirstPass_SB/19GO.SB1pass.SJ.out.tab \
$FirstPass_SB/1EB_merge_trimmed.fq.gz.SB1pass.SJ.out.tab \
$FirstPass_SB/1EO.SB1pass.SJ.out.tab \
$FirstPass_SB/207AB.SB1pass.SJ.out.tab \
$FirstPass_SB/207AO.SB1pass.SJ.out.tab \
$FirstPass_SB/209AB.SB1pass.SJ.out.tab \
$FirstPass_SB/209AO.SB1pass.SJ.out.tab \
$FirstPass_SB/20AB.SB1pass.SJ.out.tab \
$FirstPass_SB/20AO.SB1pass.SJ.out.tab \
$FirstPass_SB/20DB.SB1pass.SJ.out.tab \
$FirstPass_SB/20DO.SB1pass.SJ.out.tab \
$FirstPass_SB/20IB.SB1pass.SJ.out.tab \
$FirstPass_SB/20IO.SB1pass.SJ.out.tab \
$FirstPass_SB/222AB.SB1pass.SJ.out.tab \
$FirstPass_SB/222AO.SB1pass.SJ.out.tab \
$FirstPass_SB/232AB.SB1pass.SJ.out.tab \
$FirstPass_SB/232AO.SB1pass.SJ.out.tab \
$FirstPass_SB/233AB.SB1pass.SJ.out.tab \
$FirstPass_SB/233AO.SB1pass.SJ.out.tab \
$FirstPass_SB/235AB.SB1pass.SJ.out.tab \
$FirstPass_SB/235AO.SB1pass.SJ.out.tab \
$FirstPass_SB/239AB_merge_trimmed.fq.gz.SB1pass.SJ.out.tab \
$FirstPass_SB/239AO.SB1pass.SJ.out.tab \
$FirstPass_SB/240AB.SB1pass.SJ.out.tab \
$FirstPass_SB/240AO.SB1pass.SJ.out.tab \
$FirstPass_SB/30AB.SB1pass.SJ.out.tab \
$FirstPass_SB/30AO.SB1pass.SJ.out.tab \
$FirstPass_SB/30EB.SB1pass.SJ.out.tab \
$FirstPass_SB/30EO.SB1pass.SJ.out.tab \
$FirstPass_SB/30GB.SB1pass.SJ.out.tab \
$FirstPass_SB/30GO.SB1pass.SJ.out.tab \
$FirstPass_SB/5AB.SB1pass.SJ.out.tab \
$FirstPass_SB/5AO.SB1pass.SJ.out.tab \
$FirstPass_SB/5GB.SB1pass.SJ.out.tab \
$FirstPass_SB/5GO.SB1pass.SJ.out.tab
#
