#!/bin/bash
#SBATCH -N 1 -n 12 -x node30[01-03] -J PtSurfaces


for surface in 100 110 111; do
    export surface
    jdftx -i Vacuum.in | tee ${surface}-Vacuum.out
    jdftx -i Solvated.in | tee ${surface}-Solvated.out
done
