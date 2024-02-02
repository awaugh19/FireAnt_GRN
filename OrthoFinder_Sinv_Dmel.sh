#!/bin/bash
#SBATCH --job-name=OrthoFinder_Sinv_Dmel.sh                                 #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=4			                                            #Single task job
#SBATCH --cpus-per-task=12                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=24:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/OrthoFinder_Sinv_Dmel.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/OrthoFinder_Sinv_Dmel.err.%j		    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL,ARRAY_TASKS                                       #Mail events (BEGIN, END, FAIL, ALL)

module load OrthoFinder/2.5.4-foss-2022a

proteomes="/scratch/ahw22099/FireAnt_GRN/proteomes"
if [ ! -d $proteomes ]
then
mkdir -p $proteomes
fi


for f in *.faa

do python3 $proteomes/primary_transcript.py $f

done

orthofinder -f $proteomes/primary_transcripts/ -t 12
