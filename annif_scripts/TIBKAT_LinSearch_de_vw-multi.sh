#!/bin/bash
 
annif_project="TIBKAT_LinSearch_Mapping_de_vw_multi_ect"

#Load vocabulary GND
echo "Start loading LinSearch classification"
annif loadvoc $annif_project vocab/LinSearch.tsv
echo "LinSearch classification loaded"
 
#Train loaded vocabulary
echo "Start training"
annif train $annif_project training/TIBKAT_LinSearch_Mapping_de/
echo "Trained"

#Evaluate against gold standard
touch $annif_project.txt
annif eval -r $annif_project.txt $annif_project goldstandard/TIBKAT_LinSearch_Mapping_de/