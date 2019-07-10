#!/bin/bash

### author: Ignaitus Pang ` i.pang at unsw.edu.au '


#PBS -N MakeDB
#PBS -l nodes=1:ppn=1
#PBS -l vmem=8gb
#PBS -l walltime=11:00:00
#PBS -j oe
#PBS -M i.pang@unsw.edu.au
#PBS -m ae

module load blast+/2.9.0


file_name=/srv/scratch/z3371724/Sepsis/Data/Uniprot/Uniprot_Sprot/uniprot_sprot.fasta
strain_name=uniprot_sprot


cd "$PBS_O_WORKDIR"

echo $file_name   > temp_$array_index.log
echo $strain_name >> temp_$array_index.log

makeblastdb -in $file_name -dbtype prot -title $strain_name -hash_index 



