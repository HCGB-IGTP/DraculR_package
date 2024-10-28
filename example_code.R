##################################
## data test
##################################
## test file
source("./draculR.HGCB/R/draculR_counts.R")
source("./draculR.HGCB/R/draculR_validate.R")

test_file <- "./dataExample/exampleCounts.csv"
counts.test <- draculR_parse_file(raw_data = test_file, sep_input = ",", verbose = FALSE)
draculR_results <- draculR_parse_counts(counts_df = counts.test)
draculR_results

