#!/bin/bash


db-open-problem(){
    resp=`uname -s`
    if [ $resp == "Darwin" ]; then
        cmd="open"
    else
	    cmd="zathura"
    fi
    $cmd $1 &
}

