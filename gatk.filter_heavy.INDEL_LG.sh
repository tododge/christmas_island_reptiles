#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=64GB
#PBS -l walltime=6:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N filter_heavy.INDEL

cd /project/DevilVirome2016/listers_gecko/variant_calling

module load java gatk picard bwa samtools

gatk SelectVariants \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.vcf.gz \
    -select-type INDEL \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INDEL.vcf.gz

gatk VariantFiltration \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INDEL.vcf.gz \
    -filter "DP > 48" --filter-name "DP48" \
    -filter "DP < 21" --filter-name "DP21" \
    -filter "QD < 10.0" --filter-name "QD10" \
    -filter "QUAL < 60.0" --filter-name "QUAL60" \
    -filter "FS > 200.0" --filter-name "FS200" \
    -filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.INDEL.heavy_filter.FINAL.vcf.gz
