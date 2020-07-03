#!/bin/bash

rm -rf aux
mkdir aux
touch aux/tags.txt
touch aux/unique-tags.txt


cat "../main.tex" <(echo) > aux/main.tex
echo "\renewcommand{\coursetitle}{ALL}" >> aux/main.tex
echo "\setmathstyle{\date}{script-build}{}" >> aux/main.tex
echo "\begin{document}" >> aux/main.tex
echo "\tagsmode" >> aux/main.tex
echo "\teachermode" >> aux/main.tex

cd ../problems-db

echo "Начинаем построение таблицы тегов."

declare -A tagsarray

for file in $(find -follow); do
    str=$(grep -Pozs 'tags{\K.*?(\n|.)*?(?=})' $file | tr '\0' '\n')
    if [ -n "$str" ]; then
        file1=${file%/*}
        file2=${file#*$file1/}
        echo "${file1#*/}, ${file2%.tex*}: $str;" >> ../utils/aux/tags.txt
        IFS=',' read -r -a array <<< "$str"
        for i in $(seq 0 $((${#array[@]} - 1))); do
            tagsarray[$(echo -e "${array[$i]}" | awk '$1=$1')]=1
        done
    
    fi
done

cd ../utils

uniquetags=()

for i in "${!tagsarray[@]}"; do
    uniquetags+=("$i")
done

IFS=$'\n' sorted=($(sort <<<"${uniquetags[*]}"))
printf "%s\n" "${sorted[@]}" >> aux/unique-tags.txt



#if [ {$?} = 0 ] ; then exit; fi
if [ "$1" != "-f" ] ; then exit; fi

echo "Начинаем построение таблицы использования задач."

declare -A problems

touch aux/problem-usage.txt
cd ..

for file in $(find . -type d \( -path ./problems-db -o -path ./.git \) -prune -o -name '*.tex' -print); do
    str=$(grep 'libproblem{' $file)
    str=$(echo "${str}" | tr '\n' ' ')
    while [[ $str = *"libproblem"* ]]; do
        str=$(echo "${str#*libproblem{}")
        head=$(echo "$str" | sed 's/}{.*//')
        str=$(echo "${str#*\}{}")
        tail=$(echo "$str" | sed 's/}.*//')
        str=$(echo "${str#*\}}")
        prob="$head, $tail"
        nfile=$(echo "${file//_/\\_}")
        problems[$prob]+="$nfile; "
    done
done

for i in "${!problems[@]}"; do
    echo "$i: ${problems[$i]}" >> utils/aux/problem-usage.txt
done
