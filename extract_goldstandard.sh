#!/bin/bash

cd /home/mila/Annif-corpora/goldstandard/TIBIndex/

while read p; do
        data_set=$(echo "$p" | cut -f1 -d",")

        data_set_txt=${data_set%.xml}.txt
        data_set_tsv=${data_set%.xml}.tsv

        mv /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_en/txt/$data_set_txt /home/mila/Annif-corpora/goldstandard/TIBIndex/TIBKAT_abstracts_GND_en_202011/.
        mv /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_en/tsv/$data_set_tsv /home/mila/Annif-corpora/goldstandard/TIBIndex/TIBKAT_abstracts_GND_en_202011/.

done <Goldstandard_TIBKAT_abstracts_GND_en_20201123.csv