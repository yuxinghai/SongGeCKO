#!/bin/bash
source "/data/zhoulab/yuxinghai/tools/utilis.sh"

des_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/07_mageck_merge

NAMES=(A B)
numSamples=${#NAMES[@]}
for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    if [ $i -lt 1 ];then
        exist_or_run "mageck test -k ${des_dir}/merge_${name}.txt -t ${name}1,${name}2 -c NC-A-merge  --normcounts-to-file --sort-criteria pos --adjust-method fdr -n ${des_dir}/${name} --pdf-report" ${des_dir}/${name}.gene_summary.txt
    else
        exist_or_run "mageck test -k ${des_dir}/merge_${name}.txt -t ${name}1,${name}2 -c NC-B-merge --normcounts-to-file --sort-criteria pos --adjust-method fdr -n ${des_dir}/${name} --pdf-report" ${des_dir}/${name}.gene_summary.txt
    fi
done

