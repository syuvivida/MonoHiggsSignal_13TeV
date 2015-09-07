#!/bin/tcsh
echo $1
cd $1
setenv SCRAM_ARCH slc6_amd64_gcc481; eval `scramv1 runtime -csh`
cmsRun -e -j step0_${2}.xml step0_${2}_cfg.py
