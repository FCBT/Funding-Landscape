# !/bin/bash

## to recover other output files from binary output
# mallet train-topics -input-model ./path/to/binary/file.txt --output-topic-keys ./path/to/save/outputfile --no-inference true

## to recover other output files from model state

for r in 1
do
    for t in {125..500..25}
    do
    mallet train-topics --input-state ./results/fine-scale/mallet-models/STEM-ENG/$t-topic-files/$r-$t-topics-state.gz --input ./clean-data/fine-scale/STEM-ENG/$r-training.mallet --output-topic-keys ./results/fine-scale/mallet-models/STEM-ENG/$t-topic-files/$r-$t-topics-key.txt --no-inference true --num-topics $t
    done
done

# mallet train-topics --input-state ./results/fine-scale/mallet-models/STEM-ENG/5-topic-files/1-5-topics-state.gz --input ./clean-data/fine-scale/STEM-ENG/1-training.mallet --output-topic-keys ./results/fine-scale/mallet-models/STEM-ENG/5-topic-files/1-5-topics-key.txt --no-inference true --num-topics 5