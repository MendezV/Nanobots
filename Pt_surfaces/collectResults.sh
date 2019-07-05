#!/bin/bash

Ebulk="-89.040956" #Bulk metal energy per atom


function parseOutputs()
{
    logFile="$1"
    awk "
        /R =/ {RstartLine=NR}
        NR==RstartLine+3 { Lz = \$4 }           #Height of unit cell
        /unit cell volume/ { A = \$NF*2/Lz}     #Surface area (top+bottom)
        /FillingsUpdate:/ { mu = \$3 }          #Electron chemical potential
        /IonicMinimize: Iter/ { Esurf = (\$5 - $Ebulk*5)/A }  #Surface energy
        END {
            eV = 1/27.2114;
            nm = 1/0.05291772;
            print Esurf/(eV/(nm*nm)), mu/eV     #Output with unit conversion
        }
    " $logFile
}

#Print header:
echo "Surface      Esurf [eV/nm^2]           Absolute mu [eV]     V_SHE"
echo "         Vacuum Solvated  Shift     Vacuum Solvated  Shift   [V]"

#Print results:
for surface in 100 110 111; do
    EmuVac="$(parseOutputs $surface-Vacuum.out)"
    EmuSol="$(parseOutputs $surface-Solvated.out)"
    echo -n "  $surface   "
    #Print extracted results and solvation differences:
    echo "$EmuVac $EmuSol" | awk '{
        printf("%7.2f %7.2f %7.2f   %7.2f %7.2f %7.2f %7.2f\n",
            $1, $3, $3-$1, $2, $4, $4-$2, -($4-(-4.68))) }'
done

