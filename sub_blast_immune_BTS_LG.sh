#! /bin/bash
#PBS -P DevilVirome2016
#PBS -N blast
#PBS -l select=1:ncpus=4:mem=5GB
#PBS -l walltime=02:00:00
#PBS -q defaultQ

module load blast+/2.7.1

# If you're going to use this script, please change the PBS project directive and the project variable to the Artemis project you have access to (don't use DevilVirome2016)
# this script is how to blast a protein query against a nucleotide database
# make sure there is already a BLAST database for your nucleotide target sequence, if not you can generate using the following

project=DevilVirome2016

assembly=/project/DevilVirome2016/listers_gecko/genome/leplis_V1.2.SM.fa
assembly=/project/DevilVirome2016/bluetailed_skink/genome/cryege_V1.0.SM.fa

query=/project/DevilVirome2016/bluetailed_skink/annotation/immune/input/MHC_class_I_mod_name.fasta
query=/project/DevilVirome2016/bluetailed_skink/annotation/immune/input/MHC_class_II_mod_name.fasta
query=/project/DevilVirome2016/bluetailed_skink/annotation/immune/input/TLR_class_all_mod_name.fasta
out=/project/DevilVirome2016/bluetailed_skink/annotation/immune/output/
genome=`basename ${assembly}`
blastquery=`basename ${query}`
name=${genome}.${blastquery}.blastn.txt

#make blast database
#makeblastdb -in ${assembly} -dbtype nucl

# run tblastn of a protein query against the genome
blastn -query ${query} -db ${assembly} -evalue 1e-1 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qseq sseq" -out ${out}/${name} -task blastn
