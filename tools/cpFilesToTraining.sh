#!/bin/bash

cd /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/tsv

for tsv in *.tsv ; do

    cp -v "$tsv" /home/mila/Annif-corpora/training/TIBKAT_LinSearch_Mapping_de/.

done

cd /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/txt

for txt in *.txt ; do

    cp -v "$txt" /home/mila/Annif-corpora/training/TIBKAT_LinSearch_Mapping_de/.

done