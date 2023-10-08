#!/bin/sh

mkdir aux

dirs=(I II III IV V)
bot=(1 1 1 1 1)
top=(2 3 1 2 2)

number=4

for i in $(seq 1 $number); do

    cp head.tex aux/$i.tex
    for j in {0..4}; do
        rnd=$RANDOM
        let "rnd %= (top[$j] - bot[$j] + 1)"
        let "rnd += bot[$j]"
        cat ${dirs[$j]}/$rnd.tex >> aux/$i.tex
        echo -e "\n" >> aux/$i.tex
        echo -e "\n" >> aux/$i.tex
    done

    cat tail.tex >> aux/$i.tex
done
