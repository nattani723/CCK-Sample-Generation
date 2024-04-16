#!/usr/bin/env python
import os

project="make_kaon_events_numi_fhc_run1_assok_overlay_test_26dec"
stage="detsim_sce"
stage_name=stage

common="file_type mc and ub_project.version prod_v08_00_00_13k and ub_project.name "

defname    = [  "assok" ]
fileformat = [ "artroot" ]


for i in range(len(defname)):
    thisdefname = "taniuchi_" + project+"_"+stage_name+"_"+ defname[i]
    print thisdefname
    cmd1 = "samweb delete-definition " + thisdefname
    os.system(cmd1)
    cmd = "samweb create-definition " + thisdefname
    cmd = cmd + " '" + common + project + " and file_format " +fileformat[i] + " and ub_project.stage " + stage
    cmd = cmd + " with availability physical'"
    #cmd = cmd + " with availability virtual'"
    print cmd
    os.system(cmd)
    count_cmd = "samweb count-definition-files " + thisdefname
    os.system(count_cmd)
    #print thisdefname

for i in range(len(defname)):
    thisdefname = "taniuchi_" + project+ "_" +stage_name+"_" + defname[i]
    print thisdefname

print "Done!"
