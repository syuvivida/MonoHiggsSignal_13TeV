#!/bin/bash

scriptname=`basename $0`
EXPECTED_ARGS=1
if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $scriptname processName"
    echo "Example: ./$scriptname ZpA0h"
    exit 1
fi

# name of the run
name=$1



export PRODHOME=`pwd`
CARDSDIR=${PRODHOME}

########################
#Locating the proc card#
########################
if [ ! -e $CARDSDIR/${name}_proc_card.dat ]; then
    echo $CARDSDIR/${name}_proc_card.dat " does not exist!"
    exit 1;
fi


Zpmass=600
last_Zpmass=1400
chimass=100
iteration=0

while [[ $Zpmass -le $last_Zpmass ]]; 
do
    A0mass=300
    last_A0mass=800
    while [[ $A0mass -le $last_A0mass ]]; 
    do
	diffmass=$(( Zpmass - $chimass ))
#	echo $diffmass
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
#	$PWD/runLaunch.sh $PWD $CARDSDIR/${newname}_proc_card.dat

	fi
	A0mass=$(( A0mass + 100 ))
    done
	Zpmass=$(( Zpmass + 200 ))
done


echo "There are "$iteration" mass points in total."





