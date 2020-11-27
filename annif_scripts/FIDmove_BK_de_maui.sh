#!/bin/bash
 
annif_project="FIDmove_BK_de_maui"

#Load vocabulary GND
echo "Start loading vocabulary BK"
annif loadvoc $annif_project vocab/bk.tsv
echo "Vocabulary BK loaded"
 
#Train loaded vocabulary
echo "Start training of FTX"
annif train $annif_project training/FIDmoveIndex/FIDmove_BK_de/
echo "Vocabulary FTX trained"

#Evaluate against gold standard
touch $annif_project.txt
annif eval -r $annif_project.txt $annif_project goldstandard/FIDmoveIndex/FIDmove_BK_de/