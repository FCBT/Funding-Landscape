import gensim
import pandas as pd
import re
import numpy as np
from sklearn.manifold import TSNE

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

# filter out docs with no topics (shouldnt exist with new min probability...)
no_topic_index = np.sum(doc_topic_mat, axis = (0)) > 0

#remove rows from metadata
df_meta_joined = df_meta_joined[no_topic_index]
doc_topic_mat = doc_topic_mat[:,no_topic_index]

#sample random
svec = np.random.uniform(size = len(df_meta_joined)) < 0.1
df_meta_joined = df_meta_joined[svec]
doc_topic_mat = doc_topic_mat[:, svec]

perplexitites = [30, 50, 70, 90, 110, 200]

for i in perplexitites:
    print('calculating with perplexity:', i)
    tsne_model = TSNE(n_components=2, verbose=1, random_state=0, angle=.5, init='pca',perplexity=i, n_iter=5000, n_jobs=24)
    tsne_lda = tsne_model.fit_transform(doc_topic_mat.transpose())

    df_meta_joined["tsne_ax1_"+str(i)] = tsne_lda[:,0]
    df_meta_joined["tsne_ax2_"+str(i)] = tsne_lda[:,1]

#save output
df_meta_joined.to_csv("./results/fine-scale/all-countries/tnse_df.csv")

