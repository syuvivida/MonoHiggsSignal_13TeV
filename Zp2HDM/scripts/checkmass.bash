#!/bin/bash

scriptname=`basename $0`
EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $scriptname processName EOSDirVersion"
    echo "Example: ./$scriptname Zprime_A0h_A0chichi v1"
    exit 1
fi



process=$1
version=$2
#dir=/store/group/phys_generator/cvmfs/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/monoHiggs/${process}/$version
dir=/cvmfs/cms.cern.ch/phys_generator/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/monoHiggs/${process}/$version 

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
	echo ""
	file=${name}_MZP${Zpmass}_M${A0mass}_tarball.tar.xz
	cmsLs $dir/$file
	fi
	A0mass=$(( A0mass + 100 ))
    done
	Zpmass=$(( Zpmass + 200 ))
done


echo "There are "$iteration" mass points in total."
