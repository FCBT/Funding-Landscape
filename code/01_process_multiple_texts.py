#!/usr/bin/env python3

""" Reads text files from the raw-data folder and saves the processed text into the clean-data folder.
The raw text is made of projects' titles and abstracts. The processed texts are corpuses and dictionaries
that will be used as input in the LDA models. 

If run as a script, it takes two arguments: the file path to the source text files and the file path to save
the processed data. """

__appname__ = '[process_multiple_texts.py]'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'


## imports ##
import sys # module to interface our program with the operating system
import os
import gensim
import re
from gensim import corpora
from pprint import pprint
from gensim.utils import simple_preprocess
from gensim.models import tfidfmodel
import nltk
from nltk.stem import WordNetLemmatizer
from nltk.corpus import stopwords
nltk.download('averaged_perceptron_tagger') 

## constants ##

## define stop words
stop_words = stopwords.words('english')
stop_words.extend(['from', 'subject', 're', 'edu', 'use', 'not', 'would', 'say', 'could', '_', 'be', 'know', 'good', 'go', 'get', 'do', 
'done', 'try', 'many', 'some', 'nice', 'thank', 'think', 'see', 'rather', 'easy', 'easily', 'lot', 'lack', 'make', 'want', 'seem', 'run', 
'need', 'even', 'right', 'line', 'even', 'also', 'may', 'take', 'come', 'title', 'abstract'])

## define lemmatizer
lemmatizer = WordNetLemmatizer()

## functions ##

# The __iter__() method should iterate through all the files in a given directory and yield 
# the processed list of word tokes. The advantage is that one can read an entire text file 
# without loading the file in memory all at once.

# print(os.getcwd())

# define __iter__() by the name ReadTxtFiles
class ReadTxtFiles(object):
    def __init__(self, dirname):
        self.dirname = dirname
    
    def __iter__(self):
        # print((self.dirname))
        i = 0
        for fname in os.listdir(self.dirname):
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
                                        
                    yield(tokens, fname)


def main(argv):

    print(argv)
    # create dictionary
    dict_data = corpora.Dictionary()

    # create empty list for corpus and proj id 
    corpus = []
    projectid = []

    # iterate through all files to get corpus and ids
    for i in ReadTxtFiles(argv[1]):
        corpus.append(dict_data.doc2bow(i[0], allow_update= True))
        projectid.append(i[1])

    # Create the TF-IDF model
    # tfidf = gensim.models.tfidfmodel.TfidfModel(corpus, smartirs='ntc')

    # save projects IDs
    with open(os.path.join(argv[2], "projectID_corpus.txt"), 'w') as fp:
        for item in projectid:
            fp.write("%s\n" % item)
        print("Projects IDs saved in " + argv[2]) 

    # save corpus
    corpora.MmCorpus.serialize(os.path.join(argv[2], "corpus.mm"), corpus)

    # save dictionary
    dict_data.save(os.path.join(argv[2], "dictionary.dict"))

    return 0   


if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)
