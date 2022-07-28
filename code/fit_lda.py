import sys
import gensim
import gensim.corpora as corpora
from gensim.models import LdaMulticore
from gensim.models import TfidfModel
import psutil

print(psutil.cpu_count())

def main(argv):
    #load data
    loaded_dict = corpora.Dictionary.load('./clean-data/fine-scale/UK/dictionary.dict')
    loaded_corpus = corpora.MmCorpus('./clean-data/fine-scale/UK/corpus.mm')

    lda_model = gensim.models.ldamulticore.LdaMulticore(corpus = loaded_corpus, id2word=loaded_dict, eval_every=1)

    lda_model.save('./models/UKRI_100.model')

if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)



