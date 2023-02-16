#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=120GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N big_log

cd /project/DevilVirome2016/bluetailed_skink/variant_calling/

module load java gatk picard bwa samtools tabix

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.vcf.gz \
#    -select-type NO_VARIATION \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.vcf.gz

#gatk VariantFiltration \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.vcf.gz \
#    -filter "DP > 62" --filter-name "DP62" \
#    -filter "DP < 27" --filter-name "DP27" \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.vcf.gz

cd /project/DevilVirome2016/bluetailed_skink/variant_calling/gatk_output

#zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL.vcf.gz | head -n 10000 | grep "#" > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_head

#edit header now, add a filter category called "RGQ99" and "NOTINV"

zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL.vcf.gz | grep -v "#" | awk -F":|\t" '{ if ($6 != ".") {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" "NOTINV" "\t" $8 "\t" $9 ":" $10 ":" $11 "\t" $12 ":" $13 ":" $14}; if ($6 == ".") {print $0}}' > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL_tail.vcf

cat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.light_filter.FINAL_head cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL_tail.vcf > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf

rm cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL_tail.vcf

bgzip cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf

tabix -p vcf cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf.gz

cd /project/DevilVirome2016/bluetailed_skink/variant_calling/

gatk --java-options '-Xmx8g' MergeVcfs \
    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.vcf.gz \
    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INDEL.heavy_filter.FINAL.vcf.gz \
    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf.gz \
    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.vcf.gz

gatk --java-options '-Xmx8g' MergeVcfs \
    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.vcf.gz \
    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf.gz \
    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.vcf.gz

#gatk --java-options '-Xmx8g' MergeVcfs \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.vcf.gz \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INDEL.heavy_filter.FINAL.vcf.gz \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.vcf.gz

cd /project/DevilVirome2016/bluetailed_skink/variant_calling/gatk_output

zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.vcf.gz | grep -v "#" | grep "PASS" > VCF_nohead_pass

for line in `cut -f1 cryege_V1.0.SM.fa.fai`; do echo -e "$line\t0"; grep -w $line VCF_nohead_pass | awk 'NR%1000000==0 {print($1 "\t" $2)}'; done > test

VAR=`head -n 1 test`
{ echo "$VAR"; cat test; } >test2
paste test test2 | awk 'BEGIN{FS=" "}{OFS = "\t"}{if($2>$4){print $1,$4,$2}}' | awk 'BEGIN{FS=" "}{if($3>$2){print}}' > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.vcf.1000000SNP.bed



zcat cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.vcf.gz | grep -v "#" | grep "PASS" > VCF_nohead_pass2

for line in `cut -f1 cryege_V1.0.SM.fa.fai`; do echo -e "$line\t0"; grep -w $line VCF_nohead_pass2 | awk 'NR%10000==0 {print($1 "\t" $2)}'; done > test_A

VAR=`head -n 1 test_A`
{ echo "$VAR"; cat test_A; } >test2_A
paste test_A test2_A | awk 'BEGIN{FS=" "}{OFS = "\t"}{if($2>$4){print $1,$4,$2}}' | awk 'BEGIN{FS=" "}{if($3>$2){print}}' > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.vcf.10000SNP.bed

rm VCF_nohead_pass* test*

#gatk --java-options '-Xmx8g' MergeVcfs \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.FINAL.vcf.gz \
#    -I gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INDEL.light_filter.FINAL.vcf.gz \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.light_filter.FINAL.vcf.gz
