# this is a one-time only script - this step should be added to the script that combine texts in the future

import pandas as pd
# open files with raw text

# edit column with project ID to add research councils names
df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/USA/NIH/titles-abstracts.csv')
df['ProjectId'] = str('NIH-') + df['ProjectId'].astype(str)
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/USA/NIH/titles-abstracts.csv')


df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/USA/NSF/titles-abstracts.csv')
df['ProjectId'] = str('NSF-') + df['ProjectId'].astype(str)
df.head()
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/USA/NSF/titles-abstracts.csv')

df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/UK/UKRI/titles-abstracts.csv')
df['ProjectId'] = str('UKRI-') + df['ProjectId'].astype(str)
df.head()
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/UK/UKRI/titles-abstracts.csv')
