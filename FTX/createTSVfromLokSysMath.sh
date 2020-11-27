#!/bin/bash
#
# Extract the BK indexing information and write it into a corresponding tsv file

cd /home/mila/Annif-corpora/collections/TIBKAT_LokSys_de/xml/

for f in *.xml ; do

    cp $f ../tsv/

done

cd ../tsv/

for xml in *.xml ; do

    tsv=${xml%.xml}.tsv

    # Extract loc sys code from FTX XML
    xmlstarlet sel -T -t -v "//location[@type='tibLocationCode']" -nl "$xml" >> "$tsv"

    sed -i '/mat/!d' $tsv

    # Remove every character until 'mat' begins
    sed -i -e 's/^.*\(mat.*\).*$/\1/' $tsv

    # Remove the blank between mat and number
    sed -i -e 's/ //g' $tsv

    # Replace the dot in subcategories with an underscore
    tr '.' '_' < $tsv

    # Add URI
    sed -i -e 's/^/\<http:\/\/uricorn.fly\/tib\_lok\_sys\#/' "$tsv"
    sed -i -e 's/\(.*\)[0-9]/&> /' "$tsv"

    # Add name
    awk 'FNR==NR{ urls[$1]=$0 } FNR!=NR { print $2"\t"urls[$1] }' /home/mila/Annif-corpora/vocab/TIBLokSysMath.tsv $tsv > $xml

    # Add tab
    sed -e 's/^[ \t]*//' $xml > $tsv

    # fi

    rm $xml

done

# Test
# echo "$(xmlstarlet sel -T -t -v "//location[@type='tibLocationCode']" -nl $xml)" | sed 's/^.*\(mat.*\).*$/\1/' | sed 's/ //g' | tr '.' '_'