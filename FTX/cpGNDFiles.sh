#!/bin/bash
FILES=/home/mila/TIB/annif/Annif-corpora/training/FIDmove/originalData/GND/*
for f in $FILES
do
  echo "Processing $f file..."
  cp -v -- "$f" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND/.
done
