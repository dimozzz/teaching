#!/bin/bash

source src/db-print.sh
source src/db-build.sh
source src/db-open.sh

mkdir -p pdf
lang=ru
res=result
rm aux/$res.tex 2> /dev/null
touch aux/$res.tex
cat aux/main.tex >> aux/$res.tex

cd ../problems-db

emptyflag=false

for file in $(find . -name '*.tex' ! -name '*fig.tex'); do
    str=$(cat $file | tr '\n' ' ')
    str=${str,,}
    pattern=${1,,}
    if [[ $str = *"$pattern"* ]]; then
        emptyflag=true
        head=${file%/*}
        tail=${file#*$head/}
        db-print-problem "${head:2:${#head} - 1}" "${tail:0:${#tail} - 7}" ../utils/aux/$res false
    fi
done

if [[ $emptyflag == "false" ]]; then
    emptyflag=true
    echo "Задач с таким текстом не найдено."
    exit
fi

echo "\end{document}" >> ../utils/aux/$res.tex

cd ../utils/aux
db-build $res.tex ../pdf
db-open-problem ../pdf/$res.pdf &
