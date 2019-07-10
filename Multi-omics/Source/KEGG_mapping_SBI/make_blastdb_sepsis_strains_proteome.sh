#!/bin/bash

### author: Ignaitus Pang ` i.pang at unsw.edu.au '

#PBS -N MakeDB
#PBS -l nodes=1:ppn=1
#PBS -l vmem=8gb
#PBS -l walltime=11:00:00
#PBS -j oe
#PBS -M i.pang@unsw.edu.au
#PBS -m ae

# Command for running array jobs 
#PBS -J 0-50

module load blast+/2.9.0

data_dir=/srv/scratch/z3371724/Sepsis/Data/Proteome_File_Per_Strain
list_of_files=( $(find $data_dir/*.faa) )
array_index=$PBS_ARRAY_INDEX
file_name=${list_of_files[$array_index]}
temp_name=${list_of_files[$array_index]##*/}
strain_name=${temp_name%.*}

cd "$PBS_O_WORKDIR"

echo $file_name   > temp_$array_index.log
echo $strain_name >> temp_$array_index.log

# -input_type fasta

if [ ! -f data_dir/$file_name.psi ] 
then
  makeblastdb -in $file_name -dbtype prot -title $strain_name -hash_index 
fi  
