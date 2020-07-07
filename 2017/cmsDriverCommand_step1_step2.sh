#!/bin/bash
export SCRAM_ARCH=slc6_amd64_gcc630
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_9_4_0_patch1/src ] ; then 
 echo release CMSSW_9_4_0_patch1 already exists
else
scram p CMSSW CMSSW_9_4_0_patch1
fi
cd CMSSW_9_4_0_patch1/src
eval `scram runtime -sh`


scram b
cd ../../
cmsDriver.py step1 --filein file:B2Phi_2017_GENSIM.root --fileout file:B2Phi_2017_step1.root  --pileup_input "dbs:/Neutrino_E-10_gun/RunIISummer17PrePremix-MC_v2_94X_mc2017_realistic_v9-v1/GEN-SIM-DIGI-RAW" --mc --eventcontent PREMIXRAW --datatier GEN-SIM-RAW --conditions 94X_mc2017_realistic_v10 --step DIGIPREMIX_S2,DATAMIX,L1,DIGI2RAW,HLT:2e34v40 --nThreads 8 --datamix PreMix --era Run2_2017 --python_filename B2Phi_2017_step1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n -1 || exit $? ; 

cmsDriver.py step2 --filein file:B2Phi_2017_step1.root --fileout file:B2Phi_2017_AODSIM.root --mc --eventcontent AODSIM --runUnscheduled --datatier AODSIM --conditions 94X_mc2017_realistic_v10 --step RAW2DIGI,RECO,RECOSIM,EI --nThreads 8 --era Run2_2017 --python_filename B2Phi_2017_step2_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n -1 || exit $? ; 