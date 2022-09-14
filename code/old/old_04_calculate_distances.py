import gensim
import pandas as pd
import re
import random
import seaborn as sns
import numpy as np

# load LDA model, dictionary and corpus
#dictionary = gensim.corpora.Dictionary.load('../clean-data/fine-scale/all-countries/dictionary.dict')
corpus = gensim.corpora.MmCorpus('./clean-data/fine-scale/all-countries/corpus.mm')
lda = gensim.models.ldamulticore.LdaMulticore.load('./models/fine-scale/all-countries/model_105_topics')

# load metadata
ukri_metadata = pd.read_csv("./raw-data/fine-scale/UK/UKRI/projects-metadata/UKRI_project_metadata.csv")
# as the USA metadata project id column is made of only numbers, python thinks it is suppose to be numeric, so coerce it into a string to avoid problems when concatenating the UKRI data.
us_metadata = pd.read_csv("./raw-data/fine-scale/USA/NSF/projects-metadata/NSF_projects_metadata.csv", dtype="object")

# row bind the detasets together; and reset index to match corpus, as datasets have more rows than the corpus. That happened because not all projects were used to fit the LDA (for example projects that did not have titles or abstracts)
df_meta = pd.concat([ukri_metadata,us_metadata]).reset_index()

## COMBINE METADATA WITH CORPUS IDS ##

# load ordered project ID 
project_id_ordered = pd.read_csv("./clean-data/fine-scale/all-countries/projectID_corpus.csv")

project_id_ordered = project_id_ordered.query("ProjectId != 'errors.txt'")

# add docId column
project_id_ordered["docId"] = project_id_ordered.index.astype("object")

# remove .txt from end
project_id_ordered["ProjectId"] = project_id_ordered["ProjectId"].apply(lambda x: re.sub(".txt","",x))

# merge projects ids and metadata by columns in common
df_meta_joined = project_id_ordered.merge(df_meta, on=["ProjectId","Country","CountryFundingBody"])


## MAKE ARRAY WITH TOPICS PROBABILITIES ##

# topics 
N = len(corpus)
res = np.zeros((lda.num_topics, N))

for i in range(0,N):
    topic_probs = lda.get_document_topics(corpus[i])
    for j in topic_probs:
        res[j[0],i] = j[1]

# filter out docs with no topics
no_topic_index = np.sum(res, axis = (0)) > 0

# filter docs with missing data
no_data_doc_ids = list(df_meta.query("FundingBody == 'None'").docId)
no_topic_index[no_data_doc_ids] = False

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


# filter out funding bodies with less than 2800 projects
df_meta_filter = df_meta.groupby('FundingBody').filter(lambda x : len(x) > 2800)
# filter out EHR as it is not STEM (i made a note to remove it at first stages of data processing not here in the future)
filter_list = ['EHR', 'BFA', 'IRM', 'OPP']
df_meta_filter[~df_meta_filter.FundingBody.isin(filter_list)]


funders = df_meta_filter["FundingBody"].unique()

N = len(funders)
N_sample = 2990

# create empty array to store distances by using the number of existing documents
Hellinger_distance = np.zeros((N,N,N_sample))
Cosine_distance = np.zeros((N,N,N_sample))
Shannon_distance = np.zeros((N,N,N_sample))
Wasserstein_distance = np.zeros((N,N,N_sample))


# for loop to allocate distances to the distances array
# for every document in N
for i in range(N):
    # and for each document in the top right triangle
    for j in range(i, N):
        #get samples
        indx_1 = df_meta_filter[df_meta_filter.FundingBody == funders[i]].index
        indx_2 = df_meta_filter[df_meta_filter.FundingBody == funders[j]].index
        
        print(len(indx_1), len(indx_2))
        
        indx_1 = random.sample(sorted(indx_1), N_sample)
        indx_2 = random.sample(sorted(indx_2), N_sample)
        for a, (k,l) in enumerate(zip(indx_1,indx_2)):
           # calculate Hellinger distance of probability of one document to another for all topics
            dis = Hellinger(res[:,k], res[:,l])
            Hellinger_distance[i,j,a] = Hellinger_distance[j,i,a] = dis
            
            dis = scipy.spatial.distance.cosine(res[:,k], res[:,l])
            Cosine_distance[i,j,a] = Cosine_distance[j,i,a] = dis
            
            dis = scipy.spatial.distance.jensenshannon(res[:,k], res[:,l])
            Shannon_distance[i,j,a] = Shannon_distance[j,i,a] = dis
            
            dis = scipy.stats.wasserstein_distance(res[:,k], res[:,l])
            Wasserstein_distance[i,j,a] = Wasserstein_distance[j,i,a] = dis
        
sns.set(rc={'figure.figsize':(18,18)})


fig, axs = plt.subplots(2,2)

sns.heatmap(np.nanmean(Hellinger_distance, axis = (2)), ax=axs[0,0],xticklabels=funders,yticklabels=funders, cmap = "Blues").set(title='Hellinger')
sns.heatmap(np.nanmean(Cosine_distance, axis = (2)), ax=axs[0,1], xticklabels=funders,yticklabels=funders,cmap = "Blues").set(title='Cosine')
sns.heatmap(np.nanmean(Shannon_distance, axis = (2)), ax=axs[1,0], xticklabels=funders,yticklabels=funders,cmap = "Blues").set(title='Jensen-Shannon')
sns.heatmap(np.nanmean(Wasserstein_distance, axis = (2)), ax=axs[1,1], xticklabels=funders,yticklabels=funders,cmap = "Blues").set(title='Wasserstein')

plt.savefig('../results/fine-scale/figures/heatmap_distances_by_funding_body.png')