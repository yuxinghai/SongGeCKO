#!/bin/sh
# properties = {"rule": "merge_fastq", "local": false, "input": ["/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/results/02_decode/NC-A1_combined_R1.fastq", "/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/results/02_decode/NC-A1_combined_R2.fastq"], "output": ["/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/results/02_decode/NC-A1_combined_merge.fastq"], "wildcards": ["/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/results", "NC-A1_combined"], "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 5, "cluster": {}}
cd /data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/analysis && \
/home/yuxinghai/.conda/envs/py36/bin/python \
-m snakemake /data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/results/02_decode/NC-A1_combined_merge.fastq --snakefile /data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/analysis/Snakefile \
--force -j --keep-target-files --keep-shadow --keep-remote \
--wait-for-files /data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/analysis/.snakemake/tmp.sj5qwf6q /data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/results/02_decode/NC-A1_combined_R1.fastq /data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/results/02_decode/NC-A1_combined_R2.fastq --latency-wait 5 \
--benchmark-repeats 1 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
   --nocolor \
--notemp --no-hooks --nolock --timestamp  --force-use-threads  --allowed-rules merge_fastq  && touch "/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/analysis/.snakemake/tmp.sj5qwf6q/5.jobfinished" || (touch "/data2/zhoulab/yuxinghai/songlab/SongGeCKO_zn_2/analysis/.snakemake/tmp.sj5qwf6q/5.jobfailed"; exit 1)

