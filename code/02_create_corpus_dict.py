#!/usr/bin/env python3

""" 
This script creates bigram models from titles and abstracts. The titles and abstracts were previously tokenised and are used here as 
the input for the bigram model. Due to the large size of the tokenised files, this script reads and process the file line-by -line. 

The first argument should be the path to the processed tokens (tokenised titles and abstracts), and the second argument should the 
path to save the frozen bigram model.
Example:

argv[1]= "./clean-data/fine-scale/UK-USA/tokens/"
argv[2]= "./code/supporting-files/bigram-models/"
argv[3]= "./clean-data/fine-scale/UK-USA/corpus-dictionary/"
"""

__appname__ = 'create_corpus_dict.py'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'

#  imports

import copy
from gensim.models.phrases import Phrases
import pandas as pd
import sys
import csv
import ast
import os
import gensim
from gensim import corpora



# create iterator to read line by line of processed tokes. Files are too large, so this uses less memory.  
class TokenIterator:
    def __init__(self, fpath) -> None:
        self.fpath = fpath

    def __iter__(self):
        with open(self.fpath, newline='') as csvfile:
            reader = csv.reader(csvfile, delimiter=",")
            next(reader, None) # ignores the header
            for row in reader:
                row_line = ast.literal_eval(row[1])
                # keep only text with at least 30 words
                if len(row_line) > 29:
                    yield(row_line) # reads lines as lists

def main(argv):
    tokens = TokenIterator(os.path.join(argv[1], "titles-abstracts-tokenized.csv"))

    # load bigram
    bigram_model = Phrases.load(os.path.join(argv[2], "bigram_model_uk_usa.pkl")) # load bigram
    print('loaded tokens and bigram model')

    # create empty dictionary and corpus
    dict_data = corpora.Dictionary()
    corpus = []
    print('created empty corpus and dict')

    # fill corpus + dict
    i = 0
    for t in tokens:
        if i % 1000 == 0:
            print(i)
        bigram_token = bigram_model[t]
        # make corpus + dict
        corpus.append(dict_data.doc2bow(bigram_token, allow_update= True))
        i += 1
    print('fill out corpus and dictionary')

    # remove common + rare words
    old_dict = copy.deepcopy(dict_data)
    dict_data.filter_extremes(no_below = round(len(corpus) * 0.001) ,no_above=0.80)
    old2new = {old_dict.token2id[token]:new_id for new_id, token in dict_data.iteritems()}
    vt = gensim.models.VocabTransform(old2new)
    corpus = vt[corpus]
    print('updated corpus and dictionary without common and rare words')

    # create tf-idf matrix
    # This is a bag-of-words model that down-weights tokens that appear frequently across documents.
    tfidf = gensim.models.tfidfmodel.TfidfModel(corpus, smartirs='ntc') # fit model
    corpus_tfidf = tfidf[corpus] # apply model to corpus
    print("tfidf corpus created")

    # save corpus
    corpora.MmCorpus.serialize(os.path.join(argv[3], "corpus.mm"), corpus_tfidf)

    # save dictionary
    dict_data.save(os.path.join(argv[3], "dictionary.dict"))
    print('corpus and dict saved in ' + argv[3])


    return 0

if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)



