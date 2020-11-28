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
    xmlstarlet sel -T -t -v "//location[@type='tibLocationCode']" -nl "$xml" > "$tsv"

    # Remove every line that does not contain 'mat'
    sed -i '/mat/!d' $tsv

    # Remove every "Z" and "e" and "g" in string
    sed -i 's/Z//' $tsv
    sed -i 's/e//' $tsv
    sed -i 's/g//' $tsv

    # Remove "a" if it is the last character in a line
    sed -i 's/a$//' $tsv

    # Remove everything after and including dash "-"
    cat $tsv | cut -f1 -d"-" > $xml

    # Remove every character until 'mat' begins
    sed -i -e 's/^.*\(mat.*\).*$/\1/' $xml

    # Remove the blank between mat and number
    sed -i -e 's/ //g' $xml

    # Replace the dot in subcategories with an underscore
    tr '.' '_' < $xml

    # Add URI
    sed -i -e 's/^/\<http:\/\/uricorn.fly\/tib\_lok\_sys\#/' "$xml"
    sed -i -e 's/\(.*\)[0-9]/&> /' "$xml"

    # Add name
    awk 'FNR==NR{ urls[$1]=$0 } FNR!=NR { print $2"\t"urls[$1] }' /home/mila/Annif-corpora/vocab/TIBLokSysMath.tsv $xml > $tsv

    # Add tab
    sed -e 's/^[ \t]*//' $tsv > $xml

    uniq $xml $tsv

    rm $xml 

done

# Test
# echo "$(xmlstarlet sel -T -t -v "//location[@type='tibLocationCode']" -nl $xml)" | sed 's/^.*\(mat.*\).*$/\1/' | sed 's/ //g' | tr '.' '_'