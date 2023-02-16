#!/bin/bash
#PBS -P DevilVirome2016
#PBS -l select=1:ncpus=1:mem=64GB
#PBS -l walltime=3:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ
#PBS -N merge_raw


cd /project/DevilVirome2016/bluetailed_skink/variant_calling/gatk_output


module load java gatk picard bwa samtools


ls cryege_V1.0.SM.fa.sorted.nosecondary.bam.*.vcf.gz > cryege_V1.0.SM.fa.sorted.nosecondary.bam.vcf.gz.list

gatk --java-options '-Xmx7g' MergeVcfs -I cryege_V1.0.SM.fa.sorted.nosecondary.bam.vcf.gz.list -O cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.vcf.gz

