#!/bin/bash
#
# usage: dryland.sh ocean.epub
#
# generates: ocean.dry.epub
#
INFILE=$(readlink -f "$@")
echo $INFILE
OUTFILE="${INFILE%.epub}.dry.epub"

WORKDIR="$(mktemp -d)"

unzip  "${INFILE}" -d ${WORKDIR}

{
    cd ${WORKDIR}
    # I've seen epubs with medtadata permission 000?!?
    chmod --recursive u+rwX .
    rm -f oceanofpdf.com
    find ./O*PS -type f -name \*.\*htm\* -exec \
	 sed -i -e 's_^.*oceanofpdf.*</body>_</body>_' '{}' ';'

    zip -X0 --move "${OUTFILE}" mimetype
    zip -X9r --move "${OUTFILE}"  . -x mimetype
}
rmdir ${WORKDIR}
