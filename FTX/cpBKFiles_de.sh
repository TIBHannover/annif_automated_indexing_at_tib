#!/bin/bash
cd /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusBK/

for txt in *.txt ; do
    tsv=${txt%.txt}.tsv
if  grep -q '>de<' $txt  ||  grep -q '>ger<' $txt ; then
	cp "$txt" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusBK_de/.
	cp "$tsv" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusBK_de/.
    fi
done
