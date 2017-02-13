mkdir tmp

pdflatex --output-directory tmp -jobname "table" main.tex

cd ../tmp
rm *.log
rm *.aux
rm *.txt
