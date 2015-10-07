#!/bin/bash

scriptname=`basename $0`

# name of the run
name=Zprime_Zh_Zinv

## customercards
custom=2HDM_customizecards.dat 

export PRODHOME=`pwd`
CARDSDIR=${PRODHOME}/cards

########################
#Locating the proc card#
########################
if [ ! -e $CARDSDIR/${name}_proc_card.dat ]; then
    echo $CARDSDIR/${name}_proc_card.dat " does not exist!"
    exit 1;
fi


########################
#Locating the customization 
########################
if [ ! -e $CARDSDIR/$custom ]; then
    echo $CARDSDIR/$custom " does not exist!"
    exit 1;
fi


########################
#Locating the run card
########################
run=run_card.dat
if [ ! -e $CARDSDIR/$run ]; then
    echo $CARDSDIR/$run " does not exist!"
    exit 1;
fi


########################
#Locating the extramodel card
########################
model=extramodels.dat
if [ ! -e $CARDSDIR/$model ]; then
    echo $CARDSDIR/$model " does not exist!"
    exit 1;
fi


########################
#Run the code-generation step to create the process directory
########################
topdir=$CARDSDIR/$name
mkdir $topdir

iteration=0
massfile=inputs/input_zprime
lastpoint=`cat $massfile | wc -l`
echo "There are "$lastpoint" mass points"

A0massfile=inputs/input_a0
A0mass=(`head -n 1 $A0massfile  | tail -1 | awk '{print $1}'`)
A0width=(`head -n 1 $A0massfile  | tail -1 | awk '{print $2}'`)

while [ $iteration -lt $lastpoint ]; 
do
    iteration=$(( iteration + 1 ))
    Zpmass=(`head -n $iteration $massfile  | tail -1 | awk '{print $1}'`)
    Zpwidth=(`head -n $iteration $massfile  | tail -1 | awk '{print $2}'`)
    echo "Producing cards for Zprime mass = "$Zpmass" GeV"
    echo ""
    newname=${name}_MZp${Zpmass}
    mkdir $topdir/$newname
    dir=$CARDSDIR/$name/$newname
    sed -e 's/'$name'/'${newname}'/g' $CARDSDIR/${name}_proc_card.dat > $dir/${newname}_proc_card.dat
    sed -e 's/MZP/'$Zpmass'/g' -e 's/MA0/'$A0mass'/g' -e 's/WZP/'$Zpwidth'/g' -e 's/WA0/'$A0width'/g' $CARDSDIR/$custom > $dir/${newname}_customizecards.dat
    cp -p $CARDSDIR/$run $dir/${newname}_run_card.dat
    cp -p $CARDSDIR/$model $dir/${newname}_extramodels.dat
done


echo "There are "$iteration" mass points in total."
