# R code to combine funder-year data into funder data for India
# Data accessed/scraped using nstmis_scrape.py

india_path <- "../raw-data/fine-scale/India_temp"
india_comb_path <- "../raw-data/fine-scale/India"
india_f <- list.files(india_path,
                      full.names = F)
india_funders <- sapply(strsplit(india_f, "-"), `[`, 1)

india_f_df <- data.frame("FileName" = india_f,
                         "FundingBody" = india_funders)

un_india_funders <- unique(india_funders)

if (!file.exists(india_comb_path)){
  dir.create(india_comb_path)
}
# for each funder
for (funder in un_india_funders){
  tmp_f_ls <- subset(india_f_df, FundingBody == funder)[,"FileName"]
  
  out_ls <- vector("list", length(tmp_f_ls))
  # load all files, to each file, add unID, funder_yr_idx
  for (idx in 1:length(tmp_f_ls)){
    tmp_df <- read.csv(file.path(india_path, tmp_f_ls[idx]))
    if (nrow(tmp_df)>0){
      tmp_df$ProjectID <- paste(tmp_df$Funding_Agency_Short,
                                tmp_df$Year,
                                1:nrow(tmp_df),
                                sep = "_")
      out_ls[[idx]] <- tmp_df
    }
  }
  # bind all files
  out_df <- do.call(rbind, out_ls)
  # edit colnames?
  # save to subfolder
  write.csv(out_df,
            file.path(india_comb_path, paste0(tolower(funder), ".csv")))
  # head(out_df)
  # print(file.path(india_comb_path, paste0(funder, ".csv")))
}



india_comb_f <- list.files(india_comb_path,
                           full.names = T)
nrow_vec <- rep(0, length(india_comb_f))

for (idx in 1:length(india_comb_f)){
  tmp_df <- read.csv(india_comb_f[idx])
  nrow_vec[idx] <- nrow(tmp_df)
}

sum(nrow_vec)
# [1] 78468


# Note: MOEF and MOEN are the same, MOEN is a typo from the website...
moef_df <- read.csv("../raw-data/fine-scale/India/moef.csv")
moen_df <- read.csv("../raw-data/fine-scale/India/moen.csv")

unique(moef_df$Funding_Agency)
unique(moen_df$Funding_Agency)

moen_df$Funding_Agency_Short <- "MOEF"
moen_df$ProjectID <- gsub("MOEN", "MOEF", moen_df$ProjectID)
head(moen_df)

moef_df_ <- rbind(moen_df, moef_df)
write.csv(moef_df_[,-1],
          "../raw-data/fine-scale/India/moef.csv")

# delete ../raw-data/fine-scale/India/moen.csv
file.remove("../raw-data/fine-scale/India/moen.csv")


# NOTE: moef becomes moefcc in 2015-26