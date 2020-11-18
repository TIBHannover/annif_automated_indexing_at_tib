#!/bin/bash
cd /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND/

for txt in *.txt ; do
    tsv=${txt%.txt}.tsv
if  grep -q '>en<' $txt  ||  grep -q '>eng<' $txt ; then
	cp "$txt" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND_en/.
	cp "$tsv" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND_en/.
    fi
done
