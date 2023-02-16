#!/bin/bash

export PATH=~/hifiasm/:$PATH

#for skink
hifiasm -t 32 -k 63 -r 5 -o cryege_V1.0.asm 359702_TSI_AGRF_DA149190.hifi.ccs.filt.fastq.gz 359702_TSI_AGRF_DA149222.hifi.ccs.filt.fastq.gz

#for gecko
hifiasm -t 32 -D 20 -k 63 -r 9 --max-kocc 10000 -a 6 -s 0.65 -N 300 --hom-cov 30 -o leplis_V1.0.asm 359703_TSI_AGRF_DA149208.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA149210.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA162797.hifi.ccs.filt.fastq.gz
