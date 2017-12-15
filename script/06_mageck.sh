#!/bin/bash
source "/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/script/utilis.sh"
source activate py27
NAMES=(A1 B1 A2 B2 A3)
numSamples=${#NAMES[@]}
root=/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2
raw_dir=$root/results/05_count
des_dir=$root/results/06_mageck
for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    awk -v OFS='\t' '{print $2,$1,$4,$5}' ${raw_dir}/screen_${name}.csv > ${des_dir}/screen_${name}.txt
    if (($i%2==0));then
        sed -i "1i sgRNA\tgene\tNC-A1\t${name}" ${des_dir}/screen_${name}.txt
        exist_or_run "mageck test -k ${des_dir}/screen_${name}.txt -t ${name} -c NC-A1 --norm-method total --normcounts-to-file --sort-criteria pos --adjust-method fdr -n ${des_dir}/${name} --pdf-report" ${des_dir}/${name}.gene_summary.txt
    else
        sed -i "1i sgRNA\tgene\tNC-B1\t${name}" ${des_dir}/screen_${name}.txt
        exist_or_run "mageck test -k ${des_dir}/screen_${name}.txt -t ${name} -c NC-B1 --norm-method total --normcounts-to-file --sort-criteria pos --adjust-method fdr -n ${des_dir}/${name} --pdf-report" ${des_dir}/${name}.gene_summary.txt
    fi
done

