#!/bin/bash
export SCRAM_ARCH=slc6_amd64_gcc700
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_2_6/src ] ; then 
 echo release CMSSW_10_2_6 already exists
else
scram p CMSSW CMSSW_10_2_6
fi
cd CMSSW_10_2_6/src
eval `scram runtime -sh`

mkdir -p Configuration/GenProduction/python/
cp ../../B2Phi_fragment.py Configuration/GenProduction/python/B2Phi_fragment.py

scram b
cd ../../
cmsDriver.py Configuration/GenProduction/python/B2Phi_fragment.py --fileout file:B2Phi_2018_GENSIM.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 102X_upgrade2018_realistic_v11 --beamspot Realistic25ns13TeVEarly2018Collision --step GEN,SIM --geometry DB:Extended --era Run2_2018 --python_filename B2Phi_2018_step0_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 1000 || exit $? ; 
