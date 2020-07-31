dir=pdf
compiler=xelatex
mkdir $dir
$compiler --output-directory $dir main.tex
cp main.bib $dir
cd $dir
biber main
cd ..
$compiler --output-directory $dir main.tex
$compiler --output-directory $dir main.tex
