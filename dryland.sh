#!/bin/bash
#
# usage: dryland.sh ocean.epub
#
# generates: ocean.dry.epub
#
INFILE="$(readlink -f $1)"
echo $INFILE
OUTFILE="${INFILE%.epub}.dry.epub"

WORKDIR="$(mktemp -d)"

unzip  "${INFILE}" -d ${WORKDIR}

{
    cd ${WORKDIR}
    rm -f oceanofpdf.com
    sed -i -e 's_^.*oceanofpdf.*</body>_</body>_' ./O*PS/*.xhtml

    zip -X0 --move "${OUTFILE}" mimetype
    zip -X9r --move "${OUTFILE}"  . -x mimetype
}
rmdir ${WORKDIR}
