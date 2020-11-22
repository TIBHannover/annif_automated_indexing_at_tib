#!/bin/bash
#
# Extract the BK indexing information and write it into a corresponding tsv file

cd /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_de/xml/

for f in *.xml ; do

    cp $f ../tsv/

done

cd /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_de/tsv/

for xml in *.xml ; do

	trans=${xml%.xml}.trans
    tsv=${trans%.trans}.tsv

    xmlstarlet sel -N marcxml="http://www.loc.gov/MARC21/slim" -t -v '//marcxml:subfield[@code="2"][text()="bk"]/following-sibling::marcxml:subfield[@code="a"]' -nl "$xml" >> "$trans"

    sed -i -e 's/^/\<http:\/\/uri.gbv.de\/terminology\/bk\//' "$trans"
	sed -i -e 's/\(.*\)[0-9]/&> /' "$trans"

    awk 'FNR==NR{ urls[$1]=$0 } FNR!=NR { print $2"\t"urls[$1] }' /home/mila/Annif-corpora/vocab/bk.tsv $trans > $xml

    sed -e 's/^[ \t]*//' $xml >> $tsv

    rm $xml
    rm $trans

done