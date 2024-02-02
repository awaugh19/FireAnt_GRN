#!/bin/bash
#SBATCH --job-name=1.3_cp_proj_scratch_LK                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=24:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/1.3_cp_proj_scratch_LK.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/1.3_cp_proj_scratch_LK.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

#### 3 ####
scp ahw22099@xfer.gacrc.uga.edu:/project/bghlab/LK_RNAseq_reformatted_dir/LK_RNAseq_reformatted.tar.gz /scratch/ahw22099/FireAnt_GRN/

# manually move the .fastq.gz files inside the tarball to /scratch/ahw22099/FireAnt_GRN/LK_raw_fq
