#!/bin/bash

cd /home/mila/Annif-corpora/goldstandard/TIBIndex/

while read p; do
        data_set=$(echo "$p" | cut -f1 -d",")

        data_set_txt=${data_set%.xml}.txt
        data_set_tsv=${data_set%.xml}.tsv

        cp /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_de/txt/$data_set_txt /home/mila/Annif-corpora/goldstandard/TIBIndex/TIBKAT_abstracts_GND_de_202011/.
        cp /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_de/tsv/$data_set_tsv /home/mila/Annif-corpora/goldstandard/TIBIndex/TIBKAT_abstracts_GND_de_202011/.

done <Goldstandard_TIBKAT_BK_de_20201117.csv