dir=pdf
files=(test-3 test-2 test-1)
compiler=xelatex
mkdir $dir
for i in "${files[@]}"; do
    $compiler --output-directory $dir $i.tex
#    cp references.bib $dir
#    cd $dir
#    biber $i
#    cd ..
#    $compiler --output-directory $dir $i.tex
#    $compiler --output-directory $dir $i.tex
done
