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




Zpmassfile=inputs/input_zprime
lastZppoint=`cat $Zpmassfile | wc -l`
echo "There are "$lastZppoint" Zprime mass points"

A0massfile=inputs/input_a0
lastA0point=`cat $A0massfile | wc -l`
echo "There are "$lastA0point" A0 mass points"
chimass=100


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
	diffmass=$(( Zpmass - $chimass ))
	
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
    done
done

	    

echo "There are "$iteration" mass points in total."
