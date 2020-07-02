#!/bin/bash


db-build(){
    file=$1
    dir=$2
    if ! pdflatex --output-directory "$dir" -halt-on-error -interaction=nonstopmode "$file" >/dev/null; then
        if !  pdflatex --output-directory "$dir" -halt-on-error -interaction=nonstopmode "$file" >/dev/null; then
            pdflatex --output-directory "$dir" -halt-on-error -interaction=nonstopmode "$file" || true
            echo "Ошибка в сборке $file."
            exit 1
        fi
    fi
}
