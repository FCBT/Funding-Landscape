#!/usr/bin/env python3

""" Reads dictionary and corpus previously created from the clean-data/fine-scale folder and saves the fitted models into the models/fine-scale folder.
The input corpuses and dictionaries are used as input in the LDA models.
Several LDA models are run with differing values of topics, which will later be plotted against coherences scores to get the ideal number of topics.
k is the number of topics to be choosen by the reader and is one argument to run this as a script. 

If run as a script, it takes 5 arguments: 
1) the file path to the input dictionaries and corpuses
2) the file path to save the fitted models
3) the initial value of topics to run the model with
4) the final value of topcis to run the model with (this value is not included in the run. i.e if one wants to run 5 to 10 topics, use 11 in this argument)
5) the step value for topics to run the model (i.e run 10 to 101 but at 10 intervals = 10, 20, 30, ... 80, 90, 100 topics)

Example:  python3 code/03_test_subset.py ~/Funding-Landscape/clean-data/fine-scale/UK-USA ~/Funding-Landscape/results/fine-scale/UK-USA/lda-models/testing-subsets
"""

__appname__ = '[02_topic_tuning.py]'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'


## imports ##
from importlib.resources import path
import pandas as pd
import sys
import os
import gensim
import gensim.corpora as corpora
from gensim.models import LdaMulticore
import psutil
import random
from datetime import datetime


def main(argv):
    print("Number of cores:  ", psutil.cpu_count())

    # topics_range = range(int(argv[3]),int(argv[4]),int(argv[5]))
    topics_range = [50, 100, 150, 200, 250, 300, 350, 400]
    proportion_corpus = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25]
    
    print("Loading data")

    #load data
    loaded_dict = corpora.Dictionary.load(os.path.join(argv[1], 'dictionary.dict'))
    loaded_corpus = corpora.MmCorpus(os.path.join(argv[1], 'corpus.mm'))

    fitting_times = {"n_topics":[], "proportion_corpus":[], "fitting_time":[]}

    print("Fitting")

    for proportion in proportion_corpus:

        corpus_index = random.sample(range(len(loaded_corpus)), int(len(loaded_corpus) * proportion))

        for k in topics_range:
            start = datetime.now()
            print(start)

            print("Fitting", k, "topics with", str(proportion*100), "% corpus")
            lda_model = gensim.models.ldamulticore.LdaMulticore(corpus = loaded_corpus[corpus_index], id2word=loaded_dict, chunksize=3000, passes=10, iterations=100, num_topics=k, workers=40)

            # Save model
            lda_model.save(os.path.join(argv[2], 'perc_'+ str(proportion)+'_model_'+str(k)+'_topics'))
            model_time = datetime.now()
            time2fit = model_time-start
            print("Saved tuning model ", k, "at", model_time, "with ", str(proportion*100), "% corpus")
            print("it took ", model_time-start, "to fit")

            fitting_times["n_topics"].append(k)
            fitting_times["proportion_corpus"].append(proportion)
            fitting_times["fitting_time"].append(time2fit)

    time_df = pd.DataFrame.from_dict(fitting_times)
    time_df.to_csv(os.path.join(argv[2], 'fitting_time_topics.csv'), index = False)


    end = datetime.now()
    print("Saved training results")
    
    print(end)
    print("it took ", end-start, "to fit all models")


    
if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)

