#!/bin/bash
#PBS -P DevilVirome2016
#PBS -N hisat2_index
#PBS -l select=1:ncpus=1:mem=19GB
#PBS -l walltime=3:00:00
#PBS -M tristram.dodge@sydney.edu.au
#PBS -q defaultQ

cd /project/DevilVirome2016/listers_gecko/genome/
module load hisat2/2.1.0
hisat2-build leplis_V1.2.HM.fa leplis_V1.2.HM.fa.hisat2_index
