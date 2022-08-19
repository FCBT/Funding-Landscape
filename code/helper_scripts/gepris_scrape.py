'''
Python code to scrape info on German grant recipients/projects
Using Gepris website/dataportal : https://gepris.dfg.de/gepris/
'''

import requests
import pandas as pd
import numpy as np
import json
from bs4 import BeautifulSoup

# Results 1 to 50 out of 135,203 on 2,705 pages


# Need to get project urls from pages, 
# start page is:
# https://gepris.dfg.de/gepris/OCTOPUS?beginOfFunding=&bewilligungsStatus=&bundesland=DEU%23&context=projekt&einrichtungsart=-1&fachgebiet=%23&findButton=historyCall&gefoerdertIn=&ggsHunderter=0&hitsPerPage=50&index=0&language=en&nurProjekteMitAB=false&oldGgsHunderter=0&oldfachgebiet=%23&pemu=%23&task=doKatalog&teilprojekte=true&zk_transferprojekt=false
# index=0  
# page 2:
# https://gepris.dfg.de/gepris/OCTOPUS?beginOfFunding=&bewilligungsStatus=&bundesland=DEU%23&context=projekt&einrichtungsart=-1&fachgebiet=%23&findButton=historyCall&gefoerdertIn=&ggsHunderter=0&hitsPerPage=50&index=50&language=en&nurProjekteMitAB=false&oldGgsHunderter=0&oldfachgebiet=%23&pemu=%23&task=doKatalog&teilprojekte=true&zk_transferprojekt=false
# need to increment index=50
# final page:
# https://gepris.dfg.de/gepris/OCTOPUS?beginOfFunding=&bewilligungsStatus=&bundesland=DEU%23&context=projekt&einrichtungsart=-1&fachgebiet=%23&findButton=historyCall&gefoerdertIn=&ggsHunderter=0&hitsPerPage=50&index=135200&language=en&nurProjekteMitAB=false&oldGgsHunderter=0&oldfachgebiet=%23&pemu=%23&task=doKatalog&teilprojekte=true&zk_transferprojekt=false
# index=135200 


#################
# Main code below
#################

def get_projekt_links(url):
    soup = BeautifulSoup(req_session.get(url).content, 'html')

    projekt_links = [ x["href"] for x in soup.find_all('a', href=True) 
                    if "/gepris/projekt/" in x["href"] ]

    projekt_links = list(set([ x for x in projekt_links if "=" not in x ]))

    return(projekt_links)


# 20220810: Added ".replace("\r", "").replace("\n", "")"
# Need to re-run/test...
def get_project_details(projektID):
    
    attrs_list = [("projektID", projektID)]
    url = "https://gepris.dfg.de"+projektID+"?language=en"
    soup = BeautifulSoup(req_session.get(url).content, 'html')

    soup_elem = soup.find('div', attrs={'class': 'content_inside detailed'})
    # soup_elem = soup_elem.find('div', attrs={'class': 'details'}, recursive=False)
    title_text = soup_elem.find('h1', recursive=True).get_text(strip=True)
    # attrs_list = [('title', title_text)]
    title_text = title_text.replace("\r", "").replace("\n", "") 
    attrs_list.append(('title', title_text))
    for curr_div in soup_elem.find_all('div', recursive=True):
        if curr_div.find('span', attrs={'class': 'name'}, recursive=True) is not None:
            curr_name = curr_div.find('span', attrs={'class': 'name'}, recursive=True).get_text(strip=True)
            curr_value = curr_div.find('span', attrs={'class': 'value'}, recursive=True).get_text(strip=True)
            curr_value = curr_value.replace("\r", "").replace("\n", "")
            attrs_list.append((curr_name, curr_value))
        if curr_div.find("div", attrs={"id" : "projekttext"}, recursive=True) is not None:
            curr_name = "projekttext"
            curr_value = curr_div.find("div", attrs={"id" : "projekttext"}, recursive=True).get_text(strip=True)
            curr_value = curr_value.replace("\r", "").replace("\n", "")
            attrs_list.append((curr_name, curr_value))
    return(dict(attrs_list))



# get_projekt_links("https://gepris.dfg.de/gepris/OCTOPUS?beginOfFunding=&bewilligungsStatus=&bundesland=DEU%23&context=projekt&einrichtungsart=-1&fachgebiet=%23&findButton=historyCall&gefoerdertIn=&ggsHunderter=0&hitsPerPage=50&index=135200&language=en&nurProjekteMitAB=false&oldGgsHunderter=0&oldfachgebiet=%23&pemu=%23&task=doKatalog&teilprojekte=true&zk_transferprojekt=false")


req_session = requests.Session()

# First, get a list of all project links
projekts_ls = []

cntr = 1
# for i in range(0, 100+1, 50):

# Note: max i is set manually based on strt page
# for i in range(0, 135200+1, 50):
# 10th Aug update... - more pages... 135,773 entries
for i in range(0, 135750+1, 50):
    if cntr % 100 == 0 :
        print(cntr)
    url_pre = "https://gepris.dfg.de/gepris/OCTOPUS?beginOfFunding=&bewilligungsStatus=&bundesland=DEU%23&context=projekt&einrichtungsart=-1&fachgebiet=%23&findButton=historyCall&gefoerdertIn=&ggsHunderter=0&hitsPerPage=50&index="
    url_post = "&language=en&nurProjekteMitAB=false&oldGgsHunderter=0&oldfachgebiet=%23&pemu=%23&task=doKatalog&teilprojekte=true&zk_transferprojekt=false"
    tmp_url = url_pre+str(i)+url_post

    projekts_ls.extend(get_projekt_links(tmp_url))
    cntr+=1

len(set(projekts_ls))
# projekts_ls[0]
# projekts_ls[50]

projekts_un = list(set(projekts_ls))
len(projekts_un)
get_project_details(projekts_ls[100])


# For each project link, get the project details
projekt_details = []

cntr = 1
for projID in projekts_un:
    if cntr % 1000 == 0 :
        print(cntr)
    projekt_details.append(get_project_details(projID))
    cntr+=1

len(projekt_details)
projekt_df = pd.DataFrame(projekt_details)
# Save csv
projekt_df.to_csv("../raw-data/fine-scale/GER_temp/dfg-gepris.csv",
                    index = False)


req_session.close()
# No errors this time...

# NEW SESSION
# Look to condense N columns in df
projekt_df_ = pd.read_csv("../raw-data/fine-scale/GER_temp/dfg-gepris.csv")

projekt_df_.columns  # 54 columns
# [
# 'projektID', 
# 'title', 
# 'Subject Area', 
# 'Term',
# 'Project identifier', 
# 'DFG Programme', 
# 'projekttext', 
# 'Subproject of', ??
# 'Applicant Institution', 
# 'Project Heads', 
# 'Project Head',
# 'Applicant',
# 'Applicants', 
# 'Participating Person', 
# 'Participating Persons', 
# 'International Connection', 
# 'Co-Investigators',
# 'Co-Investigator',
# 'Co-Applicants', 
# 'Co-Applicant',
# 'Hosts', 
# 'Host', 
# 'Co-Applicant Institution',
# 'Instrumentation Group', 
# 'Leader', 
# 'Leaders',
# 'Cooperation Partner',
# 'Cooperation Partners',
# 'Business and Industry', 
# 'Website', - NOT NEEDED
# 'Participating Institution', 
# 'Spokesperson',
# 'Spokespersons', 
# 'Partner Organisation',
# 'Major Instrumentation', 
# 'Ehemaliger Antragsteller', 
# 'Ehemalige Antragstellerin',
# 'Ehemalige Antragsteller',
# 'Ehemalige Antragstellerinnen / Ehemalige Antragsteller',
# 'Ehemalige Antragstellerinnen',  -- former applicants?
# 'Participating subject areas', 
# 'Participating University', 
# 'Participating Researchers', 
# 'Participating Researcher']
# 'International Co-Applicant',
# 'International Co-Applicants', 
# 'Co-Spokespersons', 'Deputy', 
# 'Application Partner',
# 'IRTG-Partner Institution', 
# 'IRTG-Partner: Spokesperson',
# 'IRTG-Partner: Spokespersons',
# 'Deputies',


# Many are duplicates - 

projekt_df_["Ehemalige Antragstellerinnen"].unique()
# People previously on the project?

projekt_df_['Ehemalige Antragsteller'].unique()




projekt_df_.Leader.unique()

projekt_df_.Leaders.unique()

projekt_df_["Project Heads"].unique()


projekt_df_.Host.unique()

projekt_df_.Hosts.unique()
# people...

projekt_df_.Term.unique()
# "from YYYY to YYYY"
# "Funded in YYYY"
# "since YYYY"
# "Currently being funded."
# "until YYYY"

import re

projekt_df_["Term_txt_only"] = projekt_df_.Term.apply(lambda s: re.sub(r'\d{4}', '', s).strip())

projekt_df_.Term_txt_only.unique()
# ['from  to', 'since', 'Funded in', 'until',
# 'Currently being funded.']

# If from, or since, or Funded in
# get start

# if to or until
# get end

def get_start_year(string):
    if "from" in string:
        tmp = int(string.split("to")[0].replace("from ", "").strip())
    elif "since" in string:
        tmp = int(string.replace("since ", "").strip())
    elif "Funded in" in string:
        tmp = int(string.replace("Funded in ", "").strip())
    else: 
        tmp = pd.NA

    return(tmp)

def get_end_year(string):
    if "to" in string:
        tmp = int(string.split("to")[1].strip())
    elif "until" in string:
        tmp = int(string.replace("until ", "").strip())
    else: 
        tmp = pd.NA

    return(tmp)

projekt_df_["Start_year"] = projekt_df_.Term.apply(lambda x: get_start_year(x))
projekt_df_.Start_year.unique()


projekt_df_["End_year"] = projekt_df_.Term.apply(lambda x: get_end_year(x))
projekt_df_.End_year.unique()





projekt_df_['Participating subject areas'].unique()

projekt_df_['Participating Researchers'].unique()

projekt_df_['Participating Researcher'].unique()


projekt_df_['IRTG-Partner Institution'].unique()
# 'IRTG-Partner: Spokesperson',
# 'IRTG-Partner: Spokespersons',


projekt_df_['Applicant Institution'].unique()
projekt_df_['Participating Institution'].unique()

projekt_df_["DFG Programme"].unique()




# KEY fields
# 'projektID', 
# 'title', 
# 'Subject Area', 
# 'Term',
# 'Project identifier', 
# 'DFG Programme', 
# 'projekttext', - project description
# 'Subproject of', ??
# 'Applicant Institution', 
# 'Project Heads', 
# 'Project Head',
# 'Applicant',
# 'Applicants', 
# 'Participating Person', 
# 'Participating Persons', 
# 'International Connection', 


projekt_df_ = projekt_df_.rename(columns={"projektID" : "Project ID",
                                          "projekttext" : "Project Description",
                                          "title" : "Project Title"})

# projekt_df_ = projekt_df_.drop(columns=['Unnamed: 0'])

projekt_df_.columns


projekt_df_.to_csv("../raw-data/fine-scale/GER_temp/dfg-gepris_.csv", index=False)
# DtypeWarning: Columns (38,43,50,51,52,53) have mixed types
# subtract one after rm of "Unnamed: 0"
projekt_df_.iloc[:,[37]]
projekt_df_["Ehemalige Antragsteller"].unique()

projekt_df_.iloc[:,[42]]
projekt_df_["Co-Spokespersons"].unique()

projekt_df_.iloc[:,[49]]
projekt_df_["Ehemalige Antragstellerinnen / Ehemalige Antragsteller"].unique()

projekt_df_.iloc[:,[50]]
projekt_df_["Ehemalige Antragstellerinnen"].unique()

projekt_df_.iloc[:,[51]]
projekt_df_["IRTG-Partner: Spokespersons"].unique()

projekt_df_.iloc[:,[52]]
projekt_df_["Participating Researcher"].unique()


# Collate columns with singular v plural names...
# 'Project Heads', 
# 'Project Head',
sum(projekt_df_['Project Heads'].notna() & projekt_df_['Project Head'].notna())
# 0

projekt_df_['Project Head_'] = projekt_df_['Project Head']
projekt_df_['Project Head_'][pd.isna(projekt_df_['Project Head']) &
                            projekt_df_['Project Heads'].notna()] = projekt_df_['Project Heads'][pd.isna(projekt_df_['Project Head']) &
                                                                                                projekt_df_['Project Heads'].notna()]
sum(projekt_df_['Project Head'].notna())
sum(projekt_df_['Project Head_'].notna())


# 'Applicant',
# 'Applicants', 
sum(projekt_df_['Applicant'].notna() & projekt_df_['Applicants'].notna())
# 0
projekt_df_['Applicant_'] = projekt_df_['Applicant']
projekt_df_['Applicant_'][pd.isna(projekt_df_['Applicant']) &
                            projekt_df_['Applicants'].notna()] = projekt_df_['Applicants'][pd.isna(projekt_df_['Applicant']) &
                                                                                                projekt_df_['Applicants'].notna()]
sum(projekt_df_['Applicant'].notna())
sum(projekt_df_['Applicant_'].notna())


# 'Participating Person', 
# 'Participating Persons', 
sum(projekt_df_['Participating Person'].notna() & projekt_df_['Participating Persons'].notna())
# 0
projekt_df_['Participating Person_'] = projekt_df_['Participating Person']
projekt_df_['Participating Person_'][pd.isna(projekt_df_['Participating Person']) &
                            projekt_df_['Participating Persons'].notna()] = projekt_df_['Participating Persons'][pd.isna(projekt_df_['Participating Person']) &
                                                                                                projekt_df_['Participating Persons'].notna()]
sum(projekt_df_['Participating Person'].notna())
sum(projekt_df_['Participating Person_'].notna())


# 'Co-Investigators',
# 'Co-Investigator',
sum(projekt_df_['Co-Investigator'].notna() & projekt_df_['Co-Investigators'].notna())
# 0
projekt_df_['Co-Investigator_'] = projekt_df_['Co-Investigator']
projekt_df_['Co-Investigator_'][pd.isna(projekt_df_['Co-Investigator']) &
                            projekt_df_['Co-Investigators'].notna()] = projekt_df_['Co-Investigators'][pd.isna(projekt_df_['Co-Investigator']) &
                                                                                                projekt_df_['Co-Investigators'].notna()]
sum(projekt_df_['Co-Investigator'].notna())
sum(projekt_df_['Co-Investigator_'].notna())


# 'Co-Applicants', 
# 'Co-Applicant',
sum(projekt_df_['Co-Applicant'].notna() & projekt_df_['Co-Applicants'].notna())
# 0
projekt_df_['Co-Applicant_'] = projekt_df_['Co-Applicant']
projekt_df_['Co-Applicant_'][pd.isna(projekt_df_['Co-Applicant']) &
                            projekt_df_['Co-Applicants'].notna()] = projekt_df_['Co-Applicants'][pd.isna(projekt_df_['Co-Applicant']) &
                                                                                                projekt_df_['Co-Applicants'].notna()]
sum(projekt_df_['Co-Applicant'].notna())
sum(projekt_df_['Co-Applicant_'].notna())


# 'Hosts', 
# 'Host', 
sum(projekt_df_['Host'].notna() & projekt_df_['Hosts'].notna())
# 0
projekt_df_['Host_'] = projekt_df_['Host']
projekt_df_['Host_'][pd.isna(projekt_df_['Host']) &
                            projekt_df_['Hosts'].notna()] = projekt_df_['Hosts'][pd.isna(projekt_df_['Host']) &
                                                                                                projekt_df_['Hosts'].notna()]
sum(projekt_df_['Host'].notna())
sum(projekt_df_['Host_'].notna())

# 'Leader', 
# 'Leaders',
sum(projekt_df_['Leader'].notna() & projekt_df_['Leaders'].notna())
# 0
projekt_df_['Leader_'] = projekt_df_['Leader']
projekt_df_['Leader_'][pd.isna(projekt_df_['Leader']) &
                            projekt_df_['Leaders'].notna()] = projekt_df_['Leaders'][pd.isna(projekt_df_['Leader']) &
                                                                                                projekt_df_['Leaders'].notna()]
sum(projekt_df_['Leader'].notna())
sum(projekt_df_['Leader_'].notna())


# 'Cooperation Partner',
# 'Cooperation Partners',
sum(projekt_df_['Cooperation Partner'].notna() & projekt_df_['Cooperation Partners'].notna())
# 0
projekt_df_['Cooperation Partner_'] = projekt_df_['Cooperation Partner']
projekt_df_['Cooperation Partner_'][pd.isna(projekt_df_['Cooperation Partner']) &
                            projekt_df_['Cooperation Partners'].notna()] = projekt_df_['Cooperation Partners'][pd.isna(projekt_df_['Cooperation Partner']) &
                                                                                                projekt_df_['Cooperation Partners'].notna()]
sum(projekt_df_['Cooperation Partner'].notna())
sum(projekt_df_['Cooperation Partner_'].notna())


# 'Participating Institution', 
# 'Participating University',
sum(projekt_df_['Participating Institution'].notna() & projekt_df_['Participating University'].notna())
# 288
# Not the same!!

# 'Spokesperson',
# 'Spokespersons', 
sum(projekt_df_['Spokesperson'].notna() & projekt_df_['Spokespersons'].notna())
# 0
projekt_df_['Spokesperson_'] = projekt_df_['Spokesperson']
projekt_df_['Spokesperson_'][pd.isna(projekt_df_['Spokesperson']) &
                            projekt_df_['Spokespersons'].notna()] = projekt_df_['Spokespersons'][pd.isna(projekt_df_['Spokesperson']) &
                                                                                                projekt_df_['Spokespersons'].notna()]
sum(projekt_df_['Spokesperson'].notna())
sum(projekt_df_['Spokesperson_'].notna())


# 'Ehemaliger Antragsteller', 
# 'Ehemalige Antragstellerin',
# 'Ehemalige Antragsteller',
# 'Ehemalige Antragstellerinnen / Ehemalige Antragsteller',
# 'Ehemalige Antragstellerinnen',  -- former applicants?
sum(projekt_df_['Ehemaliger Antragsteller'].notna() & 
    projekt_df_['Ehemalige Antragstellerin'].notna() &
    projekt_df_['Ehemalige Antragsteller'].notna() & 
    projekt_df_['Ehemalige Antragstellerinnen / Ehemalige Antragsteller'].notna() &
    projekt_df_['Ehemalige Antragstellerinnen'].notna() 
    )
# 0 

sum(projekt_df_['Ehemaliger Antragsteller'].notna() |
    projekt_df_['Ehemalige Antragstellerin'].notna() |
    projekt_df_['Ehemalige Antragsteller'].notna() |
    projekt_df_['Ehemalige Antragstellerinnen / Ehemalige Antragsteller'].notna() |
    projekt_df_['Ehemalige Antragstellerinnen'].notna() 
    )

projekt_df_['Ehemaliger Antragsteller_'] = projekt_df_['Ehemaliger Antragsteller']
projekt_df_['Ehemaliger Antragsteller_'][projekt_df_['Ehemalige Antragstellerin'].notna()] = projekt_df_['Ehemalige Antragstellerin'][projekt_df_['Ehemalige Antragstellerin'].notna()]

projekt_df_['Ehemaliger Antragsteller_'][projekt_df_['Ehemalige Antragsteller'].notna()] = projekt_df_['Ehemalige Antragsteller'][projekt_df_['Ehemalige Antragsteller'].notna()]
projekt_df_['Ehemaliger Antragsteller_'][projekt_df_['Ehemalige Antragstellerinnen / Ehemalige Antragsteller'].notna()] = projekt_df_['Ehemalige Antragstellerinnen / Ehemalige Antragsteller'][projekt_df_['Ehemalige Antragstellerinnen / Ehemalige Antragsteller'].notna()]
projekt_df_['Ehemaliger Antragsteller_'][projekt_df_['Ehemalige Antragstellerinnen'].notna()] = projekt_df_['Ehemalige Antragstellerinnen'][projekt_df_['Ehemalige Antragstellerinnen'].notna()]


sum(projekt_df_['Ehemaliger Antragsteller'].notna())
sum(projekt_df_['Ehemaliger Antragsteller_'].notna())


# 'Participating Researchers', 
# 'Participating Researcher'
sum(projekt_df_['Participating Researcher'].notna() & projekt_df_['Participating Researchers'].notna())
# 0
projekt_df_['Participating Researcher_'] = projekt_df_['Participating Researcher']
projekt_df_['Participating Researcher_'][pd.isna(projekt_df_['Participating Researcher']) &
                            projekt_df_['Participating Researchers'].notna()] = projekt_df_['Participating Researchers'][pd.isna(projekt_df_['Participating Researcher']) &
                                                                                                projekt_df_['Participating Researchers'].notna()]
sum(projekt_df_['Participating Researcher'].notna())
sum(projekt_df_['Participating Researcher_'].notna())



sum(projekt_df_['Participating Researcher'].notna() & 
    projekt_df_['Participating Researchers'].notna() &
    projekt_df_['Participating Person'].notna() & 
    projekt_df_['Participating Persons'].notna())
# 0...
# ??

# 'International Co-Applicant',
# 'International Co-Applicants', 
sum(projekt_df_['International Co-Applicant'].notna() & projekt_df_['International Co-Applicants'].notna())
# 0
projekt_df_['International Co-Applicant_'] = projekt_df_['International Co-Applicant']
projekt_df_['International Co-Applicant_'][pd.isna(projekt_df_['International Co-Applicant']) &
                            projekt_df_['International Co-Applicants'].notna()] = projekt_df_['International Co-Applicants'][pd.isna(projekt_df_['International Co-Applicant']) &
                                                                                                projekt_df_['International Co-Applicants'].notna()]
sum(projekt_df_['International Co-Applicant'].notna())
sum(projekt_df_['International Co-Applicant_'].notna())


# 'Deputy', 
# 'Deputies',
sum(projekt_df_['Deputy'].notna() & projekt_df_['Deputies'].notna())
# 0
projekt_df_['Deputy_'] = projekt_df_['Deputy']
projekt_df_['Deputy_'][pd.isna(projekt_df_['Deputy']) &
                            projekt_df_['Deputies'].notna()] = projekt_df_['Deputies'][pd.isna(projekt_df_['Deputy']) &
                                                                                                projekt_df_['Deputies'].notna()]
sum(projekt_df_['Deputy'].notna())
sum(projekt_df_['Deputy_'].notna())


# 'IRTG-Partner: Spokesperson',
# 'IRTG-Partner: Spokespersons',
sum(projekt_df_['IRTG-Partner: Spokesperson'].notna() & projekt_df_['IRTG-Partner: Spokespersons'].notna())
# 0
projekt_df_['IRTG-Partner: Spokesperson_'] = projekt_df_['IRTG-Partner: Spokesperson']
projekt_df_['IRTG-Partner: Spokesperson_'][pd.isna(projekt_df_['IRTG-Partner: Spokesperson']) &
                            projekt_df_['IRTG-Partner: Spokespersons'].notna()] = projekt_df_['IRTG-Partner: Spokespersons'][pd.isna(projekt_df_['IRTG-Partner: Spokesperson']) &
                                                                                                projekt_df_['IRTG-Partner: Spokespersons'].notna()]
sum(projekt_df_['IRTG-Partner: Spokesperson'].notna())
sum(projekt_df_['IRTG-Partner: Spokesperson_'].notna())



projekt_df_reduced = projekt_df_[['Project ID', 'Project identifier', 'DFG Programme',
        'Project Title', 'Project Description', 'Subject Area', 
        'Term', 'Start_year', 'End_year', 
        
       'Subproject of', 'Applicant Institution', 'Co-Applicant Institution',
       'International Connection', 
       
       
       'Instrumentation Group', 'Cooperation Partner',
       'Business and Industry', 'Website',
       'Participating Institution',  'Partner Organisation',
       'Major Instrumentation', 
       'Cooperation Partners',  
       'Participating subject areas', 
       'Participating University', 
       'Participating Researchers', 
       'Co-Spokespersons',  'Application Partner',
       'IRTG-Partner Institution',
        
       
       'Participating Researcher', 
       'Project Head_',
       'Applicant_', 'Participating Person_', 'Co-Investigator_',
       'Co-Applicant_', 'Host_', 'Leader_', 'Cooperation Partner_',
       'Spokesperson_', 'Participating Researcher_',
       'International Co-Applicant_', 'Deputy_', 'IRTG-Partner: Spokesperson_',
       'Ehemaliger Antragsteller_']]


# Save to csv
projekt_df_reduced.to_csv("../raw-data/fine-scale/GER_temp/dfg-gepris_reduced.csv", 
                            index=False)

# Split to allow github upload
split_project_df_reduced = np.array_split(projekt_df_reduced, 4)

split_project_df_reduced[0].to_csv("../raw-data/fine-scale/Germany/dfg-gepris-1.csv", index=False)
split_project_df_reduced[1].to_csv("../raw-data/fine-scale/Germany/dfg-gepris-2.csv", index=False)
split_project_df_reduced[2].to_csv("../raw-data/fine-scale/Germany/dfg-gepris-3.csv", index=False)
split_project_df_reduced[3].to_csv("../raw-data/fine-scale/Germany/dfg-gepris-4.csv", index=False)




