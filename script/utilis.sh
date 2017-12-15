#!/bin/bash

function exist_or_run {
    cmdline=$1
    outfile=$2
    date
    echo ${cmdline}
    if [[ -z ${outfile} || ! -e ${outfile} ]]; then
        eval ${cmdline}
    fi
    date
}


function exist_or_exit {
    infile=$1
    if [[ -z ${infile} || ! -e ${infile} ]]; then
        echo "${infile} not exist"
        exit
    fi
}

