#!/usr/bin/env python
import os

project="assok_production_numi_fhc_run1_main_reco"
stage="reco2"
stage_name=stage

common="file_type mc and ub_project.version prod_v08_00_00_51 and ub_project.name "

defname    = [  "reco2" , "pandora" ]
fileformat = [ "artroot" , "pndr" ]


for i in range(len(defname)):
    thisdefname = "taniuchi_" + project+"_"+stage_name+"_"+ defname[i]
    print thisdefname
    cmd1 = "samweb delete-definition " + thisdefname
    os.system(cmd1)
    cmd = "samweb create-definition " + thisdefname
    cmd = cmd + " '" + common + project + " and file_format " +fileformat[i] + " and ub_project.stage " + stage
    cmd = cmd + " with availability physical'"
    print cmd
    os.system(cmd)
    count_cmd = "samweb count-definition-files " + thisdefname
    os.system(count_cmd)
    #print thisdefname

for i in range(len(defname)):
    thisdefname = "taniuchi_" + project+ "_" +stage_name+"_" + defname[i]
    print thisdefname

print "Done!"
