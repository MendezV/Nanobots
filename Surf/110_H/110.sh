#!/bin/bash
#SBATCH --partition=nodes
#SBATCH --job-name=110_H_solv
#SBATCH --output=110_H_%a.txt
#SBATCH --array=1-2
#SBATCH --export=surface=110
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12


declare -a commands

commands[1]="/home/jfm343/JDFTXDIR/build/jdftx -i Vacuum.in | tee ${surface}-Vacuum.out; /home/jfm343/JDFTXDIR/build/jdftx -i Solvated.in | tee ${surface}-Solvated.out"
commands[2]="echo done"
bash -c "${commands[${SLURM_ARRAY_TASK_ID}]}"
