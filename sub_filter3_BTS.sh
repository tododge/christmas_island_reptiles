#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=100GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N merge2

cd /project/DevilVirome2016/bluetailed_skink/variant_calling/gatk_output

module load java gatk picard bwa samtools tabix

#zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL.vcf.gz | head -n 10000 | grep "#" > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_head

#zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL.vcf.gz | grep -v "#" | awk -F":|\t" '{ if ($14 < 98) {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" "RGQ99" "\t" $8 "\t" $9 ":" $10 ":" $11 "\t" $12 ":" $13 ":" $14}; if ($14 > 98) {print $0}}' | awk -F":|\t" '{ if ($6 != ".") {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" "NOTINV" "\t" $8 "\t" $9 ":" $10 ":" $11 "\t" $12 ":" $13 ":" $14}; if ($6 == ".") {print $0}}' > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_2_tail.vcf

#cat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_2_head cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_2_tail.vcf | gzip > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_2.vcf.gz

#rm *vcf

#cd ../

#zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_3.vcf.gz | grep -v "#" > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_3_nohead.vcf

#cat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_3.vcf.gz_header cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_3_nohead.vcf > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_4.vcf

#bgzip cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_4.vcf

#tabix -p vcf cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_4.vcf.gz

cd /project/DevilVirome2016/bluetailed_skink/variant_calling/

#gatk --java-options '-Xmx8g' MergeVcfs \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.FINAL.vcf.gz \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INDEL.light_filter.FINAL.vcf.gz \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_4.vcf.gz \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.FINAL.vcf.gz


#gatk --java-options '-Xmx8g' MergeVcfs \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.FINAL.vcf.gz \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_4.vcf.gz \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.light_filter.FINAL.vcf.gz

#zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL.vcf.gz | grep -v # | awk -F":|\t" '{ if ($14 < 98) {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" "RGQ99" "\t" $8 "\t" $9 ":" $10 ":" $11 "\t" $12 ":" $13 ":" $14}; if ($14 > 98) {print $0}}' | awk -F":|\t" '{ if ($6 != ".") {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" "NOTINV" "\t" $8 "\t" $9 ":" $10 ":" $11 "\t" $12 ":" $13 ":" $14}; if ($6 == ".") {print $0}}' | gzip > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_2.vcf.gz


cd /project/DevilVirome2016/bluetailed_skink/variant_calling/gatk_output


#zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.light_filter.FINAL.vcf.gz | grep -v "#" | grep "PASS" > VCF_nohead_pass2

for line in `cut -f1 cryege_V1.0.SM.fa.fai`; do echo -e "$line\t0"; grep -w $line VCF_nohead_pass2 | awk 'NR%10000==0 {print($1 "\t" $2)}'; done > test_A

VAR=`head -n 1 test_A`
{ echo "$VAR"; cat test_A; } >test2_A
paste test_A test2_A | awk 'BEGIN{FS=" "}{OFS = "\t"}{if($2>$4){print $1,$4,$2}}' | awk 'BEGIN{FS=" "}{if($3>$2){print}}' > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.light_filter.FINAL.vcf.10000SNP.bed

#rm VCF_nohead_pass test test2
