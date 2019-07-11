# Multi-omics analysis README


## 1. KEGG pathways annotations

The aim is to search the query protein sequences from bacterial strains of interest to find similar sequences in the Uniprot-SwissProt database using BlastP. Since the KEGG database contains information on the KEGG pathways annotations of Uniprot-SwissProt protein, we could transfer the KEGG pathways annotation to the query protein sequence based on homology. 

### 1.1 Download Genomics Sequences and Data

We have to download the protein sequences in FASTA format.

* [Perl script for downloading protein sequences in FASTA format](Multi-omics/Source/Download_Sequences/fetch_fasta.pl)


* [Perl script for downloading the size of the chromosomes and plasmids](Multi-omics/Source/Download_Sequences/get_genome_size.pl)


1. BlastP

* 

