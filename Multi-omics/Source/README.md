# Multi-omics analysis README

## 1. KEGG pathways annotations

The aim is to search the query protein sequences from bacterial strains of interest to find similar sequences in the Uniprot-SwissProt database using BlastP. Since the KEGG database contains information on the KEGG pathways annotations of Uniprot-SwissProt protein, we could transfer the KEGG pathways annotation to the query protein sequence based on homology. 

### 1.1 Downloading genomics sequences and data

We have to download the protein sequences in FASTA format.

* [Perl script for downloading protein sequences in FASTA format](Multi-omics/Source/Download_Sequences/fetch_fasta.pl)

The plasmids for each bactrial strain are labelled from p01, p02, etc... ranked from longest to shortest size. Downloading teh size of the chromosome and plasmids will help us work this out. Input is a list of RefSeq accessions (e.g. NZ_LR130511.1).  

* [Perl script for downloading the size of the chromosomes and plasmids](Multi-omics/Source/Download_Sequences/get_genome_size.pl)

### 1.2 Performing BlastP searches

* [Script for formatting the UniProt-SwissProt BlastP database on the UNSW Katana HPC PBS cluster](Multi-omics/Source/KEGG_mapping_SBI/make_blastdb_uniprot_sprot.sh)
* [Script for formatting the FASTA sequences for the bacterial strains of interest, to enable reciprocal top-hits BlastP searches (code has been run but not fully relevant for KEGG annotations)](Multi-omics/Source/KEGG_mapping_SBI/make_blastdb_sepsis_strains_proteome.sh)
* [Script for performing the BlastP searches on the UNSW Katana HPC](https://github.com/mabelbpa/Bioplatforms-Australia-Sepsis-Data-Integration/blob/master/Multi-omics/Source/KEGG_mapping_SBI/Map_To_Uniprot/run_blast_sepsis_strain_to_uniprot.sh)

### 1.3 Transferring KEGG annoations from similar UniProt sequences to query protein

* [R Notebook script for transferring KEGG annoations of similar UniProt seqeucnes to query protein from the bacterial strains of interest](Multi-omics/Source/KEGG_mapping_SBI/Map_To_Uniprot/parse_blast_sepsis_strain_to_uniprot.Rmd) **Warnings: requires at least 30 GB of RAM to run, otherwise it could hang up the computer.** 

### 1.4 Summary statistics of KEGG annotations for reporting and supplementary information

* [R Notebook script for transferring KEGG annoations of similar UniProt seqeucnes to query protein from the bacterial strains of interest](Multi-omics/Source/KEGG_mapping_SBI/Map_To_Uniprot/parse_blast_sepsis_strain_to_uniprot.Rmd) **Warnings: requires at least 30 GB of RAM to run, otherwise it could hang up the computer.** 

* [R Notebook script for calculating the summary statistics for each strain (e.g. percentage of proteins in the proteome annoatated with a KEGG pathway)](Multi-omics/Source/KEGG_mapping_SBI/Map_To_Uniprot/plot_summary_stats.Rmd)




