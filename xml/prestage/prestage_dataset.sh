#!/bin/bash

nohup samweb prestage-dataset --defname=${1} --parallel=4 >& prestage_${1}.log &
