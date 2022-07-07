# Funding Landscape

This contains all relevant code/data/results for quantifying gaps in the current STEM funding landscape at the UK and international level.

### data

#### raw-data

```raw-data/broad-scale/metadata.csv``` - detailed information of the raw data collected at broad scale: what country/funding body it refers to, where/when it was found online, where it is stored and who collected it. 

```raw-data/broad-scale/'country'/*.csv``` - each file contains the raw data on research councils funding topics and scope for STEM per funding body.

```raw-data/fine-scale/metadata.csv``` - detailed information of the raw data collected at fine scale: what country/funding body/funded project it refers to, where/when/how it was found online, where it is stored and who collected it.

```raw-data/fine-scale/'country'/*.csv``` - each file contains the raw data on funded projects (i.e titles, abstracts, funded amount...) by research councils.

#### clean-data

```clean-data/broad-scale/metadata.csv``` - detailed information of the data processed: what country/funding body it refers to, file path to raw data, where clean data is stored, who processed it and script used to processed it.

```clean-data/broad-scale/'country'/*.csv``` - the entire processed data (or one file per funding body? - Ask will and samraat) on research councils funding topics and scope for STEM per country per funding body.

```clean-data/fine-scale/metadata.csv``` - detailed information of the data processed: what country/funding body it refers to, file path to raw data, where clean data is stored, who processed it and script used to processed it.

```clean-data/fine-scale/'country'/*.csv``` - the entire processed data on funded projects per country by research councils.

### code

TBD

### results

TBD

### ms

TBD

### src

packages.R - use ```src/packages.R``` at the beginning of scripts to load (and install) any packages needed.

### conda environment
packages used for text processing and running the LDA models