#!/usr/bin/env python3

""" Reads text files from the raw-data folder and saves the processed text into the clean-data folder.
The raw text is made of projects' titles and abstracts. The processed texts are corpuses and dictionaries
that will be used as input in the LDA models. 

If run as a script, it takes two arguments: the file path to the source text files and the file path to save
the processed data. Example:  python3 code/01_process_multiple_texts.py ./raw-data/fine-scale/test ./clean-data/fine-scale/test """

__appname__ = '[01_process_multiple_texts.py]'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'

import sys
import os
import gensim
import gensim.corpora as corpora
from gensim.models import LdaMulticore
import psutil


def main(argv):
    print("Number of cores:  ", psutil.cpu_count())

    topics_range = range(int(argv[3]),int(argv[4]),int(argv[5]))
    
    print("Loading data")

    #load data
    loaded_dict = corpora.Dictionary.load(os.path.join(argv[1], 'dictionary.dict'))
    loaded_corpus = corpora.MmCorpus(os.path.join(argv[1], 'corpus.mm'))

    print("Fitting")
    for k in topics_range:
        print("Fitting", k)
        lda_model = gensim.models.ldamulticore.LdaMulticore(corpus = loaded_corpus, num_topics=k ,id2word=loaded_dict, chunksize=3000, passes=5, eval_every=1, alpha=0.01, eta='symmetric')

        # Save model
        lda_model.save(os.path.join(argv[2], 'model_'+str(k)+'_topics'))
        print("Saved tuning model ", k)

    print("Saved training results")

    

if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)

