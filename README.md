# DraculR R package
## A small repository for the DraculR minimun working code

DraculR is a new lightweight tool for haemolysis detection in human plasma miR-Seq datasets. See original publication and github repository [here](https://github.com/mxhp75/DraculR)

The original code allow you to execute a DraculR Shiny.io page <a href="https://mxhp75.shinyapps.io/DraculR">here</a> or using a local version

## What is the difference here?

Here, we have just set the code for the calculation of the draculR haemolysis score so that given a dataframe of miRNA counts, it determines the haemolysis score. 

No plots neither distributions are plotted. Please refer to the original code or shiny app to do so.

Please refer and cite the original code/paper appropriately.


Smith, Melanie D., Shalem Y. Leemaqz, Tanja Jankovic-Karasoulos, Dale McAninch, Dylan McCullough, James Breen, Claire T. Roberts, and Katherine A. Pillman. 2022. “Haemolysis Detection in MicroRNA-Seq from Clinical Plasma Samples.” Genes 13 (7). https://doi.org/10.3390/genes13071288.

### How to use it

Please ensure the following packages are installed on your local machine:

```r
library(dplyr)
library(plyr)
library(tidyr)
library(magrittr)
library(edgeR)
```

To install the draculR.HCGB package you can either clone the repository and source the functions or install the developer R package

### Clone and source

```bash
  $ cd folder/to/clone-into/
  $ git clone https://github.com/HCGB-IGTP/DraculR_package/
  $ 
  $ source draculR.HGCB/R/draculR_validate.R
  $ source draculR.HGCB/R/draculR_counts.R
```

### Install R package

```r
# Install version from GitHub:
install.packages("devtools")
devtools::install_github("HCGB-IGTP/DraculR_package", subdir="draculR.HCGB")
```

## Usage example

You can now open the `example_code.R` script and execute it from RStudio to get a working example.

```r
test_file <- "./dataExample/exampleCounts.csv"
counts.test <- draculR_parse_file(raw_data = test_file, sep_input = ",", verbose = FALSE)
draculR_results <- draculR_parse_counts(counts_df = counts.test)
draculR_results
```


