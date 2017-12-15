#!/usr/bin/bash
root=/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2
source "/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/script/utilis.sh"
RAWDIR=$root/results/02_decode
des_dir=$root/results/03_20nt_sgRNA
FASTQS=(A1 B1 NC-A1 NC-B1 A2 A3 B2)
numFastqs=${#FASTQS[@]}
n1=32 # barcode+primer_site
adapter_3="GTTTTAGAG" # 3'adapter
#no strag is the difference from zhaonan
for (( i=0; i<${numFastqs}; i++ )); do
    
    lane=${FASTQS[$i]}
    f_fq=${RAWDIR}/${lane}.fq
    f_cut1=${des_dir}/sg_${lane}.precut.fq
    f_cut=${des_dir}/sg_${lane}.fq
    exist_or_run "cutadapt -f fastq -u ${n1}  ${f_fq} -o ${f_cut1}" ${f_cut1}
    exist_or_run "cutadapt -f fastq -a ${adapter_3} -m 17 -M 23 ${f_cut1} -o ${f_cut}" ${f_cut}
    rm ${f_cut1} 
done

