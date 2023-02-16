#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=64GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N exclude_filtered

cd /project/DevilVirome2016/listers_gecko/variant_calling/

module load java gatk picard bwa samtools

gatk SelectVariants \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.vcf.gz \
    --exclude-filtered \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz

gatk SelectVariants \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.vcf.gz \
    --exclude-filtered \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.PASS.vcf.gz
