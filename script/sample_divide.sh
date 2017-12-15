#!/usr/bin/bash
root=/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2
dir=$root/results/02_decode
primer_Site="TCTTGTGGAAAGGACGAAACACCG"
A1_barcode="ACACGATC"
B1_barcode="CATGATCG"
NC_A1_barcode="AACGCATT"
NC_B1_barcode="ACAGGTAT"
B2_barcode="AGGTCGCA"
A2_barcode="ACTGTATC"
A3_barcode="AACAATGG"

NAMES=(A1 NC-A1 A2 A3 B1 NC-B1 B2)
BARCODES=($A1_barcode ${NC_A1_barcode} $A2_barcode $A3_barcode $B1_barcode $NC_B1_barcode $B2_barcode)
numSamples=${#NAMES[@]}
for (( i=0; i<${numSamples}; i++ )); do
    name=${NAMES[$i]}
    barcode=${BARCODES[$i]}
    multi_barcode=$barcode$primer_Site
    grep "\!${multi_barcode}.*TTTTAGAG" $1 |sed -r 's/\!/\n/g' >${dir}/${name}.fq
done
