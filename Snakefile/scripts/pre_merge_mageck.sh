#!/bin/bash
raw_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/05_count
des_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/07_mageck_merge
NAMES=(A B)
mkdir -p ${des_dir}
numSamples=${#NAMES[@]}
for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    awk -v OFS='\t' '{print $2,$1,$4,$5,$6}' ${raw_dir}/merge_${name}.tsv > ${des_dir}/merge_${name}.txt
    sed -i "1i sgRNA\tgene\tNC-${name}-merge\t${name}1\t${name}2" ${des_dir}/merge_${name}.txt
done
