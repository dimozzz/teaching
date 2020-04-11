dir=pdf
compiler=pdflatex

mkdir $dir
touch $dir/number.txt
cd series
for i in *.tex; do
	$compiler --output-directory ../$dir -jobname "${i::-4}" $i
done

cd ../$dir
rm *.log
rm *.out
rm *.aux
rm *.txt
