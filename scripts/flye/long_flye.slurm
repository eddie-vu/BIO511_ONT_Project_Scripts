#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J flye_polished
#SBATCH -p vera  
#SBATCH -N 1 --cpus-per-task=12
#SBATCH -t 02:30:00
#SBATCH --output=/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/logs/output/flye_polished_long%j.out
#SBATCH --error=/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/logs/error/flye_polished_long%j.err

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS  
DATA_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/BIO511_project/BIO511_project/results/fastqlong_data/30_min/30_min/long_cut"
RESULTS_PATH="/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/results/flye_results/long_cut"
SINGULARITY_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/singularity_images/flye.sif"

# Set bind paths for Singularity
export SINGULARITY_BINDPATH="${DATA_PATH}:/data,${RESULTS_PATH}:/results"

# Set sample and output paths
ONT_READS="${DATA_PATH}/CCUG-55970_filtered_30.fastq"
OUTPUT_DIR="${RESULTS_PATH}/assembly/flye_polished"

# Create output directories
mkdir -p ${OUTPUT_DIR}

# Run Flye assembly with enhanced polishing
singularity exec ${SINGULARITY_PATH} flye --nano-raw /data/CCUG-55970_filtered_30_long.fastq \
     --out-dir /results/assembly/flye_polished \
     --threads 12 \
     --iterations 5 \

echo "Polished ONT assembly completed"