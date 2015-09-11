#!/bin/bash

name=ZpA0h



export PRODHOME=`pwd`
CARDSDIR=${PRODHOME}

########################
#Locating the proc card#
########################
if [ ! -e $CARDSDIR/${name}_proc_card.dat ]; then
    echo $CARDSDIR/${name}_proc_card.dat " does not exist!"
    exit 1;
fi



Zpmassfile=inputs/input_zprime
lastZppoint=`cat $Zpmassfile | wc -l`
echo "There are "$lastZppoint" Zprime mass points"

A0massfile=inputs/input_a0
lastA0point=`cat $A0massfile | wc -l`
echo "There are "$lastA0point" A0 mass points"
hmass=125


iteration=0
iterZp=0
while [ $iterZp -lt $lastZppoint ]; 
do
    iterZp=$(( iterZp + 1 ))
    Zpmass=(`head -n $iterZp $Zpmassfile  | tail -1 | awk '{print $1}'`)    
    iterA0=0
    while [ $iterA0 -lt $lastA0point ]; 
    do
	iterA0=$(( iterA0 + 1 ))
	A0mass=(`head -n $iterA0 $A0massfile  | tail -1 | awk '{print $1}'`) 
	diffmass=$(( Zpmass - $hmass ))
	
	if [[ $A0mass -lt $diffmass ]]
	then
	    iteration=$(( iteration + 1 ))
	    echo ""
	    echo "Producing cards for Zprime mass = "$Zpmass" GeV"
	    echo "Producing cards for A0 mass = "$A0mass" GeV "
	    echo ""
	    newname=${name}_MZp${Zpmass}_MA0${A0mass}
	    sed -e 's/FOLDERNAME/'$newname'/g' -e 's/MASSZP/'$Zpmass'/g' -e 's/MASSA0/'$A0mass'/g' $CARDSDIR/${name}_proc_card.dat > $CARDSDIR/${newname}_proc_card.dat
	    bsub -q8nh $PWD/runLaunch.sh $PWD $CARDSDIR/${newname}_proc_card.dat

	fi
    done
done


echo "There are "$iteration" mass points in total."





