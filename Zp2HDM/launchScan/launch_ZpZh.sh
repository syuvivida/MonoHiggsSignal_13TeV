#!/bin/bash

name=ZpZh



export PRODHOME=`pwd`
CARDSDIR=${PRODHOME}

########################
#Locating the proc card#
########################
if [ ! -e $CARDSDIR/${name}_proc_card.dat ]; then
    echo $CARDSDIR/${name}_proc_card.dat " does not exist!"
    exit 1;
fi

iteration=0
massfile=inputs/input_zprime
lastpoint=`cat $massfile | wc -l`
echo "There are "$lastpoint" mass points"

A0massfile=inputs/input_a0
A0mass=(`head -n 1 $A0massfile  | tail -1 | awk '{print $1}'`)


while [ $iteration -lt $lastpoint ]; 
do
    iteration=$(( iteration + 1 ))
    Zpmass=(`head -n $iteration $massfile  | tail -1 | awk '{print $1}'`)
    echo "Producing cards for Zprime mass = "$Zpmass" GeV"
    echo ""
    newname=${name}_MZp${Zpmass}

    sed -e 's/FOLDERNAME/'$newname'/g' -e 's/MASSZP/'$Zpmass'/g' -e 's/MASSA0/'$A0mass'/g' $CARDSDIR/${name}_proc_card.dat > $CARDSDIR/${newname}_proc_card.dat
    bsub -q8nh $PWD/runLaunch.sh $PWD $CARDSDIR/${newname}_proc_card.dat

done


echo "There are "$iteration" mass points in total."





