#!/bin/bash
#PBS -P DevilVirome2016
#PBS -N minimap
#PBS -l select=1:ncpus=3:mem=100GB
#PBS -l walltime=8:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/listers_gecko/alignments

#SEQ_Y=leplis_V1.1.SM.fa
SEQ_Y=out*
SEQ_X=MPM_Stown_v2.2.fasta

/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 $SEQ_Y $SEQ_X > OUT.fa_to_MPM_Stown_v2.2.fasta_approx-mapping.paf

