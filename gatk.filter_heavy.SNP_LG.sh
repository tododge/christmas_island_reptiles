#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=64GB
#PBS -l walltime=6:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N filter_heavy.SNP

cd /project/DevilVirome2016/listers_gecko/variant_calling

module load java gatk picard bwa samtools

gatk SelectVariants \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.vcf.gz \
    -select-type SNP \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.vcf.gz

gatk VariantFiltration \
    -V gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.vcf.gz \
    -filter "DP > 48" --filter-name "DP48" \
    -filter "DP < 21" --filter-name "DP21" \
    -filter "QD < 10.0" --filter-name "QD10" \
    -filter "QUAL < 60" --filter-name "QUAL60" \
    -filter "SOR > 3.0" --filter-name "SOR3" \
    -filter "FS > 60.0" --filter-name "FS60" \
    -filter "MQ < 40.0" --filter-name "MQ40" \
    -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
    -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
    -O gatk_output/leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.SNP.heavy_filter.FINAL.vcf.gz

