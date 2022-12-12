# R code to format fine-scale data for upload to OneDrive
# Author: RC
# Description: For each country and funding body, splits data into meta and text
#              All other, unneccessary columns are dropped


# Tidy all data to text/metadata - single file pair per funding body
# linked by ProjectID
# Metadata: ['ProjectId', 'Country', 'CountryFundingBody', 'FundingBody','LeadInstitution', 'StartDate', 'EndDate', 'FundingAmount','FundingCurrency']
# raw-text: ["ProjectId", "TitleAbstract"]


# Australia
# arc
arc_previous <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/arc.csv")

arc_meta <- arc_previous

arc_meta$ProjectId <- paste0("ARC_", seq(1,nrow(arc_meta)), "_", arc_meta$code)
arc_meta$Country <- "Australia"
arc_meta$CountryFundingBody <- "ARC"
arc_meta$FundingBody <- "ARC"
arc_meta$LeadInstitution <- arc_meta$announcement_admin_organisation
arc_meta$StartDate <- arc_meta$project_start_date
arc_meta$EndDate <- arc_meta$anticipated_end_date
arc_meta$FundingAmount <- arc_meta$announced_funding_amount
arc_meta$FundingCurrency <- "AUD"

arc_rawtxt <- arc_meta[,c("ProjectId", "grant_summary")]
colnames(arc_rawtxt) <- c("ProjectId", "TitleAbstract")

write.csv(arc_meta[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                      "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                      "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/arc-raw-metadata.csv")
write.csv(arc_rawtxt,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/arc-raw-text.csv")

rm(arc_previous, arc_meta, arc_rawtxt)

# dese
dese_meta <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/dese.csv")
head(dese_meta)

dese_meta$ProjectId <- paste0("DESE_", seq(1,nrow(dese_meta)), "_", dese_meta$code)
dese_meta$Country <- "Australia"
dese_meta$CountryFundingBody <- "DESE"
dese_meta$FundingBody <- "DESE"
dese_meta$LeadInstitution <- NA
dese_meta$StartDate <- dese_meta$project_start_date
dese_meta$EndDate <- dese_meta$anticipated_end_date
dese_meta$FundingAmount <- dese_meta$grant_value
dese_meta$FundingCurrency <- "AUD"

dese_meta$TitleAbstract <- paste(dese_meta$grant_title,
                                 dese_meta$grant_summary)
dese_meta$TitleAbstract[1:2]
dese_rawtxt <- dese_meta[,c("ProjectId", "TitleAbstract")]
# colnames(dese_rawtxt) <- c("ProjectId", "TitleAbstract")

write.csv(dese_meta[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                       "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                       "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/dese-raw-metadata.csv")
write.csv(dese_rawtxt,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/dese-raw-text.csv")

rm(dese_meta, dese_rawtxt)

# dod
dod_meta <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/dod.csv")
# head(dod_meta)
# colnames(dod_meta)


dod_meta$ProjectId <- paste0("DOD_", seq(1,nrow(dod_meta)), "_", dod_meta$code)
dod_meta$Country <- "Australia"
dod_meta$CountryFundingBody <- "DOD"
dod_meta$FundingBody <- "DOD"
dod_meta$LeadInstitution <- NA
dod_meta$StartDate <- dod_meta$project_start_date
dod_meta$EndDate <- dod_meta$anticipated_end_date
dod_meta$FundingAmount <- dod_meta$grant_value
dod_meta$FundingCurrency <- "AUD"

dod_meta$TitleAbstract <- paste(dod_meta$grant_title,
                                dod_meta$grant_summary)
# dod_meta$TitleAbstract[1:2]
dod_rawtxt <- dod_meta[,c("ProjectId", "TitleAbstract")]
# colnames(dese_rawtxt) <- c("ProjectId", "TitleAbstract")

write.csv(dod_meta[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                      "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                      "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/dod-raw-metadata.csv")
write.csv(dod_rawtxt,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/dod-raw-text.csv")

rm(dod_meta, dod_rawtxt)


# nisdrg
nisdrg_meta <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nisdrg.csv")
head(nisdrg_meta)
colnames(nisdrg_meta)


nisdrg_meta$ProjectId <- paste0("NISDRG_", seq(1,nrow(nisdrg_meta)), "_", nisdrg_meta$code)
nisdrg_meta$Country <- "Australia"
nisdrg_meta$CountryFundingBody <- "NISDRG"
nisdrg_meta$FundingBody <- "NISDRG"
nisdrg_meta$LeadInstitution <- NA
nisdrg_meta$StartDate <- nisdrg_meta$project_start_date
nisdrg_meta$EndDate <- nisdrg_meta$anticipated_end_date
nisdrg_meta$FundingAmount <- nisdrg_meta$grant_value
nisdrg_meta$FundingCurrency <- "AUD"

nisdrg_meta$TitleAbstract <- paste(nisdrg_meta$grant_title,
                                   nisdrg_meta$grant_summary)
nisdrg_meta$TitleAbstract[1:2]
nisdrg_rawtxt <- nisdrg_meta[,c("ProjectId", "TitleAbstract")]
# colnames(dese_rawtxt) <- c("ProjectId", "TitleAbstract")

write.csv(nisdrg_meta[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                         "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                         "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nisdrg-raw-metadata.csv")
write.csv(nisdrg_rawtxt,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nisdrg-raw-text.csv")

rm(nisdrg_meta, nisdrg_rawtxt)


# arena
arena_meta <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/arena_rm_disclaimer.csv")
head(arena_meta)
colnames(arena_meta)


arena_meta$ProjectId <- paste0("ARENA_", seq(1,nrow(arena_meta)))
arena_meta$Country <- "Australia"
arena_meta$CountryFundingBody <- "ARENA"
arena_meta$FundingBody <- "ARENA"
arena_meta$LeadInstitution <- arena_meta$Lead.organisation
# Format all dates as YYYY-MM-DD
arena_meta$StartDate <- as.character(lubridate::as_date(arena_meta$Start.date,
                                                        format="%d/%m/%Y"))
arena_meta$EndDate <- NA

arena_meta$FundingAmount <- gsub("\\$", "", arena_meta$Arena.funding.provided)
# Sort m/k
arena_meta$funding_mult <- 1
arena_meta$funding_mult[grepl("m", arena_meta$FundingAmount)] <- 1000000
arena_meta$funding_mult[grepl("k", arena_meta$FundingAmount)] <- 1000
arena_meta$FundingAmount <- as.numeric(gsub("[a-z]", "", arena_meta$FundingAmount)) * arena_meta$funding_mult

arena_meta$FundingCurrency <- "AUD"

arena_meta$TitleAbstract <- paste(arena_meta$Project)
arena_meta$TitleAbstract[1:2]
arena_rawtxt <- arena_meta[,c("ProjectId", "TitleAbstract")]
# colnames(dese_rawtxt) <- c("ProjectId", "TitleAbstract")

write.csv(arena_meta[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                        "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                        "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/arena-raw-metadata.csv")
write.csv(arena_rawtxt,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/arena-raw-text.csv")

rm(arena_meta, arena_rawtxt)


# mrff to csv
mrff_meta <- readxl::read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/mrff-20-september-2022.xlsx",
                               sheet = 2)
head(mrff_meta)
colnames(mrff_meta)

mrff_meta$ProjectId <- paste0("MRFF_", seq(1,nrow(mrff_meta)))
mrff_meta$Country <- "Australia"
mrff_meta$CountryFundingBody <- "MRFF"
mrff_meta$FundingBody <- "MRFF"
mrff_meta$LeadInstitution <- mrff_meta$Organisation
mrff_meta$StartDate <- sapply(strsplit(mrff_meta$`Grant Opportunity`, " "), `[`, 1)
mrff_meta$EndDate <- NA
mrff_meta$FundingAmount <- mrff_meta$`Total Funding`
mrff_meta$FundingCurrency <- "AUD"

mrff_meta$TitleAbstract <- paste(mrff_meta$`Project Name`,
                                 mrff_meta$`Project Summary`)
mrff_meta$TitleAbstract[1:2]
mrff_rawtxt <- mrff_meta[,c("ProjectId", "TitleAbstract")]
# colnames(dese_rawtxt) <- c("ProjectId", "TitleAbstract")

write.csv(mrff_meta[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                       "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                       "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/mrff-raw-metadata.csv")
write.csv(mrff_rawtxt,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/mrff-raw-text.csv")

rm(mrff_meta, mrff_rawtxt)


# Combine nhmrc years into one...
nhmrc_f_ls <- list.files("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia",
                         pattern= "tsv", full.names = T)


nhmrc_meta_ls <- lapply(nhmrc_f_ls, function(x){read.csv(x, sep = "\t")})

# DO PER YEAR - VARIABLE STRUCTURE...
test <- read.csv(nhmrc_f_ls[1], sep = "\t")
test[1055,]

# TODO: issue with row 1056 in 2013 (" in media summary)
# Fix projects with NA for APP.ID, just use row N?


# 2013
# Issue with tsv...
nhmrc_meta_2013_ <- readxl::read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2013.xlsx",
                                      sheet = 2,
                                      skip = 8)

nhmrc_meta_2013_$ProjectId <- paste0("NHMRC_2013_", seq(1,nrow(nhmrc_meta_2013_)), "_",
                                     nhmrc_meta_2013_$`APP ID`)
nhmrc_meta_2013_$Country <- "Australia"
nhmrc_meta_2013_$CountryFundingBody <- "NHMRC"
nhmrc_meta_2013_$FundingBody <- nhmrc_meta_2013_$`Funding Source`
nhmrc_meta_2013_$LeadInstitution <- nhmrc_meta_2013_$`APP ADMIN INSTITUTION`
nhmrc_meta_2013_$StartDate <- as.character(nhmrc_meta_2013_$`Start Year`)
nhmrc_meta_2013_$EndDate <- NA
nhmrc_meta_2013_$FundingAmount <- nhmrc_meta_2013_$`Final Budget - Rounded`
nhmrc_meta_2013_$FundingCurrency <- "AUD"

nhmrc_meta_2013_$Abs <- nhmrc_meta_2013_$`MEDIA SUMMARY`
nhmrc_meta_2013_$Abs[is.na(nhmrc_meta_2013_$Abs)] <- ""
nhmrc_meta_2013_$Abs[nhmrc_meta_2013_$Abs == "Not Applicable"] <- ""

sum(nhmrc_meta_2013_$`MEDIA SUMMARY` == "N/A", na.rm = T)

nhmrc_meta_2013_$Abs[grepl("\"", nhmrc_meta_2013_$Abs)]


nhmrc_meta_2013_$TitleAbstract <- paste(nhmrc_meta_2013_$`SCIENTIFIC TITLE`,
                                        nhmrc_meta_2013_$Abs)

nhmrc_meta_2013_$TitleAbstract[100:1002]
nhmrc_rawtxt_2013_ <- nhmrc_meta_2013_[,c("ProjectId", "TitleAbstract")]

sum(is.na(nhmrc_meta_2013_$`APP ID`))

nhmrc_meta_2013_[is.na(nhmrc_meta_2013_$`APP ID`),]

write.csv(nhmrc_meta_2013_,
          "~/Documents/nhmrc_2013_met_test.csv")
test <- read.csv("~/Documents/nhmrc_2013_met_test.csv")
test[1057,]
# 
# nhmrc_meta_2013 <- nhmrc_meta_ls[[1]]
# nhmrc_meta_2013$ProjectId <- paste0("NHMRC_2013_", nhmrc_meta_2013$APP.ID)
# nhmrc_meta_2013$Country <- "Australia"
# nhmrc_meta_2013$CountryFundingBody <- "NHMRC"
# nhmrc_meta_2013$FundingBody <- nhmrc_meta_2013$Funding.Source
# nhmrc_meta_2013$LeadInstitution <- nhmrc_meta_2013$APP.ADMIN.INSTITUTION
# nhmrc_meta_2013$StartDate <- as.character(nhmrc_meta_2013$Start.Year)
# nhmrc_meta_2013$EndDate <- NA
# nhmrc_meta_2013$FundingAmount <- nhmrc_meta_2013$Final.Budget...Rounded
# nhmrc_meta_2013$FundingCurrency <- "AUD"
# 
# nhmrc_meta_2013$TitleAbstract <- nhmrc_meta_2013$SCIENTIFIC.TITLE
# 
# nhmrc_meta_2013$TitleAbstract[1:2]
# nhmrc_rawtxt_2013 <- nhmrc_meta_2013[,c("ProjectId", "TitleAbstract")]
# 
# unique(nhmrc_meta_2013$Start.Year)


# 2014
nhmrc_2014 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2014.xlsx",
                        sheet = 1,
                        skip = 0)

nhmrc_meta_2014 <- nhmrc_meta_ls[[2]]
head(nhmrc_meta_2014)
colnames(nhmrc_meta_2014)
nhmrc_meta_2014$ProjectId <- paste0("NHMRC_2014_", seq(1,nrow(nhmrc_meta_2014)), "_", nhmrc_meta_2014$APP.ID)
nhmrc_meta_2014$Country <- "Australia"
nhmrc_meta_2014$CountryFundingBody <- "NHMRC"
nhmrc_meta_2014$FundingBody <- "NHMRC"
nhmrc_meta_2014$LeadInstitution <- nhmrc_meta_2014$ADMIN_.INSTITUTION

nhmrc_meta_2014$StartDate <- 2020
for (yr in c(2020, 2019, 2018, 2017, 2016, 2015, 2014)){
  tmp_col_nm <- paste0("X", yr)
  nhmrc_meta_2014$StartDate[!is.na(nhmrc_meta_2014[,tmp_col_nm])] <- as.character(yr)
}

nhmrc_meta_2014$EndDate <- 2014
for (yr in c(2014, 2015, 2016, 2017, 2018, 2019, 2020)){
  tmp_col_nm <- paste0("X", yr)
  nhmrc_meta_2014$EndDate[!is.na(nhmrc_meta_2014[,tmp_col_nm])] <- as.character(yr)
}

nhmrc_meta_2014$FundingAmount <- nhmrc_meta_2014$TOTAL
nhmrc_meta_2014$FundingCurrency <- "AUD"

nhmrc_meta_2014$TitleAbstract <- nhmrc_meta_2014$SIMPLIFIED.TITLE

nhmrc_meta_2014$TitleAbstract[1:2]
nhmrc_rawtxt_2014 <- nhmrc_meta_2014[,c("ProjectId", "TitleAbstract")]


rm(nhmrc_2014)

# 2015
nhmrc_2015 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2015.xlsx",
                        sheet = 1,
                        skip = 0)
rm(nhmrc_2015)
nhmrc_meta_2015 <- nhmrc_meta_ls[[3]]
head(nhmrc_meta_2015)
colnames(nhmrc_meta_2015)
nhmrc_meta_2015$ProjectId <- paste0("NHMRC_2015_", seq(1,nrow(nhmrc_meta_2015)), "_", nhmrc_meta_2015$APP.ID)
nhmrc_meta_2015$Country <- "Australia"
nhmrc_meta_2015$CountryFundingBody <- "NHMRC"
nhmrc_meta_2015$FundingBody <- "NHMRC"
nhmrc_meta_2015$LeadInstitution <- nhmrc_meta_2015$Admin.Institution

nhmrc_meta_2015$StartDate <- nhmrc_meta_2015$Start.Yr
nhmrc_meta_2015$EndDate <- nhmrc_meta_2015$End.Yr

nhmrc_meta_2015$FundingAmount <- nhmrc_meta_2015$Total
nhmrc_meta_2015$FundingCurrency <- "AUD"

nhmrc_meta_2015$Abs <- nhmrc_meta_2015$Plain.Description
nhmrc_meta_2015$Abs[is.na(nhmrc_meta_2015$Abs)] <- ""
nhmrc_meta_2015$Abs[nhmrc_meta_2015$Abs == "Not Applicable"] <- ""
nhmrc_meta_2015$Abs[nhmrc_meta_2015$Abs == "N/A"] <- ""

# nhmrc_meta_2015$Abs[nhmrc_meta_2015$Plain.Description == "N/A"] 
# nhmrc_meta_2015$Abs[is.na(nhmrc_meta_2015$Plain.Description)]
# sum(is.na(nhmrc_meta_2015$Plain.Description))
# 
# sum(nhmrc_meta_2015$Plain.Description == "N/A")

nhmrc_meta_2015$TitleAbstract <- paste(nhmrc_meta_2015$Grant.Title,
                                       nhmrc_meta_2015$Abs)

nhmrc_meta_2015$TitleAbstract[1:2]
nhmrc_rawtxt_2015 <- nhmrc_meta_2015[,c("ProjectId", "TitleAbstract")]


# 2016
nhmrc_2016 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2016.xlsx",
                        sheet = 1,
                        skip = 0)
rm(nhmrc_2016)
nhmrc_meta_2016 <- nhmrc_meta_ls[[4]]
head(nhmrc_meta_2016)
colnames(nhmrc_meta_2016)
nhmrc_meta_2016$ProjectId <- paste0("NHMRC_2016_", seq(1,nrow(nhmrc_meta_2016)), "_", nhmrc_meta_2016$APP.ID)
nhmrc_meta_2016$Country <- "Australia"
nhmrc_meta_2016$CountryFundingBody <- "NHMRC"
nhmrc_meta_2016$FundingBody <- "NHMRC"
nhmrc_meta_2016$LeadInstitution <- nhmrc_meta_2016$Admin.Institution

nhmrc_meta_2016$StartDate <- nhmrc_meta_2016$Start.Yr
nhmrc_meta_2016$EndDate <- nhmrc_meta_2016$End.Yr

nhmrc_meta_2016$FundingAmount <- nhmrc_meta_2016$Total
nhmrc_meta_2016$FundingCurrency <- "AUD"

nhmrc_meta_2016$Abs <- nhmrc_meta_2016$Plain.Description
nhmrc_meta_2016$Abs[is.na(nhmrc_meta_2016$Abs)] <- ""
nhmrc_meta_2016$Abs[nhmrc_meta_2016$Abs == "Not Applicable"] <- ""
nhmrc_meta_2016$Abs[nhmrc_meta_2016$Abs == "N/A"] <- ""

# nhmrc_meta_2016$Abs[nhmrc_meta_2016$Plain.Description == "N/A"] 
# nhmrc_meta_2016$Abs[nhmrc_meta_2016$Plain.Description == "Not Applicable"] 
# nhmrc_meta_2016$Abs[is.na(nhmrc_meta_2016$Plain.Description)]
# sum(is.na(nhmrc_meta_2016$Plain.Description))
# 
# sum(nhmrc_meta_2015$Plain.Description == "N/A")

nhmrc_meta_2016$TitleAbstract <- paste(nhmrc_meta_2016$Grant.Title,
                                       nhmrc_meta_2016$Abs)

nhmrc_meta_2016$TitleAbstract[1:2]
nhmrc_rawtxt_2016 <- nhmrc_meta_2016[,c("ProjectId", "TitleAbstract")]

unique(nhmrc_meta_2016$Start.Yr)
unique(nhmrc_meta_2016$End.Yr)

# 2017
nhmrc_2017 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2017.xlsx",
                        sheet = 1,
                        skip = 0)
rm(nhmrc_2017)
nhmrc_meta_2017 <- nhmrc_meta_ls[[5]]
head(nhmrc_meta_2017)
colnames(nhmrc_meta_2017)
nhmrc_meta_2017$ProjectId <- paste0("NHMRC_2017_", seq(1,nrow(nhmrc_meta_2017)), "_",nhmrc_meta_2017$APP.ID)
nhmrc_meta_2017$Country <- "Australia"
nhmrc_meta_2017$CountryFundingBody <- "NHMRC"
nhmrc_meta_2017$FundingBody <- "NHMRC"
nhmrc_meta_2017$LeadInstitution <- nhmrc_meta_2017$Admin.Institution

nhmrc_meta_2017$StartDate <- as.character(nhmrc_meta_2017$Start.Yr)
nhmrc_meta_2017$EndDate <- as.character(nhmrc_meta_2017$End.Yr)

nhmrc_meta_2017$FundingAmount <- nhmrc_meta_2017$Total
nhmrc_meta_2017$FundingCurrency <- "AUD"

nhmrc_meta_2017$Abs <- nhmrc_meta_2017$Plain.Description
nhmrc_meta_2017$Abs[is.na(nhmrc_meta_2017$Abs)] <- ""
nhmrc_meta_2017$Abs[nhmrc_meta_2017$Abs == "Not Applicable"] <- ""
nhmrc_meta_2017$Abs[nhmrc_meta_2017$Abs == "N/A"] <- ""

# nhmrc_meta_2017$Abs[nhmrc_meta_2017$Plain.Description == "N/A"] 
# nhmrc_meta_2017$Abs[nhmrc_meta_2017$Plain.Description == "Not Applicable"] 
# nhmrc_meta_2017$Abs[is.na(nhmrc_meta_2017$Plain.Description)]

nhmrc_meta_2017$TitleAbstract <- paste(nhmrc_meta_2017$Grant.Title,
                                       nhmrc_meta_2017$Abs)

nhmrc_meta_2017$TitleAbstract[1:2]
nhmrc_rawtxt_2017 <- nhmrc_meta_2017[,c("ProjectId", "TitleAbstract")]

unique(nhmrc_meta_2017$StartDate)
unique(nhmrc_meta_2017$EndDate)

# 2018
nhmrc_2018 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2018.xlsx",
                        sheet = 1,
                        skip = 0)
rm(nhmrc_2018)

nhmrc_meta_2018 <- nhmrc_meta_ls[[6]]
head(nhmrc_meta_2018)
colnames(nhmrc_meta_2018)
nhmrc_meta_2018$ProjectId <- paste0("NHMRC_2018_", seq(1,nrow(nhmrc_meta_2018)), "_",nhmrc_meta_2018$APP.ID)
nhmrc_meta_2018$Country <- "Australia"
nhmrc_meta_2018$CountryFundingBody <- "NHMRC"
nhmrc_meta_2018$FundingBody <- "NHMRC"
nhmrc_meta_2018$LeadInstitution <- nhmrc_meta_2018$Admin.Institution

nhmrc_meta_2018$StartDate <- "2018"
nhmrc_meta_2018$EndDate <- NA

nhmrc_meta_2018$FundingAmount <- nhmrc_meta_2018$Total
nhmrc_meta_2018$FundingCurrency <- "AUD"

nhmrc_meta_2018$Abs <- nhmrc_meta_2018$Plain.Description
nhmrc_meta_2018$Abs[is.na(nhmrc_meta_2018$Abs)] <- ""
nhmrc_meta_2018$Abs[nhmrc_meta_2018$Abs == "Not Applicable"] <- ""
nhmrc_meta_2018$Abs[nhmrc_meta_2018$Abs == "N/A"] <- ""

nhmrc_meta_2018$Abs[nhmrc_meta_2018$Plain.Description == "N/A"]
nhmrc_meta_2018$Abs[nhmrc_meta_2018$Plain.Description == "Not Applicable"]
nhmrc_meta_2018$Abs[is.na(nhmrc_meta_2018$Plain.Description)]

nhmrc_meta_2018$TitleAbstract <- paste(nhmrc_meta_2018$Grant.Title,
                                       nhmrc_meta_2018$Abs)

nhmrc_meta_2018$TitleAbstract[1:2]
nhmrc_rawtxt_2018 <- nhmrc_meta_2018[,c("ProjectId", "TitleAbstract")]


# 2019
nhmrc_2019 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2019.xlsx",
                        sheet = 2,
                        skip = 0)
rm(nhmrc_2019)

nhmrc_meta_2019 <- nhmrc_meta_ls[[7]]
head(nhmrc_meta_2019)
colnames(nhmrc_meta_2019)
nhmrc_meta_2019$ProjectId <- paste0("NHMRC_2019_", seq(1,nrow(nhmrc_meta_2019)), "_", nhmrc_meta_2019$APP.ID)
nhmrc_meta_2019$Country <- "Australia"
nhmrc_meta_2019$CountryFundingBody <- "NHMRC"
nhmrc_meta_2019$FundingBody <- "NHMRC"
nhmrc_meta_2019$LeadInstitution <- nhmrc_meta_2019$Admin.Institution

nhmrc_meta_2019$StartDate <- "2019"
nhmrc_meta_2019$EndDate <- NA

nhmrc_meta_2019$FundingAmount <- nhmrc_meta_2019$Total
nhmrc_meta_2019$FundingCurrency <- "AUD"

nhmrc_meta_2019$Abs <- nhmrc_meta_2019$Plain.Description
nhmrc_meta_2019$Abs[is.na(nhmrc_meta_2019$Abs)] <- ""
nhmrc_meta_2019$Abs[nhmrc_meta_2019$Abs == "Not Applicable"] <- ""
nhmrc_meta_2019$Abs[nhmrc_meta_2019$Abs == "N/A"] <- ""

nhmrc_meta_2019$Abs[nhmrc_meta_2019$Plain.Description == "N/A"]
nhmrc_meta_2019$Abs[nhmrc_meta_2019$Plain.Description == "Not Applicable"]
nhmrc_meta_2019$Abs[is.na(nhmrc_meta_2019$Plain.Description)]

nhmrc_meta_2019$TitleAbstract <- paste(nhmrc_meta_2019$Grant.Title,
                                       nhmrc_meta_2019$Abs)
# nhmrc_meta_2019$TitleAbstract <- paste(nhmrc_meta_2019$Grant.Title,
#                                        nhmrc_meta_2019$Plain.Description)

nhmrc_meta_2019$TitleAbstract[1:2]
nhmrc_rawtxt_2019 <- nhmrc_meta_2019[,c("ProjectId", "TitleAbstract")]


# 2020
nhmrc_2020 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2020.xlsx",
                        sheet = 2,
                        skip = 0)
rm(nhmrc_2020)


nhmrc_meta_2020 <- nhmrc_meta_ls[[8]]
head(nhmrc_meta_2020)
colnames(nhmrc_meta_2020)
nhmrc_meta_2020$ProjectId <- paste0("NHMRC_2020_", seq(1,nrow(nhmrc_meta_2020)), "_", nhmrc_meta_2020$APP.ID)
nhmrc_meta_2020$Country <- "Australia"
nhmrc_meta_2020$CountryFundingBody <- "NHMRC"
nhmrc_meta_2020$FundingBody <- "NHMRC"
nhmrc_meta_2020$LeadInstitution <- nhmrc_meta_2020$Admin.Institution

nhmrc_meta_2020$StartDate <- "2020"
nhmrc_meta_2020$EndDate <- NA

nhmrc_meta_2020$FundingAmount <- nhmrc_meta_2020$Total
nhmrc_meta_2020$FundingCurrency <- "AUD"

nhmrc_meta_2020$Abs <- nhmrc_meta_2020$Plain.Description
nhmrc_meta_2020$Abs[is.na(nhmrc_meta_2020$Abs)] <- ""
nhmrc_meta_2020$Abs[nhmrc_meta_2020$Abs == "Not Applicable"] <- ""
nhmrc_meta_2020$Abs[nhmrc_meta_2020$Abs == "N/A"] <- ""

nhmrc_meta_2020$Abs[nhmrc_meta_2020$Plain.Description == "N/A"]
nhmrc_meta_2020$Abs[nhmrc_meta_2020$Plain.Description == "Not Applicable"]
nhmrc_meta_2020$Abs[is.na(nhmrc_meta_2020$Plain.Description)]

nhmrc_meta_2020$TitleAbstract <- paste(nhmrc_meta_2020$Grant.Title,
                                       nhmrc_meta_2020$Abs)
# nhmrc_meta_2020$TitleAbstract <- paste(nhmrc_meta_2020$Grant.Title,
#                                        nhmrc_meta_2020$Plain.Description)

nhmrc_meta_2020$TitleAbstract[1:2]
nhmrc_rawtxt_2020 <- nhmrc_meta_2020[,c("ProjectId", "TitleAbstract")]


# 2021
nhmrc_2021 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2021.xlsx",
                        sheet = 2,
                        skip = 0)
rm(nhmrc_2021)

nhmrc_meta_2021 <- nhmrc_meta_ls[[9]]
head(nhmrc_meta_2021)
colnames(nhmrc_meta_2021)
nhmrc_meta_2021$ProjectId <- paste0("NHMRC_2021_", seq(1,nrow(nhmrc_meta_2021)), "_", nhmrc_meta_2021$APP.ID)
nhmrc_meta_2021$Country <- "Australia"
nhmrc_meta_2021$CountryFundingBody <- "NHMRC"
nhmrc_meta_2021$FundingBody <- "NHMRC"
nhmrc_meta_2021$LeadInstitution <- nhmrc_meta_2021$Admin.Institution

nhmrc_meta_2021$StartDate <- "2021"
nhmrc_meta_2021$EndDate <- NA

nhmrc_meta_2021$FundingAmount <- nhmrc_meta_2021$Total
nhmrc_meta_2021$FundingCurrency <- "AUD"

nhmrc_meta_2021$Abs <- nhmrc_meta_2021$Plain.Description
nhmrc_meta_2021$Abs[is.na(nhmrc_meta_2021$Abs)] <- ""
nhmrc_meta_2021$Abs[nhmrc_meta_2021$Abs == "Not Applicable"] <- ""
nhmrc_meta_2021$Abs[nhmrc_meta_2021$Abs == "N/A"] <- ""

nhmrc_meta_2021$Abs[nhmrc_meta_2021$Plain.Description == "N/A"]
nhmrc_meta_2021$Abs[nhmrc_meta_2021$Plain.Description == "Not Applicable"]
nhmrc_meta_2021$Abs[is.na(nhmrc_meta_2021$Plain.Description)]

nhmrc_meta_2021$TitleAbstract <- paste(nhmrc_meta_2021$Grant.Title,
                                       nhmrc_meta_2021$Abs)
# nhmrc_meta_2021$TitleAbstract <- paste(nhmrc_meta_2021$Grant.Title,
#                                        nhmrc_meta_2021$Plain.Description)

nhmrc_meta_2021$TitleAbstract[1:2]
nhmrc_rawtxt_2021 <- nhmrc_meta_2021[,c("ProjectId", "TitleAbstract")]

# 2022
nhmrc_2022 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc_2022.xlsx",
                        sheet = 2,
                        skip = 0)
rm(nhmrc_2022)

nhmrc_meta_2022 <- nhmrc_meta_ls[[10]]
head(nhmrc_meta_2022)
colnames(nhmrc_meta_2022)
nhmrc_meta_2022$ProjectId <- paste0("NHMRC_2022_", seq(1,nrow(nhmrc_meta_2022)), "_", nhmrc_meta_2022$APP.ID)
nhmrc_meta_2022$Country <- "Australia"
nhmrc_meta_2022$CountryFundingBody <- "NHMRC"
nhmrc_meta_2022$FundingBody <- "NHMRC"
nhmrc_meta_2022$LeadInstitution <- nhmrc_meta_2022$Admin.Institution

nhmrc_meta_2022$StartDate <- "2022"
nhmrc_meta_2022$EndDate <- NA

nhmrc_meta_2022$FundingAmount <- nhmrc_meta_2022$Total
nhmrc_meta_2022$FundingCurrency <- "AUD"

nhmrc_meta_2022$Abs <- nhmrc_meta_2022$Plain.Description
nhmrc_meta_2022$Abs[is.na(nhmrc_meta_2022$Abs)] <- ""
nhmrc_meta_2022$Abs[nhmrc_meta_2022$Abs == "Not Applicable"] <- ""
nhmrc_meta_2022$Abs[nhmrc_meta_2022$Abs == "N/A"] <- ""

nhmrc_meta_2022$Abs[nhmrc_meta_2022$Plain.Description == "N/A"]
nhmrc_meta_2022$Abs[nhmrc_meta_2022$Plain.Description == "Not Applicable"]
nhmrc_meta_2022$Abs[is.na(nhmrc_meta_2022$Plain.Description)]

nhmrc_meta_2022$TitleAbstract <- paste(nhmrc_meta_2022$Grant.Title,
                                       nhmrc_meta_2022$Abs)
# nhmrc_meta_2022$TitleAbstract <- paste(nhmrc_meta_2022$Grant.Title,
#                                        nhmrc_meta_2022$Plain.Description)

nhmrc_meta_2022$TitleAbstract[1:2]
nhmrc_rawtxt_2022 <- nhmrc_meta_2022[,c("ProjectId", "TitleAbstract")]


meta_cols <- c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
               "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
               "FundingCurrency")

nhmrc_meta <- dplyr::bind_rows(#nhmrc_meta_2013[,meta_cols],
  nhmrc_meta_2013_[,meta_cols],
  nhmrc_meta_2014[,meta_cols],
  nhmrc_meta_2015[,meta_cols],
  nhmrc_meta_2016[,meta_cols],
  nhmrc_meta_2017[,meta_cols],
  nhmrc_meta_2018[,meta_cols],
  nhmrc_meta_2019[,meta_cols],
  nhmrc_meta_2020[,meta_cols],
  nhmrc_meta_2021[,meta_cols],
  nhmrc_meta_2022[,meta_cols])

write.csv(nhmrc_meta,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc-raw-metadata.csv")
nhmrc_rawtxt <- dplyr::bind_rows(#nhmrc_rawtxt_2013,
  nhmrc_rawtxt_2013_,
  nhmrc_rawtxt_2014,
  nhmrc_rawtxt_2015,
  nhmrc_rawtxt_2016,
  nhmrc_rawtxt_2017,
  nhmrc_rawtxt_2018,
  nhmrc_rawtxt_2019,
  nhmrc_rawtxt_2020,
  nhmrc_rawtxt_2021,
  nhmrc_rawtxt_2022)
write.csv(nhmrc_rawtxt,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/nhmrc-raw-text.csv")

head(nhmrc_meta_2013_$ProjectId)
head(nhmrc_meta_2014$ProjectId)
head(nhmrc_meta_2015$ProjectId)
head(nhmrc_meta_2016$ProjectId)
head(nhmrc_meta_2017$ProjectId)
head(nhmrc_meta_2018$ProjectId)
head(nhmrc_meta_2019$ProjectId)
head(nhmrc_meta_2020$ProjectId)
head(nhmrc_meta_2021$ProjectId)
head(nhmrc_meta_2022$ProjectId)

head(nhmrc_rawtxt_2013_$ProjectId)
head(nhmrc_rawtxt_2014$ProjectId)
head(nhmrc_rawtxt_2015$ProjectId)
head(nhmrc_rawtxt_2016$ProjectId)
head(nhmrc_rawtxt_2017$ProjectId)
head(nhmrc_rawtxt_2018$ProjectId)
head(nhmrc_rawtxt_2019$ProjectId)
head(nhmrc_rawtxt_2020$ProjectId)
head(nhmrc_rawtxt_2021$ProjectId)
head(nhmrc_rawtxt_2022$ProjectId)

head(nhmrc_rawtxt$ProjectId)
tail(nhmrc_rawtxt$ProjectId)

# colnames(dese_rawtxt) <- c("ProjectId", "TitleAbstract")

# write.csv(nhmrc_meta_2013[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
#                        "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
#                        "FundingCurrency")],
#           "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/mrff-raw-metadata.csv")
# write.csv(nhmrc_rawtxt_2013,
#           "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/mrff-raw-text.csv")

# rm(mrff_meta, mrff_rawtxt)

nhmrc_meta_2013[nhmrc_meta_2013$APP.ID == 1073366,]

# Note: Some scientific titles include the below
""
"IRIISS - 2013"
"2013 Equipment Grant"
"Uncoupled Research Fellowship"
"Research Fellowship"




# Grant connect...
rm(list = ls())
aus_gc <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/GrantConnect-Grant-Award-List_20220929_233006.xlsx",
                    sheet = 1,
                    skip = 18)

unique(aus_gc$Agency)
aus_gc <- subset(aus_gc, Agency != "Australian Research Council")
aus_gc <- subset(aus_gc, Agency != "National Health and Medical Research Council (NHMRC)")

aus_gc
as.character(aus_gc$`Start Date`)[1]

aus_gc$Agency
min(aus_gc$`Start Date`)

# Just get all info in one for now...
aus_gc$ProjectId <- paste0("GOV_", seq(1,nrow(aus_gc)))
aus_gc$Country <- "Australia"
aus_gc$CountryFundingBody <- aus_gc$Agency
aus_gc$FundingBody <- aus_gc$Agency
aus_gc$LeadInstitution <- NA
aus_gc$StartDate <- as.character(aus_gc$`Start Date`)
aus_gc$EndDate <- as.character(aus_gc$`End Date`)
aus_gc$FundingAmount <- aus_gc$`Value (AUD)`
aus_gc$FundingCurrency <- "AUD"
aus_gc$TitleAbstract <- aus_gc$`Grant Activity`

write.csv(aus_gc[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                    "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                    "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/gov-raw-metadata.csv")
write.csv(aus_gc[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Australia/gov-raw-text.csv")
# [,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
#     "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
#     "FundingCurrency")]

aus_gc_non_rep <- aus_gc[!(duplicated(aus_gc$`Grant Activity`) | 
                             duplicated(aus_gc$`Grant Activity`, fromLast=TRUE)),]
aus_gc_non_rep <- subset(aus_gc_non_rep,
                         Category != "Commemorative")
aus_gc_non_rep <- subset(aus_gc_non_rep,
                         Category != "Humanities, Arts and Social Sciences (HASS) Research")

subset(aus_gc, Agency == "Department of Agriculture, Fisheries and Forestry")
subset(aus_gc, Agency == "National Health and Medical Research Council (NHMRC)")
View(subset(aus_gc_non_rep, Agency == "Department of Defence"))

length(unique(aus_gc$`Grant Activity`))
# Hmm, most are names of grant, not project itself...
# But some are project....
rm(aus_gc, aus_gc_non_rep)


# NZ
# who-got funded to csv - split out per research council?
# drop royal soc...
nz_gov <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/who-got-funded-NZ.xlsx",
                    sheet = 2,
                    skip = 0)
# mbie

nz_gov$ProjectId <- paste0("MBIE_", seq(1,nrow(nz_gov)), "_", nz_gov$`Contract ID`)
nz_gov$Country <- "New Zealand"
nz_gov$CountryFundingBody <- "MBIE"
nz_gov$FundingBody <- "MBIE"
nz_gov$LeadInstitution <- nz_gov$Organisation
nz_gov$StartDate <- as.character(nz_gov$`Start Date`)
nz_gov$EndDate <- as.character(nz_gov$`End Date`)
nz_gov$FundingAmount <- nz_gov$`Total Allocation (GST excl)`
nz_gov$FundingCurrency <- "NZD"

nz_gov$TitleAbstract <- paste(nz_gov$`Project Title`,
                              nz_gov$`Public Statement`)

write.csv(nz_gov[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                    "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                    "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/mbie-raw-metadata.csv")
write.csv(nz_gov[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/mbie-raw-text.csv")
rm(nz_gov)

# Callaghan
callaghan <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/callaghan-grant-recipients.csv")

callaghan$ProjectId <- paste0("Callaghan_", seq(1,nrow(callaghan)), "_", callaghan$Contract.ID)
callaghan$Country <- "New Zealand"
callaghan$CountryFundingBody <- "Callaghan-Innovation"
callaghan$FundingBody <- "Callaghan-Innovation"
callaghan$LeadInstitution <- callaghan$Organisation



callaghan$StartDate <- as.character(lubridate::as_date(callaghan$Start.Date,
                                                       format = "%d-%m-%Y"))
callaghan$EndDate <- as.character(lubridate::as_date(callaghan$End.Dates,
                                                     format = "%d-%m-%Y"))

callaghan$FundingAmount <- as.numeric(callaghan$Value)
callaghan$FundingCurrency <- "NZD"

callaghan[is.na(callaghan$FundingAmount), c("Grant.Type") ]

callaghan$TitleAbstract <- callaghan$Project.Title

write.csv(callaghan[,c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
                       "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
                       "FundingCurrency")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/callaghan-raw-metadata.csv")
write.csv(callaghan[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/callaghan-raw-text.csv")
rm(callaghan)

# Royal Society
# marsden combine and to csv 
mars_2017 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-Marsden-Announcements-2008-2017.xlsx",
                       sheet = 1, skip = 0)

mars_2018 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-Marsden-2018-annoucement-supplement.xlsx",
                       sheet = 1, skip = 0)
mars_2019 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-2019-Marsden-Fund-awarded-supplement_with-websheet-v2.xlsx",
                       sheet = 1, skip = 0)
mars_2020 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-2020-Marsden-Fund-announcement-supplement_corrected.xlsx",
                       sheet = 1, skip = 0)
mars_2021 <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-2021-Marsden-Fund-announcement-supplement-with-websheet-v3.xlsx",
                       sheet = 1, skip = 0)

mars_2018$Year <- 2018
mars_2019$Year <- 2019
mars_2020$Year <- 2020
mars_2021$Year <- 2021

mars <- dplyr::bind_rows(mars_2017, mars_2018, mars_2019, mars_2020, mars_2021)

mars$ProjectId <- paste0("RS_marsden_", seq(1,nrow(mars)), "_", mars$`Project ID`)
mars$Country <- "New Zealand"
mars$CountryFundingBody <- "Royal-Society"
mars$FundingBody <- "Royal-Society"
mars$LeadInstitution <- mars$Institution

mars$StartDate <- as.character(mars$Year)
mars$EndDate <- NA

mars$FundingAmount <- mars$`Funding (ex GST)`
mars$FundingCurrency <- "NZD"

mars$TitleAbstract <- paste(mars$Project,
                            mars$Abstract)

# rutherford to csv
rutherford <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-Rutherford-Discovery-Fellowship-Announcements-2010-2017.xlsx",
                        sheet = 1,
                        skip = 0)

rutherford$ProjectId <- paste0("RS_rutherford_", seq(1,nrow(rutherford)), "_", rutherford$`Proposal ID`)
rutherford$Country <- "New Zealand"
rutherford$CountryFundingBody <- "Royal-Society"
rutherford$FundingBody <- "Royal-Society"
rutherford$LeadInstitution <- rutherford$Host

rutherford$StartDate <- as.character(rutherford$Year)
rutherford$EndDate <- as.character(rutherford$Year+5)

rutherford$FundingAmount <- rutherford$TotalAward
rutherford$FundingCurrency <- "NZD"

rutherford$TitleAbstract <- paste(rutherford$Title,
                                  rutherford$PublicSummary)

# jcf to csv
jcf <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-JCF-Announcements-1996-2017.xlsx",
                 sheet = 1,
                 skip = 0)

jcf$ProjectId <- paste0("RS_jcf_", seq(1,nrow(jcf)), "_", jcf$ProjectID)
jcf$Country <- "New Zealand"
jcf$CountryFundingBody <- "Royal-Society"
jcf$FundingBody <- "Royal-Society"
jcf$LeadInstitution <- jcf$Host

jcf$StartDate <- as.character(jcf$Year)
jcf$EndDate <- as.character(jcf$Year+jcf$Duration)

jcf$FundingAmount <- jcf$TotalAward
jcf$FundingCurrency <- "NZD"

jcf$TitleAbstract <- paste(jcf$Title,
                           jcf$PublicSummary)

# Eco-hydraulics and Hay Travel
nz_ecohydro <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-ecohydraulics.xlsx")

nz_hay <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-hay.xlsx")

nz_ecohydro$StartDate <- as.character(nz_ecohydro$StartDate)
nz_hay$StartDate <- as.character(nz_hay$StartDate)

meta_cols <- c("ProjectId", "Country", "CountryFundingBody", "FundingBody",
               "LeadInstitution", "StartDate", "EndDate", "FundingAmount",
               "FundingCurrency")


write.csv(dplyr::bind_rows(mars[,meta_cols],
                           rutherford[,meta_cols],
                           jcf[,meta_cols],
                           nz_ecohydro[,meta_cols],
                           nz_hay[,meta_cols]),
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-raw-metadata.csv")


write.csv(dplyr::bind_rows(mars[,c("ProjectId", "TitleAbstract")],
                           rutherford[,c("ProjectId", "TitleAbstract")],
                           jcf[,c("ProjectId", "TitleAbstract")],
                           nz_ecohydro[,c("ProjectId", "TitleAbstract")],
                           nz_hay[,c("ProjectId", "TitleAbstract")]),
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/New-Zealand/royal-society-raw-text.csv")

rm(list = ls())


# UK 
# Wellcome to csv
wellcome <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/wellcome-grants.xlsx",
                      sheet = 1, skip = 0)

head(wellcome)
wellcome$ProjectId <- paste0("Wellcome_", seq(1,nrow(wellcome)), "_", wellcome$`Internal ID`)
wellcome$Country <- "UK"
wellcome$CountryFundingBody <- wellcome$`Funding Org:Name`
wellcome$FundingBody <- wellcome$`Funding Org:Name`
wellcome$LeadInstitution <- wellcome$`Recipient Org:Name`

wellcome$StartDate <- as.character(wellcome$`Planned Dates:Start Date`)
wellcome$EndDate <- as.character(wellcome$`Planned Dates:End Date`)

wellcome$FundingAmount <- wellcome$`Amount Awarded`
wellcome$FundingCurrency <- wellcome$Currency

wellcome$Abs <- wellcome$Description
wellcome$Abs[wellcome$Abs == "Not available"] <- ""
wellcome$Abs[wellcome$Abs == "NA"] <- ""
wellcome$Abs[wellcome$Abs == "N/A"] <- ""
wellcome$Abs[wellcome$Abs == "No data entered."] <- ""
wellcome$Abs[wellcome$Abs == "No Data Entered"] <- ""
wellcome$Abs[wellcome$Abs == "Not Applicable"] <- ""
wellcome$Abs[wellcome$Abs == "Do not Publish"] <- ""


sum(wellcome$Abs == "N/A")
sum(wellcome$Abs == "Not Applicable")


unique(wellcome$Abs[duplicated(wellcome$Abs)])

wellcome$TitleAbstract <- paste(wellcome$Title,
                                wellcome$Abs)

write.csv(wellcome[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/wellcome-raw-metadata.csv")


write.csv(wellcome[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/wellcome-raw-text.csv")

View(wellcome[18536,])

rm(wellcome)

# nihr tidy
nihr <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/infonihr-open-dataset.csv",
                 sep = ";")

nihr$ProjectId <- paste0("NIHR_", seq(1,nrow(nihr)), "_", nihr$Project_ID)
nihr$Country <- "UK"
nihr$CountryFundingBody <- "NIHR"
nihr$FundingBody <- nihr$Funder
nihr$LeadInstitution <- nihr$Contracted_Organisation

nihr$StartDate <- nihr$Start_date
nihr$EndDate <- nihr$End_Date

nihr$FundingAmount <- nihr$Award_Amount
nihr$FundingCurrency <- "GBP"


nihr$Abs <- nihr$Scientific_Abstract
nihr$Abs[nihr$Abs == "n/a"] <- ""
nihr$Abs[nihr$Abs == "N/A"] <- ""
nihr$Abs[nihr$Abs == "Not Available"] <- ""

View(nihr[,c("ProjectId", "Abs")])

nihr$Abs[3381]

nihr$TitleAbstract <- paste(nihr$Project_Title,
                            nihr$Scientific_Abstract)

write.csv(nihr[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/nihr-raw-metadata.csv")

write.csv(nihr[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/nihr-raw-text.csv")

rm(nihr, nihr_, nihr_summ_)



# dft tidy
dft <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/dft-trig.csv")

dft$ProjectId <- paste0("DFT_", seq(1,nrow(dft)))
dft$Country <- "UK"
dft$CountryFundingBody <- "DFT"
dft$FundingBody <- "DFT"
dft$LeadInstitution <-dft$Company

dft$StartDate <- as.character(dft$Year.Funded)
dft$EndDate <- NA

dft$FundingAmount <- NA
dft$FundingCurrency <- NA

dft$Abs <- dft$Project.summary
dft$Abs[dft$Abs == "Details on application"] <- ""
dft$Abs[dft$Abs == "Details on application "] <- ""
dft$Abs[131]


dft$TitleAbstract <- paste(dft$Project.title,
                           dft$Abs)

write.csv(dft[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/dft-raw-metadata.csv")

write.csv(dft[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/UK/dft-raw-text.csv")



# Ireland - tidy
# irc (irc_edit)
irc <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/irc_edit.csv")

irc$ProjectId <- paste0("IRC_", seq(1,nrow(irc)))
irc$Country <- "Ireland"
irc$CountryFundingBody <- "IRC"
irc$FundingBody <- "IRC"
irc$LeadInstitution <-irc$Higher.Education.Institution

irc$StartDate <- as.character(irc$Year)
irc$EndDate <- NA

irc$FundingAmount <- NA
irc$FundingCurrency <- NA

irc$TitleAbstract <- irc$Project.Title

write.csv(irc[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/irc-raw-metadata.csv")

write.csv(irc[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/irc-raw-text.csv")

rm(irc)


# sfi
sfi <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/sfi.csv")

sfi$ProjectId <- paste0("SFI_", seq(1,nrow(sfi)), "_", sfi$Proposal.ID)
sfi$Country <- "Ireland"
sfi$CountryFundingBody <- "SFI"
sfi$FundingBody <- "SFI"
sfi$LeadInstitution <-sfi$Research.Body

sfi$StartDate <- sfi$Start.Date
sfi$EndDate <- sfi$End.Date

sfi$FundingAmount <- as.numeric(gsub("\\)", "", gsub("\\(", "", gsub(",", "", gsub(" ", "", sfi$Current.Total.Commitment)))))

sfi[is.na(sfi$FundingAmount),]
sfi$FundingCurrency <- "EUR"

sfi$TitleAbstract <- sfi$Proposal.Title

write.csv(sfi[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/sfi-raw-metadata.csv")

write.csv(sfi[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/sfi-raw-text.csv")

rm(sfi)

# dafm (DofAFM.csv)
dafm <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/DofAFM.csv")

dafm$ProjectId <- paste0("DofAFM_", seq(1,nrow(dafm)), "_", dafm$Reference)
dafm$Country <- "Ireland"
dafm$CountryFundingBody <- "DofAFM"
dafm$FundingBody <- "DofAFM"
dafm$LeadInstitution <-dafm$Lead.Irish.Institution

dafm$StartDate <- dafm$Call.Year
dafm$EndDate <- NA

dafm$FundingAmount <- dafm$Amount.Awarded

dafm[is.na(dafm$FundingAmount),]
dafm$FundingCurrency <- "EUR"

dafm$TitleAbstract <- paste(dafm$Project.Title,
                            dafm$Project.Summary)

write.csv(dafm[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/dofafm-raw-metadata.csv")

write.csv(dafm[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/dofafm-raw-text.csv")

rm(dafm)

# marine inst
marine <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/marine-institute-projects.csv")

marine$ProjectId <- paste0("MarineInstitute_", seq(1,nrow(marine)))
marine$Country <- "Ireland"
marine$CountryFundingBody <- "Marine Institute"
marine$FundingBody <- "Marine Institute"
marine$LeadInstitution <-marine$Lead.Organisation

marine$StartDate <- marine$Year.Awarded
marine$EndDate <- NA

marine$FundingAmount <- as.numeric(gsub(",", "", gsub("\\€", "", marine$Grant.Aid)))

marine[is.na(marine$FundingAmount),]
marine$FundingCurrency <- "EUR"

# See application form
marine$Abs <- marine$Project.Summary
marine$Abs[marine$Abs == "See application form"] <- ""

marine$TitleAbstract <- paste(marine$Project.Name,
                              marine$Abs)

write.csv(marine[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/marine-institute-raw-metadata.csv")

write.csv(marine[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/marine-institute-raw-text.csv")

rm(marine)

# marine research
marine1 <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/Marine-Research-Database.csv")
unique(marine1$Lead.Funder)

marine1 <- subset(marine1,
                  !(Lead.Funder %in% c("European Commission",
                                       "Marine Institute",
                                       "",
                                       "Irish Research Council",
                                       "Science Foundation Ireland (SFI)",
                                       "Department of Agriculture, Food and the Marine")))

marine1$ProjectId <- paste0("IrelandGov_", seq(1,nrow(marine1)))
marine1$Country <- "Ireland"
marine1$CountryFundingBody <- marine1$Lead.Funder
marine1$FundingBody <- marine1$Lead.Funder
marine1$LeadInstitution <-marine1$Lead.Organisation

marine1$StartDate <- as.character(marine1$Year.Awarded)
marine1$EndDate <- as.character(marine1$Year.Awarded + round(marine1$Duration..months./12))

marine1$FundingAmount <- marine1$Total.Project.Grant.Aid

marine1[is.na(marine1$FundingAmount),]
marine1$FundingCurrency <- "EUR"

marine1$TitleAbstract <- marine1$Project.Name

write.csv(marine1[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/various-gov-raw-metadata.csv")

write.csv(marine1[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Ireland/various-gov-raw-text.csv")

rm(marine1)


# India - tidy
india_f <- list.files("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/India_prep",
                      full.names = T)

for (f in india_f){
  tmp_df <- read.csv(f)
  print(tmp_df$Funding_Agency_Short[1])
  tmp_df$ProjectId <- tmp_df$ProjectID
  tmp_df$Country <- "India"
  tmp_df$CountryFundingBody <- tmp_df$Funding_Agency_Short
  tmp_df$FundingBody <- tmp_df$Funding_Agency_Short
  tmp_df$LeadInstitution <-tmp_df$Institution_Name
  
  tmp_df$Year1 <- as.numeric(sapply(strsplit(tmp_df$Year, "-"), `[`, 1))
  tmp_df$StartDate <- as.character(tmp_df$Year1)
  tmp_df$EndDate <- as.character(tmp_df$Year1 + round(as.numeric(tmp_df$Duration)/12))
  
  tmp_df$FundingAmount <- tmp_df$Cost
  
  tmp_df$FundingCurrency <- "INR"
  
  tmp_df$TitleAbstract <- tmp_df$Project_Title
  
  write.csv(tmp_df[,meta_cols],
            paste0("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/India_prep/",
                   tolower(tmp_df$Funding_Agency_Short[1]),
                   "-raw-metadata.csv"))
  
  write.csv(tmp_df[,c("ProjectId", "TitleAbstract")],
            paste0("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/India_prep/",
                   tolower(tmp_df$Funding_Agency_Short[1]),
                   "-raw-text.csv"))
}

tmp_df[is.na(tmp_df$EndDate),]

rm(india1, f, tmp_df, india_f)


# Austria - tidy
# fwf
fwf <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Austria/fwf_projects_search_sept.xlsx",
                 skip = 3)

fwf$ProjectId <- paste0("FWF_", seq(1,nrow(fwf)))
fwf$Country <- "Austria"
fwf$CountryFundingBody <- "FWF"
fwf$FundingBody <- "FWF"
fwf$LeadInstitution <- fwf$`research place & institute`

fwf$StartDate <- fwf$from
fwf$EndDate <- fwf$till

fwf$FundingAmount <- fwf$`grants awarded`

fwf$FundingCurrency <- "EUR"

fwf$TitleAbstract <- fwf$`project title`
fwf$TitleAbstractKeywords <- paste(fwf$`project title`,
                                   fwf$keywords)

fwf$`project title`[1:3]
fwf$keywords[1:3]


write.csv(fwf[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Austria/fwf-raw-metadata.csv")

write.csv(fwf[,c("ProjectId", "TitleAbstract", "TitleAbstractKeywords")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Austria/fwf-raw-text.csv")

rm(fwf)


# gov
austria_gov <- read.table("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Austria/projektliste_sept.csv",
                          sep = ";")
headers <- austria_gov[1,]
austria_gov <- austria_gov[2:nrow(austria_gov),]

colnames(austria_gov) <- c("Project_code", "Start", "Status", "Contractor", 
                           "Project_title", "Funder", "Funding_amount")

austria_gov$ProjectId <- paste0(austria_gov$Funder, "_", seq(1,nrow(austria_gov)))
austria_gov$Country <- "Austria"
austria_gov$CountryFundingBody <- austria_gov$Funder
austria_gov$FundingBody <- austria_gov$Funder
austria_gov$LeadInstitution <- austria_gov$Contractor

austria_gov$StartDate <- as.character(lubridate::as_date(austria_gov$Start,
                                                         format = "%d.%m.%Y"))
austria_gov$EndDate <- NA

austria_gov$FundingAmount <- as.numeric(gsub(",", ".", gsub("\\.", "", austria_gov$Funding_amount)))

austria_gov$FundingCurrency <- "EUR"

austria_gov$TitleAbstract <- austria_gov$Project_title


write.csv(austria_gov[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Austria/austria-gov-raw-metadata.csv")

write.csv(austria_gov[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Austria/austria-gov-raw-text.csv")

rm(austria_gov, headers)


# Switzerland - tidy
# snf
snf <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/snf-GrantWithAbstracts.csv")

sum(snf$Abstract == "")
sum(snf$LaySummary_En == "")
sum(snf$LaySummaryLead_En == "")

sum(snf$Title == "")
sum(snf$TitleEnglish == "")

# So, just use Abstract
# Use Title, 
# If TitleEnglish is not "", use TitleEnglish


snf$ProjectId <- paste0("SNSF_", seq(1,nrow(snf)), "_", snf$GrantNumberString)
snf$Country <- "Switzerland"
snf$CountryFundingBody <- "SNSF"
snf$FundingBody <- "SNSF"
snf$LeadInstitution <- snf$ResearchInstitution

snf$StartDate <- as.character(as.POSIXct(snf$EffectiveGrantStartDate))
snf$EndDate <- as.character(as.POSIXct(snf$EffectiveGrantEndDate))

snf$FundingAmount <- as.numeric(snf$AmountGrantedAllSets)

snf$FundingCurrency <- "CHF"

snf$Title_ <- snf$Title
snf$Title_[snf$TitleEnglish != ""] <- snf$TitleEnglish[snf$TitleEnglish != ""]
snf$TitleAbstract <- paste(snf$Title_,
                           snf$Abstract)

write.csv(snf[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/snsf-raw-metadata.csv")

write.csv(snf[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/snsf-raw-text.csv")

# Need to check lang of Title/Abstract - not clear 
# Some abstracts are En, others Fr....


# head(snf[,c("Title", "TitleEnglish")])
rm(snf, snf_reduced)


# aramis - split
aramis <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/aramis-full-export.csv")
colnames(aramis)
colnames(aramis) <- c("ResearchUnit", "ProjectNumber", "ProjectTitle", 
                      "ProjectTitleEN", "Description", "ProjectStatus",
                      "Area", "ProjectCategory", "NABSCategory", 
                      "ContactPerson", "ProjectStart", "ProjectEnd",
                      "TotalCostsApproved", "TypeOfResearch")

# https://www.aramis.admin.ch/About/

aramis$ProjectId <- paste0(aramis$ResearchUnit, "_", seq(1, nrow(aramis)), "_", aramis$ProjectNumber)
aramis$Country <- "Switzerland"
aramis$CountryFundingBody <- aramis$ResearchUnit
aramis$FundingBody <- aramis$ResearchUnit
aramis$LeadInstitution <- NA

aramis$StartDate <- as.character(as.Date(as.character(as.POSIXct(aramis$ProjectStart))))
aramis$EndDate <- as.character(as.Date(as.character(as.POSIXct(aramis$ProjectEnd))))

aramis$FundingAmount <- aramis$TotalCostsApproved

aramis$FundingCurrency <- "CHF"

sum(aramis$ProjectTitle == "")
sum(aramis$ProjectTitleEN == "")

aramis$Title_ <- aramis$ProjectTitleEN
aramis$Title_[aramis$ProjectTitleEN == ""] <- aramis$ProjectTitle[aramis$ProjectTitleEN == ""]
aramis$TitleAbstract <- paste(aramis$Title_,
                              aramis$Description)

write.csv(aramis[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/swiss-gov-raw-metadata.csv")

write.csv(aramis[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/swiss-gov-raw-text.csv")

rm(aramis)
# Need to check lang...

# kfs - tidy
kfs <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/krebsforschung-25.09.2022 15 53 23-Export.csv")


# split into kfs/kls
kfs$ProjectId <- paste0(kfs$ID, "_", seq(1, nrow(kfs)))
kfs$Country <- "Switzerland"
kfs$CountryFundingBody <- kfs$Funding.Organisation
kfs$FundingBody <- kfs$Funding.Organisation
kfs$LeadInstitution <- kfs$Project.Coordinator.Organisation

# %%%%
lubridate::as_date(kfs$Start.Date)

unique(kfs$Start.Date)
kfs$StartDate <- as.character(lubridate::dmy(kfs$Start.Date))
kfs$EndDate <- as.character(lubridate::dmy(kfs$End.Date))


# %%%%

kfs$FundingAmount <- as.numeric(gsub(" ", "", gsub("-", "00", gsub("CHF ", "", kfs$Total.Award))))

kfs$FundingCurrency <- "CHF"

kfs$TitleAbstract <- paste(kfs$Project.Title,
                           kfs$Summary)

write.csv(kfs[kfs$Funding.Organisation == "KFS",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/kfs-raw-metadata.csv")

write.csv(kfs[kfs$Funding.Organisation == "KFS",c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/kfs-raw-text.csv")


write.csv(kfs[kfs$Funding.Organisation == "KLS",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/kls-raw-metadata.csv")

write.csv(kfs[kfs$Funding.Organisation == "KLS",c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Switzerland/kls-raw-text.csv")

subset(kfs, ProjectId == "BIL KFS-4127-02-2017_385")

rm(kfs)

# Hungary 
# txt to csv, combine and drop duplicates
nkfi_health <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Hungary/nkfi_health.txt",
                         skip = 2)

nkfi_natsci <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Hungary/nkfi_natsci.txt",
                         skip = 2)

nkfi_no <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Hungary/nkfi_no_keywords.txt",
                     skip = 2)

nkfi_phys <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Hungary/nkfi_physci.txt",
                       skip = 2)

nkfi_tech <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Hungary/nkfi_techsci.txt",
                       skip = 2)

nkfi <- dplyr::bind_rows(nkfi_health, 
                         nkfi_natsci,
                         nkfi_no,
                         nkfi_phys,
                         nkfi_tech)

length(unique(nkfi$Identifier))

sum(duplicated(nkfi$Identifier))

8193+378

nkfi_dedup <- nkfi[!duplicated(nkfi$Identifier),]
nkfi_dup <- nkfi[duplicated(nkfi$Identifier),]

subset(nkfi_dedup, Identifier == 71902)

as.numeric(nkfi_dedup$Funding..in.million.HUF.)*1000000

nkfi_dedup$ProjectId <- paste0("NKFI_", seq(1, nrow(nkfi_dedup)), "_", nkfi_dedup$Identifier)
nkfi_dedup$Country <- "Hungary"
nkfi_dedup$CountryFundingBody <- "NKFI"
nkfi_dedup$FundingBody <- "NKFI"
nkfi_dedup$LeadInstitution <- nkfi_dedup$Department.or.equivalent

nkfi_dedup$StartDate <- nkfi_dedup$Starting.date
nkfi_dedup$EndDate <- nkfi_dedup$Closing.date

nkfi_dedup$FundingAmount <- as.numeric(nkfi_dedup$Funding..in.million.HUF.)*1000000

nkfi_dedup$FundingCurrency <- "HUF"

nkfi_dedup$TitleAbstract <- nkfi_dedup$Title

write.csv(nkfi_dedup[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Hungary/nkfi-raw-metadata.csv")

write.csv(nkfi_dedup[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Hungary/nkfi-raw-text.csv")

rm(nkfi, nkfi_dedup, nkfi_dup, nkfi_health, nkfi_natsci, nkfi_no, nkfi_phys, nkfi_tech)


# Sweden
# From https://www.vr.se/english/swecris.html#/?funder=202100-2585&funder=202100-4946&funder=202100-5000&funder=202100-5208&funder=202100-5216&funder=202100-5232&funder=202100-5240&funder=802400-4155&scb=1&scb=2&scb=3&scb=4&scb=9
# Excludes: Swedish Heart-Lung Foundation (non-gov) and Riksbankens Jubileumsfond (non-sci)
swed <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/export_sci_funders_202210103.csv")

unique(swed$FundingOrganisationTypeOfOrganisationEn)

unique(swed$FundingOrganisationNameEn)

swed$ProjectId <- paste0(swed$ProjectId, "_", seq(1, nrow(swed)))
swed$Country <- "Sweden"
swed$CountryFundingBody <- swed$FundingOrganisationNameEn
swed$FundingBody <- swed$FundingOrganisationNameEn
swed$LeadInstitution <- swed$CoordinatingOrganisationNameEn

swed$StartDate <- swed$FundingStartDate
swed$EndDate <- swed$FundingEndDate

swed$FundingAmount <- swed$FundingsSek

swed$FundingCurrency <- "SEK"


swed$TitleAbstractEn <- paste(swed$ProjectTitleEn,
                              swed$ProjectAbstractEn)
swed$TitleAbstractEn[swed$TitleAbstractEn == " "] <- ""

swed$TitleAbstractSv <- paste(swed$ProjectTitleSv,
                              swed$ProjectAbstractSv)
swed$TitleAbstractSv[swed$TitleAbstractSv == " "] <- ""


swed$Title_ <- swed$ProjectTitleEn
sum(is.na(swed$Title_))
swed$Title_[is.na(swed$Title_)] <- ""
swed$Title_[swed$Title_ == ""] <- swed$ProjectTitleSv[swed$Title_ == ""]

swed$Abs_ <- swed$ProjectAbstractEn
swed$Abs_[swed$ProjectAbstractEn == ""] <- swed$ProjectAbstractSv[swed$ProjectAbstractEn == ""]

swed$TitleAbstract <- paste(swed$Title_,
                            swed$Abs_)

# If English and another lang, have two cols, En and Xx



# Split
# [1] "Vinnova"                                                              
write.csv(swed[swed$FundingBody == "Vinnova",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/vinnova-raw-metadata.csv")

write.csv(swed[swed$FundingBody == "Vinnova",c("ProjectId", "TitleAbstractEn", "TitleAbstractSv")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/vinnova-raw-text.csv")

# [2] "Swedish Research Council"  
write.csv(swed[swed$FundingBody == "Swedish Research Council",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/src-raw-metadata.csv")

write.csv(swed[swed$FundingBody == "Swedish Research Council",c("ProjectId", "TitleAbstractEn", "TitleAbstractSv")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/src-raw-text.csv")

# [3] "Swedish National Space Agency"   
write.csv(swed[swed$FundingBody == "Swedish National Space Agency",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/snsa-raw-metadata.csv")

write.csv(swed[swed$FundingBody == "Swedish National Space Agency",c("ProjectId", "TitleAbstractEn", "TitleAbstractSv")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/snsa-raw-text.csv")

# [4] "Swedish Energy Agency "
write.csv(swed[swed$FundingBody == "Swedish Energy Agency ",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/snea-raw-metadata.csv")

write.csv(swed[swed$FundingBody == "Swedish Energy Agency ",c("ProjectId", "TitleAbstractEn", "TitleAbstractSv")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/snea-raw-text.csv")

# [5] "Institute for Evaluation of Labour Market and Education Policy (IFAU)"
write.csv(swed[swed$FundingBody == "Institute for Evaluation of Labour Market and Education Policy (IFAU)",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/ifau-raw-metadata.csv")

write.csv(swed[swed$FundingBody == "Institute for Evaluation of Labour Market and Education Policy (IFAU)",c("ProjectId", "TitleAbstractEn", "TitleAbstractSv")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/ifau-raw-text.csv")

# [6] "Foundation for Baltic and East European Studies"                      
write.csv(swed[swed$FundingBody == "Foundation for Baltic and East European Studies",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/fbees-raw-metadata.csv")

write.csv(swed[swed$FundingBody == "Foundation for Baltic and East European Studies",c("ProjectId", "TitleAbstractEn", "TitleAbstractSv")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/fbees-raw-text.csv")

# [7] "Forte"                                                                
write.csv(swed[swed$FundingBody == "Forte",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/forte-raw-metadata.csv")

write.csv(swed[swed$FundingBody == "Forte",c("ProjectId", "TitleAbstractEn", "TitleAbstractSv")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/forte-raw-text.csv")

# [8] "Formas" 
write.csv(swed[swed$FundingBody == "Formas",meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/formas-raw-metadata.csv")

write.csv(swed[swed$FundingBody == "Formas",c("ProjectId", "TitleAbstractEn", "TitleAbstractSv")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/formas-raw-text.csv")




swed$Scbs[1000:1003]
unique(swed$Scbs)

swed$Research_field_num <- sapply(strsplit(swed$Scbs, ":"), `[`, 1)

swed$Research_field <- NA
swed$Research_field[swed$Research_field_num == "¤¤¤ 9"] <- "Unclassified"
swed$Research_field[swed$Research_field_num == "¤¤¤ 1"] 
swed$Research_field[swed$Research_field_num == "¤¤¤ 2"] <- "Engineering and Technology"
swed$Research_field[swed$Research_field_num == "¤¤¤ 3"] <- "Medical and Health Sciences"
swed$Research_field[swed$Research_field_num == "¤¤¤ 4"]
swed$Research_field[swed$Research_field_num == "¤¤¤ 5"]
swed$Research_field[swed$Research_field_num == "¤¤¤ 6"] 

swed$Sci_unclass <- ( grepl(" 1: ", swed$Scbs) |
                        grepl(" 2: ", swed$Scbs) |
                        grepl(" 3: ", swed$Scbs) |
                        grepl(" 4: ", swed$Scbs) |
                        grepl(" 9: ", swed$Scbs) )

swed$Scbs[grepl(" 5: ", swed$Scbs)][1]

sum(swed$Scbs == "")
swed$Sci_unclass[swed$Scbs == ""] <- T

sum(swed$Sci_unclass)

View(subset(swed, Sci_unclass == F))
# Should I drop non-science topics...

swed_non_sci <- subset(swed, Sci_unclass == F) # 6424
swed_sci <- subset(swed, Sci_unclass == T) # 44660
unique(swed_non_sci$CountryFundingBody)
unique(swed_sci$CountryFundingBody)

write.csv(swed_sci,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Sweden/swed_sci.csv")
rm(swed, swed_sci, swed_non_sci)



# France - combine
# tidy
# anr
anr_dgpie <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr-dgpie-depuis-2010-projets-finances-20220512-projets.csv")
anr_dgpie_ <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr-dgpie-depuis-2010-projets-finances-20220512-partenaires.csv")

anr_dos_05 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr-dos-2005-2009-projets-finances-20210826-projets.csv")
anr_dos_05_ <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr-dos-2005-2009-projets-finances-20210826-partenaires.csv")

anr_dos_10 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr-dos-depuis-2010-projets-finances-20220504-projets.csv")
anr_dos_10_ <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr-dos-depuis-2010-projets-finances-20220504-partenaires.csv")

anr_dgpie_$Projet.Partenaire.Est_coordinateur
nrow(subset(anr_dgpie_, Projet.Partenaire.Est_coordinateur == "True"))

# Left join coordinator org with project
library(dplyr)

anr_dgpie <- anr_dgpie %>%
  dplyr::left_join(subset(anr_dgpie_, Projet.Partenaire.Est_coordinateur == "True"))

rm(anr_dgpie_)
rm(anr_dgpie__)

nrow(subset(anr_dos_05_, Projet.Partenaire.Est_coordinateur == "True"))
anr_dos_05 <- anr_dos_05 %>%
  left_join(subset(anr_dos_05_, Projet.Partenaire.Est_coordinateur == "True"))



nrow(subset(anr_dos_10_, Projet.Partenaire.Est_coordinateur == "True"))

anr_dos_10_sub <- subset(anr_dos_10_, Projet.Partenaire.Est_coordinateur == "True")
length(unique(anr_dos_10_sub$Projet.Code_Decision_ANR))

sum(unique(anr_dos_10_sub$Projet.Code_Decision_ANR) %in% unique(anr_dos_10$Projet.Code_Decision_ANR))
sum(unique(anr_dos_10_sub$Projet.Code_Decision_ANR) %in% unique(anr_dos_05$Projet.Code_Decision_ANR))

anr_dos_10 <- anr_dos_10 %>%
  left_join(subset(anr_dos_10_, Projet.Partenaire.Est_coordinateur == "True"))


head(anr_dgpie)
head(anr_dos_05)
head(anr_dos_10)

colnames(anr_dgpie)
colnames(anr_dos_05)
colnames(anr_dos_10)

anr <- bind_rows(anr_dgpie,
                 anr_dos_05,
                 anr_dos_10)

length(unique(anr$Projet.Code_Decision_ANR))


anr$ProjectId <- paste0(anr$Projet.Code_Decision_ANR, "_", seq(1, nrow(anr)))
anr$Country <- "France"
anr$CountryFundingBody <- "ANR"
anr$FundingBody <- "ANR"
anr$LeadInstitution <- anr$Projet.Partenaire.Nom_organisme

anr$StartDate <- anr$Projet.Date_debut
anr$StartDate[anr$StartDate == ""] <- anr$Action.Edition[anr$StartDate == ""]

anr$EndDate <- NA

anr$FundingAmount <- anr$Projet.Aide_allouee

anr$FundingCurrency <- "EUR"


anr$TitleAbstractEn <- paste(anr$Projet.Titre.Anglais,
                             anr$Projet.Resume.Anglais)
anr$TitleAbstractEn[anr$TitleAbstractEn == "NA NA"] <- ""

anr$TitleAbstractFr <- paste(anr$Projet.Titre.Francais,
                             anr$Projet.Resume.Francais)

write.csv(anr[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr/anr-raw-metadata.csv")

write.csv(anr[,c("ProjectId", "TitleAbstractEn", "TitleAbstractFr")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr/anr-raw-text.csv")

rm(anr, anr_dgpie, anr_dgpie_, anr_dos_05, anr_dos_05_, anr_dos_10, anr_dos_10_,
   anr_dos_10_sub)

# pia
pia <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/scanr_projects_pia.tsv",
                sep = "\t")

unique(pia$Identifiant)

anr <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/anr/anr-raw-metadata.csv")

sum(pia$Identifiant %in% sapply(strsplit(anr$ProjectId, "_"), `[`, 1))
# all in ANR data...
rm(pia)

# inca
inca <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/scanr_projects_inca.csv",
                 sep = "\t")
unique(inca$Date.de.début)
unique(inca$Budget.financé)

# all french, no associated funding/organisations
inca$ProjectId <- paste0(inca$Identifiant, "_", seq(1, nrow(inca)))
inca$Country <- "France"
inca$CountryFundingBody <- "INCA"
inca$FundingBody <- "INCA"
inca$LeadInstitution <- NA

inca$StartDate <- sapply(strsplit(inca$Identifiant, "-"), `[`, 2)

inca$EndDate <- NA

inca$FundingAmount <- NA

inca$FundingCurrency <- NA

inca$TitleAbstract <- inca$Label

write.csv(inca[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/inca/inca-raw-metadata.csv")

write.csv(inca[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/inca/inca-raw-text.csv")
rm(inca)

inca_ <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/od-scanr-inca.csv")
unique(inca_$description)
rm(inca_)

# ademe
ademe <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/scanr_projects_ademe.tsv",
                  sep = "\t")

unique(ademe$Type)
# all french, no associated funding/organisations
ademe$ProjectId <- paste0(ademe$Identifiant, "_", seq(1, nrow(ademe)))
ademe$Country <- "France"
ademe$CountryFundingBody <- "ADEME"
ademe$FundingBody <- "ADEME"
ademe$LeadInstitution <- NA
ademe$StartDate <- sapply(strsplit(ademe$Identifiant, "-"), `[`, 3)
ademe$EndDate <- NA
ademe$FundingAmount <- NA
ademe$FundingCurrency <- NA
ademe$TitleAbstract <- ademe$Label

write.csv(ademe[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/ademe/ademe-raw-metadata.csv")

write.csv(ademe[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/ademe/ademe-raw-text.csv")
rm(ademe)

ademe_ <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/od-scanr-ademe.csv")
unique(ademe_$description)
rm(ademe_)


# casdar
casdar <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/od-scanr-casdar.csv")
# all french, no associated funding/organisations
casdar$ProjectId <- paste0(casdar$id, "_", seq(1, nrow(casdar)))
casdar$Country <- "France"
casdar$CountryFundingBody <- "CASDAR"
casdar$FundingBody <- "CASDAR"
casdar$LeadInstitution <- NA
casdar$StartDate <- casdar$startDate
# Add duration (months?) to start date
library(lubridate)

casdar$EndDate <- as.character(lubridate::ymd(casdar$StartDate) %m+% months(casdar$duration))

casdar$FundingAmount <- as.numeric(casdar$budgetTotal)
casdar$FundingCurrency <- "EUR"

sum(grepl("en\\\":", casdar$label))
sum(grepl("en\\\":", casdar$description))
casdar$label[1000]

casdar$label_ <- gsub("\\{\\\"fr\\\": \\\"", "", casdar$label) %>%
  gsub("\\\\n", "", .) %>%
  gsub("\\\"\\}", "", .)

casdar$description_ <- gsub("\\{\\\"fr\\\": \\\"", "", casdar$description) %>%
  gsub("\\\\n", "", .) %>%
  gsub("\\\"\\}", "", .)


casdar$label[171]
casdar$TitleAbstract <- paste(casdar$label_,
                              casdar$description_)

write.csv(casdar[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/casdar/casdar-raw-metadata.csv")

write.csv(casdar[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/casdar/casdar-raw-text.csv")
rm(casdar)

# cifre
cifre <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/od-scanr-cifre.csv")
# all french, no associated funding/organisations
cifre$ProjectId <- paste0(cifre$id, "_", seq(1, nrow(cifre)))
cifre$Country <- "France"
cifre$CountryFundingBody <- "CIFRE"
cifre$FundingBody <- "CIFRE"
cifre$LeadInstitution <- NA
cifre$StartDate <- cifre$year
cifre$EndDate <- NA

cifre$FundingAmount <- NA
cifre$FundingCurrency <- NA

sum(grepl("en\\\":", cifre$label))
# sum(grepl("en\\\":", cifre$description))
cifre$label[1000]

cifre$label_ <- gsub("\\{\\\"fr\\\": \\\"", "", cifre$label) %>%
  gsub("\\\\n", "", .) %>%
  gsub("\\\"\\}", "", .)

cifre$label_[171]
cifre$TitleAbstract <- cifre$label_

write.csv(cifre[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/cifre/cifre-raw-metadata.csv")

write.csv(cifre[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/cifre/cifre-raw-text.csv")
rm(cifre)

# phc
phc <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/od-scanr-phc.csv")
# all french, no associated funding/organisations
phc$ProjectId <- paste0(phc$id, "_", seq(1, nrow(phc)))
phc$Country <- "France"
phc$CountryFundingBody <- phc$type
phc$FundingBody <- phc$type
phc$LeadInstitution <- NA
phc$StartDate <- phc$startDate
phc$EndDate <- NA

phc$FundingAmount <- NA
phc$FundingCurrency <- NA

sum(grepl("en\\\":", phc$label))
# sum(grepl("en\\\":", cifre$description))
phc$label[1000]

sum(grepl("\\\"fr\\\": \\\"", phc$label))
sum(grepl("\\{\\\"default\\\": \\\"", phc$label))

phc$label_ <- sapply(strsplit(phc$label, "\\\"fr\\\": \\\""), `[`, 1) %>%
  gsub("\\{\\\"default\\\": \\\"", "", .) %>%
  gsub("\\\\n", "", .) %>%
  gsub("\\\",", "", .)

phc$label_[171]
phc$TitleAbstract <- phc$label_

write.csv(phc[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/phc/phc-raw-metadata.csv")

write.csv(phc[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/phc/phc-raw-text.csv")
rm(phc)

# phrc
phrc <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/od-scanr-phrc.csv")

# phrc_json <- jsonlite::fromJSON("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/od-scanr-phrc.json")



# all french, no associated funding/organisations
phrc$ProjectId <- paste0(phrc$id, "_", seq(1, nrow(phrc)))
phrc$Country <- "France"
phrc$CountryFundingBody <- phrc$type
phrc$FundingBody <- phrc$type
phrc$LeadInstitution <- NA
phrc$StartDate <- phrc$year
phrc$EndDate <- NA

phrc$FundingAmount <- as.numeric(phrc$budgetTotal)
phrc$FundingCurrency <- "EUR"

phrc$label_default <- ""
phrc$label_en <- ""
phrc$label_fr <- ""

phrc$descr_default <- ""
phrc$descr_en <- ""
phrc$descr_fr <- ""

for (i in 1:nrow(phrc)){
  if (phrc$label[i] != ""){
    tmp_lab_ls <- jsonlite::fromJSON(phrc$label[i])
    
    tmp_nms <- names(tmp_lab_ls)
    if ("default" %in% tmp_nms){
      phrc$label_default[i] <- tmp_lab_ls$default  
    }
    if ("en" %in% tmp_nms){
      phrc$label_en[i] <- tmp_lab_ls$en
    }
    if ("fr" %in% tmp_nms){
      phrc$label_fr[i] <- tmp_lab_ls$fr
    }
  }
  
  if (phrc$description[i] != ""){
    tmp_descr_ls <- jsonlite::fromJSON(phrc$description[i])
    
    tmp_nms <- names(tmp_descr_ls)
    if ("default" %in% tmp_nms){
      phrc$descr_default[i] <- tmp_descr_ls$default
    }
    if ("en" %in% tmp_nms){
      phrc$descr_en[i] <- tmp_descr_ls$en
    }
    if ("fr" %in% tmp_nms){
      phrc$descr_fr[i] <- tmp_descr_ls$fr
    }
  }
}

phrc$TitleAbstract <- paste(phrc$label_default,
                            phrc$descr_default)
phrc$TitleAbstractEn <- paste(phrc$label_en,
                              phrc$descr_en)
phrc$TitleAbstractFr <- paste(phrc$label_fr,
                              phrc$descr_fr)

write.csv(phrc[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/phrc/phrc-raw-metadata.csv")

write.csv(phrc[,c("ProjectId", "TitleAbstract", "TitleAbstractEn", "TitleAbstractFr")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/phrc/phrc-raw-text.csv")
rm(phrc)


# %%%%%%
# dev
sum(grepl("en\\\":", phrc$label))
# sum(grepl("en\\\":", cifre$description))
phrc$label[1000]

sum(grepl("\\\"fr\\\": \\\"", phrc$label))
sum(grepl("\\{\\\"default\\\": \\\"", phrc$label))

phrc$label[!grepl("\\\"fr\\\": \\\"", phrc$label)]

phrc$label[578]
strsplit(phrc$label[578], "\\{\\\"fr\\\": \\\"")

tmp <- jsonlite::fromJSON(phrc$label[3713])
tmp[["default"]]
tmp$default
tmp$en
tmp$fr


gsub('["{}]', "", phrc$label[1])
phrc$n_labs <- sapply(strsplit(phrc$label, "\\\","), length)
phrc$n_descr <- sapply(strsplit(phrc$description, "\\\","), length)


# "default", "fr", and "en" are options = within dict


phc$label_ <- sapply(strsplit(phc$label, "\\\"fr\\\": \\\""), `[`, 1) %>%
  gsub("\\{\\\"default\\\": \\\"", "", .) %>%
  gsub("\\\\n", "", .) %>%
  gsub("\\\",", "", .)

phrc$label_[171]
# %%%%%%
# NEED TO FIX ABOVE - text columns...

# ilab
ilab <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/fr-esr-laureats-concours-national-i-lab.csv")
# all french, 
ilab$ProjectId <- paste0(ilab$Identifiant, "_", seq(1, nrow(ilab)))
ilab$Country <- "France"
ilab$CountryFundingBody <- "iLab"
ilab$FundingBody <- "iLab"
ilab$LeadInstitution <- ilab$Structure.liée.au.projet
ilab$StartDate <- ilab$Année.de.concours
ilab$EndDate <- NA

ilab$FundingAmount <- NA
ilab$FundingCurrency <- NA

ilab$TitleAbstract <- paste(ilab$Moto,
                            ilab$Résumé)

write.csv(ilab[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/ilab/ilab-raw-metadata.csv")

write.csv(ilab[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/France/ilab/ilab-raw-text.csv")
rm(ilab)
# ...



# Germany - combine
# tidy
# dfg
dfg <- lapply(list.files("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Germany",
                         pattern = "dfg-",
                         full.names = T), 
              read.csv) %>% bind_rows()
# German...
# unique(sapply(strsplit(dfg$Project.ID, "/"), length))

dfg$ProjectId <- paste0("DFG_", sapply(strsplit(dfg$Project.ID, "/"), `[`, 4), "_", seq(1, nrow(dfg)))
dfg$Country <- "Germany"
dfg$CountryFundingBody <- "DFG"
dfg$FundingBody <- "DFG"
dfg$LeadInstitution <- dfg$Applicant.Institution
dfg$StartDate <- dfg$Start_year
dfg$EndDate <- dfg$End_year

dfg$FundingAmount <- NA
dfg$FundingCurrency <- NA

dfg$TitleAbstract <- paste(dfg$Project.Title,
                           dfg$Project.Description)

write.csv(dfg[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Germany/dfg/dfg-raw-metadata.csv")

write.csv(dfg[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Germany/dfg/dfg-raw-text.csv")
rm(dfg)

# fisa
fisa <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Germany/fisa.csv")
colnames(fisa)

fisa$ProjectId <- paste0(fisa$Förderkennzeichen, "_", seq(1, nrow(fisa)))
fisa$Country <- "Germany"
fisa$CountryFundingBody <- NA
fisa$FundingBody <- NA
fisa$LeadInstitution <- NA
fisa$StartDate <- fisa$Projektbeginn
fisa$EndDate <- fisa$Projektende

fisa$FundingAmount <- fisa$Fördersumme
fisa$FundingCurrency <- "EUR"

fisa$abs <- fisa$Projektbeschreibung
fisa$abs[fisa$abs == "no details"] <- ""
fisa$abs[fisa$abs == "currently unavailable"] <- ""
fisa$abs[fisa$abs == "keine Angaben"] <- ""
fisa$abs[fisa$abs == "keine Angabe"] <- ""
fisa$abs[fisa$abs == "no data"] <- ""
fisa$abs[fisa$abs == "No data available"] <- ""
fisa$abs[fisa$abs == "currently not available"] <- ""
fisa$abs[fisa$abs == "No details"] <- ""
fisa$abs[fisa$abs == "no details yet"] <- ""

# no details
# currently unavailable
# keine Angaben
# no data
# No data available
fisa$TitleAbstract <- paste(fisa$Projekttitel,
                            fisa$abs)

# Note: some DFG....
# Need info on funder... - not available in core download
paste0("https://www.fisaonline.de", fisa$Details[1])
# req <- httr:::request(url = "https://www.fisaonline.de", fisa$Details[1], ".html")
# 
# tmp <- xml2::read_html(paste0("https://www.fisaonline.de", fisa$Details[1]))
# tmp[1]
# rm(tmp)


# Europe - format
# tidy

# cordis fpX
# scMaxContribution seems to be funding amount

cordis_fp1 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_fp1_projects.csv")

unique(cordis_fp1$frameworkProgramme)
unique(cordis_fp1$fundingScheme)

cordis_fp1$ProjectId <- paste0("FP1_", cordis_fp1$id, "_", seq(1, nrow(cordis_fp1)))
cordis_fp1$Country <- "EU"
cordis_fp1$CountryFundingBody <- "EU-FP"
cordis_fp1$FundingBody <- "FP1"
# unique(cordis_fp1$programme)
# unique(cordis_fp2$programme)
cordis_fp1$LeadInstitution <- cordis_fp1$coordinator
cordis_fp1$LeadInstitutionCountry <- cordis_fp1$coordinatorCountry
cordis_fp1$StartDate <- cordis_fp1$startDate
cordis_fp1$EndDate <- cordis_fp1$endDate

cordis_fp1$FundingAmount <- NA
cordis_fp1$FundingCurrency <- NA
range(cordis_fp1$ecMaxContribution, na.rm = T)

cordis_fp1$TitleAbstract <- paste(cordis_fp1$title,
                                  cordis_fp1$objective)

write.csv(cordis_fp1[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp1-raw-metadata.csv")
write.csv(cordis_fp1[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp1-raw-text.csv")
rm(cordis_fp1)

# fp2
cordis_fp2 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_fp2_projects.csv")
unique(cordis_fp2$frameworkProgramme)
unique(cordis_fp2$fundingScheme)

range(cordis_fp2$ecMaxContribution, na.rm = T)
unique(cordis_fp1$programme)

cordis_fp2$ProjectId <- paste0("FP2_", cordis_fp2$id, "_", seq(1, nrow(cordis_fp2)))
cordis_fp2$Country <- "EU"
cordis_fp2$CountryFundingBody <- "EU-FP"
cordis_fp2$FundingBody <- "FP2"
# unique(cordis_fp1$programme)
# unique(cordis_fp2$programme)
cordis_fp2$LeadInstitution <- cordis_fp2$coordinator
cordis_fp2$LeadInstitutionCountry <- cordis_fp2$coordinatorCountry
cordis_fp2$StartDate <- cordis_fp2$startDate
cordis_fp2$EndDate <- cordis_fp2$endDate

cordis_fp2$FundingAmount <- cordis_fp2$ecMaxContribution
cordis_fp2$FundingCurrency <- "EUR"
range(cordis_fp1$ecMaxContribution, na.rm = T)

cordis_fp2$TitleAbstract <- paste(cordis_fp2$title,
                                  cordis_fp2$objective)

write.csv(cordis_fp2[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp2-raw-metadata.csv")
write.csv(cordis_fp2[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp2-raw-text.csv")
rm(cordis_fp2)

# fp3
cordis_fp3 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_fp3_projects.csv")
unique(cordis_fp3$frameworkProgramme)
unique(cordis_fp3$fundingScheme)

range(cordis_fp3$ecMaxContribution, na.rm = T)
unique(cordis_fp3$programme)

cordis_fp3$ProjectId <- paste0("FP3_", cordis_fp3$id, "_", seq(1, nrow(cordis_fp3)))
cordis_fp3$Country <- "EU"
cordis_fp3$CountryFundingBody <- "EU-FP"
cordis_fp3$FundingBody <- "FP3"
# unique(cordis_fp1$programme)
# unique(cordis_fp2$programme)
cordis_fp3$LeadInstitution <- cordis_fp3$coordinator
cordis_fp3$LeadInstitutionCountry <- cordis_fp3$coordinatorCountry
cordis_fp3$StartDate <- cordis_fp3$startDate
cordis_fp3$EndDate <- cordis_fp3$endDate

cordis_fp3$FundingAmount <- cordis_fp3$ecMaxContribution
cordis_fp3$FundingCurrency <- "EUR"
range(cordis_fp3$ecMaxContribution, na.rm = T)

cordis_fp3$TitleAbstract <- paste(cordis_fp3$title,
                                  cordis_fp3$objective)

write.csv(cordis_fp3[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp3-raw-metadata.csv")
write.csv(cordis_fp3[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp3-raw-text.csv")
rm(cordis_fp3)

# fp4
cordis_fp4 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_fp4_projects.csv")
unique(cordis_fp4$frameworkProgramme)
unique(cordis_fp4$fundingScheme)

range(cordis_fp4$ecMaxContribution, na.rm = T)
unique(cordis_fp4$programme)

cordis_fp4$ProjectId <- paste0("FP4_", cordis_fp4$id, "_", seq(1, nrow(cordis_fp4)))
cordis_fp4$Country <- "EU"
cordis_fp4$CountryFundingBody <- "EU-FP"
cordis_fp4$FundingBody <- "FP4"
# unique(cordis_fp1$programme)
# unique(cordis_fp2$programme)
cordis_fp4$LeadInstitution <- cordis_fp4$coordinator
cordis_fp4$LeadInstitutionCountry <- cordis_fp4$coordinatorCountry
cordis_fp4$StartDate <- cordis_fp4$startDate
cordis_fp4$EndDate <- cordis_fp4$endDate

cordis_fp4$FundingAmount <- cordis_fp4$ecMaxContribution
cordis_fp4$FundingCurrency <- "EUR"

cordis_fp4$TitleAbstract <- paste(cordis_fp4$title,
                                  cordis_fp4$objective)

write.csv(cordis_fp4[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp4-raw-metadata.csv")
write.csv(cordis_fp4[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp4-raw-text.csv")
rm(cordis_fp4)

# fp5
cordis_fp5 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_fp5_projects.csv")
unique(cordis_fp5$frameworkProgramme)
unique(cordis_fp5$fundingScheme)

range(cordis_fp5$ecMaxContribution, na.rm = T)
unique(cordis_fp5$programme)

cordis_fp5$ProjectId <- paste0("FP5_", cordis_fp5$id, "_", seq(1, nrow(cordis_fp5)))
cordis_fp5$Country <- "EU"
cordis_fp5$CountryFundingBody <- "EU-FP"
cordis_fp5$FundingBody <- "FP5"
# unique(cordis_fp1$programme)
# unique(cordis_fp2$programme)
cordis_fp5$LeadInstitution <- cordis_fp5$coordinator
cordis_fp5$LeadInstitutionCountry <- cordis_fp5$coordinatorCountry
cordis_fp5$StartDate <- cordis_fp5$startDate
cordis_fp5$EndDate <- cordis_fp5$endDate

cordis_fp5$FundingAmount <- cordis_fp5$ecMaxContribution
cordis_fp5$FundingCurrency <- "EUR"
range(cordis_fp5$ecMaxContribution, na.rm = T)

cordis_fp5$TitleAbstract <- paste(cordis_fp5$title,
                                  cordis_fp5$objective)

write.csv(cordis_fp5[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp5-raw-metadata.csv")
write.csv(cordis_fp5[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp5-raw-text.csv")

rm(cordis_fp5)

# fp6
cordis_fp6 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_fp6_projects.csv")
unique(cordis_fp6$frameworkProgramme)
unique(cordis_fp6$fundingScheme)

range(cordis_fp6$ecMaxContribution, na.rm = T)
unique(cordis_fp6$programme)

cordis_fp6$ProjectId <- paste0("FP6_", cordis_fp6$id, "_", seq(1, nrow(cordis_fp6)))
cordis_fp6$Country <- "EU"
cordis_fp6$CountryFundingBody <- "EU-FP"
cordis_fp6$FundingBody <- "FP6"
cordis_fp6$LeadInstitution <- cordis_fp6$coordinator
cordis_fp6$LeadInstitutionCountry <- cordis_fp6$coordinatorCountry
cordis_fp6$StartDate <- cordis_fp6$startDate
cordis_fp6$EndDate <- cordis_fp6$endDate
cordis_fp6$FundingAmount <- as.numeric(cordis_fp6$ecMaxContribution)
cordis_fp6$FundingCurrency <- "EUR"

cordis_fp6$TitleAbstract <- paste(cordis_fp6$title,
                                  cordis_fp6$objective)

write.csv(cordis_fp6[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp6-raw-metadata.csv")
write.csv(cordis_fp6[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp6-raw-text.csv")

rm(cordis_fp6)

# fp7
cordis_fp7 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_fp7_project.csv")

cordis_fp7_org <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_fp7_organization.csv")
unique(cordis_fp7_org$role)
cordis_fp7_org_coord <- subset(cordis_fp7_org, role == "coordinator")
length(unique(cordis_fp7$id))
length(unique(cordis_fp7_org_coord$projectID))


cordis_fp7_org_coord[duplicated(cordis_fp7_org_coord$projectID),]
subset(cordis_fp7_org_coord, projectID == 336679)
unique(cordis_fp7_org_coord$order)
subset(cordis_fp7_org_coord, order == 3)

cordis_fp7_org_coord <- cordis_fp7_org_coord[!duplicated(cordis_fp7_org_coord$projectID),]

unique(cordis_fp7$frameworkProgramme)
unique(cordis_fp7$fundingScheme)

cordis_fp7 <- left_join(cordis_fp7,
                        cordis_fp7_org_coord[,c("projectID", "name", "country")],
                        by = c("id" = "projectID"))

range(cordis_fp7$ecMaxContribution, na.rm = T)
unique(cordis_fp7$programme)

cordis_fp7$ProjectId <- paste0("FP7_", cordis_fp7$id, "_", seq(1, nrow(cordis_fp7)))
cordis_fp7$Country <- "EU"
cordis_fp7$CountryFundingBody <- "EU-FP"
cordis_fp7$FundingBody <- "FP7"
cordis_fp7$LeadInstitution <- cordis_fp7$name
cordis_fp7$LeadInstitutionCountry <- cordis_fp7$country
cordis_fp7$StartDate <- cordis_fp7$startDate
cordis_fp7$EndDate <- cordis_fp7$endDate
cordis_fp7$FundingAmount <- cordis_fp7$ecMaxContribution
cordis_fp7$FundingCurrency <- "EUR"

cordis_fp7$TitleAbstract <- paste(cordis_fp7$title,
                                  cordis_fp7$objective)

write.csv(cordis_fp7[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp7-raw-metadata.csv")
write.csv(cordis_fp7[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp7-raw-text.csv")

unique(cordis_fp7$subCall)
unique(cordis_fp7$fundingScheme[grepl("ERC-", cordis_fp7$fundingScheme)])

# Non-erc
write.csv(cordis_fp7[!grepl("ERC-", cordis_fp7$fundingScheme),
                     c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp7NoERC-raw-metadata.csv")
write.csv(cordis_fp7[!grepl("ERC-", cordis_fp7$fundingScheme),
                     c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp7NoERC-raw-text.csv")

rm(cordis_fp7, cordis_fp7_org, cordis_fp7_org_coord)


# horizon 2020
h_2020 <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_H2020_project.csv")

h2020_org <- read.csv2("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/cordis_H2020_organization.csv")
unique(h2020_org$role)
h2020_org_coord <- subset(h2020_org, role == "coordinator")

unique(h_2020$frameworkProgramme)
unique(h_2020$fundingScheme)

h_2020 <- left_join(h_2020,
                    h2020_org_coord[,c("projectID", "name", "country")],
                    by = c("id" = "projectID"))

range(h_2020$ecMaxContribution, na.rm = T)
unique(h_2020$programme)

h_2020$ProjectId <- paste0("H2020_", h_2020$id, "_", seq(1, nrow(h_2020)))
h_2020$Country <- "EU"
h_2020$CountryFundingBody <- "EU-FP"
h_2020$FundingBody <- "H2020"
h_2020$LeadInstitution <- h_2020$name
h_2020$LeadInstitutionCountry <- h_2020$country
h_2020$StartDate <- as.character(lubridate::dmy(h_2020$startDate))
h_2020$EndDate <- as.character(lubridate::dmy(h_2020$endDate))
h_2020$FundingAmount <- h_2020$ecMaxContribution
h_2020$FundingCurrency <- "EUR"

h_2020$TitleAbstract <- paste(h_2020$title,
                              h_2020$objective)

write.csv(h_2020[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/h2020-raw-metadata.csv")
write.csv(h_2020[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/h2020-raw-text.csv")

# NO ERC
unique(h_2020$fundingScheme)
write.csv(h_2020[!grepl("ERC-", h_2020$fundingScheme),
                 c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/h2020NoERC-raw-metadata.csv")
write.csv(h_2020[!grepl("ERC-", h_2020$fundingScheme),
                 c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/h2020NoERC-raw-text.csv")

rm(h_2020, h2020_org, h2020_org_coord)

# horizon Europe
h_eur <- read_xlsx("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/horizon_europe.xlsx")

h_eur <- h_eur[h_eur$`Partner Role` == "COORDINATOR",]
unique(h_eur$`Pillar Descr`)
unique(h_eur$Programme)
unique(h_eur$`Thematic Priority Descr`)

h_eur$ProjectId <- paste0("HorizonEurope_", h_eur$`Project Number`, "_", seq(1, nrow(h_eur)))
h_eur$Country <- "EU"
h_eur$CountryFundingBody <- "EU-FP"
h_eur$FundingBody <- "Horizon Europe"
h_eur$LeadInstitution <- h_eur$`Legal Name`
h_eur$LeadInstitutionCountry <- h_eur$`Country Code`
h_eur$StartDate <- h_eur$`Project Start Date`
h_eur$EndDate <- h_eur$`Project End Date`
h_eur$FundingAmount <- h_eur$`EU Contribution`
h_eur$FundingCurrency <- "EUR"

h_eur$TitleAbstract <- h_eur$`Project Title`

write.csv(h_eur[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/HorizonEurope-raw-metadata.csv")
write.csv(h_eur[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/HorizonEurope-raw-text.csv")

write.csv(h_eur[h_eur$`Thematic Priority Descr` != "European Research Council (ERC)",
                c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/HorizonEuropeNoERC-raw-metadata.csv")
write.csv(h_eur[h_eur$`Thematic Priority Descr` != "European Research Council (ERC)",
                c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/HorizonEuropeNoERC-raw-text.csv")

rm(h_eur)


# ERC
erc <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/erc.tsv",
                sep = "\t")

erc$LeadInstitutionCountry <- erc$Country
erc$ProjectId <- paste0("ERC_", erc$Project.number, "_", seq(1, nrow(erc)))
erc$Country <- "EU"
erc$CountryFundingBody <- "EU-ERC"
erc$FundingBody <- "ERC"
erc$LeadInstitution <- erc$Host.Institution

erc$StartDate <- sapply(strsplit(erc$Call.ID, "-"), `[`, 2)
erc$EndDate <- NA
erc$FundingAmount <- as.numeric(gsub("\\.", "", erc$Project.budget))
sum(grepl(",", erc$Project.budget))
erc$FundingCurrency <- "EUR"

erc$TitleAbstract <- paste(erc$Project.title,
                           erc$Abstract)

write.csv(erc[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/erc-raw-metadata.csv")
write.csv(erc[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/erc-raw-text.csv")
rm(erc)


# NOTE:
# ERC is a subset of FP7, Horizon 2020 and Horizon Europe
# Drop ERC from FP7, Horizon 2020 and Horizon Europe
# DONE

# Combine all into single files - eu-raw-text...
rm(erc, h_2020, h2020_org, h2020_org_coord, test)

eu_meta <- bind_rows(
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp1-raw-metadata.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp2-raw-metadata.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp3-raw-metadata.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp4-raw-metadata.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp5-raw-metadata.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp6-raw-metadata.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp7NoERC-raw-metadata.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/h2020NoERC-raw-metadata.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/HorizonEuropeNoERC-raw-metadata.csv")
)

erc <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/erc-raw-metadata.csv")
erc$StartDate <- as.character(erc$StartDate)

eu_meta <- bind_rows(eu_meta,
                     erc)

eu_txt <- bind_rows(
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp1-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp2-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp3-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp4-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp5-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp6-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp7NoERC-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/h2020NoERC-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/HorizonEuropeNoERC-raw-text.csv"),
  read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/erc-raw-text.csv")
)

write.csv(eu_meta[,c(meta_cols, "LeadInstitutionCountry")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/eu-raw-metadata.csv")
write.csv(eu_txt[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/eu-raw-text.csv")

rm(erc, eu_meta, eu_txt)

# test <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/erc-raw-metadata.csv")
# range(test$StartDate)
# 
# test <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/h2020-raw-metadata.csv")
# 
# test <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Europe/fp7-raw-metadata.csv")



# %%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%
# Denmark
# DFF
# dff <- read.csv("Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Denmark/dff_grants.csv")
# 
# unique(dff$Department)
# dff$ProjectId <- paste0("DFF_", seq(1, nrow(dff)))
# dff$Country <- "Denmark"
# dff$CountryFundingBody <- "DFF"
# dff$FundingBody <- "DFF"
# # dff$LeadInstitution
# 
# dff$StartDate <- as.numeric(dff$StartYear)
# dff$EndDate <- NA
# # dff$FundingAmount 
# # dff$FundingCurrency
# 
# dff$TitleAbstract <- dff$Title
# 
# sum(grepl("\\(adm", dff$LeadInstitution))
# dff$LeadInstitution[grepl("\\(adm", dff$LeadInstitution)] <- sapply(strsplit(dff$LeadInstitution[grepl("\\(adm", dff$LeadInstitution)], "\\(adm"),
#                                                                     `[`,
#                                                                     1)
# 
# write.csv(dff[,meta_cols],
#           "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Denmark/dff-raw-metadata.csv")
# write.csv(dff[,c("ProjectId", "TitleAbstract")],
#           "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Denmark/dff-raw-text.csv")
# 
# # "Departments" to drop
# # [4] "Social sciences"                                                                
# # [6] "Humanities"                                                                     
# # [14] "thematic » Socio-economic effects of welfare investments"   
# # [15] "thematic » Learning and education quality"    
# # [10] "thematic » Early action" - Health/economics... ??     - many at social sci unis...                                                  
# # [13] "thematic » People and Society"   ?? social                                           
# 
# 
# dff_sci <- subset(dff, !(Department %in% c("Social sciences",
#                                            "Humanities",
#                                            "thematic » Socio-economic effects of welfare investments",
#                                            "thematic » Learning and education quality",
#                                            "thematic » Early action",
#                                            "thematic » People and Society")))
# unique(dff_sci$Department)
# 
# write.csv(dff_sci[,meta_cols],
#           "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Denmark/dff-sci-raw-metadata.csv")
# write.csv(dff_sci[,c("ProjectId", "TitleAbstract")],
#           "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Denmark/dff-sci-raw-text.csv")
# rm(dff, dff_sci)
# 

# %%%%%%%%%%%
# Norway - rcn
# %%%%%%%%%%%

rcn <- read.csv("~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Norway/rcn-scrape.csv")

# Need to split up Organisations
# Seems like split on "/" and item 3 is lead org
rcn$Org_sector <- sapply(strsplit(rcn$Organisation, " /"), `[`, 1)

# "UoH-sektor"       "Næringsliv"       "Instituttsektor"  "Offentlig sektor"
# [5] "Øvrige"           "ukjent"           "Helseforetak"     "Ukjent Sektor"   
# [9] "Utlandet"  

subset(rcn, Org_sector == "Utlandet")[,"Organisation"]
subset(rcn, Org_sector == "Ukjent Sektor")[,"Organisation"]
subset(rcn, Org_sector == "ukjent")[,"Organisation"]
subset(rcn, Org_sector == "Øvrige")[,"Organisation"]

# Tidy Project_Period to start/end
# Tidy Award to numeric values 


rcn$ProjectId <- paste0("RCN_", rcn$Project_Number, "_", seq(1, nrow(rcn)))
rcn$Country <- "Norway"
rcn$CountryFundingBody <- "RCN"
rcn$FundingBody <- "RCN"
rcn$LeadInstitution <- sapply(strsplit(rcn$Organisation, " / "), `[`, 3)

rcn$StartDate <- sapply(strsplit(rcn$Project_Period, " - "), `[`, 1)
rcn$EndDate <- sapply(strsplit(rcn$Project_Period, " - "), `[`, 2)


rcn$funding_num <- gsub(" NOK ", "", rcn$Award)
unique(gsub("[0-9]", "", rcn$funding_num[grepl("[a-z]", rcn$funding_num)]))

rcn$funding_mult <- 1
rcn$funding_mult[grepl("mill.", rcn$funding_num)] <- 1000000
rcn$funding_mult[grepl("bill.", rcn$FundingAmount)] <- 1000000000

rcn$funding_num <- gsub(" mill.", "", rcn$funding_num)
rcn$funding_num <- gsub(" bill.", "", rcn$funding_num)
rcn$funding_num <- gsub(",", "", rcn$funding_num)

rcn$FundingAmount <- as.numeric(rcn$funding_num) * rcn$funding_mult
rcn$FundingCurrency <- "NOK"

rcn$Abs <- rcn$Summary
rcn$Abs[rcn$Summary == ""] <- rcn$Popular.Science.Description[rcn$Summary == ""]


rcn$TitleAbstract <- paste(rcn$Title,
                           rcn$Abs)

write.csv(rcn,
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Norway/rcn-scrape-proc.csv")

# Need to split out subjects - only get sci
rcn$Subject_Fields[1:5]
# Seems like split on "/" , and first item is broad area..
# Or just grepl and find any sci... in case 

# Annet : Other
# Humaniora : Humanities
# Landbruks- og fiskerifag : Agriculture and fisheries
# Matematikk og naturvitenskap : Maths and natural sci
# Medisin og helsefag : Medicine and health
# Samfunnsvitenskap : Social sci
# Teknologi : Technology
# Ukjent : Unknown

rcn$sci_bool <- (grepl("Landbruks- og fiskerifag", rcn$Subject_Fields) |
                   grepl("Matematikk og naturvitenskap", rcn$Subject_Fields) |
                   grepl("Medisin og helsefag", rcn$Subject_Fields) |
                   grepl("Teknologi", rcn$Subject_Fields) )

rcn$unknown_bool <- (grepl("Annet", rcn$Subject_Fields) |
                       grepl("Ukjent", rcn$Subject_Fields))

subset(rcn, unknown_bool == T)[,"Subject_Fields"] %>% unique()


View(rcn[grepl("Forskningsformidling", rcn$Subject_Fields),])
# May be relevant...


rcn_sci <- subset(rcn, sci_bool == T)
write.csv(rcn_sci[,meta_cols],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Norway/rcn-raw-metadata.csv")

write.csv(rcn_sci[,c("ProjectId", "TitleAbstract")],
          "~/Documents/Funding-Landscape-LOCAL/raw-data/fine-scale/Norway/rcn-raw-text.csv")



