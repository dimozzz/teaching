#!/bin/sh

mkdir aux

dirs=(I II III IV V)
bot=(4 3 1 3 4)
top=(6 5 2 5 6)

number=40

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
