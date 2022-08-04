#!/usr/bin/env python3

""" This code parses the NSF project xml files, extracts project titles and abstracts (if they exist) and writes them into
# a .txt file ("projectID.txt)

If run as a script, it takes 5 arguments: 
1) the file path to the raw xml files
2) the file path to save text data, which will be the input to the script 01_process_multiple_text.py
3) the file path to save the projects metadata which will be used for analysis after running the LDA model

argv[1] = "./raw-data/fine-scale/USA/NSF/NSF_raw_xml"
argv[2] = "./raw-data/fine-scale/USA/NSF/titles_abstracts/"
argv[3] = "./raw-data/fine-scale/USA/NSF/projects_metadata/"

Example:  python3 ./raw-data/fine-scale/USA/NSF/NSF_raw_xml ./raw-data/fine-scale/USA/NSF/titles_abstracts/ ./raw-data/fine-scale/USA/NSF/projects_metadata/

"""


__appname__ = 'NSF_xml_txt.py'
__author__ = 'Michael Mustri (email), Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.2'


## Imports ## 
from re import X
import sys # module to interface our program with the operating system
import xml.etree.ElementTree as Xet
import pandas as pd
import os
import io
import numpy

# one = "./raw-data/fine-scale/USA/NSF/NSF_raw_xml"
# two = "./raw-data/fine-scale/USA/NSF/titles_abstracts/"
# three = "./raw-data/fine-scale/USA/NSF/projects_metadata/"

## Constants ##
metadata = {"ProjectId": [], "Country": [], "CountryFundingBody": [], "FundingBody":[], "LeadInstitution":[], 
"StartDate": [], "EndDate": [], "FundingAmount": [], "FundingCurrency": []}

## funcions ##
def check_text(x):
    # print(x)
    if x != None:
        if x.text == None:
            return("None")
        else:
            return(x.text)
    return("None")


def main(argv):
    ## Loop through years folders in the NSF_xml_raw folder
    for folder in os.listdir(os.path.join(argv[1])):
        print(folder)
   
        current_year_path = os.path.join(argv[1], folder)
        
        ## Loop through files in each year folder 
        for filename in os.listdir(current_year_path):
            
            
            ## Check if a file has xml format, if so, parse xml file, store its name without ".xml" suffix and create a name for .txt file
            if filename.endswith(".xml"):
                rawname = filename.removesuffix('.xml')
                xmlparse = Xet.parse(os.path.join(current_year_path,filename))
                root = xmlparse.getroot()

                # get projects metadata and store
                ProjectId = check_text(root.find(".//AwardID"))
                metadata["ProjectId"].append(ProjectId)

                FundingBody = check_text(root.find(".//Directorate/Abbreviation"))
                metadata["FundingBody"].append(FundingBody)

                StartDate = check_text(root.find(".//AwardEffectiveDate"))
                metadata["StartDate"].append(StartDate)

                EndDate = check_text(root.find(".//AwardExpirationDate"))
                metadata["EndDate"].append(EndDate)
                
                FundingAmount = check_text(root.find(".//AwardAmount"))
                metadata["FundingAmount"].append(FundingAmount) 

                LeadInst = check_text(root.find(".//Performance_Institution/Name"))
                metadata["LeadInstitution"].append(LeadInst)

                # values that are the same for all documents
                metadata["Country"].append("USA")
                metadata["CountryFundingBody"].append("NSF")
                metadata["FundingCurrency"].append("USD")

                ## find titles and abstracts to store them in a separate file
                Title = root.find(".//AwardTitle").text
                Abstract = root.find(".//AbstractNarration").text

                ## check we have title and abstract
                if Title:
                    if Abstract:
                        ## if TRUE, save in a txt file that has the project ID as the filename
                        with open(os.path.join(argv[2], rawname + '.txt'), 'w') as f:
                            f.write(Title)
                            f.write("\n")
                            f.write(Abstract)
    # turn dict into dataframe and save it
    df = pd.DataFrame.from_dict(metadata)
    df.to_csv(os.path.join(argv[3], "NSF_project_metadata.csv"), index=False)

              

                    


if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)
