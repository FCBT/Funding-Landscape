# this is a one-time only script - this step should be added to the script that combine texts in the future

# open files with raw text

# edit column with project ID to add research councils names
df['ProjectID'] = 'NIH' + df['ProjectId'].astype(str)