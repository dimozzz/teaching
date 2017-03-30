#!/bin/bash

mkdir tmp
python exam.py problems.tex output.tex 15 2 1 1 1
pdflatex --output-directory="tmp" main.tex
pdflatex --output-directory="tmp" main.tex
mv output.tex tmp

cd tmp
rm *.log
rm *.out
rm *.aux
rm *.txt
