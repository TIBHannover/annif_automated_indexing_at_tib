#touch FIDmoveBK_de.sh 
 
#!/bin/bash
 
annif_project="FIDmoveBK_de_tfidf"

#Load vocabulary BK
echo "Start loading vocabulary BK"
annif loadvoc $annif_project vocab/bk.tsv
echo "Vocabulary BK loaded"
 
#Train loaded vocabulary
echo "Start training of FTX"
annif train $annif_project training/FIDmoveIndex/FTX/CorpusBK_de/
echo "Vocabulary BK trained"
 
#Evaluate against gold standard
annif eval $annif_project goldstandard/FIDmoveIndex/FTX/de/bk/

#Run Web GUI
echo "Start Web GUI"
annif run
