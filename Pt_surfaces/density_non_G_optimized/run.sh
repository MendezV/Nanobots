#!/bin/bash
export surface="110"   #or "110" or "111" later on
jdftx -i Vacuum.in | tee ${surface}-Vacuum.out
jdftx -i Solvated.in | tee ${surface}-Solvated.out
