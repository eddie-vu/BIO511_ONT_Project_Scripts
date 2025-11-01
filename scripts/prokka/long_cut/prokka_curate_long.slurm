#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J prokka_curated
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=8
#SBATCH -t 01:00:00
#SBATCH --output=/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/logs/output/prokka_curate/long_cut/prokka_baseline_%j.out # output log, adjust path to where you want to save logs
#SBATCH --error=/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/logs/error/prokka_curate/long_cut/prokka_baseline_%j.err # error log, adjust path to where you want to save logs

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511/singularity_images/prokka.sif"
RESULTS_PATH="/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/data/prokka/prokka_curate/long_cut"
ASSEMBLIES_DIR="/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/data/flye/long_cut/assembly/flye_polished"
CURATED_PROTEINS="/cephyr/users/eddievu/Vera/eddie_student_folder/Eddie/BIO511/BIO511_project/BIO511_project/data/curated_protein/curatedRef.faa"
OUTPUT_DIR="${RESULTS_PATH}/annotation/prokka_curated"

# Bind paths for container
export SINGULARITY_BINDPATH="${ASSEMBLIES_DIR}:/assemblies,${RESULTS_PATH}:/results,${CURATED_PROTEINS}:/curatedRef.faa"

# Create output directories
mkdir -p ${OUTPUT_DIR}

# Input assembly
ASSEMBLY="/assemblies/assembly.fasta"

# Set a prefix variable for naming outputs
PREFIX="$(basename ${ASSEMBLY} .fa)_curated"

# Run Prokka (curated)
singularity exec ${CONTAINER_PATH} prokka \
  --cpus 8 \
  --outdir /results/annotation/prokka_curated \
  --prefix ${PREFIX} \
  --locustag BIO511 \
  --genus Escherichia \
  --species coli \
  --proteins /curatedRef.faa \
  --force \
  ${ASSEMBLY}

echo "Curated Prokka annotation completed"