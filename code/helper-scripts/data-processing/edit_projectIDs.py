# this is a one-time only script - this step should be added to the script that combine texts in the future

from operator import index
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

df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/RSNZ/RSNZ_rawtext.csv')
df['ProjectId'] = str('RSNZ-') + df['ProjectId'].astype(str)
df.head()
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/RSNZ/titles-abstracts.csv')

df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/HRC/HRC_rawtext.csv')
df['ProjectId'] = str('HRC-') + df['ProjectId'].astype(str)
df.head()
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/HRC/titles-abstracts.csv')

df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/MBIE/MBIE-raw-text.csv')
# df['ProjectId'] = str('HRC-') + df['ProjectId'].astype(str)
df.head()
df.columns
df = df.drop(['Unnamed: 0'],axis=1)
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/MBIE/titles-abstracts.csv', index= False)

df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/Callaghan/Callaghan-raw-text.csv')
# df['ProjectId'] = str('HRC-') + df['ProjectId'].astype(str)
df.head()
df.columns
df = df.drop(['Unnamed: 0'],axis=1)
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/Callaghan/titles-abstracts.csv', index= False)

df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/RS/royal-society-raw-text.csv')
# df['ProjectId'] = str('HRC-') + df['ProjectId'].astype(str)
df.head()
df.columns
df = df.drop(['Unnamed: 0'],axis=1)
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/NewZealand/RS/titles-abstracts.csv', index= False)

df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/Australia/ACIAR/STEM-ACIAR-raw-text.csv', index_col=False)
df['ProjectId'] = str('ACIAR-') + df['ProjectId'].astype(str)
df.head()
df.columns
# df = df.drop(['Unnamed: 0'],axis=1)
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/Australia/ACIAR/titles-abstracts.csv', index= False)

# Autralia - ARC
df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/Australia/ARC/arc-raw-text.csv', index_col=False)
# df['ProjectId'] = str('ARC-') + df['ProjectId'].astype(str)
df.head()
df.columns
df = df.drop(['Unnamed: 0'],axis=1)
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/Australia/ARC/titles-abstracts.csv', index= False)

# Autralia 
df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/Australia/NISDRG/nisdrg-raw-text.csv', index_col=False)
df.head()
df.columns
df = df.drop(['Unnamed: 0'],axis=1)
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/Australia/NISDRG/titles-abstracts.csv', index= False)

# Ireland 
df = pd.read_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/Ireland/GOV/various-gov-raw-text.csv', index_col=False)
df.head()
# df['ProjectId'] = str('HRB-') + df['ProjectId'].astype(str)
df.columns
df = df.drop(['Unnamed: 0'],axis=1)
df.to_csv('/Users/flavia/Projects/Ongoing/Funding-Landscape/flavia/raw-data/fine-scale/Ireland/GOV/titles-abstracts.csv', index= False)
