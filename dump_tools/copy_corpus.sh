#!/bin/bash

cd /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_en/tsv/

for f in *.tsv ; do
	cp $f /home/mila/Annif-corpora/training/TIBIndex/TIBKAT_abstracts_GND_en_202011/.
done

cd /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_en/txt/

for f in *.txt ; do
	cp $f /home/mila/Annif-corpora/training/TIBIndex/TIBKAT_abstracts_GND_en_202011/.
done