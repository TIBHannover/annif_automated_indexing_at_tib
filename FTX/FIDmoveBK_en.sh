#touch FIDmoveBK_en.sh 
 
#!/bin/bash

annif_project="FIDmoveBK_en_tfidf"

#Load vocabulary BK
echo "Start loading vocabulary BK"
annif loadvoc $annif_project vocab/bk.tsv
echo "Vocabulary BK loaded"
 
#Train loaded vocabulary
echo "Start training of FTX"
annif train $annif_project training/FIDmoveIndex/FTX/CorpusBK_en/
echo "Vocabulary BK trained"

#Evaluate against gold standard
annif eval $annif_project goldstandard/FIDmoveIndex/FTX/en/bk/

#Run Web GUI
echo "Start Web GUI"
annif run
