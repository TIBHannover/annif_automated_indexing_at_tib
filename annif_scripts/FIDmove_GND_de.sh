touch FIDmoveGND_de.sh 
 
#!/bin/bash
 
annif_project="FIDmoveGND_de_OP"

#Load vocabulary GND
echo "Start loading vocabulary GND"
annif loadvoc $annif_project vocab/FIDmove/GND_vocab-pref-var.tsv
echo "Vocabulary GND loaded"
 
#Train loaded vocabulary
echo "Start training of FTX"
annif train $annif_project training/FIDmove/CorpusGND_de/
echo "Vocabulary FTX trained"

#Evaluate against gold standard
annif eval $annif_project goldstandard/de/gnd/

#Run Web GUI
echo "Start Web GUI"
annif run
