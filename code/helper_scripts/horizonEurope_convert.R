# R code to convert horizon Europe xlsx to tsv
# Data downloaded from: 
# https://webgate.ec.europa.eu/dashboard/sense/app/98dcd94d-ca66-4ce0-865b-48ffe7f19f35/sheet/QCdc/state/analysis

library(readxl)

horizonEurope <- read_xlsx("../raw-data/fine-scale/Europe/horizon_europe.xlsx")

write.table(horizonEurope,
            "../raw-data/fine-scale/Europe/horizon_europe.tsv",
            sep = "\t",
            row.names = F)