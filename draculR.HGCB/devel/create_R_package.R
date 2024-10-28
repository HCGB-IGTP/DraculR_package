#!/usr/bin/env Rscript

## Install packages
library(devtools)
#install.packages("roxygen2")
library(roxygen2)

## Sets upper directory as working directory
setwd("/imppc/labs/lslab/jsanchez/git_repo/HCGB_git/DraculR_package/")
getwd()

## creates package folder structure
devtools::create("draculR.HGCB")
