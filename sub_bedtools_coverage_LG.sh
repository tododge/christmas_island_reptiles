#!/bin/bash
#PBS -P awggdata
#PBS -N bedtools
#PBS -l select=1:ncpus=1:mem=120GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/listers_gecko/coverage

module load samtools
module load bedtools

samtools faidx leplis_V1.2.SM.fa

cut -f1,2 leplis_V1.2.SM.fa.fai > leplis_V1.2.SM.fa_bedtools_genome_file

bedtools makewindows -w 1000000 -g leplis_V1.2.SM.fa_bedtools_genome_file > leplis_V1.2.SM.fa_bedtools_genome_file_1mb_bins

bedtools genomecov -ibam leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam -bga > leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam_whole-genome-coverage.bed

bedtools map -a leplis_V1.2.SM.fa_bedtools_genome_file_1mb_bins -b leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam_whole-genome-coverage.bed -c 4 -o mean > leplis_V1.2.SM.fa.merged.sorted.nosecondary.bam_whole-genome-coverage_1mb_windows.bed


