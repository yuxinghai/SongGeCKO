import sys
import subprocess

def read_parser(fastq):
    name=[]
    seqs=[]

    with open(fastq,"r") as fq:
        for line in fq:
            line=line.strip()
            #print line[1:-1]
            #exit(0)
            if line[0] == '@':
                name.append(line[1:-1])
            elif line[0]=='+':
                continue
            else:
                seqs.append(line)
    seq=seqs[0::2]
    qual=seqs[1::2]
    return list(zip(name,seq,qual))

def select_proper_end(fastq1,fastq2):
    j=0
    faq2=read_parser(fastq2)
    faq1=read_parser(fastq1)

    p="TCTTGTGGAAAGGACGAAACACCG"

    n=int(int(subprocess.check_output(["wc", "-l",fastq1]).split()[0])/4)
    #print(n)
    #exit(0)
    for i in range(n):
        name1, seq1, qual1 = faq1[i][0].split()[0], faq1[i][1], faq1[i][2]
        name2, seq2, qual2 = faq2[i][0].split()[0], faq2[i][1], faq2[i][2]
        # print faq1[i]
        # print seq1
        # print name1==name2
        # exit(0)

        if name1 == name2:
            # print name1
            # exit(0)
            if p in seq1:
                # print i
                yield name1, seq1, qual1
                # print name1, seq1, qual1
                j += 1
            elif p not in seq1 and p in seq2:
                yield name2, seq2, qual2
                j += 1
            else:
                continue
        else:
            continue



    print(" %d reads write to file" % (j))


if __name__ == "__main__":

    fq1=sys.argv[1]
    fq2=sys.argv[2]
    output=sys.argv[3]
    with open(output,"w") as f:
        for name, seq, qual in select_proper_end(fq1, fq2):

            w='@'+name+"\n"+seq+"\n"+"+"+"\n"+qual+"\n"
            f.write(w)

