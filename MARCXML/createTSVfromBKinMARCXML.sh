#!/bin/bash
#
# Extract the BK indexing information and write it into a corresponding tsv file

cd /home/mila/Annif-corpora/getdump/TIBKAT_BK_de/xml/

for f in *.xml ; do

    cp $f ../tsv/

done

cd /home/mila/Annif-corpora/getdump/TIBKAT_BK_de/tsv/

for xml in *.xml ; do

	trans=${xml%.xml}.trans

    xmlstarlet sel -N marcxml="http://www.loc.gov/MARC21/slim" -t -v '//marcxml:subfield[@code="2"][text()="bk"]/following-sibling::marcxml:subfield[@code="a"]' -nl "$xml" >> "$trans"

    sed -i -e 's/^/\<http:\/\/uri.gbv.de\/terminology\/bk\//' "$trans"
	sed -i -e 's/\(.*\)[0-9]/&> /' "$trans"

    rm $xml

done

for trans in *.trans ; do

    tsv=${trans%.trans}.tsv

    awk 'FNR==NR{ urls[$1]=$2 } FNR!=NR { print $1"\t"urls[$1] }' /home/mila/Annif-corpora/vocab/bk.tsv $trans >> $tsv

    rm $trans

done