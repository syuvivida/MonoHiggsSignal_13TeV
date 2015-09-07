#!/bin/bash

scriptname=`basename $0`
EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $scriptname queue directoryName"
    echo "Example: ./$scriptname 2nd cards/production/13TeV/monoHiggs"
    exit 1
fi

# name of the run
queue=$1
CARDSDIR=$2

name=Zprime_A0h_A0chichi

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
	    echo "Producing gridpacks for Zprime mass = "$Zpmass" GeV"
	    echo "Producing gridpacks for A0 mass = "$A0mass" GeV "
	    echo ""
	    process=${name}_MZp${Zpmass}_MA0${A0mass}
	    dir=$CARDSDIR/$name/$process
	    ls $dir
	    bsub -q $queue $PWD/runJob.sh $PWD $process $dir
	    
	fi
	A0mass=$(( A0mass + 100 ))
    done
	Zpmass=$(( Zpmass + 200 ))
done


echo "There are "$iteration" mass points in total."
