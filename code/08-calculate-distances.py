import pandas as pd
import re
import numpy as np
import random
from scipy.spatial.distance import cdist

# get metadata
df_meta = pd.read_csv("/home/flavia/Projects/Funding-Landscape/clean-data/fine-scale/STEM/project-metadata.csv", index_col = False)    

k = 100
#read topic probs (100 topics)
df_topics = pd.read_csv("./results/fine-scale/mallet-models/STEM/"+str(k)+"-topic-files/1-"+str(k)+"-topics-doc.txt", delimiter = "\t", header = None, skiprows = [0], index_col = False)
df_cleaned = df_topics.rename(columns={1: "ProjectId"})

#merge files
df_joined = df_cleaned.merge(df_meta, on= ["ProjectId"], validate= "one_to_one")

# model = set(df_cleaned["ProjectId"])
# meta = set(df_meta["ProjectId"])
joined = set(df_joined["ProjectId"])

# model.difference((joined))

#get np array of probs
probs = np.array(df_cleaned[df_cleaned["ProjectId"].isin(joined)].drop(columns=["ProjectId",0]))

def get_distances(df, projectId, Nmax):
    #calculate distances
    # get df subset
    df_sub = df[df["ProjectId"].isin(projectId)]
    #get probs
    probs = np.array(df_sub.iloc[:, range(2,Nmax)])
    #calculate distances
    d_mat = cdist(probs,probs, 'euclid')

    return(d_mat)

#remove wrong spelling of new zealand
df_joined.loc[df_joined["Country"] == "New-Zealand", "Country"] = "New Zealand"

#sample project Ids from each country group
Project_sample = df_joined.groupby("Country").sample(n = 1000)["ProjectId"]

#get distances with function defined above
d_mat = get_distances(df_joined, Project_sample, 101)

#convert distance matrix to dataframe
df_dist = pd.DataFrame(d_mat, columns = list(Project_sample))

#reshape to two columns
df_dist["ProjectId_1"] = list(Project_sample)
df_dist = pd.melt(df_dist, id_vars = "ProjectId_1", var_name= "ProjectId_2")

#add countries
df_final = df_dist.merge(df_joined[["ProjectId","Country"]], left_on = "ProjectId_1", right_on = "ProjectId", how = "left").drop(columns = "ProjectId")
df_final = df_final.merge(df_joined[["ProjectId","Country"]], left_on = "ProjectId_2", right_on = "ProjectId", how = "left", suffixes=('_1', '_2')).drop(columns = "ProjectId")


df_final.to_csv("./results/fine-scale/distances/country-dist.csv", index = False)

probs = np.array(df_cleaned[df_cleaned["ProjectId"].isin(joined)].drop(columns=["ProjectId",0]))
