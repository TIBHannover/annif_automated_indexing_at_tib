#!/bin/bash
 
annif_project="TIBKAT_abstracts_GND_en_OP"

#Load vocabulary GND
echo "Start loading vocabulary GND"
annif loadvoc $annif_project vocab/GND_vocab-pref-var.tsv
echo "Vocabulary GND loaded"
 
#Train loaded vocabulary
echo "Start training of FTX"
annif train $annif_project training/TIBIndex/TIBKAT_abstracts_GND_en_202011/
echo "Vocabulary GND trained"
 
#Evaluate against gold standard
touch subject_results.txt
annif eval -r subject_results.txt $annif_project goldstandard/TIBIndex/TIBKAT_abstracts_GND_en_202011/

#Run Web GUI
echo "Start Web GUI"
annif run