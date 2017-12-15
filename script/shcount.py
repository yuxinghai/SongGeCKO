#!/usr/bin/bash
#!/usr/bin/env python
"""Count shRNA from mapped file"""

import os
import sys
import pysam
import optparse
from collections import defaultdict
import HTSeq

def process_command_line(argv):
    if argv is None:
        argv = sys.argv[1:]
    usage = "usage: %prog [options] f_pool sam1 [sam2 ..]"
    parser = optparse.OptionParser(usage,
        formatter=optparse.TitledHelpFormatter(width=178),
        add_help_option=None)

    parser.add_option('-o', '--outfile', dest='outfile',
        help='outfile name[default None, to stdout]', metavar="FILE")

    parser.add_option('-h', '--help', action='help',
        help='Show this help message and exit.')

    (options, args) = parser.parse_args(argv)
    if len(args) < 2:
        parser.error('No required parameters')

    return options, args


def countref(samfile):
    sam = pysam.Samfile(samfile, 'r')
    ref2cnt = defaultdict(int)
    i = 0
    for hit in sam.fetch():
        i += 1
        if hit.is_unmapped:
            continue
        if i % 1000000 == 0:
            sys.stderr.write("%d\n" % i)
        chrom = sam.references[hit.rname]
        ref2cnt[chrom] += 1

    return ref2cnt

def htcount(samfile):
    sam = HTSeq.SAM_Reader(samfile)
    ref2cnt = defaultdict(int)
    i = 0
    for hit in sam:
        i += 1
        if hit.aligned:
            chrom = hit.iv.chrom
            ref2cnt[chrom] += 1
        if i % 1000000 == 0:
            sys.stderr.write("%d\n" % i)

    return ref2cnt


if __name__ == '__main__':
    options, args = process_command_line(None)
    f_pool = args[0]
    samfiles = args[1:]
    for samfile in samfiles:
        assert os.path.exists(samfile)

    cid2gene = {}
    for line in open(f_pool):
        if line.startswith("gene_id"):
            continue
        vs = line.rstrip().split(",")
        cid2gene[vs[1]] = vs

    sys.stderr.write("#crispr: %d\n" % len(cid2gene))
    outfile = options.outfile
    foh = sys.stdout
    if outfile:
        foh = open(outfile, 'w')

    cntli = []
    for samfile in samfiles:
        sys.stderr.write("Counting %s ..\n" % samfile)
        cntdic = htcount(samfile)
        sys.stderr.write("#crispr with count: %d, total count: %d\n" % (
            len(cntdic), sum(cntdic.values())))
        cntli.append(cntdic)

    for cid in sorted(cid2gene):
        counts = [cntli[i][cid] for i in range(len(cntli))]
        foh.write("\t".join(cid2gene[cid] + list(map(str,counts)))+"\n")

    if outfile:
        foh.close()

