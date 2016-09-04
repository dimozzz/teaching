IFS=$'\n'
file=curseries.tex
mkdir tmp
declare -A tasks
cd tmp
cp ../main.tex .


ser=1
task=1
title=true
break=true
for line in `grep '[^[:blank:]]' ../series.txt`; do
	if [ $title = true ]; then
		echo $title
		echo -e "\setmathstyle{АУ}{$line}{DM \& ML, 1 курс}\n" >> $file
		title=false
		continue
	fi
	if [ $line = "F" ]; then
		let "ser += 1"
		break=true
		title=true
		rm $file
	else
		for i in `echo $line | tr ',' '\n' | tr -d ' '`; do
			if [ "${tasks[$i]}" = "" ]; then
				tasks[$i]=$task
				let "task += 1"
			else
				if [ $break = true ]; then
					echo "\breakline" >> $file
					echo >> $file
				fi
				break=false
			fi
			echo -e "\setcounter{curtask}{${tasks["$i"]}}\n\n" >> $file
			echo "\begin{task}" >> $file
			echo -e "\input{../../../base/problems/"$i".tex}\n\n" >> $file
			echo "\end{task}" >> $file
		done
		pdflatex -jobname "$(printf "%02d" $ser)" main.tex
	fi
		
done

rm main.tex
rm $file

rm *.log
rm *.out
rm *.aux
rm *.txt

