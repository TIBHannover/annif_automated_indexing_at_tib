#!/bin/bash
#
# Extract the LinSearch indexing information and write it into a corresponding tsv file

cd /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/xml/

for f in *.xml ; do

    cp $f ../tsv/

done

cd ../tsv/

for xml in *.xml ; do

    tsv=${xml%.xml}.tsv

done