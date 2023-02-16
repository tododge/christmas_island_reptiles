#!/bin/bash/

##############################################
# ARIMA GENOMICS MAPPING PIPELINE 02/08/2019 #
#  MODIFIED AUGUST 10 2022 by TRIS FOR AWGG  #
##############################################



################ README ######################

###################### THINGS YOU WILL NEED AT START OF EACH RUN ##########################
##	-fasta file in a directory called $WORK_DIR/ref/
##	-fastq.gz files in a directory called $WORK_DIR/raw/
##	-arima genomics scripts in a directory called $ARIMA_PATH. can be found on github.
##		-cd $WORK_DIR
##		-git clone https://github.com/ArimaGenomics/mapping_pipeline
##
##IF USING YAHS, YOUR DESIRED OUTPUT WILL BE A BAM FILE $REP_DIR/$REP_LABEL.sortedName.bam


#VARIABLES THAT NEED TO BE DEFINED BEFORE EACH RUN#

WORK_DIR='/data/listers_gecko/HiC'
ARIMA_PATH=$WORK_DIR/mapping_pipeline

SRA1='408044_AusARG_BRF_HG5YLDMXY_S4_L001'
SRA2='408044_AusARG_BRF_HG5YLDMXY_S4_L002'
LABEL='leplis_HiC_408044_AusARG_BRF_HG5YLDMXY_S4'

REF=$WORK_DIR/ref/leplis_V1.0.SM.fa
PREFIX=$WORK_DIR/ref/leplis_V1.0.SM.fa

#VARIABLES THAT SHOULD WORK AS THEY ARE ON PAWSEY BUT CAN BE CHANGED IF DESIRED#

IN_DIR=$WORK_DIR/raw
RAW_DIR=$WORK_DIR/raw_bams
FILT_DIR=$WORK_DIR/filt_bams
TMP_DIR=$WORK_DIR/temp_dir
PAIR_DIR=$WORK_DIR/pair_bams
REP_DIR=$WORK_DIR/rep_dir
MERGE_DIR=$WORK_DIR/merge_bams
REP_NUM=2 #number of the technical replicate set e.g. 1
REP_LABEL=$LABEL\_rep$REP_NUM

INPUTS_TECH_REPS=('INPUT=/data/listers_gecko/HiC/pair_bams/408044_AusARG_BRF_HG5YLDMXY_S4_L001.bam' 'INPUT=/data/listers_gecko/HiC/pair_bams/408044_AusARG_BRF_HG5YLDMXY_S4_L002.bam')

BWA='/home/ubuntu/miniconda3/pkgs/bwa-0.7.17-h7132678_9/bin/bwa'
PICARD='/home/ubuntu/miniconda3/pkgs/picard-2.23.8-0/share/picard-2.23.8-0/picard.jar'
SAMTOOLS='/home/ubuntu/miniconda3/bin/samtools'
BEDTOOLS='/home/ubuntu/miniconda3/bin/bedtools'

FAIDX='$REF.fai'

FILTER=$ARIMA_PATH/filter_five_end.pl
COMBINER=$ARIMA_PATH/two_read_bam_combiner.pl
STATS=$ARIMA_PATH/get_stats.pl

REP_NUM=2 #number of the technical replicates (aka lanes that sequenced the same individual) 
REP_LABEL=$LABEL\_rep$REP_NUM
MAPQ_FILTER=10
CPU=64



####START PIPELINE#####


cd $WORK_DIR

echo "### Step 0: Check output directories exist & create them as needed"
[ -d $RAW_DIR ] || mkdir -p $RAW_DIR
[ -d $FILT_DIR ] || mkdir -p $FILT_DIR
[ -d $TMP_DIR ] || mkdir -p $TMP_DIR
[ -d $PAIR_DIR ] || mkdir -p $PAIR_DIR
[ -d $REP_DIR ] || mkdir -p $REP_DIR
[ -d $MERGE_DIR ] || mkdir -p $MERGE_DIR

echo "### Step 0: Index reference" # Run only once! Skip this step if you have already generated BWA index files
$BWA index -a bwtsw -p $PREFIX $REF
$SAMTOOLS faidx $REF

####LANE 1####

echo "### Step 1.A: FASTQ to BAM (1st)"
$BWA mem -t $CPU $REF $IN_DIR/$SRA1\_R1_001.fastq.gz | $SAMTOOLS view -@ $CPU -Sb - > $RAW_DIR/$SRA1\_1.bam

echo "### Step 1.B: FASTQ to BAM (2nd)"
$BWA mem -t $CPU $REF $IN_DIR/$SRA1\_R2_001.fastq.gz | $SAMTOOLS view -@ $CPU -Sb - > $RAW_DIR/$SRA1\_2.bam

echo "### Step 1.C: Filter 5' end (1st)"
$SAMTOOLS view -h $RAW_DIR/$SRA1\_1.bam | perl $FILTER | $SAMTOOLS view -Sb - > $FILT_DIR/$SRA1\_1.bam

echo "### Step 1.D: Filter 5' end (2nd)"
$SAMTOOLS view -h $RAW_DIR/$SRA1\_2.bam | perl $FILTER | $SAMTOOLS view -Sb - > $FILT_DIR/$SRA1\_2.bam

rm $RAW_DIR/$SRA1\_1.bam
rm $RAW_DIR/$SRA1\_2.bam

echo "### Step 1.E: Pair reads & mapping quality filter"
perl $COMBINER $FILT_DIR/$SRA1\_1.bam $FILT_DIR/$SRA1\_2.bam $SAMTOOLS $MAPQ_FILTER | $SAMTOOLS view -bS -t $FAIDX - | $SAMTOOLS sort -@ $CPU -o $TMP_DIR/$SRA1.bam -

rm $FILT_DIR/$SRA1\_1.bam
rm $FILT_DIR/$SRA1\_2.bam

echo "### Step 1.F: Add read group"
java -Xmx4G -Djava.io.tmpdir=temp/ -jar $PICARD AddOrReplaceReadGroups INPUT=$TMP_DIR/$SRA1.bam OUTPUT=$PAIR_DIR/$SRA1.bam ID=$SRA1 LB=$SRA1 SM=$LABEL PL=ILLUMINA PU=none

rm $TMP_DIR/$SRA1.bam

####LANE 2####

echo "### Step 2.A: FASTQ to BAM (1st)"
$BWA mem -t $CPU $REF $IN_DIR/$SRA2\_R1_001.fastq.gz | $SAMTOOLS view -@ $CPU -Sb - > $RAW_DIR/$SRA2\_1.bam

echo "### Step 2.B: FASTQ to BAM (2nd)"
$BWA mem -t $CPU $REF $IN_DIR/$SRA2\_R2_001.fastq.gz | $SAMTOOLS view -@ $CPU -Sb - > $RAW_DIR/$SRA2\_2.bam

echo "### Step 2.C: Filter 5' end (1st)"
$SAMTOOLS view -h $RAW_DIR/$SRA2\_1.bam | perl $FILTER | $SAMTOOLS view -Sb - > $FILT_DIR/$SRA2\_1.bam

echo "### Step 2.D: Filter 5' end (2nd)"
$SAMTOOLS view -h $RAW_DIR/$SRA2\_2.bam | perl $FILTER | $SAMTOOLS view -Sb - > $FILT_DIR/$SRA2\_2.bam

rm $RAW_DIR/$SRA2\_1.bam
rm $RAW_DIR/$SRA2\_2.bam

echo "### Step 2.E: Pair reads & mapping quality filter"
perl $COMBINER $FILT_DIR/$SRA2\_1.bam $FILT_DIR/$SRA2\_2.bam $SAMTOOLS $MAPQ_FILTER | $SAMTOOLS view -bS -t $FAIDX - | $SAMTOOLS sort -@ $CPU -o $TMP_DIR/$SRA2.bam -

rm $FILT_DIR/$SRA2\_1.bam
rm $FILT_DIR/$SRA2\_2.bam

echo "### Step 2.F: Add read group"
java -Xmx4G -Djava.io.tmpdir=temp/ -jar $PICARD AddOrReplaceReadGroups INPUT=$TMP_DIR/$SRA2.bam OUTPUT=$PAIR_DIR/$SRA2.bam ID=$SRA2 LB=$SRA2 SM=$LABEL PL=ILLUMINA PU=none

rm $TMP_DIR/$SRA2.bam

####MERGE LANES####

echo "### Step 3.C: Merge tech reps"

java -Xmx8G -Djava.io.tmpdir=temp/ -jar $PICARD MergeSamFiles $INPUTS_TECH_REPS OUTPUT=$MERGE_DIR/$REP_LABEL.bam USE_THREADING=TRUE ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=LENIENT

rm $PAIR_DIR/$SRA1.bam
rm $PAIR_DIR/$SRA2.bam

echo "### Step 4: Mark duplicates"
java -Xmx30G -XX:-UseGCOverheadLimit -Djava.io.tmpdir=temp/ -jar $PICARD MarkDuplicates INPUT=$MERGE_DIR/$REP_LABEL.bam OUTPUT=$REP_DIR/$REP_LABEL.bam METRICS_FILE=$REP_DIR/metrics.$REP_LABEL.txt TMP_DIR=$TMP_DIR ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE

$SAMTOOLS index $REP_DIR/$REP_LABEL.bam

perl $STATS $REP_DIR/$REP_LABEL.bam > $REP_DIR/$REP_LABEL.bam.stats

echo "Finished Mapping Pipeline through Duplicate Removal"


####SORT BAM FILE BY NAME FOR YAHS####

echo "### Step 5: Sort bam file by name"

$SAMTOOLS sort -n $REP_DIR/$REP_LABEL.bam -o $REP_DIR/$REP_LABEL.sortedName.bam 

####CONVERT TO BED FORMAT FOR SALSA####

#$BEDTOOLS bamtobed -i $REP_DIR/$REP_LABEL.bam > $REP_DIR/$REP_LABEL.bed
#sort -k 4 $REP_DIR/$REP_LABEL.bed > tmp && mv tmp $REP_DIR/$REP_LABEL.bed

