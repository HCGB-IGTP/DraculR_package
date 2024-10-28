#!/usr/bin/env Rscript

## update package
library(devtools)
library(roxygen2)

## set path containing package folder structure
setwd("./")
getwd()
devtools::document()

