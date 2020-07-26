#!/bin/bash


db-build(){
    compiler=pdflatex
    file=$1
    dir=$2
    if ! $compiler --output-directory "$dir" -halt-on-error -interaction=nonstopmode "$file" >/dev/null; then
        if ! $compiler --output-directory "$dir" -halt-on-error -interaction=nonstopmode "$file" >/dev/null; then
            $compiler --output-directory "$dir" -halt-on-error -interaction=nonstopmode "$file" || true
            echo "Ошибка в сборке $file."
            exit 1
        fi
    fi
}
