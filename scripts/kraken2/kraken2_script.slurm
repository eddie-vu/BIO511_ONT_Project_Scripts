#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J kraken2_job
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=12 # Request 1 node with 12 CPUs
#SBATCH -t 01:00:00
#SBATCH --output=/cephyr/users/eddievu/Vera/BIO511_sequencing/output_error/output_error.out  # Standard output
#SBATCH --error=/cephyr/users/eddievu/Vera/BIO511_sequencing/output_error/output_error.err   # Standard error

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/singularity_images/kraken2.sif"
DB_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/ref_dbs/kraken2db"
DATA_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/BIO511_project/BIO511_project/results/fastqlong_data/30_min/30_min/small_cut"
RESULTS_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/students/Eddie/BIO511/BIO511_project/BIO511_project/results/kraken2_data/30_min/small_cut/"

# Bind paths for container
export SINGULARITY_BINDPATH="${DB_PATH}:/db,${DATA_PATH}:/data,${RESULTS_PATH}:/results"

# Create results directory
mkdir -p ${RESULTS_PATH}

# Identify sample
sample="CCUG-55970_filtered_30"
echo "Processing sample: ${sample}"

# Run Kraken2 classification
srun singularity exec ${CONTAINER_PATH} kraken2 \
        --db /db \
        --threads 8 \
        --output /results/${sample}_kraken2_output.txt \
        --report /results/${sample}_kraken2_report.txt \
        --classified-out /results/${sample}_classified#.fastq \
        --unclassified-out /results/${sample}_unclassified#.fastq \
        /data/${sample}.fastq
        

echo "Completed classification for ${sample}"

echo "All samples processed successfully"