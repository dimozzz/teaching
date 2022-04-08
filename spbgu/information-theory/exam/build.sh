compiler=xelatex
dir=pdf
mkdir $dir

cd aux
for i in *.tex; do
    $compiler --output-directory ../$dir $i
done

cd ../$dir
rm *.out
rm *.aux
rm *.log
