# R code to reduce columns in SNSF (Switzerland) data
# Data downloaded from: https://data.snf.ch/datasets

snf <- read.csv2("../raw-data/fine-scale/Switzerland/snf-GrantWithAbstracts.csv")

snf_reduced <- snf[,colnames(snf)[!grepl("LaySummary", colnames(snf))]]

write.csv2(snf_reduced,
           "../raw-data/fine-scale/Switzerland/snf.csv")