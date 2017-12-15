#!/usr/bin/env python
"""
Make lentiPool Fasta file
"""
import os
import sys
from Bio.Seq import Seq
import sys

if __name__ == '__main__':
    dir_fa= sys.argv[1]
    
    f_pool1 = "/data2/zhoulab/yuxinghai/songlab/SongGeCKO/anno/human_geckov2_library_a.csv"
    foh = open(dir_fa+"/crisprpool_A.fa", "w")
    for line in open(f_pool1):
        if line.startswith("gene_id"):
            continue

        f = line.rstrip().split(",")
        s = Seq(f[2])
        foh.write(">%s\n%s\n" % (f[1], f[2] + "CTCGAG" + s.reverse_complement()))
    foh.close()
    
    f_pool2 = "/data2/zhoulab/yuxinghai/songlab/SongGeCKO/anno/human_geckov2_library_b.csv"
    foh = open(dir_fa+"/crisprpool_B.fa", "w")
    for line in open(f_pool2):
        if line.startswith("gene_id"):
            continue

        f = line.rstrip().split(",")
        s = Seq(f[2])
        foh.write(">%s\n%s\n" % (f[1], f[2] + "CTCGAG" + s.reverse_complement()))
    foh.close()

