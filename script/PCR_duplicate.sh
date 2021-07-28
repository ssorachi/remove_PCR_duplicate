#! /bin/sh
#$ -S /bin/sh
#$ -cwd

export PATH=#Input your conda pass:${PATH}
samtools_PATH=#Input your samtools path

#TXT file with lots of BAM ex)xxx/xxx/1.bam \n xxx/xxx/2.bam \n ...
bam_pass=xxx/xxx/xxx/bam_pass.txt
#culutivar_name
culutivar_name=xxx
#-----------------------------------------------------------------------------------------------------------------------------------------------------------
#used cpu
used_cpu=8
#-----------------------------------------------------------------------------------------------------------------------------------------------------------
cd ../
mkdir ${culutivar_name}_rmdup_sort_bam_bai
cd ${culutivar_name}_rmdup_sort_bam_bai

python ../script/PCR_duplicate.py ${bam_pass}

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
