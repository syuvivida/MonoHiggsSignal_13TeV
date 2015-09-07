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

name=Zprime_Zh_Zinv

Zpmass=600
last_Zpmass=1400
chimass=100
iteration=0
A0mass=300

while [[ $Zpmass -le $last_Zpmass ]]; 
do
    iteration=$(( iteration + 1 ))    
    echo ""
    echo "Producing gridpacks for Zprime mass = "$Zpmass" GeV"
    echo ""
    process=${name}_MZP${Zpmass}
    dir=$CARDSDIR/$name/$process
    ls $dir
    bsub -q $queue $PWD/runJob.sh $PWD $process $dir
    
    Zpmass=$(( Zpmass + 200 ))
    
done


echo "There are "$iteration" mass points in total."
