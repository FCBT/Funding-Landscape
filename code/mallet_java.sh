# !/bin/bash

# python ./code/01_tokenize_texts4mallet.py ./test/dir.txt ./test/
# mallet import-file --input ./test/titles-abstracts-tokenized.csv --keep-sequence TRUE --print-output TRUE --output ./test/tokens.mallet
# mallet train-topics --input ./test/tokens.mallet --num-topics 2 --output-state ./test/topics-mallet.gz


#process text
python ./code/01_tokenize_texts4mallet.py ./code/supporting-files/directories-path/titles-abstracts-directories.txt ./clean-data/fine-scale/UK-USA/
# # importing data with Mallet
mallet import-file --input ./clean-data/fine-scale/UK-USA/mallet-tokens.csv --keep-sequence TRUE --print-output TRUE --output ./clean-data/fine-scale/UK-USA/mallet-tokens.mallet
# # training topic model with Mallet
mallet train-topics --input ./clean-data/fine-scale/UK-USA/mallet-tokens.mallet --num-topics 200 --output-state ./results/fine-scale/mallet-models/UK-USA/200-topics.gz 
