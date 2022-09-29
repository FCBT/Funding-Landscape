
#!/usr/bin/env python3

""" Reads dictionary and corpus previously created from the clean-data/fine-scale folder and saves the fitted models into the models/fine-scale folder.
The input corpuses and dictionaries are used as input in the LDA models.
Several LDA models are run with differing values of topics, which will later be plotted against coherences scores to get the ideal number of topics.
k is the number of topics to be choosen by the reader and is one argument to run this as a script. 

If run as a script, it takes 5 arguments: 
1) the file path to the input dictionaries and corpuses
2) the file path to save the fitted models

Example:  python3 code/03_test_subset.py ~/Funding-Landscape/clean-data/fine-scale/UK-USA ~/Funding-Landscape/results/fine-scale/UK-USA/hdp-models/25-percent-models
"""

__appname__ = '[02_topic_tuning.py]'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'


## imports ##
from importlib.resources import path
import sys
import os
import gensim
import gensim.corpora as corpora
from gensim.models import LdaMulticore
from gensim.models import HdpModel
import psutil
import logging
import random
from datetime import datetime
# path1 = '~/Projects/Ongoing/Funding-Landscape/flavia/clean-data/fine-scale/UK-USA'
# logging.basicConfig(format="%(asctime)s:%(levelname)s:%(message)s", level=logging.INFO)
# filename='gensim.log'

def main(argv):
    print("Number of cores:  ", psutil.cpu_count())
    
    print("Loading data")

    #load data
    loaded_dict = corpora.Dictionary.load(os.path.join(argv[1], 'dictionary.dict'))
    loaded_corpus = corpora.MmCorpus(os.path.join(argv[1], 'corpus.mm'))
    corpus_index = random.sample(range(len(loaded_corpus)), int(len(loaded_corpus) * 0.25) )

    print("Fitting")
    start = datetime.now()
    print(start)

    hdp_model = gensim.models.hdpmodel.HdpModel(corpus = loaded_corpus[corpus_index], id2word=loaded_dict, chunksize=3000)

    # Save model
    hdp_model.save(os.path.join(argv[2], 'hdp_model_'+str(len(corpus_index))+'_corpus'))
    
    end = datetime.now()
    print("Saved training results")
    print(end)
    print(end-start)


    

if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)

