#!/usr/bin/bash
script_dir=/data5/zhoulab/yuxinghai/SongGeCKO/script
raw_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/02_decode
des_dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/02_decode
python ${script_dir}/readfq.py ${raw_dir}/A1_combined_1.fastq ${raw_dir}/A1_combined_2.fastq ${des_dir}/A1_combined_process.fastq
