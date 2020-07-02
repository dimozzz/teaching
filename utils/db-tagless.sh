#!/bin/bash

rm aux/tagless.txt
touch aux/tagless.txt


cd ../problems-db

for file in $(find -follow -name "*.tex" ! -name "*fig*.tex" ! -name "*default.tex")
do
    str=$(grep -Pozs 'tags{\K.*(\n|.)*(?=})' $file | tr '\0' '\n')
    if [ -z "$str" ]; then
        file1=${file%/*}
        file2=${file#*$file1/}
        echo "${file1#*/}, ${file2%.tex*}" >> ../utils/aux/tagless.txt
    fi
done

