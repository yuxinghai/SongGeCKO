#!/bin/bash
source "/data/zhoulab/yuxinghai/tools/utilis.sh"

NAMES=(A1 B1 A2 B2)
numSamples=${#NAMES[@]}
raw_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/05_count
des_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/06_mageck
numSamples=${#NAMES[@]}
for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    awk -v OFS='\t' '{print $2,$1,$4,$5}' ${raw_dir}/screen_${name}.csv > ${des_dir}/screen_${name}.txt
    sed -i "1i sgRNA\tgene\tNC-${name}\t${name}" ${des_dir}/screen_${name}.txt
    if [ $i -lt 1 ];then
        exist_or_run "mageck test -k ${des_dir}/screen_${name}.txt -t ${name} -c NC-${name} --norm-method total --normcounts-to-file --sort-criteria pos --adjust-method fdr -n ${des_dir}/${name} --pdf-report" ${des_dir}/${name}.gene_summary.txt
    else
        exist_or_run "mageck test -k ${des_dir}/screen_${name}.txt -t ${name} -c NC-${name} --norm-method total --normcounts-to-file --sort-criteria pos --adjust-method fdr -n ${des_dir}/${name} --pdf-report" ${des_dir}/${name}.gene_summary.txt
    fi
done

