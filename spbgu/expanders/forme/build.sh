dir=pdf
files=("expanders")
mkdir $dir
for i in "${files[@]}"; do
    pdflatex --output-directory $dir $i.tex
    cp main.bib $dir
    cd $dir
    biber $i
    cd ..
    pdflatex --output-directory $dir $i.tex
    pdflatex --output-directory $dir $i.tex
done
