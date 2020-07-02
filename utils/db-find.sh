#!/bin/bash

source src/db-print.sh
source src/db-build.sh
source src/db-open.sh


params=""
lang=ru
name=false
force=false
open=true
exdir="''"
while (( "$#" )); do
    case "$1" in
        -f)
            force=true
            shift
        ;;
        -n)
            name=true
            shift
        ;;
        -h)
            open=false
            shift
        ;;
        -ex)
            shift
            exdir=${1//\,/\|^}
            exdir="-v '("^${exdir}")'"
            shift
        ;;
        *)
            params="$params $1"
            shift
        ;;
    esac
done


cd aux
#com="cat tags.txt"
com="egrep "${exdir}" tags.txt"
file=result

rm $file.tex 2> /dev/null
touch $file.tex
cat main.tex >> $file.tex

#препроцессинг, да (как-то он не быстро работает, надо бы без awk попробовать)
#declare -A problems

#if [ "$force" = true ] ; then
#    str=$(cat problem-usage.txt)
#    readarray -t strings <<<"$str"
#    for i in $(seq 0 $((${#strings[@]} - 1))); do
#        head=$(echo -e "${strings[$i]%:*}" | awk '$1=$1')
#        tail=$(echo -e "${strings[$i]#*:}" | awk '$1=$1' | tr ';' '\n')
#        problems[$head]=$tail
#    done
#fi


if [ "$name" = false ] ; then
    IFS=' ' read -ra tags <<< "$params"
    for index in $(seq 0 $((${#tags[@]} - 1))); do
        com=${com}" | grep '[[:space:]]${tags[$index]}\b'"
    done

    com=${com}"| tr '\n' ' '"
    res=$(eval "$com")

    IFS=';' read -ra tasks <<< "$res"

    if [ ${#tasks[@]} -lt 2 ]; then
        echo "Задач с такими тегами не найдено."
        exit
    fi

    for i in $(seq 0 $((${#tasks[@]} - 2))); do
        curtask=$(echo -e "${tasks[$i]%:*}" | awk '$1=$1')
        head=$(echo -e "${curtask%,*}" | awk '$1=$1')
        tail=$(echo -e "${curtask#*,}" | awk '$1=$1')
        db-print-problem $head $tail $file $force
    done
else
    IFS=' ' read -ra names <<< "$params"
    if [ ! -f "../../problems-db/${names[0]}/${names[1]}.$lang.tex" ]; then
        echo "Файл с задачей не найден."
        exit
    fi
    db-print-problem ${names[0]} ${names[1]} $file $force
fi

echo "\end{document}" >> $file.tex

mkdir -p ../pdf


db-build $file ../pdf

if [ "$open" = true ] ; then
    db-open-problem ../pdf/$file.pdf &
fi
