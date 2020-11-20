#!/bin/bash

cd /home/mila/Annif-corpora/getdump/TIBKAT_BK_de/tsv/

for f in *.tsv ; do
	cp $f /home/mila/Annif-corpora/training/TIBIndex/TIBKAT_BK_de_202011/.
done

cd /home/mila/Annif-corpora/getdump/TIBKAT_BK_de/txt/

for f in *.txt ; do
	cp $f /home/mila/Annif-corpora/training/TIBIndex/TIBKAT_BK_de_202011/.
done