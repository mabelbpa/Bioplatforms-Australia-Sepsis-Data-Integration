# Author: Ignaitus Pang ` i.pang at unsw.edu.au '

if(!require(pacman)) {
  install.packages("pacman")
  library(pacman)
}

p_load(here)

base_dir <- here::here( )
data_dir <- file.path( base_dir, "Data")
results_dir <- file.path(base_dir, "Results")
source_dir <- file.path(base_dir, "Source")
dropbox_dir <- "/home/ignatius/Dropbox"
owncloud_dir <- "/home/ignatius/ownCloud/Sepsis"
oc_results_dir <- file.path(owncloud_dir, "Multi-omics/Results" )

## Dates in which master table were compiled 
master_table_version_date <- "20190807"
