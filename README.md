# Funding Landscape

This contains all relevant code and results for quantifying gaps in the current STEM funding landscape at the UK and international level. Data is stored in OneDrive (https://bit.ly/3BGzepE).

### data

#### raw-data

```raw-data/broad-scale/metadata.csv``` - detailed information of the raw data collected at broad scale: what country/funding body it refers to, where/when it was found online, where it is stored and who collected it. 

```raw-data/broad-scale/'country'/*.txt``` (in OneDrive) - each file contains the raw data on research councils funding topics and scope for STEM per funding body.

Note: for UKRI data, a general overview of each research council's remit and priorities can be found in the ```ukri/<council>.txt``` file. A more extensive 'list' of each council's areas of investment can be found in the ```ukri/<council>-research-areas.txt``` file, as sourced from https://www.ukri.org/what-we-offer/browse-our-areas-of-investment-and-support/.


```raw-data/fine-scale/metadata.csv``` - detailed information of the raw data collected at fine scale: what country/funding body/funded project it refers to, where/when/how it was found online, where it is stored and who collected it.

```raw-data/fine-scale/'country'/*.csv``` (in OneDrive) - each file contains the raw data on funded projects (i.e titles, abstracts, funded amount...) by research councils.

#### clean-data

```clean-data/broad-scale/metadata.csv``` - detailed information of the data processed: what country/funding body it refers to, file path to raw data, where clean data is stored, who processed it and script used to processed it.

```clean-data/broad-scale/'country'/*.csv``` (in OneDrive) - the entire processed data (or one file per funding body? - Ask will and samraat) on research councils funding topics and scope for STEM per country per funding body.

```clean-data/fine-scale/metadata.csv``` - detailed information of the data processed: what country/funding body it refers to, file path to raw data, where clean data is stored, who processed it and script used to processed it.

```clean-data/fine-scale/'country'/*.csv``` (in OneDrive) - the entire processed data on funded projects per country by research councils.

### code
```code/'number_script'``` - scripts to wrangle/analyse/plot data in order of use, from 01 to 07.

```code/helper-scripts/data-collection/*``` - code to retrieve data from the web (e.g. API, web scraping).

```code/helper-scripts/data-processing/*``` - code to process the raw data into standard clean data for each country/funding body. Uses data from the 'raw-data' folder and saves them into the 'clean-data' folder.

```code/src/packages.R``` -  code to use at the beginning of scripts to load (and install) any packages needed.

### results

TBD

### ms

TBD

### conda environment
environment.yml - packages used for text processing and running the LDA models