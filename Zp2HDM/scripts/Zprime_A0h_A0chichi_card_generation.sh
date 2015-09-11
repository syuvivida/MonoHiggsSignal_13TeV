#!/bin/bash

scriptname=`basename $0`

# name of the run
name=Zprime_A0h_A0chichi

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


run=run_card.dat
########################
#Locating the run card
########################
if [ ! -e $CARDSDIR/$run ]; then
    echo $CARDSDIR/$run " does not exist!"
    exit 1;
fi

########################
#Run the code-generation step to create the process directory
########################
topdir=$CARDSDIR/$name
mkdir $topdir


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
	iterZwidth=$(( iterA0 + 1 ))
	Zpwidth=(`head -n $iterZp $Zpmassfile  | tail -1 | awk -v my_var=$iterZwidth '{print $my_var}'`)    
	A0mass=(`head -n $iterA0 $A0massfile  | tail -1 | awk '{print $1}'`) 
	A0width=(`head -n $iterA0 $A0massfile  | tail -1 | awk '{print $2}'`) 
	diffmass=$(( Zpmass - $hmass ))
	
	if [[ $A0mass -lt $diffmass ]]
	then
	    iteration=$(( iteration + 1 ))

	    echo ""
	    echo "Producing cards for Zprime mass = "$Zpmass" GeV"
	    echo "Producing cards for A0 mass = "$A0mass" GeV "
	    echo ""
	    newname=${name}_MZp${Zpmass}_MA0${A0mass}
	    mkdir $topdir/$newname
	    dir=$CARDSDIR/$name/$newname
	    sed -e 's/'$name'/'${newname}'/g' $CARDSDIR/${name}_proc_card.dat > $dir/${newname}_proc_card.dat
	    sed -e 's/MZP/'$Zpmass'/g' -e 's/MA0/'$A0mass'/g' -e 's/WZP/'$Zpwidth'/g' -e 's/WA0/'$A0width'/g' $CARDSDIR/$custom > $dir/${newname}_customizecards.dat
	    cp $CARDSDIR/run_card.dat $dir/${newname}_run_card.dat
	fi
    done
done


echo "There are "$iteration" mass points in total."

