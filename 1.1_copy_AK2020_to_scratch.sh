#!/bin/bash
#SBATCH --job-name=1.1_cp_proj_scratch_AK2020                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=48:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/1.1_cp_proj_scratch_AK2020.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/1.1_cp_proj_scratch_AK2020.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

### 1 ### move AK2020 data from project to scratch
scratch_dir="/scratch/ahw22099/FireAnt_GRN/ArsenaultKing2020_raw_fq"
if [ ! -d $ArsenaultKing2020_raw_fq ]
then
mkdir -p $ArsenaultKing2020_raw_fq
fi

scp -r ahw22099@xfer.gacrc.uga.edu:/project/bghlab/Sinv_RNA/Data_for_Deposition $scratch_dir
