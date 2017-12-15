#!/usr/bin/bash
RAWDIR=/data5/zhoulab/yuxinghai/SongGeCKO/file/03_exact_20nt_sgRNA
des_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/03_exact_20nt_sgRNA
FASTQS=(
A1-F A2-F B1-F B2-F NC-A1-F1 NC-B1-F1 NC-A2-F2 NC-B2-F2
)
numFastqs=${#FASTQS[@]}

for (( i=0; i<${numFastqs}; i++ )); do
    lane=${FASTQS[$i]}
    f_cut=${des_dir}/sg_${lane}.fq
    f_output=${des_dir}/sample_satistics.txt
    wc -l ${f_cut} >> ${f_output}
done

