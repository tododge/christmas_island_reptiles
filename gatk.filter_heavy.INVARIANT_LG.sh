#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=120GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N filter_heavy.INVARIANT

cd /project/DevilVirome2016/listers_gecko/variant_calling

module load java gatk picard bwa samtools

#gatk SelectVariants \
#    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.vcf.gz \
#    -select-type NO_VARIATION \
#    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INVARIANT.vcf.gz

gatk VariantFiltration \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INVARIANT.vcf.gz \
    -filter "DP > 48" --filter-name "DP48" \
    -filter "DP < 21" --filter-name "DP21" \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INVARIANT.heavy_filter.FINAL.vcf.gz
