#!/bin/bash
# Requirements
#
#   aptitude install time curl
#
# Usage
#
#   ./getdump.sh 
#

#baseurl="https://www.tib.eu/oai/public/repository/open?verb=ListRecords&metadataPrefix=marc_xml&set=collection~tibkat_solr~+classification:bk\:*+language:de"
#baseurl="https://www.tib.eu/oai/public/repository/open?verb=ListRecords&metadataPrefix=marc_xml&set=collection~tibkat_solr~+language:de+xmlPath:subject/@type=gnd"
#baseurl="https://getinfo.tib.eu/oai/intern/repository/tib?verb=ListRecords&metadataPrefix=ftx&set=collection~tibkat_solr~+language:de+xmlPath:subject/@type=gnd+abstract:*"
#baseurl="https://getinfo.tib.eu/oai/intern/repository/tib?verb=ListRecords&metadataPrefix=ftx&set=collection~tibkat_solr~+language:en+xmlPath:subject/@type=gnd+abstract:*"
#baseurl="https://getinfo.tib.eu/oai/intern/repository/tib?verb=ListRecords&metadataPrefix=ftx&set=collection~tibkat_solr~+language:de+locationCode%3A%28L%20mat%2A%20OR%20LB%20mat%2A%29"

baseurl="https://getinfo.tib.eu/oai/intern/repository/tib?verb=ListRecords&metadataPrefix=ftx&set=collection~tibkat_solr~+language:de+xmlPath:classification/@classificationProcedure=mapping"

set -e

#cd /home/mila/Annif-corpora/getdump/TIBKAT_GND_de/dump/
#cd /home/mila/Annif-corpora/getdump/TIBKAT_abstracts_GND_de/dump/
#cd /home/mila/Annif-corpora/getdump/TIBKAT_abstracts_GND_en/dump/
#cd /home/mila/Annif-corpora/collections/TIBKAT_LokSys_de/dump

cd /home/mila/Annif-corpora/collections/TIBKAT_LinSearch_de/dump/

function token {
    xmlstarlet sel -N xmlns="http://www.openarchives.org/OAI/2.0/" -t -v '//_:OAI-PMH/_:ListRecords/_:resumptionToken[text()]' -nl $file
}

i=0

token="___"

while [ -n "$token" ]; do
    echo -n "$i "
    file="oai-`printf %08d $i`.xml"
    if [ $i -eq 0 ]; then
    	url=$baseurl
    else
        url="$baseurl&resumptionToken=$token"
    fi
    duration=$( { /usr/bin/time -f "%e" curl -sS $url > $file; } 2>&1)
    token=$(token $file)
    echo $duration $url

    i=$[i+1]
done