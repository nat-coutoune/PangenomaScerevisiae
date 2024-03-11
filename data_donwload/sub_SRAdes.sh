#!/bin/bash
#SBATCH -N 1
#SBATCH -c 5
#SBATCH -t 0-01:00
#SBATCH -p sapphire
#SBATCH --mem=5000
#SBATCH -o /n/home02/decarvalho/pangenomics/1_assembly/1_raw_reads/SRAdes_%j_less.out
#SBATCH -e /n/home02/decarvalho/pangenomics/1_assembly/1_raw_reads/SRAdes_%j_less_er.err
#SBATCH --mail-user="alvarodecarvalho33@gmail.com"
#SBATCH --mail-type=ALL

module load Anaconda2/2019.10-fasrc01
conda activate SRA_tools

RUNS_FILE="/n/holyscratch01/desai_lab/pangenomics/aux_files/runs.out"
RAW_READS_DIR="/n/holyscratch01/desai_lab/pangenomics/1_assembly/1_raw_reads"

while read -r line
do
	prefetch "$line" &&
	fasterq-dump "$line" &&
	rm -r "$RAW_READS_DIR/$line" 
done < "$RUNS_FILE"

read_enum="1"  
for aread in S*.fastq; do
    if [ -f "$aread" ]; then
        filename=$(basename "$aread")
        mv "$aread" "${read_enum}_${filename}"
        read_enum=$((read_enum + 1))
    fi
done

echo "INTEGRITY TEST:"
echo "- format"
echo "- size"
echo "- number of lines"
echo "~~~~~"
for afile in *.fastq; do
    file $afile
    du -ha $afile
    wc -l $afile
    echo "~~~~~"
done
