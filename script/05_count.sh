#!/bin/bash
source "/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/script/utilis.sh"
source activate py36
root=/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2
D=$root/results/04_map
des_dir=$root/results/05_count
script_Dir=$root/script
ano_a=/data2/zhoulab/yuxinghai/songlab/SongGeCKO/anno/human_geckov2_library_a.csv
ano_b=/data2/zhoulab/yuxinghai/songlab/SongGeCKO/anno/human_geckov2_library_b.csv

exist_or_run "python ${script_Dir}/shcount.py $ano_a  ${D}/NC-A1.sam ${D}/A1.sam -o ${des_dir}/screen_A1.csv" ${des_dir}/screen_A1.csv
exist_or_run "python ${script_Dir}/shcount.py $ano_a  ${D}/NC-A1.sam ${D}/A2.sam -o ${des_dir}/screen_A2.csv" ${des_dir}/screen_A2.csv
exist_or_run "python ${script_Dir}/shcount.py $ano_a  ${D}/NC-A1.sam ${D}/A3.sam -o ${des_dir}/screen_A3.csv" ${des_dir}/screen_A3.csv
exist_or_run "python ${script_Dir}/shcount.py $ano_b  ${D}/NC-B1.sam ${D}/B1.sam -o ${des_dir}/screen_B1.csv" ${des_dir}/screen_B1.csv
exist_or_run "python ${script_Dir}/shcount.py $ano_b  ${D}/NC-B1.sam ${D}/B2.sam -o ${des_dir}/screen_B2.csv" ${des_dir}/screen_B2.csv


