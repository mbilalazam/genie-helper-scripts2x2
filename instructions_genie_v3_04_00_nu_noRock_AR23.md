# GENIE Simulation on NERSC (Perlmutter)

This guide documents how to produce GENIE samples on NERSC using the `2x2_sim` framework.  
Steps include repository setup, environment configuration, GENIE run, and basic ROOT validation.  

---

## 1. Login to NERSC
```bash
ssh mazam@perlmutter.nersc.gov
```

---

## 2. Clone Repositories
```bash
git clone https://github.com/DUNE/ND_Production.git
git clone https://github.com/DUNE/2x2_sim.git
```

---

## 3. Go to the Relevant Directory
```bash
cd /global/homes/m/mazam/2x2_sim/run-genie
```

---

## 4. Export Block

**Fiducial GENIE config (MiniRun5-Nu, reused in MiniRun6.x):**
```bash
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
```

---

## 5. Fix `time` Command Issues
```bash
# Create symlink
mkdir -p /global/u1/m/mazam/2x2_sim/tmp_bin
ln -sf /usr/bin/time /global/u1/m/mazam/2x2_sim/tmp_bin/time
```

If `time` continues to cause issues, edit `../util/init.inc.sh` and bypass it:

```bash
nano ../util/init.inc.sh
```

**OLD:**
```bash
run() {
    echo RUNNING "$@" | tee -a "$logFile"
    time "$timeProg" --append -f "$1 %P %M %E" -o "$timeFile" "$@" 2>&1 | tee -a "$logFile"
}
```

**NEW:**
```bash
run() {
    echo RUNNING "$@" | tee -a "$logFile"
    "$@" 2>&1 | tee -a "$logFile"
}
```

---

## 6. Run GENIE
```bash
./run_genie.sh
```

This produces GHEP and GST ROOT files under  
`BilalTest.genie.nu/GHEP/0000000/`.

---

## 7. Setup ROOT (via Conda)
```bash
module load python
conda create -n root-env -c conda-forge root -y
conda activate root-env

which root
root --version
```

---

## 8. Inspect GENIE Outputs
Navigate to the GHEP directory:
```bash
cd /global/homes/m/mazam/2x2_sim/run-genie/BilalTest.genie.nu/GHEP/0000000
```

Check contents:
```bash
rootls BilalTest.genie.nu.0000000.GHEP.root
# Expected: dkmetaTree  gconfig  genv  gtree  header
```

Inspect events:
```bash
root -l BilalTest.genie.nu.0000000.GHEP.root
gtree->GetEntries()
gtree->Show(0)   # shows first event
gtree->Show(1)   # shows second event
```

---

## 9. Convert GHEP → GST
```bash
gntpc -i BilalTest.genie.nu.0000000.GHEP.root -f gst -o BilalTest.genie.nu.0000000.gst.root
```

---

✅ At this point you have both `.GHEP.root` and `.gst.root` outputs, ready for analysis.
