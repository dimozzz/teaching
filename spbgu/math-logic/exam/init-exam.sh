#!/bin/sh

mkdir aux

dirs=(I II III IV V)
bot=(1 1 1 1 1)
top=(2 2 2 1 3)

number=50

for i in $(seq 1 $number); do

    cp head.tex aux/$i.tex
    echo -e "\n" >> aux/$i.tex
    echo "\setmathstyle{\includegraphics[scale = 0.05]{../pics/utia-blood.png}}{Вариант " >> aux/$i.tex
    echo $i >> aux/$i.tex
    echo "}{Мат. логика}" >> aux/$i.tex
    echo -e "\n" >> aux/$i.tex
    cat head-2.tex >> aux/$i.tex
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
