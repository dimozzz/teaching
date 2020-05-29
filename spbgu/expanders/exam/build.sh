compiler=xelatex
dir=pdf
files=("big-questions" "small-questions" "problems")
mkdir $dir
for i in "${files[@]}"; do
    $compiler --output-directory $dir $i.tex
    cp main.bib $dir
    cd $dir
    biber $i
    cd ..
    $compiler --output-directory $dir $i.tex
    $compiler --output-directory $dir $i.tex
done
