# !/bin/bash

# process text
echo "tokenising text"
python ./code/01_tokenize_texts4mallet.py ./code/supporting-files/directories-path/titles-abstracts-directories.txt ./clean-data/fine-scale/ENG-speaking-countries/

# importing data with Mallet
echo importing data
mallet bulk-load --input ./clean-data/fine-scale/ENG-speaking-countries/titles-abstracts-tokenized.csv --keep-sequence TRUE --prune-count 20 --prune-doc-frequency 0.8 --output ./clean-data/fine-scale/ENG-speaking-countries/mallet-tokens.mallet --line-regex "^(\S*)[\s,]*(\S*)[\s,]*(.*)$"

# training topic model with Mallet and topics from 100 to 800
for k in {100..1001..50}
do
    echo number of topics: $k
    mallet train-topics --input ./clean-data/fine-scale/ENG-speaking-countries/mallet-tokens.mallet --num-topics $k --num-threads 40 --optimize-interval 20 --optimize-burn-in 40 --output-model ./results/fine-scale/mallet-models/ENG-speaking-countries/$k-topics-model.txt --output-state ./results/fine-scale/mallet-models/ENG-speaking-countries/$k-topics-state.gz --output-doc-topics ./results/fine-scale/mallet-models/ENG-speaking-countries/$k-topics-doc.txt --output-topic-keys ./results/fine-scale/mallet-models/ENG-speaking-countries/$k-topics-keys.txt --diagnostics-file ./results/fine-scale/mallet-models/ENG-speaking-countries/$k-topics-diagnostics.xml 

done

