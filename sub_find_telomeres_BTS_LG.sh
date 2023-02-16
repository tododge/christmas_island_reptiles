#!/bin/bash

####for a quick telomere assessment, use FindTelomeres.py####
#this method may miss some telomeres if > 10bp non-telomere sequence is on end

genome=cryege_V1.0.SM.fa
#genome=leplis_V1.2.SM.fa

python ~/FindTelomeres/FindTelomeres.py $genome | grep -E 'Forward|Reverse' > $genome.telomeres

####to get approximate telomere locations for plotting####
samtools faidx $genome

cat <(join -j 1 <(grep "end" $genome.telomeres | sort ) <(sort $genome.fai) | cut -d " " -f1,3,7) <(join -j 1 <(grep "start" $genome.telomeres | sort ) <(sort $genome.fai) | cut -d " " -f1,3,7) | awk 'BEGIN {FS =" "}{ OFS = "\t" } {if($2 ~ "start"){print $1,"1","15000"} else{if($2 ~ "end"){$4 = $3 - 15000}{print $1, $4, $3}}}' | sort > $genome.telomeres_approx.bed


#### for better data and telomere lengths, extract telomeres from repeat masker gff####
#this method will also find telomeres in the middle of chromosomes, which can be a real phenomenon or due to HiC scaffolding errors. identifies telomeres > 1000 bases long (arbitrary cutoff)

grep -E 'AACCCT|ACCCTA|AGGGTT|CCCTAA|CCTAAC|CTAACC|GGGTTA|GGTTAG|GTTAGG|TAACCC|TAGGGT|TTAGGG' *gff | grep -E 'Motif.{9}n' | cut -f1,4,5 | awk 'BEGIN { OFS = "\t" } { $4 = $3 - $2 } 1' | sort -k4 -nr | awk '$4 > 1000' | sort -k1 > $genome.telomeres.bed

#get mean telomere length
cat $genome.telomeres.bed | awk '{ total += $4; count++ } END { print total/count }'

