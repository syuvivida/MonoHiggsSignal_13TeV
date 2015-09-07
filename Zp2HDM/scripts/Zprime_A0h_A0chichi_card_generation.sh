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
	newname=${name}_MZP${Zpmass}_M${A0mass}
	mkdir $topdir/$newname
	dir=$CARDSDIR/$name/$newname
	sed -e 's/'$name'/'${newname}'/g' $CARDSDIR/${name}_proc_card.dat > $dir/${newname}_proc_card.dat
	sed -e 's/MZP/'$Zpmass'/g' -e 's/MA0/'$A0mass'/g' $CARDSDIR/$custom > $dir/${newname}_customizecards.dat
	cp $CARDSDIR/run_card.dat $dir/${newname}_run_card.dat
	fi
	A0mass=$(( A0mass + 100 ))
    done
	Zpmass=$(( Zpmass + 200 ))
done


echo "There are "$iteration" mass points in total."