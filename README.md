# Christmas_island_reptiles

![Christmas Island Reptiles](/fig4_github.png "figure 4")

This workflow contains scripts used in [Dodge et al. (in review)](https://www.authorea.com/users/557855/articles/607316-genomes-of-two-extinct-in-the-wild-reptiles-from-christmas-island-reveal-distinct-evolutionary-histories-and-conservation-insights?commit=87274701232938aa298c07b9d2a5588c9b93a295).

## Software and dependencies

Computation for this project was conducted on the Artemis HPC machine at Syndey Uni and Pawsey Supercomputing Research Centre. 

The following dependencies were used:

* [minimap2](https://github.com/lh3/minimap2)
* [GATK](https://gatk.broadinstitute.org/hc/en-us)
* [PSMC](https://github.com/lh3/psmc)
* [R](https://cran.r-project.org/)

## Genome Assembly

### read pre-processing

* [bamtools](https://github.com/pezmaster31/bamtools)
* [HiFiAdapterFilt](https://github.com/sheinasim/HiFiAdapterFilt)

remove non-HiFi reads ccs.bam files for the skink
```
bamtools filter -in 359702_TSI_AGRF_DA149190.ccs.bam -out 359702_TSI_AGRF_DA149190.hifi.ccs.bam -tag "rq":">-0.99"
bamtools filter -in 359702_TSI_AGRF_DA149222.ccs.bam -out 359702_TSI_AGRF_DA149222.hifi.ccs.bam -tag "rq":">-0.99"
```
remove non-HiFi reads ccs.bam files for the gecko
```
bamtools filter -in 359703_TSI_AGRF_DA149208.ccs.bam -out 359703_TSI_AGRF_DA149208.hifi.ccs.bam -tag "rq":">-0.99"
bamtools filter -in 359703_TSI_AGRF_DA149210.ccs.bam -out 359703_TSI_AGRF_DA149210.hifi.ccs.bam -tag "rq":">-0.99"
bamtools filter -in 359703_TSI_AGRF_DA162797.ccs.bam -out 359703_TSI_AGRF_DA162797.hifi.ccs.bam -tag "rq":">-0.99"
```
\
filter out HiFi adapters in the skink `hifi.ccs.bam` files. get `fastq.gz` files as output
```
export PATH=$PATH:~/HiFiAdapterFilt/
export PATH=$PATH:~/HiFiAdapterFilt/DB

bash hifiadapterfilt.sh -t 32 -p 359702_TSI_AGRF_DA149222.hifi.ccs
bash hifiadapterfilt.sh -t 32 -p 359702_TSI_AGRF_DA149190.hifi.ccs
```
filter out HiFi adapters in the gecko `hifi.ccs.bam` files. get `fastq.gz` files as output
```
export PATH=$PATH:~/HiFiAdapterFilt/
export PATH=$PATH:~/HiFiAdapterFilt/DB

bash hifiadapterfilt.sh -t 32 -p 359703_TSI_AGRF_DA149208.hifi.ccs
bash hifiadapterfilt.sh -t 32 -p 359703_TSI_AGRF_DA149210.hifi.ccs
bash hifiadapterfilt.sh -t 32 -p 359703_TSI_AGRF_DA162797.hifi.ccs
```

### assess read quality
* [NanoPlot](https://github.com/wdecoster/NanoPlot)

assess HiFi read quality with nanoplot
```
#if fails, try downgrading seaborn
#conda install seaborn==0.10.1

NanoPlot --fastq 359702_TSI_AGRF_DA149190.hifi.ccs.filt.fastq.gz 359702_TSI_AGRF_DA149222.hifi.ccs.filt.fastq.gz -p 359702_TSI_AGRF_combined.hifi.ccs.filt.fastq.gz. -t 4
NanoPlot --fastq 359703_TSI_AGRF_DA149208.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA149210.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA162797.hifi.ccs.filt.fastq.gz -p 359703_TSI_AGRF_combined.hifi.ccs.filt.fastq.gz. -t 4
```

### assemble genomes with hifiasm

* [Hifiasm](https://github.com/chhylp123/hifiasm)

the basic hifiasm command looks like this `hifiasm -o asm fq.gz` and gives several assembly graphs as output. several hifiasm parameters increase contiguity at the cost of runtime. from some testing, it appears how well each parameter performs will depend on features of each species' genome that are still unknown to me at present. after fairly extensive parameter testing, we settled on the following parameters for the skink and gecko below:
\
\
assemble skink genome increasing `-k` and `-r` parameters
```
hifiasm -t 32 -k 63 -r 5 -o cryege_V1.0.asm 359702_TSI_AGRF_DA149190.hifi.ccs.filt.fastq.gz 359702_TSI_AGRF_DA149222.hifi.ccs.filt.fastq.gz
awk '/^S/{print ">"$2;print $3}' cryege_V1.0.asm.bp.p_ctg.gfa > cryege_V1.0.asm.bp.p_ctg.fa
```

assemble gecko genome increasing `-D`, `-k`, `-r`, `--max-kocc`, `-a`, `-s`, `-N`, and `--hom-cov` parameters
```
hifiasm -t 32 -D 20 -k 63 -r 9 --max-kocc 10000 -a 6 -s 0.65 -N 300 --hom-cov 30 -o leplis_V1.0.asm 359703_TSI_AGRF_DA149208.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA149210.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA162797.hifi.ccs.filt.fastq.gz
awk '/^S/{print ">"$2;print $3}' leplis_V1.0.asm.bp.p_ctg.gfa > leplis_V1.0.asm.bp.p_ctg.fa
```

### scaffold gecko genome with HiC
* [arima_modified_LG.sh](/arima_modified_LG.sh) modified from [Arima mapping pipeline](https://github.com/ArimaGenomics/mapping_pipeline)
* [YaHS](https://github.com/c-zhou/yahs)

first use the Arima mapping pipeline to map HiC reads to primary assembly generated with hifiasm
```
bash arima_modified_LG.sh
```

scaffold the genome with YaHS. input files are `HiC.sortedName.bam` from the previous step and the contigs from hifiasm
```
yahs leplis_V1.0.asm.bp.p_ctg.fa leplis_HiC_408044_AusARG_BRF_HG5YLDMXY_S4_rep2.V1.0.SM.sortedName.bam -o leplis_V1.0_HiC
```

### evaluate HiC scaffolding
* [YaHS](https://github.com/c-zhou/yahs)
* samtools
* [juicer_tools_1.19.02.jar](https://github.com/aidenlab/juicer/wiki/Download)
* [Juicebox](https://github.com/aidenlab/Juicebox) (optional for HiC contact map viewing/assembly editing)

generate HiC contact map using a combination of YaHS and juicer tools. more detailed instructions can be found on the YaHS github

```
samtools faidx leplis_V1.0.asm.bp.p_ctg.fa
samtools leplis_V1.0_HiC_scaffolds_final.fasta

cut -f1,2 leplis_V1.0_HiC_scaffolds_final.fasta.fai > leplis_V1.0_HiC_scaffolds_final.chrom.sizes

(yahs/juicer pre leplis_V1.0_HiC.bin leplis_V1.0_HiC_scaffolds_final.agp leplis_V1.0.asm.bp.p_ctg.fa.fai | /usr/bin/sort -k2,2d -k6,6d -T ./ -S64G --parallel=16 | awk 'NF' > alignments_sorted.txt.part) && (mv alignments_sorted.txt.part leplis_V1.0_HiC_alignments_sorted.txt)

(java -jar -Xmx32G juicer_tools_1.19.02.jar pre leplis_V1.0_HiC_alignments_sorted.txt leplis_V1.0_HiC_scaffolds_final.hic.part leplis_V1.0_HiC_scaffolds_final.chrom.sizes) && (mv leplis_V1.0_HiC_scaffolds_final.hic.part leplis_V1.0_HiC_scaffolds_final.hic)
```
the leplis_V1.0_HiC_scaffolds_final.hic can be loaded into JuiceBox or other software, but cannot be edited

the following steps create `.hic` and `.assembly` files that can be edited in JuiceBox
```
../yahs/juicer pre -a -o leplis_V1.0_HiC_out_JBAT leplis_V1.0_HiC.bin leplis_V1.0_HiC_scaffolds_final.agp leplis_V1.0.asm.bp.p_ctg.fa.fai > leplis_V1.0_HiC_out_JBAT_out_JBAT.log 2>&1

(java -jar -Xmx64G juicer_tools_1.19.02.jar pre leplis_V1.0_HiC_out_JBAT.txt leplis_V1.0_HiC_out_JBAT.hic.part <(cat leplis_V1.0_HiC_out_JBAT.log  | grep PRE_C_SIZE | awk '{print $2" "$3}')) && (mv leplis_V1.0_HiC_out_JBAT.hic.part leplis_V1.0_HiC_out_JBAT.hic)
```

### evaluate assembly quality
* [bbmap]
* [quast]
* BUSCO
use bbmap and QUAST to evaluate assembly contiguity
```
genome=cryege_V1.0.fa
genome=leplis.V1.2.fa

~/bbmap/stats.sh $genome -Xmx40G  #-Xmx40G increases java memory
~/quast/quast.py $genome #many options with quast, especially in comparision to reference genome

list_num="1,10,20,30,40,50,60,70,80,90,99"
perl ~/NX.pl $genome $list_num > $genome.NX.plot

```
\
use BUSCO to evaluate assembly completeness. for reptiles, `vertebrata_odb10` and `sauropsida_odb10` are both appropriate, but we chose `vertebrata_odb_10` because these reptiles are from underrepresented clades and may both lack some BUSCOs for biological reasons. for the most accurate run, specify "-m geno" and "--long".

```
genome=cryege_V1.0.fa
#genome=leplis_V1.2.fa

ODB=vertebrata_odb10
#ODB=sauropsida_odb10

singularity exec busco_v5.3.2_cv1.sif busco -i $genome -l vertebrata_odb10 -o $genome\_busco_$ODB -m geno -c 16 --long --offline --download_path ./busco_downloads/
```

### assemble mitochondrial genomes
* [mitohifi]
* [seqkit]

MitoHiFi allows you to assemble the mito genome by either extracting it from the assembly or by assembling it from the raw reads. we did it from the raw reads. it should be noted that some PacBio HiFi library preps appear to lose the mitochondria for reasons that are unclear.
```
#download sequence for most related skink species (was Eutropis multifasciata - MT977075.1)
singularity exec mitohifi_2.2_cv1.sif findMitoReference.py --species "Cryptoblepharus egeriae" --outfolder . --min_length 16000

#convert fq reads to fa (required input)
seqkit fq2fa 359702_TSI_AGRF_DA149190.hifi.ccs.filt.fastq.gz 359702_TSI_AGRF_DA149222.hifi.ccs.filt.fastq.gz -o 359702_TSI_AGRF_combined.hifi.ccs.filt.fasta

singularity exec mitohifi_2.2_cv1.sif mitohifi.py -r 359702_TSI_AGRF_combined.hifi.ccs.filt.fasta -f MT977075.1.fasta -g MT977075.1.gb -t 6 -o 1


```

```
#download sequence for most related gecko species (was Lepidodactylus lugubris - AB738945.1)
singularity exec mitohifi_2.2_cv1.sif findMitoReference.py --species "Lepidodactylus listeri" --outfolder . --min_length 16000

#convert fq reads to fa (required input)
seqkit fq2fa 359703_TSI_AGRF_DA149208.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA149210.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA162797.hifi.ccs.filt.fastq.gz -o 359703_TSI_AGRF_combined.hifi.ccs.filt.fasta

singularity exec mitohifi_2.2_cv1.sif mitohifi.py -r 359703_TSI_AGRF_combined.hifi.ccs.filt.fasta -f AB738945.1.fasta -g AB738945.1.gb -t 6 -o 1
```
