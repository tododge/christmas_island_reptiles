#!/bin/bash
#PBS -P awggdata
#PBS -N convert
#PBS -l select=1:ncpus=6:mem=64GB
#PBS -l walltime=24:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ


#requires earlier version of juicer_tools_1.XX, eg juicer_tools_1.19.02.jar

cd /project/DevilVirome2016/listers_gecko/HiC/yahs_salsa_leplis_V1.0.SM.fa

(../yahs/juicer pre yahs_salsa_leplis_V1.0.SM_scaff.bin yahs_salsa_leplis_V1.0.SM_scaff_scaffolds_final.agp ../ref/leplis_V1.0.SM.fa.fai | /usr/local/bin/sort -k2,2d -k6,6d -T ./ -S64G --parallel=16 | awk 'NF' > alignments_sorted.txt.part) && (mv alignments_sorted.txt.part alignments_sorted.txt)

(java -jar -Xmx32G /project/DevilVirome2016/listers_gecko/HiC/juicer_tools_1.19.02.jar pre alignments_sorted.txt yahs_salsa_leplis_V1.0.SM_scaff_scaffolds_final.hic.part scaffolds_final.chrom.sizes) && (mv yahs_salsa_leplis_V1.0.SM_scaff_scaffolds_final.hic.part yahs_leplis_V1.0.SM_scaff_scaffolds_final.hic)

../yahs/juicer pre -a -o out_JBAT yahs_salsa_leplis_V1.0.SM_scaff.bin yahs_salsa_leplis_V1.0.SM_scaff_scaffolds_final.agp ../ref/leplis_V1.0.SM.fa.fai >out_JBAT.log 2>&1

(java -jar -Xmx64G /project/DevilVirome2016/listers_gecko/HiC/juicer_tools_1.19.02.jar pre out_JBAT.txt out2_JBAT.hic.part <(cat out_JBAT.log  | grep PRE_C_SIZE | awk '{print $2" "$3}')) && (mv out_JBAT.hic.part out_JBAT.hic)

../yahs/juicer post -o out_JBAT out_JBAT.review.assembly out_JBAT.liftover.agp ../../genome/leplis_V1.0.SM.fa
