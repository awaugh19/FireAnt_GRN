#!/bin/bash
#SBATCH --job-name=1.2_dwnload_Chandra2018_SRA                                  #Job name
#SBATCH --partition=batch		                                        #Partition (queue) name
#SBATCH --ntasks=1			                                            #Single task job
#SBATCH --cpus-per-task=8	                                          #Number of cores per task
#SBATCH --mem=24gb			                                            #Total memory for job
#SBATCH --time=48:00:00  		                                        #Time limit hrs:min:sec
#SBATCH --output=/scratch/ahw22099/FireAnt_GRN/std_out/1.2_dwnload_Chandra2018_SRA.log.%j			    #Standard output
#SBATCH --error=/scratch/ahw22099/FireAnt_GRN/std_out/1.2_dwnload_Chandra2018_SRA.err.%j			    #Standard error log
#SBATCH --mail-user=ahw22099@uga.edu                                #Where to send mail -
#SBATCH --mail-type=END,FAIL                                        #Mail events (BEGIN, END, FAIL, ALL)

### 2 ### download Chandra2018 worker data
module load SRA-Toolkit/3.0.1-centos_linux64

sra_ids="SRR7209532 SRR7209533 SRR7209534 \
SRR7209535 SRR7209536 SRR7209537 \
SRR7209538 SRR7209539 SRR7209540 \
SRR7209541 SRR7209542 SRR7209543 \
SRR7209544 SRR7209545 SRR7209546 \
SRR7209547 SRR7209548 SRR7209549 \
SRR7209550 SRR7209551"

Chandra2018_raw_fq="/scratch/ahw22099/FireAnt_GRN/Chandra2018_raw_fq"
mkdir -p $Chandra2018_raw_fq

# use sratools to download SRRX .fq from BioProject
for sra_id in ${sra_ids}; do
fastq-dump --gzip ${sra_id} --outdir $Chandra2018_raw_fq
done

# rename X.fastq.gz --> X.fq.gz
for file in *.fastq.gz
do mv -- "$file" "${file%.fastq.gz}.fq.gz"
done
