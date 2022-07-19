## This code parses NSF project xml files and extracts fields of interest (as specified by the columns). It then saves the fields
# into a dataframe and wirtes the dataframe into a csv file.

## Import all necessary packages

import xml.etree.ElementTree as Xet
import pandas as pd
import os
import io
import numpy

## Define working directory such that it contains the folder containing the xml files (PATH_TO_WORKING_DIR\\XML_DIR)

wd = PATH_TO_WORKING_DIR

os.chdir(wd)

## Allocate columns vector and initialize rows
cols = ["ProjectId", "Country", "FundingBody", "LeadUniversity", "StartDate", "EndDate", "FundingAmount", "FundingCurrency"]
rows = []

## Define universal fields (they are the same for every xml file)
Country = "USA"
FundingBody = "NSF"
FundingCurrency = "US Dollars"
rows = []

## Define folder where xml files are stored
xml_folder = XML_DIR


## Loop through each xml file in folder and change wd to XML_DIR
for file in os.listdir(xml_folder):
    filename = os.fsdecode(file)
    os.chdir(xml_folder)
    ## Check if it is an xml file and parse if true
    if filename.endswith(".xml"):
        xmlparse = Xet.parse(filename)
        root = xmlparse.getroot()
        ## Loop through elements of root, find and extract relevant fields
        for element in root:
            ProjectId = element.find(".//AwardID").text
            LeadUni = element.find(".//Institution")
            StartDate = element.find(".//StartDate")
            EndDate = element.find(".//EndDate")
            FundingAmount = element.find(".//AwardAmount").text
            PerformanceI = element.find(".//Performance_Institution")
            
            ## Check if fields are unspecified and change output accordingly
            
            ## If there is no LeadUni we check whether the project has been awarded to another institution
            if LeadUni == None:
                if PerformanceI != None:
                    StartDate = PerformanceI[0].text
                else:
                    LeadUni = "None"
            else:
                LeadUni = LeadUni[0].text
                
            if StartDate == None:
                StartDate = "None"
            else:
                StartDate = StartDate.text
                
            if EndDate == None:
                StartDate = "None"
            else:
                EndDate = EndDate.text

        ## Append extracted info to rows
        rows.append({"ProjectId": ProjectId, "Country": Country, "FundingBody": FundingBody, "LeadUniversity": LeadUni, 
                    "StartDate": StartDate, "EndDate": EndDate, "FundingAmount": FundingAmount, 
                    "FundingCurrency": FundingCurrency})
    ## change wd back to PATH_TO_WORKING_DIR
    os.chdir(wd)
    
## When done looping through xml files create dataframe from rows with specified column names 
df = pd.DataFrame(rows, columns=cols)

## Save dataframe to csv file
df.to_csv("NSF_general.csv", encoding="utf-8", index=False)