#!/bin/bash

# Insert a blank page into a pdf. Useful for correctly aligning pages.
# Need blank.pdf

if [ $# -ne 3 ] then
    echo "Usage example: ./pdfInsertBlankPageAt 5 src.pdf res.pdf"
    exit $E_BADARGS
fi

pdftk A="$2" B=blank.pdf cat A1-$(($1-1)) B1 A$1-end output $3

