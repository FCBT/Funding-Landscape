

'''
Python code to scrape info on Australian grant recipients/projects
Using ARC dataportal API : https://dataportal.arc.gov.au/NCGP/Web/Grant/Help


'''

# Research grant sources:
# NCGP - 30241 results - ARC funded research
# RGS - 30246 results - ARC funded, plus Office of National Intelligence funding
# Are they all the same?
# So, do NCGP first

# 1000 results per page, max
# then navigate to end using "next" link


# https://dataportal.arc.gov.au/NCGP/API/grants?page[number]=1&page[size]=1000

import requests
import pandas as pd
import numpy as np
import json


def ncgp_api_call(base_url, pg_num, pg_size):
    r = requests.get(base_url,
        params = {"page[number]" : pg_num,
                    "page[size]" : pg_size})
    if r.status_code == 200:
        j = r.json()
        return j
    else:
        return np.nan

def ncgp_api_call_wrap(base_url, strt_pg, pg_size):
    json_ls = []
    init_call = ncgp_api_call(base_url, strt_pg, pg_size)
    if not pd.isna(init_call):
        json_ls.append(init_call)
        n_pages = init_call.get("meta").get("total-pages")
        for i in range(2,n_pages+1):
            print(i)
            tmp_call = ncgp_api_call(base_url, i, pg_size)
            json_ls.append(tmp_call)
        return(json_ls)
    elif pd.isna(init_call):
        print("Initial call failed.")
        return(None)



################################################################################
ncgp_json_ls = ncgp_api_call_wrap("https://dataportal.arc.gov.au/NCGP/API/grants",
                                    1, 1000)


# save this to json
with open("../raw-data/fine-scale/AUS_temp/arc.json", "w") as json_f:
    json.dump({"ncgp_json_ls": ncgp_json_ls}, json_f)

# work on getting base data from this
# for each list item (api page)
ncgp_df_ls = []

for json_dat in ncgp_json_ls:
    # get j["data"]
    tmp_data = json_dat.get("data")
  
    # get info of interest
    code_ls = [ x.get("attributes").get("code") for x in tmp_data ]
    scheme_ls = [ x.get("attributes").get("scheme-name") for x in tmp_data ] 
    fundstrt_ls = [ x.get("attributes").get("funding-commencement-year") for x in tmp_data ]
    schemecode_ls = [ x.get("attributes").get("scheme-information").get("schemeCode") for x in tmp_data ] 
    schemeprog_ls = [ x.get("attributes").get("scheme-information").get("program") for x in tmp_data ] 
    schemeyear_ls = [ x.get("attributes").get("scheme-information").get("submissionYear") for x in tmp_data ] 
    schemenum_ls = [ x.get("attributes").get("scheme-information").get("roundNumber") for x in tmp_data ] 
    schemeround_ls = [ x.get("attributes").get("scheme-information").get("schemeRound") for x in tmp_data ] 
    current_org_ls = [ x.get("attributes").get("current-admin-organisation") for x in tmp_data ]
    orig_org_ls = [ x.get("attributes").get("announcement-admin-organisation") for x in tmp_data ]
    summ_ls = [ x.get("attributes").get("grant-summary") for x in tmp_data ]
    lead_ls = [ x.get("attributes").get("lead-investigator") for x in tmp_data ] 
    curent_fund_ls = [ x.get("attributes").get("current-funding-amount") for x in tmp_data ]
    orig_fund_ls = [ x.get("attributes").get("announced-funding-amount") for x in tmp_data ] 
    status_ls = [ x.get("attributes").get("grant-status") for x in tmp_data ]
    for_ls = [ x.get("attributes").get("primary-field-of-research") for x in tmp_data ] 
    end_ls = [ x.get("attributes").get("anticipated-end-date") for x in tmp_data ]
    investigators_ls = [ x.get("attributes").get("investigators") for x in tmp_data ] 
    lief_ls = [ str(x.get("attributes").get("lief-register")) for x in tmp_data ] 
    page_link_ls = [ x.get("links").get("self") for x in tmp_data ] 

    # put into pd.DataFrame
    tmp_df = pd.DataFrame({ "code" :                            code_ls,
                            "scheme_name" :                     scheme_ls,
                            "funding_commencement_year" :       fundstrt_ls ,
                            "scheme_info_code" :                schemecode_ls ,
                            "scheme_info_program" :             schemeprog_ls,
                            "scheme_info_submission_year" :     schemeyear_ls,
                            "scheme_info_round_number" :        schemenum_ls ,
                            "scheme_info_round" :               schemeround_ls,
                            "current_admin_organisation"   :    current_org_ls ,
                            "announcement_admin_organisation" : orig_org_ls,
                            "grant_summary" :                   summ_ls,
                            "lead_investigator" :               lead_ls,
                            "current_funding_amount" :          curent_fund_ls,
                            "announced_funding_amount" :        orig_fund_ls,
                            "grant_status" :                    status_ls,
                            "primary_field_of_research" :       for_ls,
                            "anticipated_end_date" :            end_ls,
                            "investigators" :                   investigators_ls,
                            "lief_register" :                   lief_ls,
                            "page_link"  :                      page_link_ls
                                        })
    ncgp_df_ls.append(tmp_df)

ncgp_df = pd.concat(ncgp_df_ls).reset_index(drop=False)

ncgp_df.lief_register.unique()

# Save csv
ncgp_df.to_csv("../raw-data/fine-scale/AUS_temp/arc.csv", index= False)

ncgp_df.primary_field_of_research

# look at then getting extra details from page specific data 
# - requires extra API calls per project

ncgp_df["project_start_date"] = ''
ncgp_df["sub_fields_of_research"] = ''
ncgp_df["socioeconomic_objective"] = ''
ncgp_df["international_collaboration"] = ''


# RUN HERE!!! - 20220706 DONE
for idx in range(len(ncgp_df)):
# for idx in range(22883,len(ncgp_df)):
    # print(idx)
    strt_date = ""
    for_out = ""
    seo_out = ""
    collab = ""
    if idx % 100 == 0:
        print (idx)
    r = requests.get(ncgp_df.page_link[idx])
    if r.status_code == 200:
        j = r.json()
        json_dat = j.get("data")

        strt_date = json_dat.get("attributes").get("project-start-date")

        for_ls = json_dat.get("attributes").get("field-of-research")
        for_out = "; ".join([x.get("code")+" - "+x.get("name") for x in for_ls
                            if x.get("isPrimary") != True ])

        seo_ls = json_dat.get("attributes").get("socio-economic-objective")
        seo_out = "; ".join([x.get("code")+" - "+x.get("name") for x in seo_ls ])

        collab = json_dat.get("attributes").get("international-collaboration")
        collab = "; ".join(collab)


        ncgp_df.project_start_date[idx] = strt_date
        ncgp_df.sub_fields_of_research[idx] = for_out
        ncgp_df.socioeconomic_objective[idx] = seo_out
        ncgp_df.international_collaboration[idx] = collab


ncgp_df.to_csv("../raw-data/fine-scale/AUS_temp/arc_plus.csv", index= False)

# Move arc data to Australia directory
arc_df = pd.read_csv("../raw-data/fine-scale/AUS_temp/arc_plus.csv")
arc_df.columns

arc_df.drop("index", axis = 1, inplace = True)
arc_df.columns

arc_df.to_csv("../raw-data/fine-scale/Australia/arc.csv", index= False)

# ncgp_df.loc[22882,]
# 20220705 at 18:00 -- got to 18138, need to run for 18139+ 



################################################################################
# 20220506 18:32 - DONE 
# Get Office for national intelligence data - from RGS API

rgs_json_ls = ncgp_api_call_wrap("https://dataportal.arc.gov.au/RGS/API/grants",
                                    1, 1000)

# save this to json
with open("../raw-data/fine-scale/AUS/arc_rgs.json", "w") as json_f:
    json.dump({"rgs_json_ls": rgs_json_ls}, json_f)

# work on getting base data from this
# for each list item (api page)
rgs_df_ls = []

for json_dat in rgs_json_ls:
    # get j["data"]
    tmp_data = json_dat.get("data")
  
    # get info of interest
    code_ls = [ x.get("attributes").get("code") for x in tmp_data ]
    scheme_ls = [ x.get("attributes").get("scheme-name") for x in tmp_data ] 
    fundstrt_ls = [ x.get("attributes").get("funding-commencement-year") for x in tmp_data ]
    schemecode_ls = [ x.get("attributes").get("scheme-information").get("scheme-code") for x in tmp_data ] 
    schemeprog_ls = [ x.get("attributes").get("scheme-information").get("program") for x in tmp_data ] 
    schemeyear_ls = [ x.get("attributes").get("scheme-information").get("submission-year") for x in tmp_data ] 
    schemenum_ls = [ x.get("attributes").get("scheme-information").get("round-number") for x in tmp_data ] 
    schemeround_ls = [ x.get("attributes").get("scheme-information").get("scheme-round") for x in tmp_data ] 
    
    grantee_ls = [ x.get("attributes").get("grantee") for x in tmp_data ]
    funder_ls = [ x.get("attributes").get("grant-funder") for x in tmp_data ]
    title_ls = [ x.get("attributes").get("grant-title") for x in tmp_data ]
    summ_ls = [ x.get("attributes").get("grant-summary") for x in tmp_data ]
    lead_ls = [ x.get("attributes").get("lead-investigator") for x in tmp_data ] 
    
    grant_val_ls = [ x.get("attributes").get("grant-value") for x in tmp_data ]
    
    status_ls = [ x.get("attributes").get("grant-status") for x in tmp_data ]
    for_ls = [ x.get("attributes").get("primary-field-of-research") for x in tmp_data ] 
    end_ls = [ x.get("attributes").get("anticipated-end-date") for x in tmp_data ]
    investigators_ls = [ x.get("attributes").get("investigators") for x in tmp_data ] 
    
    priority_ls = [ str(x.get("attributes").get("grant-priorities")) for x in tmp_data ] 
    
    page_link_ls = [ x.get("links").get("self") for x in tmp_data ] 

    # put into pd.DataFrame
    tmp_df = pd.DataFrame({ "code" :                            code_ls,
                            "scheme_name" :                     scheme_ls,
                            "funding_commencement_year" :       fundstrt_ls ,
                            "scheme_info_code" :                schemecode_ls ,
                            "scheme_info_program" :             schemeprog_ls,
                            "scheme_info_submission_year" :     schemeyear_ls,
                            "scheme_info_round_number" :        schemenum_ls ,
                            "scheme_info_round" :               schemeround_ls,
                            
                            "grantee" :                         grantee_ls ,
                            "grant_funder" :                    funder_ls,
                            "grant_title" :                     title_ls,
                            "grant_summary" :                   summ_ls,
                            "lead_investigator" :               lead_ls,
                            "grant_value" :                     grant_val_ls,
                            "grant_status" :                    status_ls,

                            "primary_field_of_research" :       for_ls,
                            "anticipated_end_date" :            end_ls,
                            "investigators" :                   investigators_ls,
                            "grant_priorities" :                priority_ls,
                            "page_link"  :                      page_link_ls
                                        })
    rgs_df_ls.append(tmp_df)

rgs_df = pd.concat(rgs_df_ls).reset_index(drop=False)
rgs_df.to_csv("../raw-data/fine-scale/AUS_temp/arc_rgs.csv", index= False)


rgs_df.primary_field_of_research

rgs_df.grant_funder.unique()

rgs_df.scheme_name.unique()

rgs_df_sub = rgs_df.loc[~rgs_df.code.isin(ncgp_df.code)].reset_index(drop=True)

rgs_df_sub.grant_funder.unique()
# rgs_df_sub = rgs_df.loc[rgs_df.scheme_name == "National Intelligence and Security Discovery Research Grants"].reset_index(drop=True)
# rgs_df.lief_register.unique()

# look at then getting extra details from page specific data

rgs_df_sub["project_start_date"] = ''
rgs_df_sub["sub_fields_of_research"] = ''
rgs_df_sub["socioeconomic_objective"] = ''
# rgs_df_sub["international_collaboration"] = ''

for idx in range(len(rgs_df_sub)):
    strt_date = ""
    for_out = ""
    seo_out = ""
    collab = ""
    # if idx % 100 == 0:
    print (idx)
    r = requests.get(rgs_df_sub.page_link[idx])
    if r.status_code == 200:
        j = r.json()
        json_dat = j.get("data")

        strt_date = json_dat.get("attributes").get("project-start-date")

        for_ls = json_dat.get("attributes").get("field-of-research")
        for_out = "; ".join([x.get("code")+" - "+x.get("name") for x in for_ls
                            if x.get("isPrimary") != True ])

        seo_ls = json_dat.get("attributes").get("socio-economic-objective")
        seo_out = "; ".join([x.get("code")+" - "+x.get("name") for x in seo_ls ])

        # collab = json_dat.get("attributes").get("international-collaboration")
        # collab = "; ".join(collab)

        rgs_df_sub.project_start_date[idx] = strt_date
        rgs_df_sub.sub_fields_of_research[idx] = for_out
        rgs_df_sub.socioeconomic_objective[idx] = seo_out
        # rgs_df_sub.international_collaboration[idx] = collab

rgs_df_sub
rgs_df_sub.to_csv("../raw-data/fine-scale/AUS_temp/arc_rgs_sub.csv", index= False)



rgs_df_sub = pd.read_csv("raw-data/fine-scale/AUS_temp/arc_rgs_sub.csv")
rgs_df_sub.drop("index", axis = 1, inplace = True)

rgs_df_sub.grant_funder.unique()
# Split into 
# Office of National Intelligence (NISDRG)
# Department of Defence
# Department of Education, Skills and Employment
oni_df = rgs_df_sub.loc[rgs_df_sub.grant_funder=="Office of National Intelligence"]
dod_df = rgs_df_sub.loc[rgs_df_sub.grant_funder=="Department of Defence"]
dese_df = rgs_df_sub.loc[rgs_df_sub.grant_funder=="Department of Education, Skills and Employment"]

# oni_df.to_csv("../raw-data/fine-scale/AUS/oni.csv", index= False)
# dod_df.to_csv("../raw-data/fine-scale/AUS/dod.csv", index= False)
# dese_df.to_csv("../raw-data/fine-scale/AUS/dese.csv", index= False)

# Save each funding df to file
oni_df.to_csv("../raw-data/fine-scale/Australia/nisdrg.csv", index= False)
dod_df.to_csv("../raw-data/fine-scale/Australia/dod.csv", index= False)
dese_df.to_csv("../raw-data/fine-scale/Australia/dese.csv", index= False)


################################################################################


# Metadata on API return structure

# project-start-date : str
# grant-priorities : ??
# fields-of-research : (isPrimary == Flase), paste code, name  tog : list
# socio-ecoomic-objective : paste code, name tog : list
# international-collaboration : list


# j.keys() # meta, links, data

# j["meta"]
# j["links"]
# j["links"]["next"]
# len(j["data"])

# df = pd.DataFrame(j["data"][0]["attributes"])

# df


# # Info to get:
# 'id': str,

#  'attributes': {
#     'code': str,
#     'scheme-name': str,
#     'funding-commencement-year': int,
#     'scheme-information': {
#         'schemeCode': str,
#         'program': str,
#         'submissionYear': int,
#         'roundNumber': int,
#         'schemeRound': str},
#     'current-admin-organisation': str,
#     'announcement-admin-organisation': str,
#     'grant-summary': str,
#     'lead-investigator': str,
#     'current-funding-amount': int/float,
#     'announced-funding-amount': int/float,
#     'grant-status': str,
#     'primary-field-of-research': str,
#     'anticipated-end-date': str,
#     'investigators': str,
#     'lief-register': []
#   },

#  'links': {'self': str (url)}



# project-start-date : str
# grant-priorities : ??
# fields-of-research : (isPrimary == Flase), paste code, name  tog : list
# socio-ecoomic-objective : paste code, name tog : list
# international-collaboration : list


# j.keys() # meta, links, data

# j["meta"]
# j["links"]
# j["links"]["next"]
# len(j["data"])

# df = pd.DataFrame(j["data"][0]["attributes"])

# df


# # Info to get:
# 'id': str,

#  'attributes': {
#     'code': str,
#     'scheme-name': str,
#     'funding-commencement-year': int,
#     'scheme-information': {
#         'schemeCode': str,
#         'program': str,
#         'submissionYear': int,
#         'roundNumber': int,
#         'schemeRound': str},
#     'current-admin-organisation': str,
#     'announcement-admin-organisation': str,
#     'grant-summary': str,
#     'lead-investigator': str,
#     'current-funding-amount': int/float,
#     'announced-funding-amount': int/float,
#     'grant-status': str,
#     'primary-field-of-research': str,
#     'anticipated-end-date': str,
#     'investigators': str,
#     'lief-register': []
#   },

#  'links': {'self': str (url)}




