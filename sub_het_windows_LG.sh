#!/bin/bash
#PBS -P DevilVirome2016
#PBS -N hetwindows
#PBS -l select=1:ncpus=1:mem=19GB
#PBS -l walltime=1:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/listers_gecko/variant_calling
module load bedtools

bedtools coverage -a gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.vcf.1000000SNP.bed -b gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.PASS.vcf.gz -counts > leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.heterozygocity_1mb_windows.bed

bedtools coverage -a gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.vcf.10000SNP.bed -b gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz -counts > leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.heterozygocity_10kb_windows.bed
