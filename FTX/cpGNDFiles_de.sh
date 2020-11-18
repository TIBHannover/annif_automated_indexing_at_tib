#!/bin/bash
cd /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND/

for txt in *.txt ; do
    tsv=${txt%.txt}.tsv
if  grep -q '>de<' $txt  ||  grep -q '>ger<' $txt ; then
	cp "$txt" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND_de/.
	cp "$tsv" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusGND_de/.
    fi
done
