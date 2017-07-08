This is crispr screen workflow for Songlab


1/ Evaluate Quality of R1.
2/ Find 5’adaptor TCTTGTGGAAAGGACGAAACACCG
3/ Extract sequence before as stagger+barcode
4/ Extract 20nt after as sgRNA
5/ Find the genes with enriched sgRNA comparing A* vs. NC-A*. (A/B: two sgRNA libraries; -1, -2: replicates)


NOTE:
    8 个barcode原始reader数

    每个sgRNA 有多个reader mating

    KEGG 分析

    Non-target sequence    出现正常，自发突变或者同一细胞内不止感染了一个病毒

    为解决NC-A1&NC-A2相关性低，决定合并NC数据再进行富集比较，同时A/B库中readers数为0的sgRNA讲不进行分析
