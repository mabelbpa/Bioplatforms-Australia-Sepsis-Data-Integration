#!/bin/bash

BASE_DIR=/home/ignatius/PostDoc/2019/Sepsis
SOURCE_DIR=$BASE_DIR/Source
MASTER_TAB_SRC_DIR=$SOURCE_DIR/Format_Master_Tables

PROTEOMICS_SWATH_DIR=$MASTER_TAB_SRC_DIR/Proteomics-SWATH
PROTEOMICS_MS1_DIR=$MASTER_TAB_SRC_DIR/Proteomics-MS1
TRANSCRIPTOMICS_DIR=$MASTER_TAB_SRC_DIR/Transcriptomics
METABOLOMICS_DIR=$MASTER_TAB_SRC_DIR/Metabolomics

PROTEOMICS_SWATH_FILE_LABEL=$PROTEOMICS_SWATH_DIR/Fold_Changes/parse_proteomics_swath_fold_change_table
PROTEOMICS_MS1_FILE_LABEL=$PROTEOMICS_MS1_DIR/Fold_Changes/parse_proteomics_ms1_fold_change_table
TRANSCRIPTOMICS_FILE_LABEL=$TRANSCRIPTOMICS_DIR/Fold_Changes/parse_transcriptomics_fold_changes
METABOLOMICS_FILE_LABEL=$METABOLOMICS_DIR/Fold_Changes/calculate_metabolomics_fold_change

Rscript --vanilla -e "rmarkdown::render('$PROTEOMICS_SWATH_FILE_LABEL.Rmd', output_file='$PROTEOMICS_SWATH_FILE_LABEL.html') " > $PROTEOMICS_SWATH_FILE_LABEL.log 2>&1 &
Rscript --vanilla -e "rmarkdown::render('$PROTEOMICS_MS1_FILE_LABEL.Rmd', output_file='$PROTEOMICS_MS1_FILE_LABEL.html') " > $PROTEOMICS_MS1_FILE_LABEL.log 2>&1 &
Rscript --vanilla -e "rmarkdown::render('$TRANSCRIPTOMICS_FILE_LABEL.Rmd', output_file='$TRANSCRIPTOMICS_FILE_LABEL.html') " > $TRANSCRIPTOMICS_FILE_LABEL.log 2>&1 &
Rscript --vanilla -e "rmarkdown::render('$METABOLOMICS_FILE_LABEL.Rmd', output_file='$METABOLOMICS_FILE_LABEL.html') " > $METABOLOMICS_FILE_LABEL.log 2>&1 &

# Rscript --vanilla -e "rmarkdown::render('.Rmd', output_file='.html') " > .log 2>&1 


tail $PROTEOMICS_SWATH_FILE_LABEL.log 
tail $PROTEOMICS_MS1_FILE_LABEL.log
tail $TRANSCRIPTOMICS_FILE_LABEL.log
tail $METABOLOMICS_FILE_LABEL.log

