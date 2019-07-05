export surface="110"
jdftx -ni testGeometry.in | tee testGeometry-${surface}.out
createXSF testGeometry-${surface}.out testGeometry-${surface}.xsf
