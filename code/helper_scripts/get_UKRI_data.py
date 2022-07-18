# load modules/packages
import requests
import json
import pandas as pd
import time
import os

## load csv file downloaded from URKI website
project_metadata = pd.read_csv("./raw-data/fine-scale/UK/UKRI_general.csv")
print("data loaded")
# filter projects by research grant and fellowships
data = project_metadata[project_metadata.ProjectCategory.isin(["Research Grant", "Fellowship"])]
print('data filtered')
os.getcwd()

data.shape # 63963, 25
project_metadata.shape # 130258, 25

headers = {'Accept':'application/vnd.rcuk.gtr.json-v7'}

for ind in data.index:
    print(ind)

    #check if file exists
    if (data["ProjectId"][ind]+'.txt') not in os.listdir('./raw-data/fine-scale/UK/'):
        #request data
        r = requests.get("https://gtr.ukri.org/gtr/api/projects/" + data["ProjectId"][ind], headers = headers)
         #if request is successful
        if r.status_code == 200:
            json_r = r.json()
            with open('./raw-data/fine-scale/UK/'+ data["ProjectId"][ind]+'.txt', 'w') as f:
                f.write(json_r["title"] + " " + json_r["abstractText"])
            
            time.sleep(0.5)

        else:
            with open('./raw-data/fine-scale/UK/errors' +'.txt', 'a') as f:
                f.write(data["ProjectId"][ind] + "\n")         



    
    


    
