#!/bin/bash

cd /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/tsv/

for f in *.tsv ; do
	cp $f /home/mila/Annif-corpora/training/TIBKAT_LinSearch_de/.
done

cd /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/txt/

for f in *.txt ; do
	cp $f /home/mila/Annif-corpora/training/TIBKAT_LinSearch_de/.
done