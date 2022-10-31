
# !/bin/bash

# training topic model with Mallet from 50 to 1000 topics
 for r in 1
 do
   # split data into training and validation sets
    mallet split --input ./clean-data/fine-scale/STEM-ENG/mallet-tokens.mallet --random-seed $r --training-portion 0.8 --training-file ./clean-data/fine-scale/STEM-ENG/$r-training.mallet --testing-file ./clean-data/fine-scale/STEM-ENG/testing.mallet
    
    mallet run cc.mallet.util.DocumentLengths --input ./clean-data/fine-scale/STEM-ENG/testing.mallet > $r-doc-lengths.txt

    for k in {525..800..25}
      do

        echo number of topics: $k
        echo round: $r
        
        # create folder to store all files that will be created
        mkdir -p ./results/fine-scale/mallet-models/STEM-ENG/$k-topic-files

        echo training model

        if [ ! -f ./results/fine-scale/mallet-models/STEM-ENG/$k-topic-files/$r-$k-topics-state.gz ]; then
          # train model 
          mallet train-topics --input ./clean-data/fine-scale/STEM-ENG/$r-training.mallet --random-seed $r --num-topics $k --num-threads 40 --optimize-interval 100 --optimize-burn-in 200 --output-state ./results/fine-scale/mallet-models/STEM-ENG/$k-topic-files/$r-$k-topics-state.gz --diagnostics-file ./results/fine-scale/mallet-models/STEM-ENG/$k-topic-files/$r-$k-topics-diagnostics.xml --evaluator-filename ./results/fine-scale/mallet-models/STEM-ENG/$k-topic-files/$r-$k-topics-evaluator

          echo evaluating model
          mallet evaluate-topics --input ./clean-data/fine-scale/STEM-ENG/testing.mallet --evaluator ./results/fine-scale/mallet-models/STEM-ENG/$k-topic-files/$r-$k-topics-evaluator --output-prob ./results/fine-scale/mallet-models/STEM-ENG/$k-topic-files/$r-$k-topics-log-probability
        fi
      done
done
