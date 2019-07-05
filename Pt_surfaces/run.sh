#!/bin/bash
export surface="110"   #or "110" or "111" later on
jdftx -ni testGeometry.in | tee testGeometry-${surface}.out
