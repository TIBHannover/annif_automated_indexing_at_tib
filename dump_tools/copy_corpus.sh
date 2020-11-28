#!/bin/bash

cd /home/mila/Annif-corpora/collections/TIBKAT_LokSys_de/tsv/

for f in *.tsv ; do
	cp $f /home/mila/Annif-corpora/training/TIBIndex/TIBKAT_LokSysMath_de/.
done

cd /home/mila/Annif-corpora/collections/TIBKAT_LokSys_de/txt/

for f in *.txt ; do
	cp $f /home/mila/Annif-corpora/training/TIBIndex/TIBKAT_LokSysMath_de/.
done