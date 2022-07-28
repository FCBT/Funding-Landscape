#!/usr/bin/env python3

""" Reads text files from the raw-data folder and saves the processed text into the clean-data folder.
The raw text is made of projects' titles and abstracts. The processed texts are tokenised text, corpuses and dictionaries. 
Corpuses and dictionaries will be used as input in the LDA models. The tokenized text will the used to calculate some of the
coherence scores

If run as a script, it takes two arguments: 
    1) the file path to the source text files
    2) the file path to save the processed data. 
    Example:  python3 code/01_process_multiple_texts.py ./raw-data/fine-scale/test ./clean-data/fine-scale/test """

__appname__ = '[01_process_multiple_texts.py]'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'


## imports ##
import sys # module to interface our program with the operating system
import logging
import os
import gensim
import re
import pandas as pd
from gensim import corpora
from pprint import pprint
from gensim.utils import simple_preprocess
from gensim.models import tfidfmodel
from gensim.models.phrases import Phrases, ENGLISH_CONNECTOR_WORDS
import nltk
from nltk import pos_tag
from nltk.stem import WordNetLemmatizer
from nltk.corpus import stopwords
import copy 
#nltk.download('averaged_perceptron_tagger') 

## constants ##

## set log config 
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.ERROR)

## define stop words
stop_words = stopwords.words('english')
stop_words.extend(['from', 'subject', 're', 'edu', 'use', 'not', 'would', 'say', 'could', '_', 'be', 'know', 'good', 'go', 'get', 'do', 
'done', 'try', 'many', 'some', 'nice', 'thank', 'think', 'see', 'rather', 'easy', 'easily', 'lot', 'lack', 'make', 'want', 'seem', 'run', 
'need', 'even', 'right', 'line', 'even', 'also', 'may', 'take', 'come', 'title', 'abstract', 'research', 'project', 'article', 'journal'])

## define lemmatizer
lemmatizer = WordNetLemmatizer()

## functions ##

# The __iter__() method should iterate through all the files in a given directory and yield 
# the processed list of word tokes. The advantage is that one can read an entire text file 
# without loading the file in memory all at once.

# print(os.getcwd())

# define __iter__() by the name ReadTxtFiles
class ReadTxtFiles(object):
    def __init__(self, dirname, return_fnames):
        self.dirname = dirname
        self.return_fnames = return_fnames
    
    def __iter__(self):
        # print((self.dirname))
        i = 0

        for fname in os.listdir(self.dirname):
            if i % 1000 == 0:
                print(i, " ", len(os.listdir(self.dirname)))

            i += 1
            if fname.endswith(".txt"):
                with open(os.path.join(self.dirname, fname), 'r') as f:
                    tokens = f.read()
                    tokens = re.sub('\S*@\S*\s?', '', tokens)  # remove emails
                    tokens = re.sub('\s+', ' ', tokens)  # remove newline chars
                    tokens = re.sub("\'", "", tokens)  # remove single quotes
                    tokens = gensim.utils.simple_preprocess(str(tokens), deacc=True) # lowercases, tokenizes and remove accents and punctuations.
                    tokens = [word for word in tokens if word not in (stop_words)] # remove stop words
                    tokens = [lemmatizer.lemmatize(word) for word in tokens] # lematize words (reduce words to their lemmas)
                    tokens = [word for word in tokens if len(word) > 2]
                    tagged_words = nltk.pos_tag(tokens) # get parts of speech
                    allowed_tags = ["NN", "VB"] # define allowed tags (nouns and verbs only)
                    tokens = [word[0] for word in tagged_words if word[1].startswith(tuple(allowed_tags))]
                    
                    if self.return_fnames:
                        yield(tokens, fname)
                    else:
                        yield(tokens)




def main(argv):

    print(argv)
    # create dictionary
    dict_data = corpora.Dictionary()
    corpus = []

    print("empty dictionary created")

    #allocte tolkens + project ids
    tokens = []
    projectid = []

    #loop over files
    # iterate through all files to get corpus from bigram model and ids
    for i in ReadTxtFiles(argv[1], True):
        tokens.append(i[0])
        projectid.append(i[1])

    #create bigram model #10 - 5
    bigram_model = gensim.models.phrases.Phrases(tokens, min_count = 1, threshold=1, connector_words=ENGLISH_CONNECTOR_WORDS)
    bigram_tokens = bigram_model[tokens]

    bigram_model.export_phrases()

    #1) fill corpus + dict
    for t in bigram_tokens:
        #make corpus + dict
        corpus.append(dict_data.doc2bow(t, allow_update= True))

    #2) remove common + rare words
    old_dict = copy.deepcopy(dict_data)
    dict_data.filter_extremes(no_below = round(len(corpus) * 0.01) ,no_above=0.80)
    old2new = {old_dict.token2id[token]:new_id for new_id, token in dict_data.iteritems()}
    vt = gensim.models.VocabTransform(old2new)
    corpus = vt[corpus]

    #3) write tokens to disk
    with open(os.path.join(argv[2], "tokens.txt"), 'w') as fp:
        for c in corpus:
            fp.write("%s \n" % [dict_data[i[0]] for i in c])

    #4) creat tf-idf matrix
    # # create the TF-IDF matrix. This is a bag-of-words model that down weights tokens that appear frequently across documents.
    tfidf = gensim.models.tfidfmodel.TfidfModel(corpus, smartirs='ntc') # fit model
    corpus_tfidf = tfidf[corpus] # apply model to corpus
    print("tfidf corpus created")
    
    #5) save projects IDs
    with open(os.path.join(argv[2], "projectID_corpus.txt"), 'w') as fp:
        for item in projectid:
            fp.write("%s\n" % item)
        print("Projects IDs saved in " + argv[2]) 

    # save corpus
    corpora.MmCorpus.serialize(os.path.join(argv[2], "corpus.mm"), corpus_tfidf)

    # save dictionary
    dict_data.save(os.path.join(argv[2], "dictionary.dict"))

    


    # bigrammed_token = bigram_model[i[0]]
    # 
    
    # # print(bigrammed_token, "\n")

    # corpus.append(dict_data.doc2bow(bigrammed_token, allow_update= True))

    
    # create bigram models with function Phrases
    # 'phrases' detect common phrases from a stream of sentences
    # bigram_model = gensim.models.phrases.Phrases(ReadTxtFiles(argv[1], False), min_count = 10, threshold=5, connector_words=ENGLISH_CONNECTOR_WORDS) #allocate bigram model
        
    # create a 'frozen Phrases model' to save memory. It does not update the bigrams with new documents anymore.
    # bigram_model = bigram_model.freeze()
    # print("frozen bigram model created")

    # # create empty list for corpus and proj id 
    # corpus = []
    # projectid = []

    # #open token file to save to
    # with open(os.path.join(argv[2], "tokens.txt"), 'w') as fp:
    #     # iterate through all files to get corpus from bigram model and ids
    #     for i in ReadTxtFiles(argv[1], True):
            
    #         bigrammed_token = bigram_model[i[0]]
    #         fp.write("%s \n" % bigrammed_token)
            
    #         # print(bigrammed_token, "\n")
    #         corpus.append(dict_data.doc2bow(bigrammed_token, allow_update= True))
    #         projectid.append(i[1])

    # #filter common words
    # old_dict = copy.deepcopy(dict_data)
    # dict_data.filter_extremes(no_below = round(len(corpus) * 0.01) ,no_above=0.80)
    # old2new = {old_dict.token2id[token]:new_id for new_id, token in dict_data.iteritems()}
    # vt = gensim.models.VocabTransform(old2new)
    # corpus = vt[corpus]
    


    # # save projects IDs
    # with open(os.path.join(argv[2], "projectID_corpus.txt"), 'w') as fp:
    #     for item in projectid:
    #         fp.write("%s\n" % item)
    #     print("Projects IDs saved in " + argv[2]) 

    # # save corpus
    # corpora.MmCorpus.serialize(os.path.join(argv[2], "corpus.mm"), corpus_tfidf)

    # # save dictionary
    # dict_data.save(os.path.join(argv[2], "dictionary.dict"))

    return 0   


if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)
