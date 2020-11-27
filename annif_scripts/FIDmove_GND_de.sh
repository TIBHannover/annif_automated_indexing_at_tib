touch FIDmoveGND_de.sh 
 
#!/bin/bash
 
annif_project="FIDmove_GND_de_OP"

#Load vocabulary GND
echo "Start loading vocabulary GND"
annif loadvoc $annif_project vocab/GND_vocab-pref-var.tsv
echo "Vocabulary GND loaded"
 
#Train loaded vocabulary
echo "Start training of FTX"
annif train $annif_project training/FIDmoveIndex/FIDmove_GND_de/
echo "Vocabulary FTX trained"

#Evaluate against gold standard
touch $annif_project.txt
annif eval -r $annif_project.txt $annif_project goldstandard/FIDmoveIndex/FIDmove_GND_de/

#Run Web GUI
#echo "Start Web GUI"
#annif run
