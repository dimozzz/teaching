#!/bin/sh

mkdir aux

dirs=(I II III IV V)
bot=(2 8 5 8 8)
top=(4 9 5 9 9)

number=70

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
