#!/usr/bin/env bash

if [ "$1" == "" ]; then
    echo "Please specify file name!"
    exit
fi

compile=asciidoctor
# compile="asciidoctor -r asciidoctor-bibliography"
# compile="asciidoctor -r asciidoctor-diagram"
# compile="asciidoctor-latex -b html"

adoc_file=${1%.*}.adoc
html_file=${1%.*}.html
$compile $adoc_file
browser-sync start --server --no-notify --watch $html_file --index $html_file&

while true; do
    inotifywait $adoc_file -e move_self && $compile $adoc_file
done
