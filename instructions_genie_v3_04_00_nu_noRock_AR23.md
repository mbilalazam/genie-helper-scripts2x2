#Login to NERSC
ssh mazam@perlmutter.nersc.gov

# Clone Repos
git clone https://github.com/DUNE/ND_Production.git
git clone https://github.com/DUNE/2x2_sim.git

# Go to the relevant directory
cd /global/homes/m/mazam/2x2_sim/run-genie

# Export block
# --- Fiducial GENIE config (MiniRun5-Nu, reused in MiniRun6.x) ---
export ARCUBE_RUNTIME=SHIFTER
export ARCUBE_CONTAINER=mjkramer/sim2x2:genie_edep.3_04_00.20230912

export ARCUBE_DET_LOCATION=MiniRun5-Nu
export ARCUBE_DK2NU_DIR=/global/cfs/cdirs/dune/users/2x2EventGeneration/NuMI_dk2nu/newtarget-200kA_20220409
export ARCUBE_EXPOSURE=1E19
export ARCUBE_GEOM=geometry/Merged2x2MINERvA_v4/Merged2x2MINERvA_v4_noRock.gdml
export ARCUBE_TUNE=AR23_20i_00_000
export ARCUBE_RUN_OFFSET=0
export ARCUBE_XSEC_FILE=/global/cfs/cdirs/dune/users/2x2EventGeneration/inputs/NuMI/genie_xsec-3.04.00-noarch-AR2320i00000-k250-e1000/v3_04_00/NULL/AR2320i00000-k250-e1000/data/gxspl-NUsmall.xml
export ARCUBE_OUT_NAME=BilalTest.genie.nu

export ARCUBE_INDEX=0

# Create the symlink inside your 2x2_sim clone
mkdir -p /global/u1/m/mazam/2x2_sim/tmp_bin
ln -sf /usr/bin/time /global/u1/m/mazam/2x2_sim/tmp_bin/time

# Since time call is causing issues and is not essential for producing GENIE files, just edit the script and bypass it entirely.
nano ../util/init.inc.sh

# OLD
run() {
    echo RUNNING "$@" | tee -a "$logFile"
    time "$timeProg" --append -f "$1 %P %M %E" -o "$timeFile" "$@" 2>&1 | tee -a "$logFile"
}

#NEW
run() {
    echo RUNNING "$@" | tee -a "$logFile"
    "$@" 2>&1 | tee -a "$logFile"
}


# Run Genie
./run_genie.sh



# SETUP ROOT
module load python
conda create -n root-env -c conda-forge root -y

conda activate root-env

which root
root --version

cd /global/homes/m/mazam/2x2_sim/run-genie/BilalTest.genie.nu/GHEP/0000000

rootls BilalTest.genie.nu.0000000.GHEP.root
dkmetaTree  dkmetaTree  gconfig  genv  gtree  header

root -l BilalTest.genie.nu.0000000.GHEP.root
gtree->GetEntries()
gtree->Show(0)  // shows first event
gtree->Show(1)  // shows second event

gntpc -i BilalTest.genie.nu.0000000.GHEP.root -f gst -o BilalTest.genie.nu.0000000.gst.root
