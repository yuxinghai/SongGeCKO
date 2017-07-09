#!/usr/bin/bash
source "/data/zhoulab/yuxinghai/tools/utilis.sh"
RAWDIR=/data5/zhoulab/yuxinghai/SongGeCKO/file/02_decode
des_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/03_exact_20nt_sgRNA
FASTQS=(
A1-F A2-F B1-F B2-F NC-A1-F1 NC-B1-F1 NC-A2-F2 NC-B2-F2
)
numFastqs=${#FASTQS[@]}

for (( i=0; i<${numFastqs}; i++ )); do
    let n=$i+33
    mkdir -p ${des_dir}
    lane=${FASTQS[$i]}
    f_fq=${RAWDIR}/comb_${lane}.fq
    f_cut1=${des_dir}/sg_${lane}.precut.fq
    f_cut=${des_dir}/sg_${lane}.fq
    exist_or_run "cutadapt -f fastq -u ${n}  ${f_fq} -o ${f_cut1}" ${f_cut1}
    exist_or_run "cutadapt -f fastq -l 20 ${f_cut1} -o ${f_cut}" ${f_cut}
    rm ${f_cut1} 
done

