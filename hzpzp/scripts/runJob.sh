#!/bin/bash

scriptname=`basename $0`
EXPECTED_ARGS=3

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $scriptname currentDirectory processName dirName"
    echo "Example: ./$scriptname $PWD Radion_hh_hbbhbb cards"
    exit 1
fi

cd $1
./gridpack_generation.sh $2 $3 local MonoHiggs_Zp2HDM_v1.2.tgz
