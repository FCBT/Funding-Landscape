## This code parses the NSF project xml files, extracts project titles and abstracts (if they exist) and writes them into
# a .txt file ("projectID.txt)


## Import all necessary packages
import xml.etree.ElementTree as Xet
import pandas as pd
import os
import io
import numpy

## Set working directory to directory containing folder with xml files (PATH_TO_WORKING_DIR\\XML_DIR)
wd = PATH_TO_WORKING_DIR 

os.chdir(wd)

## Define directory containing all xml files
directory_name = XML_DIR

directory = os.fsencode(directory_name)

## Create folder in XML_DIR named XML_DIR_txt to store all text files in
text_file_dir = directory_name + '\\' '\\' + directory_name + '_txt'
os.mkdir(text_file_dir)

## Loop through xml files in XML_DIR, get file names and change working directory to XML_DIR
for file in os.listdir(directory):
    filename = os.fsdecode(file)
    os.chdir(directory)
    ## Check if a file has xml format, if so, parse xml file, store its name without ".xml" suffix and create a name for .txt file
    if filename.endswith(".xml"):
        rawname = filename.removesuffix('.xml')
        txtname = rawname + '.txt'
        path = os.path.abspath(filename)
        xmlparse = Xet.parse(path)
        root = xmlparse.getroot()
        ## Loop through elements of xml root, find titles and abstracts and store them
        for element in root:
            AwardTitle = element.find(".//AwardTitle")
            Abstract = element.find(".//AbstractNarration")
        ## Change wd to XML_DIR_txt and write txt file with project title and project abstract.
        os.chdir(directory_name + '_txt')
        with io.open(txtname, 'w', encoding='utf-8') as f:
            if AwardTitle.text != None:
                f.write(AwardTitle.text)
                f.write('\n')
            if Abstract.text != None:
                f.write(Abstract.text)
    ## Change wd back to PATH_TO_WORKING_DIR 
    os.chdir(wd)
    
print("Done")