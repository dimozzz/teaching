dir=pdf
compiler=xelatex

mkdir $dir

for i in questions.tex; do
	$compiler --output-directory $dir -jobname "${i::-4}" $i
done

cd $dir
rm *.log
rm *.out
rm *.aux
rm *.txt
