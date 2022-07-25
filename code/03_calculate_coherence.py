import sys
import gensim
import os
import gensim.corpora as corpora
from gensim.models import LdaMulticore
from gensim.models import TfidfModel
from gensim.models import CoherenceModel
import pandas as pd
import psutil
import ast
import re

class ReadTxtFiles(object):
    def __init__(self, dirname, corpus, text):
        self.dirname = dirname
        self.corpus = corpus
        self.text = text
    
    def __iter__(self):
        # print((self.dirname))
        i = 0        
        for fname in os.listdir(self.dirname):

            if fname.endswith("topics"):
                print(i, " ", len(os.listdir(self.dirname)))
                i += 1
                
                lda = gensim.models.ldamulticore.LdaMulticore.load(os.path.join(self.dirname, fname))
                print("Calculating coherences for", fname)

                # UMass
                cm_umass = CoherenceModel(model=lda, corpus=self.corpus, coherence='u_mass', processes= -1)
                c_umass = cm_umass.get_coherence()

                # CV
                cm_cv = CoherenceModel(model=lda, corpus=self.corpus, texts=self.text,coherence='c_v',processes= -1)
                c_cv = cm_cv.get_coherence()

                # UCI
                cm_uci = CoherenceModel(model=lda, corpus=self.corpus, texts=self.text ,coherence='c_uci',processes= -1)
                c_uci = cm_uci.get_coherence()

                # NPMI
                cm_npmi = CoherenceModel(model=lda, corpus=self.corpus, texts=self.text ,coherence='c_npmi',processes= -1)
                c_npmi = cm_npmi.get_coherence()
            
                yield(lda.num_topics, c_umass, c_cv, c_uci, c_npmi)
            



def main(argv):
    print(psutil.cpu_count())

    #load data
    print("Loading data")
    loaded_corpus = corpora.MmCorpus(os.path.join(argv[1], 'corpus.mm'))
    with open(os.path.join(argv[1], 'tokens.txt')) as f:
        loaded_text = f.readlines()

    loaded_text = [re.sub(' \n','',s) for s in loaded_text] #strip newlines
    loaded_text = [s.strip('[]').replace("'", '').replace(' ', '').split(',') for s in loaded_text]

    coherence_results = {"Topics":[], "umass":[], "cv": [], "uci":[], "npmi":[]}
    
    #loop over
    for i in ReadTxtFiles(argv[2], loaded_corpus, loaded_text):
        coherence_results["Topics"].append(i[0])
        coherence_results["umass"].append(i[1])
        coherence_results["cv"].append(i[2])
        coherence_results["uci"].append(i[3])
        coherence_results["npmi"].append(i[4])



    # print("Fitting")
    df = pd.DataFrame.from_dict(coherence_results)
    df.to_csv(os.path.join(argv[3], 'calculated_coherence.csv'))


if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)