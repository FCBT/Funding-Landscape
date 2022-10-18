#!/usr/bin/env python3

""" blah blah 

Example:
python3 ./code/01_tokenize_texts.py ./clean-data/fine-scale/USA/NIH/

"./code/supporting-files/directories-path/titles-abstracts-directories.txt"
"""

__appname__ = 'TokenizeTexts'
__author__ = 'Flavia C. Bellotto-Trigo (flaviacbtrigo@gmail.com)'
__version__ = '0.0.1'

# imports
from operator import index
import pandas as pd
from nltk.stem import WordNetLemmatizer
import TextProcessor
import sys
import os
import nltk
import csv
nltk.download('averaged_perceptron_tagger')
nltk.download('wordnet')
nltk.download('omw-1.4')


class TokenizeTexts:
    def __init__(self, text_processor, dirnames, savefile) -> None:
        self.text_processor = text_processor
        self.dirnames = dirnames
        self.savefile = savefile

    def tokenize_csv(self):
        for fname in self.dirnames:
            print(fname.split()[0]+"\n")

            with pd.read_csv(fname.split()[0], chunksize=1000) as f:
                # print(len(f))
                i = 0
                for chunk in f:
                    print("chunk "+ str(i) + "\n")

                    chunk['TitleAbstract'] = chunk['TitleAbstract'].map(lambda x: " ".join(self.text_processor.pre_process(x)))
                    # count number of tokens
                    chunk['n_tokens'] = chunk['TitleAbstract'].map(lambda x: len(x.split()))

                    chunk['Label'] = fname.split()[1]

                    chunk = chunk[["ProjectId", "Label", "TitleAbstract"]]
                    # keep only documents with at least 5 tokens
                    chunk = chunk.query("n_tokens > 4")
                    # remove column
                    chunk = chunk.drop(["n_tokens"], axis=1)

                    if i == 0:
                        chunk.to_csv(self.savefile,mode = 'w', index=False, header = False, sep = " ")
                    else:
                        chunk.to_csv(self.savefile,mode = 'a', index=False, header = False, sep = " ")

                    i += 1

                

def main(argv):
    #read in stop words
    with open("./code/supporting-files/stop-words.txt","r") as f:
        stop_words = f.read().splitlines()

    # define lemmatizer
    lemmatizer = WordNetLemmatizer()

    # read file with path to directories
    with open(argv[1],'r') as f:
        dirnames = f.read().splitlines()

    print(dirnames)

    text_processor = TextProcessor.TextProcessor(stop_words=stop_words, lemmatizer=lemmatizer)

    tokenize_text = TokenizeTexts(text_processor=text_processor, dirnames=dirnames, savefile=os.path.join(argv[2], "titles-abstracts-tokenized.csv"))

    tokenize_text.tokenize_csv()

    return 0

if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)
