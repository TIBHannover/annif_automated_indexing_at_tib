#!/bin/bash

cd /home/mila/Annif-corpora/goldstandard/TIBIndex/

while read p; do
        data_set=$(echo "$p" | cut -f1 -d",")

        data_set_txt=${data_set%.xml}.txt
        data_set_tsv=${data_set%.xml}.tsv

        mv /home/mila/Annif-corpora/collections/TIBKAT_LokSys_de/txt/$data_set_txt /home/mila/Annif-corpora/goldstandard/TIBIndex/TIBKAT_LokSysMath_de/.
        mv /home/mila/Annif-corpora/collections/TIBKAT_LokSys_de/tsv/$data_set_tsv /home/mila/Annif-corpora/goldstandard/TIBIndex/TIBKAT_LokSysMath_de/.

done <Goldstandard_TIBKATLokSysMath.csv