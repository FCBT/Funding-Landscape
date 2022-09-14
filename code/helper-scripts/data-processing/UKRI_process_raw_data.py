#!/usr/bin/env python3

""" This code process the UKRI data from file 'UKRI_raw_metadata.csv'. It selects and rename columns to match the processed metadata
of all other countries, saving this as a new file called 'UKRI_project_metadata.csv'.

If run from the command line, it takes 3 arguments: 
1) the file path to the raw xml files
2) the file path to save text data, which will be the input to the script 01_process_multiple_text.py
3) the file path to save the projects metadata which will be used for analysis after running the LDA model

argv[1] = "./raw-data/fine-scale/UK/UKRI/"
argv[2] = "./clean-data/fine-scale/UK/UKRI/"


Example:  python3 code/helper-scripts/data-processing/UKRI_process_raw_data.py ./raw-data/fine-scale/UK/UKRI/ ./clean-data/fine-scale/UK/UKRI/

"""


__appname__ = 'UKRI_process_raw_data.py'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'


## Imports ## 
from re import X
import sys # module to interface our program with the operating system
import xml.etree.ElementTree as Xet
import pandas as pd
import os
from datetime import datetime
from datetime import date

# filename = 'UKRI_general.csv'
# one = "./raw-data/fine-scale/UK/UKRI/"
# two = "./raw-data/fine-scale/UK/UKRI/projects-metadata/"

## load csv file downloaded from URKI website
project_metadata = pd.read_csv("./raw-data/fine-scale/UK/UKRI/UKRI_raw_metadata.csv")
print("data loaded")
# filter projects by research grant and fellowships
data = project_metadata[project_metadata.ProjectCategory.isin(["Research Grant", "Fellowship"])]
#filter STEM funding bodies
stem = ["BBSRC","EPSRC", "NERC", "STFC", "MRC"]
data = data[data.FundingOrgName.isin(stem)]

def main(argv):
         
    ## Loop through files in each year folder 
    for filename in os.listdir(argv[1]):

        ## Check if a file has xml format, if so, parse xml file, store its name without ".xml" suffix and create a name for .txt file
        if filename.endswith(".csv"):

            ukri_metadata = pd.read_csv(os.path.join(argv[1], filename)) 

            # filter projects by research grant and fellowships
            data_filtered = ukri_metadata[ukri_metadata.ProjectCategory.isin(["Research Grant", "Fellowship"])]
            #filter STEM funding bodies
            data_filtered = data_filtered[data_filtered.FundingOrgName.isin(["BBSRC","EPSRC", "NERC", "STFC", "MRC"])]

            # select columns
            ukri_cleaned = data_filtered[["ProjectId","FundingOrgName","LeadROName","StartDate","EndDate","AwardPounds"]]
            # rename columns to match other countries' project metadata
            ukri_cleaned = ukri_cleaned.rename(columns = {"ProjectId":"ProjectId", "FundingOrgName":"FundingBody", "LeadROName":"LeadInstitution","StartDate":"StartDate","EndDate":"EndDate","AwardPounds":"FundingAmount"})
                    
            # add columns to match other countries' project metadata 
            ukri_cleaned["Country"] = "UK"
            ukri_cleaned["CountryFundingBody"]= "UKRI"
            ukri_cleaned["FundingCurrency"] = "GBP"

            # reorder columns
            ukri_cleaned = ukri_cleaned[['ProjectId', 'Country', 'CountryFundingBody', 'FundingBody','LeadInstitution', 'StartDate', 'EndDate', 'FundingAmount','FundingCurrency']]
        
            # save project_metadata file 
            ukri_cleaned.to_csv(os.path.join(argv[2], "UKRI_project_metadata.csv"), index=False)

              
if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)
