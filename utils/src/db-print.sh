#!/bin/bash

db-print-problem(){
    head=$1
    tail=$2
    file=$3
    force=$4
    echo "\libproblem{$head}{$tail}" >> $file.tex
    echo "" >> $file.tex
    echo "\vspace{0.1cm}" >> $file.tex
    echo "\textbf{Файл:} $head, $tail" >> $file.tex
    echo "" >> $file.tex
    if [ "$force" = true ] ; then
        str=$(grep "$head, $tail:" problem-usage.txt)
        tail=$(echo "${str#*:}" | awk '$1=$1')
        echo "\textbf{Использование:} {\small" >> $file.tex
        IFS=';' read -ra temp <<< "$tail"
        for i in $(seq 0 $((${#temp[@]} - 1))); do
            echo -e "${temp[$i]}\n" >> $file.tex
            echo -e "\n" >> $file.tex
        done
        echo "}" >> $file.tex
    fi
    echo "" >> $file.tex
}
