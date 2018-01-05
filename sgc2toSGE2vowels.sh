#!/bin/bash
#
if [[ "$PWD" =~ VowelProt ]]; then
	cd ..
fi
CURRENTWORKINGDIR=`PWD`


# Run patch
patch < ${CURRENTWORKINGDIR}/VowelProt/sgc2.patch

# Set up wordlists
cd wordlists
rm -r *
cp -r ../VowelProt/wordlists/* ./


