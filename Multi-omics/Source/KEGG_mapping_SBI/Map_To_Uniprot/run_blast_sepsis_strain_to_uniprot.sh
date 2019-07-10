#!/bin/bash

### author: Ignaitus Pang ` i.pang at unsw.edu.au '


#PBS -N BLASTP
#PBS -l nodes=1:ppn=4
#PBS -l mem=31gb
#PBS -l walltime=01:00:00
#PBS -j oe
#PBS -M i.pang@unsw.edu.au
#PBS -m ae

# Command for running array jobs 
#PBS -J 1-21

module load blast+/2.9.0

COUNTER=0
COUNTER_B=0

for j in `seq 0 20`;
do
      COUNTER=$((COUNTER+1))
      
      #  echo $COUNTER
      
      if [ $COUNTER -eq $PBS_ARRAY_INDEX ]
      then
        COUNTER_B=$j   
        break
      fi
done



echo COUNTER_B="$COUNTER_B"

SEQ_B_DIR=/srv/scratch/z3371724/Sepsis/Data/Proteome_File_Per_Strain
UNIPROT_DB=/srv/scratch/z3371724/Sepsis/Data/Uniprot/Uniprot_Sprot/uniprot_sprot.fasta
OUTPUT_DIR=/srv/scratch/z3371724/Sepsis/Results/Blast_Strain_To_Uniprot_DB

if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir $OUTPUT_DIR
fi 

list_of_files_b=( $(find $SEQ_B_DIR/*.faa) )


file_name_b=${list_of_files_b[$COUNTER_B]}
temp_name_b=${list_of_files_b[$COUNTER_B]##*/}
strain_name_b=${temp_name_b%.*}

echo file_name_b="$file_name_b"
echo strain_name_b="$strain_name_b"

if [ ! -f $OUTPUT_DIR/$strain_name_b.tab ] 
then
	blastp -query $file_name_b -db $UNIPROT_DB -outfmt 7 -evalue 0.1 -num_threads 4 \
  		-out $OUTPUT_DIR/$strain_name_b.tab
	
fi

