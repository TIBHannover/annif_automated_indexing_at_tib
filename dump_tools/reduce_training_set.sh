#!/bin/bash

cd /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/xml/

ls /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/xml/ / |sort -R |tail -150000 |while read file; do
    
    file_xml=${file%.xml}.xml

    rm /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/xml/$file_xml

done