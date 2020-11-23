#!/bin/bash

# Extract the GND indexing information and write it into a corresponding tsv file

cd /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_de/xml/

for xml in *.xml ; do
	
	tsv=${xml%.xml}.tsv

	xmlstarlet sel -N dc="http://purl.org/dc/elements/1.1/" -T -t -m "//subject[@type='gnd'][not(@subtype)]" -v '@id' -o $'\t' -v 'dc:subject[text()]' -nl "$xml" >> "$tsv"

	mv $tsv ../tsv/

done

cd /home/mila/Annif-corpora/collections/TIBKAT_abstracts_GND_de/tsv/

for tsv in *.tsv ; do
	sed -i -e 's/^/\<https:\/\/d-nb.info\/gnd\//' "$tsv"
	sed -i -e 's/\(.*\)[0-9X]/&> /' "$tsv"
done



