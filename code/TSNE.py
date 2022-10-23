from MulticoreTSNE import MulticoreTSNE as TSNE
import numpy as np

# read doc_topic_matrix
with open("./results/fine-scale/mallet-models/UK/800-topics-doc.txt","r") as f:
        txt = f.read().splitlines()

# parse probabilties
for (i,v) in enumerate(txt):
    txt[i] = [float(x) for x in v.split()[2:]]

# turn into numpy array
probs = np.array(txt)

probs.shape

tsne_fit = TSNE(n_jobs=4, verbose=1).fit_transform(probs)