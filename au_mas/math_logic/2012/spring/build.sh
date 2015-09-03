mkdir tmp
for i in *; do
	if typeset -i "$i" 2> /dev/null; then
		echo -n
	else
		if test -d "$i"; then
			cp main.tex "$i"
			cd "$i"
			pdflatex --output-directory ../tmp -jobname "$i" main.tex
			pdflatex --output-directory ../tmp -jobname "$i" main.tex
			rm main.tex
			cd ..	
		fi
	fi
done

cd tmp
rm *.log
rm *.aux
