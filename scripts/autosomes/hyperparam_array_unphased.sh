#!/bin/bash
#SBATCH --time=18:00:00                     
#SBATCH --nodes=1                          
#SBATCH --cpus-per-task=48                  
#SBATCH --partition=bigmem
#SBATCH -A mschatz1_bigmem

ml anaconda 
conda activate my-pyrho-env

pop_info=$(sed "${SLURM_ARRAY_TASK_ID}q;d" make_table_pop_sizes.txt)
pop=`cut -f1 -d' '<<<${pop_info}`
n=`cut -f2 -d' '<<<${pop_info}`


pyrho hyperparam --samplesize ${n} --tablefile ~/scr16_rmccoy22/abortvi2/pyrho_1kgp_chm13_array/lookup_tables/${pop}_lookuptable.hdf \
--mu 1.25e-8 --logfile logs/hyperparam/${pop}_hyperparam.log --ploidy 2 \
--smcpp_file ~/scr16_rmccoy22/abortvi2/pyrho_1kgp_chm13_array/smcpp_popsizes_1kg/${pop}_pop_sizes.csv --outfile hyperparam_results/${pop}_hyperparam_results.txt \
--numthreads 48
