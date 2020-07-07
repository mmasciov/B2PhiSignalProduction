#!/bin/bash
export SCRAM_ARCH=slc6_amd64_gcc630
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_9_3_6/src ] ; then 
 echo release CMSSW_9_3_6 already exists
else
scram p CMSSW CMSSW_9_3_6
fi
cd CMSSW_9_3_6/src
eval `scram runtime -sh`

mkdir -p Configuration/GenProduction/python/
cp ../../B2Phi_fragment.py Configuration/GenProduction/python/B2Phi_fragment.py

scram b
cd ../../
cmsDriver.py Configuration/GenProduction/python/B2Phi_fragment.py --fileout file:B2Phi_2017_GENSIM.root --mc --eventcontent RAWSIM --datatier GEN-SIM --conditions 93X_mc2017_realistic_v3 --beamspot Realistic25ns13TeVEarly2017Collision --step GEN,SIM --geometry DB:Extended --era Run2_2017 --python_filename B2Phi_2017_step0_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 1000; 
#|| exit $? ; 

