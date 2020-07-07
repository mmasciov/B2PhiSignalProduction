### step-0:

1) get configuration (please, point to the wished fragment):

source cmsDriverCommand_step0.sh

2) run configuration:

cmsRun B2Phi_2017_step0_cfg.py


### step-1 + step-2:

1) get configurations:

source cmsDriverCommand_step1_step2.sh

### NOTE: should ensure that the latest 2018 HLT menu is used?

2) run step-1 configuration, using output of step-0 as input:

cmsRun B2Phi_2017_step1_cfg.py

3) run step-2 configuration, using output of step-1 as input:

cmsRun B2Phi_2017_step2_cfg.py

