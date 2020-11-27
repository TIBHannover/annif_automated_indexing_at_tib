touch FIDmoveGND_en.sh 
 
#!/bin/bash

annif_project="FIDmoveGND_en_OP"
 
#Load vocabulary GND
echo "Start loading vocabulary GND"
annif loadvoc $annif_project vocab/FIDmove/GND_vocab-pref-var.tsv
echo "Vocabulary GND loaded"
 
#Train loaded vocabular
echo "Start training of FTX"
annif train $annif_project training/FIDmove/CorpusGND_en/
echo "Vocabulary FTX trained"

#Evaluate against gold standard
annif eval $annif_project goldstandard/en/gnd/
 
#Run Web GUI
echo "Start Web GUI"
annif run
