#!/bin/bash
#SBATCH --time=2:00:00                     
#SBATCH --nodes=1                          
#SBATCH --cpus-per-task=24                 
#SBATCH --partition=defq                    
#SBATCH --account=mschatz1

ml bedtools
ml htslib

pop_number=${SLURM_ARRAY_TASK_ID}

pop_info=$(sed "${pop_number}q;d" make_table_pop_sizes.txt)
pop=`cut -f1 -d' '<<<${pop_info}`

bedtools intersect -a chrX_vcfs/${pop}_chrX.vcf.gz -b combined_mask.bed.gz -header | bgzip -c > chrX_vcfs_masked/${pop}_chrX_masked.vcf.gz --threads 24
