# R code to convert Australian nhmrc xlsx to tsv
# Data downloaded from: https://www.nhmrc.gov.au/funding/data-research/outcomes

library(readxl)

nhmrc_2013 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2013.xlsx",
                        sheet = 2,
                        skip = 8)
write.table(nhmrc_2013[,1:30],
            "../raw-data/fine-scale/Australia/nhmrc_2013.tsv",
            sep = "\t",
            row.names = F)


nhmrc_2014 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2014.xlsx",
                        sheet = 1,
                        skip = 0)
write.table(nhmrc_2014,
            "../raw-data/fine-scale/Australia/nhmrc_2014.tsv",
            sep = "\t",
            row.names = F)


nhmrc_2015 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2015.xlsx",
                        sheet = 1,
                        skip = 0)
write.table(nhmrc_2015[,1:21],
            "../raw-data/fine-scale/Australia/nhmrc_2015.tsv",
            sep = "\t",
            row.names = F)


nhmrc_2016 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2016.xlsx",
                        sheet = 1,
                        skip = 0)
write.table(nhmrc_2016[,1:21],
            "../raw-data/fine-scale/Australia/nhmrc_2016.tsv",
            sep = "\t",
            row.names = F)


nhmrc_2017 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2017.xlsx",
                        sheet = 1,
                        skip = 0)
write.table(nhmrc_2017[,1:21],
            "../raw-data/fine-scale/Australia/nhmrc_2017.tsv",
            sep = "\t",
            row.names = F)
nhmrc_2017_ <- read.csv("../raw-data/fine-scale/Australia/nhmrc_2017.tsv",
                        sep = "\t")


nhmrc_2018 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2018.xlsx",
                        sheet = 1,
                        skip = 0)
write.table(nhmrc_2018[,1:18],
            "../raw-data/fine-scale/Australia/nhmrc_2018.tsv",
            sep = "\t",
            row.names = F)


nhmrc_2019 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2019.xlsx",
                        sheet = 2,
                        skip = 0)
write.table(nhmrc_2019[,1:18],
            "../raw-data/fine-scale/Australia/nhmrc_2019.tsv",
            sep = "\t",
            row.names = F)


nhmrc_2020 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2020.xlsx",
                        sheet = 2,
                        skip = 0)
write.table(nhmrc_2020[,1:18],
            "../raw-data/fine-scale/Australia/nhmrc_2020.tsv",
            sep = "\t",
            row.names = F)


nhmrc_2021 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2021.xlsx",
                        sheet = 2,
                        skip = 0)
write.table(nhmrc_2021[,1:18],
            "../raw-data/fine-scale/Australia/nhmrc_2021.tsv",
            sep = "\t",
            row.names = F)


nhmrc_2022 <- read_xlsx("../raw-data/fine-scale/Australia/nhmrc_2022.xlsx",
                        sheet = 2,
                        skip = 0)
write.table(nhmrc_2022[,1:18],
            "../raw-data/fine-scale/Australia/nhmrc_2022.tsv",
            sep = "\t",
            row.names = F)