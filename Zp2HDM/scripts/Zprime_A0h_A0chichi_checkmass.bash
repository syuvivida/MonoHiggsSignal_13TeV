#!/bin/bash

scriptname=`basename $0`
EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $scriptname EOSDirVersion"
    echo "Example: ./$scriptname v1"
    exit 1
fi



process=Zprime_A0h_A0chichi
version=$1
#dir=/store/group/phys_generator/cvmfs/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/monoHiggs/${process}/$version
dir=/cvmfs/cms.cern.ch/phys_generator/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/monoHiggs/${process}/$version 


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
	    echo ""
	    file=${process}_MZp${Zpmass}_MA0${A0mass}_tarball.tar.xz
	    cmsLs $dir/$file

	fi
    done
done


echo "There are "$iteration" mass points in total."
