## This code parses NSF project xml files and extracts fields of interest (as specified by the columns). It then saves the fields
# into a dataframe and wirtes the dataframe into a csv file.

## Import all necessary packages

import xml.etree.ElementTree as Xet
import pandas as pd
import os
import io
import numpy


def check_text(x):
    # print(x)
    if x != None:
        if x.text == None:
            return("None")
        else:
            return(x.text)
    return("None")

## Define working directory such that it contains the folder containing the xml files (PATH_TO_WORKING_DIR\\XML_DIR)

wd = 'PATH_TO_WORKING_DIR\\XML_DIR'

os.chdir(wd)

## Allocate columns vector and initialize rows
cols = ["ProjectId", "Country", "CountryFundingBody", "FundingBody", "LeadUniversity", "StartDate", "EndDate", "FundingAmount", "FundingCurrency"]
rows = []

## Define universal fields (they are the same for every xml file)
Country = "USA"
CountryFundingBody = "NSF"
FundingCurrency = "USD"
rows = []

## Define folder where xml files are stored
xml_folder = 'PATH_TO_XML_FILES'

## Loop through each xml file in folder and change wd to XML_DIR
for file in os.listdir(xml_folder):
    filename = os.fsdecode(file)
    os.chdir(xml_folder)
    ## Check if it is an xml file and parse if true
    if filename.endswith(".xml"):
        xmlparse = Xet.parse(filename)
        root = xmlparse.getroot()
        ## Loop through elements of root, find and extract relevant fields
        # for element in root:
        # print(file)
        ProjectId = check_text(root.find(".//AwardID"))
        FundingBody = check_text(root.find(".//Directorate/Abbreviation"))
        StartDate = check_text(root.find(".//AwardEffectiveDate"))
        EndDate = check_text(root.find(".//AwardExpirationDate"))
        FundingAmount = check_text(root.find(".//AwardAmount"))
        LeadUni = check_text(root.find(".//Performance_Institution/Name"))

        ## Append extracted info to rows
        rows.append({"ProjectId": ProjectId, "Country": Country, "CountryFundingBody": CountryFundingBody, "FundingBody": FundingBody, "LeadUniversity": LeadUni, 
                    "StartDate": StartDate, "EndDate": EndDate, "FundingAmount": FundingAmount, 
                    "FundingCurrency": FundingCurrency})

    ## change wd back to PATH_TO_WORKING_DIR
    os.chdir(wd)
    
## When done looping through xml files create dataframe from rows with specified column names 
df = pd.DataFrame(rows, columns=cols)


## Save dataframe to csv file
df.to_csv("./NSF_general.csv", encoding="utf-8", mode='a', index=False)
