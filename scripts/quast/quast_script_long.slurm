#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J quast_analysis
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=4
#SBATCH -t 01:00:00
#SBATCH --output=/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/logs/output/quast_%j.out
#SBATCH --error=/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/logs/error/quast_%j.err

# Load or use containerized QUAST
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/singularity_images/quast.sif"

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS
DATA_PATH="/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/results/flye_results/long_cut/assembly/flye_polished"
RESULTS_PATH="/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/results/quast_results/long_cut"
OUTPUT_DIR="${RESULTS_PATH}/quast_results"

# Set the path to the assemblies
ASSEMBLIES_DIR="/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/results/flye_results/long_cut/assembly/flye_polished"

# Bind paths for container
export SINGULARITY_BINDPATH="${ASSEMBLIES_DIR}:/assemblies,${OUTPUT_DIR}:/output"

# Create output directory
mkdir -p ${OUTPUT_DIR}

# Run QUAST on both assemblies
singularity exec ${CONTAINER_PATH} quast.py \
    -o ${OUTPUT_DIR} \
    --threads 4 \
    --plots-format png \
    --labels "Polished" \
    /assemblies/assembly.fasta

echo "QUAST analysis completed"