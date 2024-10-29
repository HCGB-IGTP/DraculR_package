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
  $ git clone https://github.com/HCGB-IGTP/draculR.HCGB/
  $ cd draculR.HCGB
  $ source R/draculR_validate.R
  $ source R/draculR_counts.R
```

### Install R package

```r
# Install version from GitHub:
install.packages("devtools")
devtools::install_github("HCGB-IGTP/draculR.HCGB")
```

## Usage example

We will be using the original example provided by draculR developers available in dataExample/ folder.

The format is either csv or tsv and contains:
- raw counts of miRNAs for each sample
- sample names as column names
- the first column must be named "mir_name" and contains miRNAs names, following mirBase convention.  See details [here](https://www.mirbase.org/help)
  
See an example here:

| mir_name        | sample1           | sample2  | sample3 
| ------------- |:-------------:| -----:| --:|
| hsa-let-7a-5p | 34884 | 29245 | 31451 |
| hsa-let-7e-5p | 721 | 354| 326 | 
| hsa-let-7f-1-3p | 2 | 0 | 1 | 
| hsa-miR-1-3p | 50| 16| 65| 
| hsa-miR-100-5p | 6| 9| 6| 
| hsa-miR-101-3p | 964| 2021| 2287| 
| hsa-miR-101-5p | 1| 1| 0| 
| hsa-miR-103a-3p | 5090| 2728| 2994| 
| hsa-miR-106a-5p | 2 | 4 | 1 | 
| hsa-miR-107 | 160 | 319 | 256 | 
| hsa-miR-10a-3p | 2 | 2 | 0 | 



You can now open the `example_code.R` script and execute it from RStudio to get a working example.

See the code here:

```r
test_file <- "./dataExample/exampleCounts.csv"
counts.test <- draculR.HCGB::draculR_parse_file(raw_data = test_file, sep_input = ",", verbose = FALSE)
draculR_results <- draculR.HCGB::draculR_parse_counts(counts_df = counts.test)
draculR_results
```


