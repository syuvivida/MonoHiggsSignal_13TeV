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

iteration=0
massfile=inputs/input_zprime
lastpoint=`cat $massfile | wc -l`
echo "There are "$lastpoint" mass points"


while [ $iteration -lt $lastpoint ]; 
do
    iteration=$(( iteration + 1 ))
    Zpmass=(`head -n $iteration $massfile  | tail -1 | awk '{print $1}'`) 
    echo ""
    echo "Producing gridpacks for Zprime mass = "$Zpmass" GeV"
    echo ""
    process=${name}_MZp${Zpmass}
    dir=$CARDSDIR/$name/$process
    ls $dir
    bsub -q $queue $PWD/runJob.sh $PWD $process $dir
done



echo "There are "$iteration" mass points in total."
