#!/bin/bash

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
		echo -e "\setmathstyle{АУ}{$line}{CC, 5 курс}\n" >> $file
		title=false
		continue
	fi
	if [ $line = "F" ]; then
		echo -e "\input{../people.tex}" >> $file
		pdflatex -jobname "$(printf "%02d" $ser)" main.tex
		let "ser += 1"
		break=true
		title=true
		rm $file
	else
		for i in `echo $line | tr ',' '\n' | tr -d ' '`; do
			if [[ ${i:0:1} == "d" ]] ; then
				echo "\begin{definition}" >> $file
				echo -e "\input{../../base/definitions/"${i:1:15}".tex}" >> $file
				echo "\end{definition}" >> $file
				continue
			fi
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
			echo -e "\input{../../base/problems/"$i".tex}" >> $file
			echo "\end{task}" >> $file
		done
	fi
done

rm main.tex
rm $file

rm *.log
rm *.out
rm *.aux
rm *.txt

