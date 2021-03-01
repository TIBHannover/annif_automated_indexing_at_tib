#!/bin/bash
#
# Extract the Law local classification and write it into a corresponding tsv file

cd /home/mila/Annif-corpora/collections/TIBKAT_LokSys_FBR_de/xml/

for f in *.xml ; do

    cp $f ../tsv/

done

cd ../tsv/

for xml in *.xml ; do

    tsv=${xml%.xml}.tsv
    trans=${xml%.xml}.trans

    xmlstarlet sel -T -t -m "//classification[@classificationName='loksys-fbr']" -v 'code[text()]' -nl "$xml" >> "$trans"

    awk -F, '{gsub(/[[:space:]]/,"-",$1)} 1' "$trans" > "$xml"

    sed -i -e 's/^/\<http:\/\/uricorn.fly\/tib_lok_sys\#/' "$xml"
    sed -i -e 's/$/\>/' "$xml"
	
    awk 'FNR==NR{ urls[$1]=$0 } FNR!=NR { print $2"\t"urls[$1] }' /home/mila/Annif-corpora/vocab/TIBLokSysJur.tsv $xml > $tsv

    sed -i 's/^[ \t]*//' $tsv

    echo "$xml converted"

    rm $xml
    rm $trans
done