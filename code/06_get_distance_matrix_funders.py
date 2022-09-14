import gensim
import pandas as pd
import re
import numpy as np
import random
from scipy.spatial.distance import cosine

# load LDA model, dictionary and corpus
#dictionary = gensim.corpora.Dictionary.load('../clean-data/fine-scale/all-countries/dictionary.dict')
corpus = gensim.corpora.MmCorpus('./clean-data/fine-scale/all-countries/corpus.mm')
lda = gensim.models.ldamulticore.LdaMulticore.load('./models/fine-scale/all-countries/model_140_topics')

# load metadata
ukri_metadata = pd.read_csv("./clean-data/fine-scale/UK/UKRI/UKRI_project_metadata.csv")
# as the USA metadata project id column is made of only numbers, python thinks it is suppose to be numeric, so coerce it into a string to avoid problems when concatenating the UKRI data.
us_metadata = pd.read_csv("./clean-data/fine-scale/USA/NSF/NSF_project_metadata.csv", dtype="object")

# row bind the detasets together; and reset index to match corpus, as datasets have more rows than the corpus. That happened because not all projects were used to fit the LDA (for example projects that did not have titles or abstracts)
df_meta = pd.concat([ukri_metadata,us_metadata]).reset_index()

## COMBINE METADATA WITH CORPUS IDS ##

# load ordered project ID 
project_id_ordered = pd.read_csv("./clean-data/fine-scale/all-countries/projectID_corpus.csv")
# remove .txt from end
project_id_ordered["ProjectId"] = project_id_ordered["ProjectId"].apply(lambda x: re.sub(".txt","",x))
# merge projects ids and metadata by columns in common
df_meta_joined = project_id_ordered.merge(df_meta, on=["ProjectId","Country","CountryFundingBody"])

## Load doctopic matrix
doc_topic_mat = np.load("./results/fine-scale/all-countries/doc_topic_mat.npy")
#filter doctop
doc_topic_mat[doc_topic_mat < 0.01] = 0.0

# filter out docs with no topics (shouldnt exist with new min probability...)
no_topic_index = np.sum(doc_topic_mat, axis = (0)) > 0

#remove rows from metadata
df_meta_joined = df_meta_joined[no_topic_index].reset_index()
doc_topic_mat = doc_topic_mat[:,no_topic_index]


#Calculate funding body distances
## DISTANCE MATRIX ##

# To get distance of research councils we:
# 1) Calculate distance in topic space of each pair of documents (might need to sample if too large...)
# 2) Calculate summary of distances within and between research councils

## Distance measure
def Hellinger(p, q):
    # distance between p an d
    # p and q are np array probability distributions
    n = len(p)
    sum = 0.0
    for i in range(n):
        sum += (np.sqrt(p[i]) - np.sqrt(q[i]))**2
    result = (1.0 / np.sqrt(2.0)) * np.sqrt(sum)
    return result

funders = df_meta_joined["FundingBody"].unique()

N = len(funders)
N_sample = 3000

# create empty array to store distances by using the number of existing documents
Hellinger_distance = np.zeros((N,N,N_sample))

# for loop to allocate distances to the distances array
# for every document in N
for i in range(N):
    # and for each document in the top right triangle
    for j in range(i, N):
        #get samples
        indx_1 = df_meta_joined[df_meta_joined.FundingBody == funders[i]].index
        indx_2 = df_meta_joined[df_meta_joined.FundingBody == funders[j]].index
        
        print(len(indx_1), len(indx_2))
        
        indx_1 = random.sample(sorted(indx_1), N_sample)
        indx_2 = random.sample(sorted(indx_2), N_sample)
        for a, (k,l) in enumerate(zip(indx_1,indx_2)):
            # indx = (doc_topic_mat[:,k] != 0) | (doc_topic_mat[:,l] !=0)
           # calculate Hellinger distance of probability of one document to another for all topics
            dis = Hellinger(doc_topic_mat[:,k], doc_topic_mat[:,l])
            Hellinger_distance[i,j,a] = Hellinger_distance[j,i,a] = dis

#save d_mat
np.save("./results/fine-scale/all-countries/funder_distances.npy", Hellinger_distance)

#save funders
with open("./results/fine-scale/all-countries/funder_index.txt", "w") as fn:
    fn.writelines("\n".join(funders))
