#!/bin/bash
cd /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_de/xml/

for f in *.xml ; do

    cp $f ../txt/

done

cd ../txt/

for f in *.xml ; do

    awk '{gsub(/<[^>]*>/,"")};1' $f > $f.sansXML
    sed -e 's/^[ \t]*//' $f.sansXML > $f

    rm $f.sansXML
    mv "$f" "$(basename "$f" .xml).txt"

done