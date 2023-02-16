#!/bin/bash
#PBS -P DevilVirome2016
#PBS -N minimap
#PBS -l select=1:ncpus=4:mem=100GB
#PBS -l walltime=6:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/bluetailed_skink/alignments

#### alignments to other species ####

SEQ_Y=cryege_V1.0.SM.fa
SEQ_X=Podarcis_muralis.PodMur_1.0.dna_sm.toplevel.fa

/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 $SEQ_Y $SEQ_X > cryege_V1.0.SM.fa_to_Podarcis_muralis.PodMur_1.0.dna_sm.toplevel.fa_approx-mapping.paf

SEQ_Y=cryege_V1.0.SM.fa
SEQ_X=Anolis_carolinensis.AnoCar2.0v2.dna_sm.toplevel.fa

/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 $SEQ_Y $SEQ_X > cryege_V1.0.SM.fa_to_Anolis_carolinensis.AnoCar2.0v2.dna_sm.toplevel.fa_approx-mapping.paf

#### Y ctg to X ctg alignment ####

SEQ_Y=h1tg000001l.fa
SEQ_X=ctg_008_X.fa

/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 $SEQ_Y $SEQ_X > Y_to_X_alignment_h1tg000001l.fa_to_ctg_008_X_approx-mapping.paf


#### Y haplotype to X ctg alignment ####

SEQ_Y=cryere_V7.1.asm.bp.hap1.p_ctg.fa
SEQ_X=ctg_008_X.fa

/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 $SEQ_Y $SEQ_X > Y_to_X_alignment_hap1_to_ctg_008_X_approx-mapping.paf


#### X haplotype to X ctg alignment ####
SEQ_Y=cryere_V7.1.asm.bp.hap2.p_ctg.fa
SEQ_X=ctg_008_X.fa

/project/DevilVirome2016/bluetailed_skink/coverage/minimap2/minimap2 $SEQ_Y $SEQ_X > Y_to_X_alignment_hap2_to_ctg_008_X_approx-mapping.paf
