#!/bin/bash -l
                                
conda activate root_env
                               
echo "Running environment at ${CONDA_PREFIX}"

##if [-z "$(ls -A /data/cmsdaq/DimensionBench/Arrays/ArrayData)" ] && echo "Not Empty" || echo "Empty"
#if [ -z "$(ls -A /data/cmsdaq/DimensionBench/Arrays/ArrayData)" ]

#begin=$(date +%s) 

begin=$SECONDS


if [ -z "$(ls -A /data/cmsdaq/DimensionBench/Bars/BarData_tmp)" ]
   

then
   echo "++++++++++++++++++++++++++++++"
   echo "No raw data in this directory"
   echo "++++++++++++++++++++++++++++++"
else
   echo "+++++++++++++++++++++++++++++++"
   echo "New raw data in this directory"
   echo "+++++++++++++++++++++++++++++++"


# Added this part to move files from ArrayData_tmp to ArrayData and run cronjob smoothly 


for file in /data/cmsdaq/DimensionBench/Bars/BarData_tmp/*-*.TXT; do

    mv "$file" "/data/cmsdaq/DimensionBench/Bars/BarData/$(basename "$file")"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++"
    echo "$file moved to BarData directory!"
    echo "Executing Galaxy analysis code ..." 
    echo "+++++++++++++++++++++++++++++++++++++++++++++++"


cd /home/cmsdaq/GalaxyAnalysis/

echo "++++++++++++++++++++++++++++++++++++"
echo " Adding Run Number to raw data file"
echo "++++++++++++++++++++++++++++++++++++"


python3 AddRunNumb-Galaxy-Bar.py


echo "++++++++++++++++++++++++++++++"
echo "  Starting LYSO Bar Analysis"
echo "++++++++++++++++++++++++++++++"



python3 runAll_Galaxy_Bar.py --inputdir /data/cmsdaq/DimensionBench/Bars/BarData

#end=$(date +%s)

#tottime=$(expr $end - $begin)

tottime=$(($SECONDS - $begin))

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Execution time for 1 LYSO Bar is: $(($tottime/60)) min $(($tottime%60)) sec"
echo "+++++++++++++++++++++++++++++++++++++++++++"

done

conda deactivate
cd ~/


fi
