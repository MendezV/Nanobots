export surface="111"   #or "110" or "111" later on
jdftx -ni testgeometry.in | tee testgeometry-${surface}.out
createXSF testgeometry-${surface}.out ${surface}.xsf
