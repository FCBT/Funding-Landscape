#!/usr/bin/env python3

""" Loads processed corpuses and tokenised text from the clean-data/fine-scale folder, loads fitted LDA models from models/fine-scale folder and 
saves coherence results into the results folder.
Corpuses and LDA model are needed to calculate the UMass coherence.
Corpuses, LDA model and tokenised text are necessary to calculate the other 3 measures of coherence. 

If run as a script, it takes three arguments: 
    1) the file path to the corpus and tokenised text
    2) the file path to the fitted LDA models
    3) the file path to save the results
Example:  python3 code/03_calculate_coherence.py ./clean-data/fine-scale/all-countries ./models/fine-scale/all-countries ./results/fine-scale/all-countries """

__appname__ = '[01_process_multiple_texts.py]'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'

## imports ##
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
import logging

#logging.basicConfig(format="%(asctime)s:%(levelname)s:%(message)s", level=logging.INFO)


## functions ##
class LoadFiles(object):
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
                cm_umass = CoherenceModel(model=lda, corpus=self.corpus, coherence='u_mass', processes= 24)
                c_umass = cm_umass.get_coherence()

                # # CV
                # cm_cv = CoherenceModel(model=lda, corpus=self.corpus, texts=self.text,coherence='c_v',processes= 24)
                # c_cv = cm_cv.get_coherence()

                # #log-perplexity
                # l_perp = lda.log_perplexity(self.corpus)
            
                yield(lda.num_topics, c_umass, 0.0, 0.0)
            



def main(argv):
    print(psutil.cpu_count())

    #load data
    print("Loading data")
    loaded_corpus = corpora.MmCorpus(os.path.join(argv[1], 'corpus.mm'))
    with open(os.path.join(argv[1], 'tokens.txt')) as f:
        loaded_text = f.readlines()

    loaded_text = [re.sub(' \n','',s) for s in loaded_text] #strip newlines
    loaded_text = [s.strip('[]').replace("'", '').replace(' ', '').split(',') for s in loaded_text]

    coherence_results = {"Topics":[], "umass":[], "cv": [], "l_perp": []}
    
    #loop over
    for i in LoadFiles(argv[2], loaded_corpus, loaded_text):
        coherence_results["Topics"].append(i[0])
        coherence_results["umass"].append(i[1])
        coherence_results["cv"].append(i[2])
        coherence_results["l_perp"].append(i[3])



    # print("Fitting")
    df = pd.DataFrame.from_dict(coherence_results)
    df.to_csv(os.path.join(argv[3], 'calculated_coherence.csv'))


if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)
