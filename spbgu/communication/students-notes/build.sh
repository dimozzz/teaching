compiler=xelatex
dir=pdf
file=notes
mkdir $dir
$compiler --output-directory $dir $file.tex
cp references.bib $dir
cd $dir
biber notes
cd ..
#$compiler --output-directory $dir $file.tex
#%$compiler --output-directory $dir $file.tex
