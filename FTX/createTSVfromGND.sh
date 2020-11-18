#!/bin/bash

# Extract the GND indexing information and write it into a corresponding tsv file

for txt in *.txt ; do

	tsv=${txt%.txt}.tsv

	xmlstarlet sel -T -t -m "//subject[@type='gnd'][not(@subtype)]" -v '@id' -o $'\t' -v 'dc:subject[text()]' -nl "$txt" >> "$tsv"
done

for tsv in *.tsv ; do
	sed -i -e 's/^/\<https:\/\/d-nb.info\/gnd\//' "$tsv"
	sed -i -e 's/\(.*\)[0-9X]/&> /' "$tsv"
done
