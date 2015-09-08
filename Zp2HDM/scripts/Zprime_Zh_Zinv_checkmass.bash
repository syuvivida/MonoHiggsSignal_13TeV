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

iteration=0
massfile=inputs/input_zprime
lastpoint=`cat $massfile | wc -l`
echo "There are "$lastpoint" mass points"

while [ $iteration -lt $lastpoint ]; 
do
    iteration=$(( iteration + 1 ))
    Zpmass=(`head -n $iteration $massfile  | tail -1 | awk '{print $1}'`)
    file=${process}_MZp${Zpmass}_tarball.tar.xz
    echo ""
    echo ""
    cmsLs $dir/$file
done



echo "There are "$iteration" mass points in total."
