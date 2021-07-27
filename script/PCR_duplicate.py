#!/usr/bin/env python
# coding: UTF-8
# In[11]:

import sys
import re

args = sys.argv
#bamが羅列したtxtファイル
bam_pass = args[1]
#----------------------------------------------------------------------------------------------------------------------------------------
#書き込み
a = open(bam_pass,'r')

z = open('rmdup_bam.txt',mode='w')
y = open('bam_to_bai.txt',mode='w')
while True:
    line_1 = a.readline()
    if line_1:
        neo_line_1 = line_1.replace('\n','')
        bam_name=re.sub('\S+/','',neo_line_1)
        z.write('samtools rmdup '+neo_line_1+' rmdup_filtered_'+bam_name+'\n')
        y.write('samtools index rmdup_filtered_'+bam_name+'\n')
    else:
        break

a.close()
