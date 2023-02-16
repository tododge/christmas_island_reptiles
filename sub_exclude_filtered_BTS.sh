#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=64GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N exclude_filtered

cd /project/DevilVirome2016/bluetailed_skink/variant_calling/

module load java gatk picard bwa samtools

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.light_filter.PASS.vcf.gz

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.light_filter.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.light_filter.PASS.vcf.gz

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter1.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter1.PASS.vcf.gz

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter2.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter2.PASS.vcf.gz

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INDEL.heavy_filter.FINAL.PASS.vcf.gz

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter5.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter5.PASS.vcf.gz

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter6.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter6.PASS.vcf.gz


#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.PASS.vcf.gz

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.PASS.vcf.gz


#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.vcf.gz \
#    --exclude-filtered \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.vcf.gz

####excluding non-focal regions for psmc


#including indels did not work

#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.PASS.vcf.gz \
#    --exclude-intervals ROH_flank_10kb_sexchrom_modified.bed \
#    --exclude-intervals cryege_V1.0.SM.fa_nonfocal.bed \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.COMBINED.heavy_filter.FINAL.PASS.focal_noROH.vcf.gz


gatk SelectVariants \
    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.vcf.gz \
    --exclude-intervals PSMC_nonfocal_mask_sex_chrom_flank_1mb_ROH_flank_10kb.bed \
    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.vcf.gz

#not excluding long ROH made a PSMC plot that seemed a little sketchier
#gatk SelectVariants \
#    -V gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.vcf.gz \
#    --exclude-intervals cryege_V1.0.SM.fa_nonfocal.bed \
#    -O gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal.vcf.gz

