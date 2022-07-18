import sys
import gensim
import gensim.corpora as corpora
from gensim.models import hdpmodel
import psutil

print(psutil.cpu_count())

def main(argv):
    #load data
    loaded_dict = corpora.Dictionary.load('./clean-data/fine-scale/UK/dictionary.dict')
    loaded_corpus = corpora.MmCorpus('./clean-data/fine-scale/UK/corpus.mm')

    #tf-idf
    tfidf = gensim.models.TfidfModel(loaded_corpus, smartirs='ntc')
    loaded_corpus = tfidf[loaded_corpus]

    lda_model = gensim.models.hdpmodel.HdpModel(corpus = loaded_corpus, id2word=loaded_dict)

    lda_model.save('./models/UK/UKRI_hdp.model')
    corpora.MmCorpus.serialize('./models/UK/UKRI_hdp.mm', loaded_corpus)


if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)