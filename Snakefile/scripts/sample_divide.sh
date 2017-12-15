#!/usr/bin/bash

source "/data/zhoulab/yuxinghai/tools/utilis.sh"
dir=/data5/zhoulab/yuxinghai/SongGeCKO/file/02_decode
grep "TAAGTAGAG" ${dir}/A1_filter_2.fq >${dir}/A1-F.fq
grep "ATACACGATC" ${dir}/A1_filter_2.fq >${dir}/A2-F.fq
grep "GATCGCGCGGT" ${dir}/A1_filter_2.fq >${dir}/B1-F.fq
grep "CGATCATGATCG" ${dir}/A1_filter_2.fq >${dir}/B2-F.fq
grep "TCGATCGTTACCA" ${dir}/A1_filter_2.fq >${dir}/NC-A1-F1.fq
grep "ATCGATTCCTTGGT" ${dir}/A1_filter_2.fq >${dir}/NC-B1-F1.fq
grep "GATCGATAACGCATT" ${dir}/A1_filter_2.fq >${dir}/NC-A2-F2.fq
grep "CGATCGATACAGGTAT" ${dir}/A1_filter_2.fq >${dir}/NC-B2-F2.fq
