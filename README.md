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

## PacBio HiFi genome assembly

### read pre-processing

* [bamtools](https://github.com/pezmaster31/bamtools)
* [HiFiAdapterFilt](https://github.com/sheinasim/HiFiAdapterFilt)
* [NanoPlot](https://github.com/wdecoster/NanoPlot)
* [Hifiasm](https://github.com/chhylp123/hifiasm)

\
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
\
### assess read quality

assess HiFi read quality with nanoplot
```
#if fails, try downgrading seaborn
#conda install seaborn==0.10.1

NanoPlot --fastq 359702_TSI_AGRF_DA149190.hifi.ccs.filt.fastq.gz 359702_TSI_AGRF_DA149222.hifi.ccs.filt.fastq.gz -p 359702_TSI_AGRF_combined.hifi.ccs.filt.fastq.gz. -t 4
NanoPlot --fastq 359703_TSI_AGRF_DA149208.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA149210.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA162797.hifi.ccs.filt.fastq.gz -p 359703_TSI_AGRF_combined.hifi.ccs.filt.fastq.gz. -t 4
```

### assemble genome with hifiasm

the basic hifiasm command looks like this `hifiasm -o asm fq.gz` and gives several assembly graphs as output. several hifiasm parameters increase contiguity at the cost of runtime. from some testing, it appears how well each parameter performs will depend on features of each species' genome that are still unknown to me at present. after fairly extensive parameter testing, we settled on the following parameters for the skink and gecko below:
\
\
assemble skink genome increasing `-k` and `-r` parameters
```
export PATH=~/hifiasm/:$PATH
hifiasm -t 32 -k 63 -r 5 -o cryege_V1.0.asm 359702_TSI_AGRF_DA149190.hifi.ccs.filt.fastq.gz 359702_TSI_AGRF_DA149222.hifi.ccs.filt.fastq.gz
```

assemble gecko genome increasing `-D`, `-k`, `-r`, `--max-kocc`, `-a`, `-s`, `-N`, and `--hom-cov` parameters
```
export PATH=~/hifiasm/:$PATH
hifiasm -t 32 -D 20 -k 63 -r 9 --max-kocc 10000 -a 6 -s 0.65 -N 300 --hom-cov 30 -o leplis_V1.0.asm 359703_TSI_AGRF_DA149208.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA149210.hifi.ccs.filt.fastq.gz 359703_TSI_AGRF_DA162797.hifi.ccs.filt.fastq.gz```


