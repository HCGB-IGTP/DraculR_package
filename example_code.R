##################################
## data test
##################################
## test file
test_file <- "./dataExample/exampleCounts.csv"
source("./draculR.HGCB/R/draculR_counts.R")
source("./draculR.HGCB/R/draculR_validate.R")

## Number in smallest group, default=1
counts.test <- draculR_parse_file(raw_data = test_file, sep_input = ",", verbose = FALSE)
draculR_results <- draculR_parse_counts(counts_df = counts.test)

draculR_results

