#!/bin/bash
FILES=/home/mila/TIB/annif/Annif-corpora/training/FIDmove/originalData/BK/*
for f in $FILES
do
  echo "Processing $f file..."
  cp -v -- "$f" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusBK/.
done
