#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=64GB
#PBS -l walltime=6:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N merge_raw
#PBS -a 0300


cd /project/DevilVirome2016/listers_gecko/variant_calling/gatk_output

module load java gatk picard bwa samtools

ls leplis*.vcf.gz > leplis_V1.2.SM.fa.vcf.gz.list

gatk --java-options '-Xmx8g' MergeVcfs -I leplis_V1.2.SM.fa.vcf.gz.list -O leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam.combined.vcf.gz
