pop_number=${SLURM_ARRAY_TASK_ID}

pop_info=$(sed "${pop_number}q;d" make_table_pop_sizes.txt)
pop=`cut -f1 -d' '<<<${pop_info}`

bedtools intersect -a chrX_vcfs_masked/${pop}_chrX_masked.vcf.gz -b chm13v2.0_PAR.bed -header | bgzip -c > chrX_PAR/${pop}_chrX_PAR_masked.vcf.gz --threads 24
