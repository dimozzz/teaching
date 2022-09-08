compiler=xelatex
dir=pdf
#files=("big-questions" "small-questions" "problems" "pr" "1")
files=("1" "2" "3")
mkdir $dir
for i in "${files[@]}"; do
    $compiler --output-directory $dir $i.tex
done
