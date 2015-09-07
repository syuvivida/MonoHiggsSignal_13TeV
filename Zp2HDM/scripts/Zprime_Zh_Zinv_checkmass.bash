#!/bin/bash

scriptname=`basename $0`
EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $scriptname EOSDirVersion"
    echo "Example: ./$scriptname v1"
    exit 1
fi



process=Zprime_Zh_Zinv
version=$1
#dir=/store/group/phys_generator/cvmfs/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/monoHiggs/${process}/$version
dir=/cvmfs/cms.cern.ch/phys_generator/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/monoHiggs/${process}/$version 

Zpmass=600
last_Zpmass=1400

chimass=100
iteration=0
A0mass=300

while [[ $Zpmass -le $last_Zpmass ]]; 
do
    iteration=$(( iteration + 1 ))
    echo ""
    echo ""
    file=${name}_MZp${Zpmass}_tarball.tar.xz
    cmsLs $dir/$file
    Zpmass=$(( Zpmass + 200 ))
done


echo "There are "$iteration" mass points in total."
