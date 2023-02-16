# Christmas_island_reptiles

![Christmas Island Reptiles](https://github.com/tododge/christmas_island_reptiles/files/10751830/revisions_fig4.pdf "figure 4")

This workflow contains scripts used in [Dodge et al. (in review)](https://www.authorea.com/users/557855/articles/607316-genomes-of-two-extinct-in-the-wild-reptiles-from-christmas-island-reveal-distinct-evolutionary-histories-and-conservation-insights?commit=87274701232938aa298c07b9d2a5588c9b93a295).

## Software and dependencies

The steps described below use the following software and assume that dependencies are on the user path:

* [minimap2](https://github.com/lh3/minimap2)
* [GATK](https://gatk.broadinstitute.org/hc/en-us)
* [PSMC](https://github.com/lh3/psmc)
* [R](https://cran.r-project.org/)

## General resources

## PacBio HiFi genome assembly

### Clean reads 

* Remove 5' end bases if quality is below 20
* Remove 3' end bases if quality is below 20
* Minimum read length = 32
* Remove reads if average quality is < 30

### Set up environment

Make directory `data`
```
mkdir data
```
