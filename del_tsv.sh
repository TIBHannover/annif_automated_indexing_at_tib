#!/bin/bash

cd /home/mila/Annif-corpora/getdump/TIBKAT_BK_de/tsv/

for f in *.tsv ; do
	rm $f
done
