dir=pdf
compiler=xelatex
file=main

mkdir $dir
$compiler --output-directory $dir -jobname $file $file.tex

cd ../$dir
rm *.log
rm *.out
rm *.aux
rm *.txt
