#!/bin/bash
#PBS -P DevilVirome2016
#PBS -N minimap
#PBS -l select=1:ncpus=4:mem=100GB
#PBS -l walltime=6:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/listers_gecko/alignments

SEQ_Y=leplis_V6.1.asm.bp.hap1.p_ctg.fa
SEQ_X=leplis_V6.1.asm.bp.hap2.p_ctg.fa

/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 $SEQ_Y $SEQ_X > leplis_V6.1.asm.bp.hap1.p_ctg.fa_to_leplis_V6.1.asm.bp.hap2.p_ctg.fa_approx-mapping.paf

SEQ_Y=leplis_V1.2*fa
SEQ_X=MPM_Stown_v2.2.fasta

/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 $SEQ_Y $SEQ_X > leplis_V1.2.SM.fa_to_MPM_Stown_v2.2.fasta_approx-mapping.paf
