'''
Python code to scrape info on India grant recipients/projects
Using NSTMIS website/dataportal : http://www.nstmis-dst.org/EMR/
'''


import requests
import pandas as pd
import numpy as np
import json
from bs4 import BeautifulSoup
import selenium
from selenium import webdriver
import time
# import sys

import os
from urllib.parse import urljoin

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select

from selenium.webdriver.firefox.service import Service as FirefoxService
from webdriver_manager.firefox import GeckoDriverManager
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.common.exceptions import NoSuchElementException

from bs4 import NavigableString

def get_table(page_source):
    soup = BeautifulSoup(page_source, 'html.parser')
    
    table = soup.find("table")
    table_bod = table.find("tbody")
    rows = []
    for child in table_bod.children:
        # print(child)
        # print(len(child))
        row = []
        for td in child:
            # print(td)
            # print(type(td))
            if isinstance(td, NavigableString):
                continue
            if isinstance(td, str):
                continue

            elif td.find_all("table"):
                continue
            try:
                row.append(td.text.replace('\n', ''))
            except:
                continue
        if len(row) > 0:
            rows.append(row)

    df = pd.DataFrame(rows[1:], columns=rows[0])
    return df



def scrape_funding_df(start_url):
    out_ls = []

    driver = None
    options = FirefoxOptions()
    options.add_argument("--headless")
    # driver = webdriver.Firefox(service=FirefoxService(GeckoDriverManager().install()),
    #     options=options)
    # Testing using intalled geckodriver...
    driver = webdriver.Firefox(executable_path="/Users/rcornf/.wdm/drivers/geckodriver/macos-aarch64/0.31/geckodriver",
                                options=options)

    # get initial page
    driver.get(start_url)
    page_source = driver.page_source
    # soup = BeautifulSoup(page_source, 'lxml')
    tmp_df = None
    tmp_df = get_table(page_source)

    out_ls.append(tmp_df)

    pg_cntr = 1

    print(pg_cntr)
    while True:
        pg_cntr+=1
        try:
            elem = driver.find_element('link text', str(pg_cntr))
        except NoSuchElementException:
            try: 
                elems = driver.find_elements('link text', "...")
                elems = [elem for elem in elems
                        if "'Page$"+str(pg_cntr)+"'" in elem.get_attribute("href")]
                if len(elems)==0:
                    break
                else: 
                    elem = elems[0]
            except NoSuchElementException:
                break
        elem.click()
        print(pg_cntr)
        # wait 2 secs.. , scrape, run again for pg+1
        time.sleep(1)
        page_source = driver.page_source
        # soup = BeautifulSoup(page_source, 'lxml')

        tmp_df = None
        tmp_df = get_table(page_source)
        out_ls.append(tmp_df)


    driver.quit()
    driver = None
    return(pd.concat(out_ls).reset_index(drop = True))



# Doesnt work !!
# sys.path.append("/Users/rcornf/Downloads/chromedriver")
# driver = webdriver.Chrome("/Users/rcornf/Downloads/chromedriver")


# from selenium.webdriver.chrome.service import Service as ChromeService
# from webdriver_manager.chrome import ChromeDriverManager


# driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))

# Go to inital page with year links
BASE_URL = "http://www.nstmis-dst.org/EMR/"
init_pg = requests.get(BASE_URL)
init_pg_soup = BeautifulSoup(init_pg.content, "lxml")

init_pg_form = init_pg_soup.find("form")

# Find all year links
yr_links = init_pg_form.find_all("a")
un_yrs = [li.text for li in yr_links]


# Make lists to store year and funding orgs
yr_ls = []
fo_ls = []
# for each year link...
for link_i in yr_links:
    driver = None
    options = FirefoxOptions()
    options.add_argument("--headless")
    driver = webdriver.Firefox(service=FirefoxService(GeckoDriverManager().install()),
        options=options)
    driver.get(urljoin(BASE_URL,link_i["href"]))

    # Select funding organisation

    search_elem = driver.find_element("id", "ContentPlaceHolder1_ddlSearch")


    options = driver.find_elements("tag name", "option")
    [opt.get_attribute("value") for opt in options]
    # [opt.get_attribute("text") for opt in options]

    fo_opt = [opt for opt in options
        if opt.get_attribute("value") == "Funding Organisation"]
    fo_opt[0].click()

    org_sel = Select(driver.find_element("id", "ContentPlaceHolder1_ddlFundingOrg"))
    org_opts = org_sel.options
    # Get list of funding orgs

    yr_ls.extend([link_i.text]*len(org_opts))
    fo_ls.extend([org_opt.get_attribute("value") for org_opt in org_opts])
    driver.quit()

driver = None

scrape_spec_df = pd.DataFrame({"Year" : yr_ls,
                                "Funder_abbr" : fo_ls})
scrape_spec_df
scrape_spec_df.to_csv("../raw-data/india_nstmis_scrape_specs.csv",
                        index = False)

scrape_spec_df.Funder_abbr.unique()


# Set of funding orgs across years
# un_fo_ = list(set(un_fo))

# Could just collate years and Funding orgs
# Then combine to form url
# 'http://www.nstmis-dst.org/EMR/EMR2002-03/ViewData.aspx?id=2&fo=AICTE'
# 'http://www.nstmis-dst.org/EMR/EMR' + yr_spec + '/ViewData.aspx?id=2&fo=' + fo_spec
# Try each link and scrape across pages if possible


################################################################################

scrape_spec_df = pd.read_csv("../raw-data/india_nstmis_scrape_specs.csv")

scrape_spec_df = scrape_spec_df.loc[scrape_spec_df.Funder_abbr != 'Funding_Agency_short_Name'].reset_index(drop = True)

# for idx in range(10):
for idx in range(len(scrape_spec_df)):
    print("\n")
    print(idx)
    print(scrape_spec_df.Year[idx])
    print(scrape_spec_df.Funder_abbr[idx])
    print("\n")

    f_nm = scrape_spec_df.Funder_abbr[idx] + "-" + scrape_spec_df.Year[idx] +".csv"
    f_pth = os.path.join("../raw-data/fine-scale/India_temp", f_nm)
    if os.path.exists(f_pth):
        print("This scrape has already been run, skipping...")
        print("\n")

        continue

    tmp_url = 'http://www.nstmis-dst.org/EMR/EMR' + scrape_spec_df.Year[idx] + '/ViewData.aspx?id=2&fo=' + scrape_spec_df.Funder_abbr[idx]
    tmp_df = scrape_funding_df(tmp_url)
    
    tmp_df["Year"] = scrape_spec_df.Year[idx]
    tmp_df["Funding_Agency_Short"] = scrape_spec_df.Funder_abbr[idx]

    tmp_df["Cost_Units"] = "Indian Rupees"
    tmp_df["Duration_Units"] = "Months"

    tmp_df.to_csv(f_pth,
        index=False)
    


################################################################################
################################################################################
