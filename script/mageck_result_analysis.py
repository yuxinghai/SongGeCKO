import sys
# before do this mageck_result must be sort  by gene name
def sgRNA_summary_parser(input_file):

    gene_dic={}
    sgrna_list=[]
    with open(input_file, mode='r') as infile:  # rU mode is necessary for excel!
        lines=infile.readlines()
        lines.sort()
        gene_tmp = ""
        i = 0
        for rows in lines:
            if "sgrna" in rows:
                continue
            sgrna, Gene, control_count, treatment_count, control_mean, treat_mean, LFC, control_var, adj_var, score, p_low, p_high, p_twosided, FDR, high_in_treatment = rows.strip().split()

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



def filter_lfc(dic1):
    filter_dic={}
    sgrna_list=[]
    for gene, sgrna_n in dic1.items():

        for sgrna in sgrna_n:
            if float(sgrna[3])>0:
                sgrna_list.append(sgrna)
            else:
                continue
        filter_dic[gene]=sgrna_list
        sgrna_list=[]
    return filter_dic







def dic_overlap(list1,list2):

    gene_list1=set(list1.keys())
    gene_list2=set(list2.keys())

    all_gene=gene_list1.union(gene_list2)
    gene_dic = {}
    sgrna_list = []
    all_gene=list(all_gene)


    for gene in all_gene:
        if gene in gene_list1:
            for sgrna in list1[gene]:
                sgrna_list.append(sgrna)

        if gene in gene_list2:

            for sgrna in list2[gene]:
                sgrna_list.append(sgrna)

        gene_dic[gene] = sgrna_list
        sgrna_list=[]


    return gene_dic





if __name__ == '__main__':
    result_dic={}
    dic1=sgRNA_summary_parser(sys.argv[1])
    dic1_f=filter_lfc(dic1)
    ''' 
    for gene, sgrna_n in dic1.items():
        

       print len(sgrna_n)
       
    exit(0)
    ''' 

    dic2 = sgRNA_summary_parser(sys.argv[2])
    dic2_f = filter_lfc(dic2)
    '''
    when input file is 4,for example A1,A2,B1,B2

    dic3 = sgRNA_summary_parser(sys.argv[3])
    dic3_f = filter_lfc(dic3)
    dic4 = sgRNA_summary_parser(sys.argv[4])
    dic4_f = filter_lfc(dic4)
    new_part1=dic_overlap(dic1_f,dic2_f)

    new_part2=dic_overlap(dic3_f,dic4_f)
    new=dic_overlap(new_part1,new_part2)
    '''
    # when input file is 2,A1,B1
    new=dic_overlap(dic1_f,dic2_f)
    for gene,sgrna_n in new.items():


        if len(sgrna_n)>=2:
            result_dic[gene]=sgrna_n
        else:
            continue
    with open(sys.argv[3],"w") as output:
        output.write("\t".join(["gene","sgrna","control_count", "treatment_count", "LFC", "FDR"])+"\n")

        for gene,sgrna_n in result_dic.items():
            for sgrna in sgrna_n:
                outstr="\t".join([gene,sgrna[0],sgrna[1],sgrna[2],sgrna[3],sgrna[4]])+"\n"
                output.write(outstr)






















