#!/bin/bash

export SCRAM_ARCH=slc7_amd64_gcc630
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_2_5/src ] ; then 
 echo release CMSSW_10_2_5 already exists
else
scram p CMSSW CMSSW_10_2_5
fi
cd CMSSW_10_2_5/src
eval `scram runtime -sh`

scram b
cd ../../

echo "Running step-0"

cmsRun step0_all.py $(($1+0))

echo "Running step-1"

cmsRun step1.py $(($1+0))

echo "Running on step-2"

cmsRun step2.py $(($1+0))
