mkdir tmp
pdflatex --output-directory tmp main.tex
cp main.bib tmp
cd tmp
bibtex main
cd ..
pdflatex --output-directory tmp main.tex
pdflatex --output-directory tmp main.tex
