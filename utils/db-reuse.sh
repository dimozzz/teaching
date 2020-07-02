#!/bin/bash

len=16

if [[ "$@" ]]; then
    len=$1
fi


res=result
rm aux/$res.txt 2> /dev/null
touch aux/$res.txt

declare -A tasks

cd ..

for file in $(find problems-db -name '*.tex'); do

    if [[ $file == *"fig"* ]]; then
        continue
    fi

    if [[ $file == *"default"* ]]; then
        continue
    fi
    
    pattern=$(cat $file | tr '\n' ' ')
    #pattern=${pattern,,} #(to lowercase)
    pattern=${pattern:0:$len}

    echo "$file   $pattern"
    str=$(grep -rn . --exclude-dir=utils --exclude-dir=problems-db --include="*.tex" -e "$pattern")
    if [[ ${#str} -ge 2 ]]; then
        tasks[$file]=$str
    fi
done


for i in "${!tasks[@]}"; do
    echo "Problem................... $i" >> utils/aux/$res.txt
    echo "${tasks[$i]}"  >> utils/aux/$res.txt
done
