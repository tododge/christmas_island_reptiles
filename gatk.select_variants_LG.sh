#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=64GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N select_variants

cd /project/DevilVirome2016/bluetailed_skink/variant_calling

module load java gatk picard bwa samtools

gatk SelectVariants \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.vcf.gz \
    -select-type SNP \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.vcf.gz

gatk SelectVariants \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.vcf.gz \
    -select-type INDEL \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INDEL.vcf.gz

gatk SelectVariants \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.vcf.gz \
    -select-type NO_VARIATION \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INVARIANT.vcf.gz

