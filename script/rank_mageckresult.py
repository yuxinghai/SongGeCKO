import sys

def sgRNA_summary_parser(input_file):

    gene_dic={}
    sgrna_list=[]
    with open(input_file, mode='r') as infile:  # rU mode is necessary for excel!
        gene_tmp = ""
        i = 0
        for rows in infile:
            if "gene" in rows:
                continue
            Gene,sgrna,control_count,treatment_count,LFC,FDR= rows.strip().split("\t")
            if i == 0:
                gene_tmp = Gene

            if gene_tmp == Gene:
                i += 1
                sgrna_list.append([sgrna, control_count, treatment_count, LFC, FDR])

            else:
                gene_dic[gene_tmp] = sgrna_list
                sgrna_list = []

                sgrna_list.append([sgrna, control_count, treatment_count, LFC, FDR])
                gene_tmp = Gene
                i += 1
        gene_dic[gene_tmp] = sgrna_list

    return gene_dic

if __name__ == '__main__':
    dic1 = sgRNA_summary_parser(sys.argv[1])
    '''
    for gene_f, sgrna_list in dic1.items():
        for sgrna in sgrna_list:

            print gene_f,sgrna[0],sgrna[3]
    exit(0)
    '''
    lfc_Sum = 0
    sgrna_list = []
    with open(sys.argv[2], "w") as output:
        output.write("\t".join(["gene", "lfc_agv", "unique_Sgrna", "total_Sgrna"]) + "\n")
        for gene_f, sgrna_n in dic1.items():
            n = len(sgrna_n)
            for sgrna in sgrna_n:
                lfc = float(sgrna[3])
                lfc_Sum += lfc
                sgrna_list.append(sgrna[0])

            agv_lfc = lfc_Sum / n
            uniq_Sgrna = len(set(sgrna_list))

            output_str = "\t".join([gene_f, str(agv_lfc), str(uniq_Sgrna), str(n)]) + "\n"
            output.write(output_str)

            lfc_Sum = 0
            sgrna_list = []









