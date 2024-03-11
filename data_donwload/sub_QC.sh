#!/bin/bash
#SBATCH -N 1
#SBATCH -c 2
#SBATCH -t 0-04:30
#SBATCH -p sapphire
#SBATCH --mem-per-cpu=15000
#SBATCH -o /n/home02/decarvalho/pangenomics/1_assembly/2_quality_control/allQC_%j.out
#SBATCH -e /n/home02/decarvalho/pangenomics/1_assembly/2_quality_control/allQC_%j_er.err
#SBATCH --mail-user="alvarodecarvalho33@gmail.com"
#SBATCH --mail-type=ALL

module load Anaconda2/2019.10-fasrc01
conda activate fastQC

cd "$SCRATCH/desai_lab/pangenomics/1_assembly/1_raw_reads"

FASTQC_DIR="/n/holyscratch01/desai_lab/pangenomics/1_assembly/2_quality_control/1_fastqc_files"
MULTIQC_DIR="/n/holyscratch01/desai_lab/pangenomics/1_assembly/2_quality_control/2_multiqc_files"

for report in *.fastq; do
        fastqc --nogroup $report -o $FASTQC_DIR
done

conda deactivate

conda activate multiQC

multiqc $FASTQC_DIR --outdir $MULTIQC_DIR

