# !/bin/bash

echo filtering data
python ./code/filter-tokens.py ./clean-data/fine-scale/STEM/titles-abstracts-tokenized.csv ./clean-data/fine-scale/STEM/
# importing data with Mallet

echo importing data
mallet bulk-load --input ./clean-data/fine-scale/STEM/titles-abstracts-tokenized-filtered.csv --keep-sequence TRUE --prune-count 20 --prune-doc-frequency 0.8 --output ./clean-data/fine-scale/STEM/mallet-tokens.mallet --line-regex "^(\S*)[\s,]*(\S*)[\s,]*(.*)$"

