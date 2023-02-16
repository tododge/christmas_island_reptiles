#!/bin/bash
#PBS -P awggdata
#PBS -N merge
#PBS -l select=1:ncpus=1:mem=120GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/listers_gecko/coverage

module load samtools
module load bedtools

samtools merge leplis_V1.2.SM.fa_merged.sorted.bam leplis_V1.2.SM.fa_1.sorted.bam leplis_V1.2.SM.fa_2.sorted.bam leplis_V1.2.SM.fa_3.sorted.bam

samtools index leplis_V1.2.SM.fa_merged.sorted.bam

rm leplis_V1.2.SM.fa_?.sorted.bam
rm leplis_V1.2.SM.fa_?.sorted.bam.bai

samtools view -F 0x100 leplis_V1.2.SM.fa_merged.sorted.bam -o leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam

samtools index leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam
