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
    trans=${xml%.xml}.trans

    xmlstarlet sel -T -t -m "//classification[@classificationProcedure='mapping']" -v 'code[text()]' -nl "$xml" >> "$trans"

    sed -i -e 's/^/\<http:\/\/uricorn.fly\/linsearch\#/' "$trans"
    sed -i -e 's/$/\>/' "$trans"
	
    awk 'FNR==NR{ urls[$1]=$0 } FNR!=NR { print $2"\t"urls[$1] }' /home/mila/Annif-corpora/vocab/LinSearch.tsv $trans > $tsv

    sed -i 's/^[ \t]*//' $tsv

    rm $xml
    rm $trans
done