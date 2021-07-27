#! /bin/sh
#$ -S /bin/sh
#$ -cwd

export PATH=/lustre7/home/lustre3/takagi-hiroki/miniconda2/bin:${PATH}
samtools_PATH=/lustre7/home/lustre3/segawa-tenta/tools/bin/samtools-1.9/samtools

#bamが羅列したtxtファイル
bam_pass=/lustre7/home/s-saiga/average_depth_analysis/multi_align_Yotsuboshi_Houkou/Yotsuboshi_bam_bai/bam_pass.txt
#culutivar_name
culutivar_name=Yotsuboshi
#-----------------------------------------------------------------------------------------------------------------------------------------------------------
#使うcpuの数
used_cpu=8
#-----------------------------------------------------------------------------------------------------------------------------------------------------------
cd ../
mkdir ${culutivar_name}_rmdup_sort_bam_bai
cd ${culutivar_name}_rmdup_sort_bam_bai

python ../script/PCR_duplicate.py ${bam_pass}

#並行処理
echo "make rmdup bam..."
cat rmdup_bam.txt|xargs -P${used_cpu} -I % sh -c %
echo "finish"

echo "make bai..."
cat bam_to_bai.txt|xargs -P${used_cpu} -I % sh -c %
echo "finish"

mkdir bam_pass
mkdir bai_pass
mv *.bam bam_pass
mv *.bai bai_pass
cd ../
