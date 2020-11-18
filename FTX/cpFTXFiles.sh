#!/bin/bash
FILES=/home/mila/TIB/annif/Annif-corpora/training/FIDmove/originalData/FTX/*
for f in $FILES
do
  #echo "Processing $f file..."
  cp -v -- "$f" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusBK/.
  cp -v -- "$f" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND/.
done
