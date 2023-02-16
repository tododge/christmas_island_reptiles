#!/bin/bash

REFERENCE=cryege_V1.0.fa
#REFERENCE=leplis_V1.2.fa
CPUS=32
PA=`expr $CPUS - 2`

source /home/ubuntu/miniconda3/etc/profile.d/conda.sh

conda activate repeats

###############################
#### BUILD CUSTOM DATABASE ####
###############################

BuildDatabase -name ${OUTPUT}_repeat_db -engine ncbi ${REFERENCE}

############################
#### RUN REPEAT MODELER ####
############################

#Script to run RepeatModeler to create a custom repeat database for genome annotation
#Program versions tested with this script
#repeatmodeler v2.0.1

RepeatModeler -pa ${PA} -engine ncbi -database ${REFERENCE}_repeat_db

###########################
#### RUN REPEAT MASKER ####
###########################

#Script to run RepeatMasker to mask a genome using a custom repeat database from RepeatModeler
#Program versions tested with this script
#repeatmasker v4.0.6

REPEATLIB=./RM*/consensi.fa.classified #path to consensus file

#Run RepeatMasker softmask
RepeatMasker -pa ${PA} -gff -lib ${REPEATLIB} -xsmall ${REFERENCE} -dir ${REFERENCE}\_RM_SM

#Run RepeatMasker hardmask, exclude simple repeats
RepeatMasker -pa ${PA} -gff -lib ${REPEATLIB} -nolow ${REFERENCE} -dir ${REFERENCE}\_RM_HM
