# !/bin/bash

'''
This script 
'''
# importing data in Mallet format to fit models in the next script
mallet bulk-load --input ./clean-data/fine-scale/UK-USA/titles-abstracts-tokenized.csv --keep-sequence TRUE --prune-count 20 --prune-doc-frequency 0.8 --line-regex "^(\S*)[\s,]*(\S*)[\s,]*(.*)$" --output ./clean-data/fine-scale/UK-USA/mallet-tokens.mallet
