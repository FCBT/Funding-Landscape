!/bin/bash

# infer topics on whole dataset
for r in 1
do
    for k in 200
    do
        echo $k
        mallet infer-topics --inferencer ./results/fine-scale/mallet-models/STEM/$k-topic-files/$r-$k-topics-inferencer --input ./clean-data/fine-scale/STEM/mallet-tokens.mallet --output-doc-topics ./results/fine-scale/mallet-models/STEM/$k-topic-files/$r-$k-topics-doc.txt
    done
done





