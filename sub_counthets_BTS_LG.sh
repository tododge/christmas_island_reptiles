#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=120GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N counthets

cd /project/DevilVirome2016/bluetailed_skink/variant_calling/gatk_output

echo "skink SNPs"
echo "cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz"
zgrep "PASS" cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz | wc -l
echo "skink INDELS"
echo "cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INDEL.heavy_filter.FINAL.vcf.gz"
zgrep "PASS" cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INDEL.heavy_filter.FINAL.vcf.gz | wc -l
echo "skink INVARIANT"
echo "cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf.gz"
zgrep "PASS" cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf.gz | wc -l
echo "skink INVARIANT exclude ROH exclude sex"
echo "cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.vcf.gz"
zgrep "PASS" cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.vcf.gz | zgrep "RGQ" | wc -l

cd /project/DevilVirome2016/listers_gecko/variant_calling/gatk_output

echo "gecko SNPs"
echo "leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz"
zgrep "PASS" leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz | wc -l
echo "gecko INDELS"
echo "leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INDEL.heavy_filter.FINAL.vcf.gz"
zgrep "PASS" leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INDEL.heavy_filter.FINAL.vcf.gz | wc -l
echo "gecko INVARIANT"
echo "leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf.gz"
zgrep "PASS" leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf.gz | wc -l

