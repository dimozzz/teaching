dir=pdf
compiler=xelatex

mkdir $dir
$compiler --output-directory $dir main.tex

cd ../$dir
rm *.log
rm *.out
rm *.aux
rm *.txt
