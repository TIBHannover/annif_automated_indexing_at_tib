touch FIDmoveBK_en.sh 
 
#!/bin/bash

annif_project="FIDmoveBK_en_OP"

#Load vocabulary BK
echo "Start loading vocabulary BK"
annif loadvoc $annif_project vocab/FIDmove/bk.tsv
echo "Vocabulary BK loaded"
 
#Train loaded vocabulary
echo "Start training of FTX"
annif train $annif_project training/FIDmove/CorpusBK_en/
echo "Vocabulary BK trained"

#Evaluate against gold standard
annif eval $annif_project goldstandard/en/bk/

#Run Web GUI
echo "Start Web GUI"
annif run
