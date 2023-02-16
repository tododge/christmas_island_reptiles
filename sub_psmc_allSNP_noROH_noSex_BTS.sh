#!/bin/bash
#PBS -P awggdata
#PBS -N PSMC.skink.bootstrap
#PBS -l select=1:ncpus=2:mem=19GB
#PBS -l walltime=2:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

module load bcftools/1.9

####

cd /project/DevilVirome2016/bluetailed_skink/pop_size/psmc_analysis/

bcftools view /project/DevilVirome2016/bluetailed_skink/variant_calling/gatk_output/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.vcf.gz | awk -F"\t" '{ if ($1 == "#") {print $0}; if ($1 != "#" && $5 ==".") {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 ";FQ=-40""\t" $9 "\t" $10}; if ($1 != "#" && $5 != ".") {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 ";FQ=40""\t" $9 "\t" $10}}' | vcfutils.pl vcf2fq | sed 's/[a,t,c,g]/\U&/g' | gzip > input/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.fastq.gz

./psmc/utils/fq2psmcfa -q 20 ./input/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.fastq.gz > ./input/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.psmcfa


####main psmc####
./psmc/psmc -N25 -t12 -r5 -p "4+30*2+4+6+10" -o ./results/pattern4.cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.psmc ./input/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.psmcfa

####bootstrap####

mkdir ./results/bootstrap
./psmc/utils/splitfa ./input/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.psmcfa > ./input/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex-split.psmcfa
seq 1 99 | xargs -i echo ./psmc/psmc -N25 -t15 -r5 -b -p "4+30*2+4+6+10" -o ./results/bootstrap/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex.round-{}.psmc ./input/cryege_V1.0.SM.fa.sorted.nosecondary.bam.combined.SNP_INVARIANT.heavy_filter.FINAL.PASS.focal_noROH_noSex-split.psmcfa | sh

