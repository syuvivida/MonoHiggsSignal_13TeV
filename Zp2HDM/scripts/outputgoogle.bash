#!/bin/bash

scriptname=`basename $0`
EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $scriptname foldername EOSDirVersion"
    echo "Example: ./$scriptname Zprime_A0h_A0chichi_MZp1000_MA0300 v1"
    exit 1
fi

rm -rf file.txt
rm -rf cvmfs.txt
rm -rf url.txt

type=$1
version=$2
process=${type%%_MZp*}
echo $process
if [[ ! -e $process ]]; then 
    mkdir $process
fi
location="/cvmfs/cms.cern.ch/phys_generator/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.3.0/monoHiggs/Zp2HDM/${process}/${version}/${type}_tarball.tar.xz"
echo $location >> cvmfs.txt

echo "https://github.com/cms-sw/genproductions/tree/4e6dda7ecc882f106135d5a33c602f53bc4843a9/bin/MadGraph5_aMCatNLO/cards/production/13TeV/monoHiggs/Zp2HDM/"$process"/"$type >> url.txt


filename=${type}_13TeV-madgraph_cff.py
echo $filename >> file.txt


