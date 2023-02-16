#!/bin/bash

conda activate deepvariant_env

ulimit -u 10000 

#TMPDIR=/data/bluetailed_skink/variantcalling/deepvariant/tmpdir
singularity exec --bind /usr/lib/locale/ \
  deepvariant_1.4.0.sif \
    /opt/deepvariant/bin/run_deepvariant \
    --model_type PACBIO \
    --ref reference/cryege_V7.1.asm.bp.p_ctg.SM.fa \
    --reads input/cryege_V7.1.asm.bp.p_ctg.SM.fa.sorted.bam \
    --output_vcf deepvariant_output/cryege_V7.1.asm.bp.p_ctg.SM.vcf.gz \
    --num_shards $(nproc) \
    --intermediate_results_dir '/data/bluetailed_skink/variantcalling/deepvariant/tmpdir'
