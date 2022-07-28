from fileinput import filename
from genericpath import exists
import pandas as pd
import numpy as np
import os
import shutil

# load dataframe with all projects metadata
df = pd.read_csv("./raw-data/fine-scale/UK/UKRI_general.csv")
df.columns
df["FundingOrgName"].unique()

# make list of the concils to keep
stem = ["BBSRC","EPSRC", "NERC", "STFC", "MRC"]

# keep only the concils that are NOT present in stem
df_filtered = df[~df.FundingOrgName.isin(stem)]
len(df_filtered)
# add text extention to projectId in dataframe
projID = df_filtered["ProjectId"] + ".txt"

# for all projects in projID (non-stem), move them from folder abstracts to folder non-stem
for i in projID:
    original_path = os.path.join("./raw-data/fine-scale/UK/abstracts", i)
    new_path = os.path.join("./raw-data/fine-scale/UK/abstracts/non-stem", i)
    # check if the project exists in the folder first
    if os.path.exists(original_path):
        # then move it
        shutil.move(original_path, new_path)
        