# function (x) to count the number of non-zero records in each column (ie per sample)
nonzero <- function(x) sum(x != 0)

# Input Validation Functions
is_csv_or_tsv <- function(input_file, radio_separator, verbose=FALSE) {
  if(radio_separator == ",") { 
    sep_str = "csv"
  } else if(radio_separator == "\t") { 
    sep_str = "tsv"
  }
  
  df.tmp <- read.csv(input_file, sep = radio_separator)
  
  ## check number of columns: if sep is not alright, will just produce 1
  if (dim(df.tmp)[2]==1) {
    print(paste0("+ File provided is not available or extension doesn't match the chosen delimiter"))  
    return(NULL)
  }
  
  print("+ File provided is readable")
  if (verbose) { 
    print("Data example:")
    print(head(df.tmp)[1:5, 1:5]) } 
  return(df.tmp)
}

has_correct_header <- function(df_given, verbose=FALSE) {
  
  if("mir_name" %in% colnames(df_given)) {
    print("+ Header looks OK")
    if (verbose) {  
      print("Colnames: ")
      print(colnames(df_given)) 
    }
    return(TRUE)
    
  } else {
    print("+ Input file must have a column named \"mir_name\" (containing miR IDs). Could not find a column by this name.")
    return(FALSE)
  }
}

at_least_one_library_one_million_reads <- function(df_given, verbose=FALSE) {
  
  library(dplyr)
  colSumLibrary <- summarise_all(df_given, ~if(is.numeric(.)) sum(.) else "Total")
  
  if (verbose) { print("colSumLibrary: ") }
  if (verbose) { print(colSumLibrary) }
  if(any(colSumLibrary>1000000)) {
    print("+ Input file contains some libraries with greater than one million reads.")
    return(TRUE)
    
  } else {
    print("+ Input file contains no libraries with greater than one million reads.")
    return(FALSE)
  }
}

#' Wrapper function for validating miRNA counts matrix file
#'
#' This function wraps other functions to check whether data meets the required criteria
#' of minimun count, colnames, etc
#'
#' @param raw_data Absolute path to raw_Data counts
#' @param radio_separator Separator: ",", "\t", ";", etc
#' @param verbose Boolean to show more/less information
#' @param file_given Boolean to identify either raw_data is a file or a dataframe
#' @return Boolean with either TRUE/FALSE if it meets the criteria
#' @export
validate_input <- function(raw_data, radio_separator = ",", verbose=FALSE, file_given=TRUE) {
  
  if (verbose) { print("## Validating input file & options ")}
  
  if (file_given) {
    ## Find if readable
    df.tmp <- is_csv_or_tsv(raw_data, radio_separator, verbose)
    
  } else {
    df.tmp <- raw_data
  }
  
  if (is.null(df.tmp)) { return(FALSE) }
  
  ## Find if correct header
  if (has_correct_header(df_given = df.tmp, verbose)) {
    ## Find if minimun counts
    if (at_least_one_library_one_million_reads(df_given = df.tmp, verbose)) {
      if (verbose) { print("##################################")}
      return(TRUE)
    }}
  
  return(FALSE)
}

#' Parse miRNA counts matrix file
#'
#' This function parses the original raw counts data that requires to meet some criteria
#' of minimun count, colnames, etc
#'
#' @param raw_data Absolute path to raw_Data counts
#' @param sep_input Separator: ",", "\t", ";", etc
#' @param verbose Boolean to show more/less information
#' @return Dataframe containing samples as columns and miRNAs as rows with raw counts
#' @export
draculR_parse_file <- function(raw_data, sep_input=",", verbose=FALSE) {
  
  ## validate file  
  validation_point <- validate_input(test_file, radio_separator = sep_input, verbose = verbose)
  
  if (validation_point) {
    
  } else {
    print("Some error ocurred, please check instructions or add correct parameters...")
    return()
  }
  
  ##################################
  ## parse original  data
  ##################################
  ## parse
  temp_counts <- read.table(file = raw_data,
                            sep = sep_input,
                            header = TRUE,
                            stringsAsFactors = FALSE) %>%
    dplyr::mutate_if(is.integer, as.numeric) %>%
    as.data.frame() %>%
    tibble::column_to_rownames("mir_name") %>%
    replace(is.na(.), 0)
  
  print("+ Original file:")
  print("dim(temp_counts)")
  print(dim(temp_counts))
  
  ## validate
  # identify samples with < 1 million reads
  lowCounts <- names(temp_counts[, base::colSums(temp_counts) < 1000000])
  
  # remove columns/samples with readcounts less than 1 million
  counts <- temp_counts[, base::colSums(temp_counts) > 1000000]
  
  print("+ Remove columns/samples with readcounts less than 1 million:")
  print("dim(counts)")
  print(dim(counts))
  
  # reduce any individual count less than five to zero
  print("+ Reduce any individual count less than five to zero")
  counts[counts < 5] <- 0
  
  # remove miRNAs with zero counts in all samples
  print("+ Remove miRNAs with zero counts in all samples")
  counts <- counts[ base::rowSums(counts)!=0, ]
  print("dim(counts)")
  print(dim(counts))
  ##################################
  
  return(counts)
  
}