#!/bin/bash
#PBS -P DevilVirome2016
#PBS -N hetwindows
#PBS -l select=1:ncpus=1:mem=19GB
#PBS -l walltime=1:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/bluetailed_skink/variant_calling
module load bedtools

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.light_filter.vcf.10000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.heterozygocity_10kb_windows.bed

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.light_filter.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.light_filter.heterozygocity_1mb_windows.bed

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.heterozygocity_1mb_windows.bed

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter1.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter1.heterozygocity_1mb_windows.bed

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter2.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter2.heterozygocity_1mb_windows.bed

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter3.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter3.heterozygocity_1mb_windows.bed

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter4.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter4.heterozygocity_1mb_windows.bed

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter5.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter5.heterozygocity_1mb_windows.bed

#bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.light_filter.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter6.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter6.heterozygocity_1mb_windows.bed

bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.vcf.1000000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.heterozygocity_1mb_windows.bed

bedtools coverage -a gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.vcf.10000SNP.bed -b gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz -counts > cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.heterozygocity_10kb_windows.bed










##bedtools coverage -a cryege_V7.1.asm.bp.p_ctg.fa_500kb_bins.bed -b gatk_output/cryege_V7.1.asm.bp.p_ctg.SM.fa.sorted.bam.variants_filtered_pass.vcf.gz -counts > cryege_V7.1.asm.bp.p_ctg.fa_500kb_bins.bed_heterozygocity_in_windows.bed

##bedtools coverage -a cryege_V7.1.asm.bp.p_ctg.fa_1mb_bins.bed -b gatk_output/cryege_V7.1.asm.bp.p_ctg.SM.fa.sorted.bam.variants_filtered_pass.vcf.gz -counts > cryege_V7.1.asm.bp.p_ctg.fa_1mb_bins.bed_heterozygocity_in_windows.bed
