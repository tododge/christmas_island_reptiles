#!/bin/bash
#PBS -P awggdata
#PBS -N minimap
#PBS -l select=1:ncpus=1:mem=100GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/listers_gecko/coverage

module load samtools
module load bedtools

#samtools faidx leplis_V1.2.SM.fa

#/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 -ax map-hifi --secondary=no -R '@RG\tID:leplis\tSM:pacbio_libraryprep' leplis_V1.2.SM.fa 359703_TSI_AGRF_DA149208.hifi.ccs.filt.fastq.gz  359703_TSI_AGRF_DA149210.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA162797.hifi.ccs.filt.fastq.gz > leplis_V1.2.SM.fa.sam

#samtools view -S -b leplis_V1.2.SM.fa.sam > leplis_V1.2.SM.fa.bam
#rm *sam

samtools sort leplis_V1.2.SM.fa.bam -o leplis_V1.2.SM.fa.sorted.bam

samtools index leplis_V1.2.SM.fa.sorted.bam
