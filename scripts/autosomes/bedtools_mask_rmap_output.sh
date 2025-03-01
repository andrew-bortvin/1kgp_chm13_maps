inFile=$(sed "${SLURM_ARRAY_TASK_ID}q;d" <<<`ls opt_params_masked`)
prefix=`cut -f1 -d'.' <<<${inFile}`
chromosome=`cut -f2 -d'_' <<<${prefix} | cut -f2 -d'r'`
chr="chr${chromosome}"

awk -F '\t' -v OFS='\t' -v chrom=${chr} '{ print chrom,$1,$2,$3,$4 }' opt_params_masked/${inFile} | sed 's/[[:space:]]*$//' > opt_params_masked_bed/${prefix}.bed

bedtools intersect -a opt_params_masked_bed/${prefix}.bed -b combined_mask.bed.gz > opt_params_masked_masked/${prefix}_masked.rmap
