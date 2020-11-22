#!/bin/bash
#
# Splits the dump into individual files per document data set, 
# moves them into another directory and renames them according 
# to their collection and its identifier.
#
# ./split_dump_FTX.sh 
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
    newFileName=$(xmlstarlet sel -t -v '//document/@id' -nl $trans_file)

    newFileName=$(echo "$newFileName" | tr '[:upper:]' '[:lower:]')
    
    newFileName=$(echo "$newFileName" | tr -d :)
  
    newFileName="${newFileName}.xml"
    mv $trans_file $newFileName
done