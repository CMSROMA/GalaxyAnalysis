#!/bin/bash -l
                                
conda activate root_env
                               
echo "Running environment at ${CONDA_PREFIX}"

##if [-z "$(ls -A /data/cmsdaq/DimensionBench/Arrays/ArrayData)" ] && echo "Not Empty" || echo "Empty"
#if [ -z "$(ls -A /data/cmsdaq/DimensionBench/Arrays/ArrayData)" ]

if [ -z "$(ls -A /data/cmsdaq/DimensionBench/Bars/BarData)" ]
   

then
   echo "++++++++++++++++++++++++++++++"
   echo "No raw data in this directory"
   echo "++++++++++++++++++++++++++++++"
else
   echo "+++++++++++++++++++++++++++++++"
   echo "New raw data in this directory"
   echo "+++++++++++++++++++++++++++++++"

cd /data/cmsdaq/DimensionBench/Bars/

echo "++++++++++++++++++++++++++++++++++++"
echo " Adding Run Number to raw data file"
echo "++++++++++++++++++++++++++++++++++++"


python3 AddRunNumb-Galaxy-Bar.py


echo "++++++++++++++++++++++++++++++"
echo "  Starting LYSO Bar Analysis"
echo "++++++++++++++++++++++++++++++"



python3 runAll_Galaxy_Bar.py --inputdir BarData

conda deactivate
cd ~/


fi
