#!/bin/bash

cd /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND_en

for tsv in *.tsv ; do
    txt=${tsv%.tsv}.txt        # Corresponding txt file.
    [[ -f $txt ]] || continue  # Skip tsv if txt doesn't exist.
    if [[ ! -s $tsv ]] ; then  # If tsv is empty
        rm "$tsv" "$txt"
    fi
done
