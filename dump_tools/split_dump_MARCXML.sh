#!/bin/bash
#
# Splits the dump into individual files per document data set, 
# moves them into another directory and renames them according 
# to their collection and its identifier.
#
# ./split_dump_MARCXML.sh 
# To be executed in the directory where the respective xml files are kept. There needs to be another directory ../xml.

for xml_file in *.xml ; do

    xml_split -l 2 -n 7 -e .trans $xml_file

done

find . -type f -name 'oai-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-0000000.trans' | xargs rm

for trans_file in *.trans ; do
    mv $trans_file ../xml
done 

cd ../xml

for trans_file in *.trans; do
    newFileNameSet=$(xmlstarlet sel -t -v '//record/header/setSpec[text()]' -nl $trans_file)
    newFileNameID=$(xmlstarlet sel -N marcxml="http://www.loc.gov/MARC21/slim" -t -m "//marcxml:collection/marcxml:record/marcxml:controlfield[@tag='001']" -v '(//marcxml:collection/marcxml:record/marcxml:controlfield[text()])[1]' -nl $trans_file)
    newFileName="${newFileNameSet}${newFileNameID}.xml"
    mv $trans_file $newFileName
done