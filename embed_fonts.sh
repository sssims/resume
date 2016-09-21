# DESCRIPTION
# Embeds fonts in pdf for portability.
#
# USAGE 
# ./embed_fonts.sh unembedded_pdf_name [embedded_pdf_name]
# 
# ARGUMENTS
# unembedded_pdf_name	- pdf to embed fonts inside
# embedded_pdf_name	- output pdf with embedded fonts.
#			  Defaults to embedded_pdf_name.

#!/bin/bash

if [ -z "$1" ]
  then
    echo "USAGE: ./embed_fonts.sh unembedded_pdf_name [embedded_pdf_name]"
    exit 1
fi

output_filename=$1

if ! [ -z "$2" ]
  then
    output_filename="$2"
fi

echo "Embedding fonts into $1; writing to $output_filename"

gs -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=/screen \
   -dCompressFonts=true \
   -dSubsetFonts=true \
   -dNOPAUSE \
   -dBATCH \
   -sDEVICE=pdfwrite \
   -sOutputFile=.embed_fonts_temp.pdf \
   -c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" \
   -f $1

embed_script_exit=$?

mv .embed_fonts_temp.pdf $output_filename

if [ "$embed_script_exit" -eq "0" ]
  then
    echo "Fonts successfully embedded into $output_filename"
else
    echo "Fonts FAILED to embed; see script output above"
fi
