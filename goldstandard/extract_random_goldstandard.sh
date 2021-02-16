#!/bin/bash

cd /home/mila/Annif-corpora/goldstandard/TIBKAT_LinSearch_Mapping_de/

N=$(ls /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/xml/ | wc -l)

M=$(printf %.i\\n "$(($N * 1/10))")

ls /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/xml |sort -R |tail -$M |while read file; do
    
    file_txt=${file%.xml}.txt
    file_tsv=${file%.xml}.tsv

    mv /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/txt/$file_txt .
    mv /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/tsv/$file_tsv .
done