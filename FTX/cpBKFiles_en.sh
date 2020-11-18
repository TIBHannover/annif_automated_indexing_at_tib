#!/bin/bash
cd /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusBK/

for txt in *.txt ; do
    tsv=${txt%.txt}.tsv
if  grep -q '>en<' $txt  ||  grep -q '>eng<' $txt ; then
	cp "$txt" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusBK_en/.
	cp "$tsv" /home/mila/TIB/annif/Annif-corpora/training/FIDmove/CorpusBK_en/.
    fi
done
