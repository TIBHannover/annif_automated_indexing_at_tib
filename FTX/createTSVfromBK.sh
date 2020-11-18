#!/bin/bash

# Extract the BK indexing information and write it into a corresponding tsv file

for txt in *.txt ; do

	tsv=${txt%.txt}.tsv

	xmlstarlet sel -T -t -m "//classification[@classificationName='bk']" -v 'code[text()]' -o $'\t' -v 'entries/entry[text()]' -nl "$txt" >> "$tsv"
done

for tsv in *.tsv ; do
	sed -i -e 's/^/\<http:\/\/uri.gbv.de\/terminology\/bk\//' "$tsv"
	sed -i -e 's/\(.*\)[0-9]/&> /' "$tsv"
done