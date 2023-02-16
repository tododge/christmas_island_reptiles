#!/bin/bash
#PBS -P DevilVirome2016
#PBS -N PSMC.gecko.bootstrap
#PBS -l select=1:ncpus=2:mem=19GB
#PBS -l walltime=12:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

module load bcftools/1.9 gatk

cd /project/DevilVirome2016/listers_gecko/variant_calling/

gatk SelectVariants \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.vcf.gz \
    --exclude-filtered \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.vcf.gz

cd /project/DevilVirome2016/listers_gecko/pop_size/psmc_analysis/

bcftools view /project/DevilVirome2016/listers_gecko/variant_calling/gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.vcf.gz | awk -F"\t" '{ if ($1 == "#") {print $0}; if ($1 != "#" && $5 ==".") {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 ";FQ=-40""\t" $9 "\t" $10}; if ($1 != "#" && $5 != ".") {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 ";FQ=40""\t" $9 "\t" $10}}' | vcfutils.pl vcf2fq | sed 's/[a,t,c,g]/\U&/g' | gzip > input/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.fastq.gz

./psmc/utils/fq2psmcfa -q 20 ./input/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.fastq.gz > ./input/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.psmcfa

./psmc/psmc -N25 -t12 -r5 -p "4+30*2+4+6+10" -o ./results/pattern4.leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.psmc ./input/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.psmcfa

mkdir ./results/bootstrap
./psmc/utils/splitfa ./input/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.psmcfa > ./input/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS-split.psmcfa

seq 1 100 | xargs -i echo ./psmc/psmc -N25 -t15 -r5 -b -p "4+30*2+4+6+10" -o ./results/bootstrap/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.round-{}.psmc ./input/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS-split.psmcfa | sh

