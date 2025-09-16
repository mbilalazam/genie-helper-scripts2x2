# Nuisance Environment Setup on DUNE GPVM

This guide documents how to set up and run **Nuisance** with **nusystematics**  
on the DUNE GPVMs inside an SL7 Apptainer container.

---

## Step 1: Login to DUNE GPVM
```bash
kinit mazam@FNAL.GOV
ssh -KY mazam@dunegpvm13.fnal.gov
```

---

## Step 2: Start SL7 Container

### 2.1 Run SL7 Apptainer
```bash
/cvmfs/oasis.opensciencegrid.org/mis/apptainer/current/bin/apptainer shell --shell=/bin/bash -B /cvmfs,/exp,/nashome,/pnfs/dune,/opt,/run/user,/etc/hostname,/etc/hosts,/etc/krb5.conf --ipc --pid /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-dev-sl7:latest
```

### 2.2 Set UPS Override (for GCC12 inside SL7)
```bash
export UPS_OVERRIDE="-H Linux64bit+3.10-2.17"
```

---

## Step 3: Change Directory
```bash
cd /exp/dune/app/users/mazam/production/event_generators/BuildEventGenerators/
```

---

## Step 4: Setup UPS Products
```bash
source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
setxkbmap us

setup cmake v3_22_2
setup gcc v12_1_0
setup pycurl
setup ifdhc
setup geant4 v4_11_0_p01c -q e20:debug
setup dk2nugenie   v01_10_01k -q debug:e20
setup genie_xsec   v3_04_00 -q AR2320i00000:e1000:k250
setup genie_phyopt v3_04_00 -q dkcharmtau
setup jobsub_client
setup eigen v3_3_5
setup duneanaobj v03_06_01b -q e20:prof
setup hdf5 v1_10_5a -q e20
setup fhiclcpp v4_15_03 -q debug:e20
setup root v6_28_12 -q e20:p3915:prof
```

---

## Step 5: Environment Fixes & Paths

### GCC runtime
```bash
export LD_LIBRARY_PATH=/cvmfs/larsoft.opensciencegrid.org/products/gcc/v12_1_0/Linux64bit+3.10-2.17/lib64:$LD_LIBRARY_PATH
```

### GEANT4 (edep-sim requirements)
```bash
G4_cmake_file=$(find ${GEANT4_FQ_DIR}/lib -name 'Geant4Config.cmake')
export Geant4_DIR=$(dirname $G4_cmake_file)
export PATH=$PATH:$GEANT4_FQ_DIR/bin
```

### ROOT include cleanup
```bash
export ROOT_INCLUDE_PATH=$ROOT_INCLUDE_PATH:$GENIE_INC/GENIE
export LD_LIBRARY_PATH=$(root-config --libdir):$LD_LIBRARY_PATH
```

### Python modules
```bash
export PYTHONPATH=${PYTHONPATH}:${PWD}/DUNE_ND_GeoEff/lib/
```

### NuSystematics
```bash
export NUSYST=${PWD}/nusystematics
export LD_LIBRARY_PATH=${NUSYST}/build/Linux/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${NUSYST}/build/nusystematics/artless:$LD_LIBRARY_PATH
export FHICL_FILE_PATH=${NUSYST}/nusystematics/fcl:$FHICL_FILE_PATH
```

### duneanaobj
```bash
export LD_LIBRARY_PATH=${DUNEANAOBJ_LIB}:$LD_LIBRARY_PATH
```

### Local build paths
```bash
mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export LD_LIBRARY_PATH=$mydir/lib:$LD_LIBRARY_PATH
export PATH=$mydir/bin:$PATH
```

### Boost
```bash
export LD_LIBRARY_PATH=/cvmfs/larsoft.opensciencegrid.org/products/boost/v1_75_0/Linux64bit+3.10-2.17-e20-prof/lib:$LD_LIBRARY_PATH
```

---

## Step 6: Source nusystematics
```bash
source /exp/dune/app/users/mazam/production/event_generators/BuildEventGenerators/nusystematics/build/Linux/bin/setup.nusystematics.sh
```

---

## Step 7: Build Nuisance
```bash
./build_nuisance.sh 2>&1 | tee build_nuisance.log
```
> ⚠️ If the build complains about missing NuWro/GiBUU, set them to **OFF**.

---

## Step 8: Confirm Nuisance Executables
```bash
ls /exp/dune/app/users/mazam/production/event_generators/BuildEventGenerators/nuisance/build/Linux/bin
```

Expected executables:
```
nuis
nuis-comp
nuisflat
nuis-prep
nuis-plot
```

---

## Notes
- For reproducibility, keep `build_nuisance.log`.  
- Recommended: limit threading inside GPVM:
  ```bash
  export OMP_NUM_THREADS=1
  ```
- Prepend your local `bin` paths (`$mydir/bin:$PATH`) if you want them to override system defaults.
