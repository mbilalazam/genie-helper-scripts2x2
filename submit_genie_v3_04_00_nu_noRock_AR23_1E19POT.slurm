#!/bin/bash
#SBATCH --qos=regular
#SBATCH --constraint=cpu
#SBATCH --job-name=genie_array_1e18
#SBATCH --account=dune
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=16GB
#SBATCH --array=0-9
#SBATCH --output=logs/genie.%A_%a.out
#SBATCH --error=logs/genie.%A_%a.err

# IMPORTANT: pin the Shifter image
#SBATCH --image=mjkramer/sim2x2:genie_edep.3_04_00.20230912

# ---- Setup paths (scratch/CFS recommended) ----
export RUN_TOP=/global/homes/m/mazam/2x2_sim/run-genie
export WORK_TOP=${PSCRATCH:-/pscratch/undefined}/bilal/genie_1e19
mkdir -p "$WORK_TOP"/logs

# Per-task working/output dir to avoid collisions
export TASK_ID=${SLURM_ARRAY_TASK_ID}
export JOB_WORKDIR=$WORK_TOP/job_${TASK_ID}
mkdir -p "$JOB_WORKDIR"
cd "$RUN_TOP"

# ---- ARCUBE / GENIE config (your values) ----
export ARCUBE_RUNTIME=SHIFTER
export ARCUBE_CONTAINER=mjkramer/sim2x2:genie_edep.3_04_00.20230912

export ARCUBE_DET_LOCATION=MiniRun5-Nu
export ARCUBE_DK2NU_DIR=/global/cfs/cdirs/dune/users/2x2EventGeneration/NuMI_dk2nu/newtarget-200kA_20220409
export ARCUBE_EXPOSURE=1E18    # each array task generates 1e18 POT
export ARCUBE_GEOM=geometry/Merged2x2MINERvA_v4/Merged2x2MINERvA_v4_noRock.gdml
export ARCUBE_TUNE=AR23_20i_00_000
export ARCUBE_RUN_OFFSET=0
export ARCUBE_XSEC_FILE=/global/cfs/cdirs/dune/users/2x2EventGeneration/inputs/NuMI/genie_xsec-3.04.00-noarch-AR2320i00000-k250-e1000/v3_04_00/NULL/AR2320i00000-k250-e1000/data/gxspl-NUsmall.xml
export ARCUBE_OUT_NAME=BilalTest.genie.nu

# INDEX must be unique per task
export ARCUBE_INDEX=${TASK_ID}

# Optional: bind threads explicitly if your code uses OpenMP
export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread

# Make run-specific output dir inside scratch and point run_genie there if it supports it
export ARCUBE_OUT_DIR="$JOB_WORKDIR"
mkdir -p "$ARCUBE_OUT_DIR"

echo "==> Starting task ${TASK_ID} in $JOB_WORKDIR"
echo "==> Writing outputs to: $ARCUBE_OUT_DIR"

# Run inside the Shifter image
# (If run_genie.sh uses ARCUBE_OUT_DIR, it will write there; otherwise it writes into CWD)
srun shifter ./run_genie.sh

# Optionally list outputs for quick sanity check
ls -lh "$ARCUBE_OUT_DIR" || true
