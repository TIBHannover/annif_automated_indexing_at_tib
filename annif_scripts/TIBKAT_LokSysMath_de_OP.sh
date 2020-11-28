#!/bin/bash

annif_project="TIBKAT_LokSysMath_de_OP"

#Load local classification
echo "Start loading local classification"
annif loadvoc $annif_project vocab/TIBLokSysMath.tsv
echo "Local classification loaded"
 
#Train loaded vocabulary
echo "Start training of FTX"
annif train $annif_project training/TIBIndex/TIBKAT_LokSysMath_de/
echo "Local classification trained"

#Evaluate against gold standard
annif eval $annif_project goldstandard/TIBIndex/TIBKAT_LokSysMath_de/

#Run Web GUI
echo "Start Web GUI"
gunicorn --bind 0.0.0.0:5000 "annif:create_app()"
#annif run
