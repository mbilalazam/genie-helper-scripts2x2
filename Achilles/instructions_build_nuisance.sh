# Step 1: Login to DUNE GPVM
	kinit mazam@FNAL.GOV      
	ssh -KY mazam@dunegpvm13.fnal.gov

# Step 2.1: Running SL7 inside a container
	/cvmfs/oasis.opensciencegrid.org/mis/apptainer/current/bin/apptainer shell --shell=/bin/bash \
	-B /cvmfs,/exp,/nashome,/pnfs/dune,/opt,/run/user,/etc/hostname,/etc/hosts,/etc/krb5.conf --ipc --pid \
	/cvmfs/singularity.opensciencegrid.org/fermilab/fnal-dev-sl7:latest

# Step 2.2: If you are planning to set up UPS software inside the SL7 container you should also set the UPS_OVERRIDE environment variable before doing any setup: 
	export UPS_OVERRIDE="-H Linux64bit+3.10-2.17"
	
# Change directory
cd /exp/dune/app/users/mazam/production/event_generators/BuildEventGenerators/

# Step 4: Setup UPS softwares
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
	setup root v6_28_12 -q e20:p3915:prof # it is for genie	

	# Make sure GCC 12 runtime libraries are picked up first
	export LD_LIBRARY_PATH=/cvmfs/larsoft.opensciencegrid.org/products/gcc/v12_1_0/Linux64bit+3.10-2.17/lib64:$LD_LIBRARY_PATH

	# edep-sim needs to know where a certain GEANT .cmake file is...
	G4_cmake_file=`find ${GEANT4_FQ_DIR}/lib -name 'Geant4Config.cmake'`
	export Geant4_DIR=`dirname $G4_cmake_file`

	# edep-sim needs to have the GEANT bin directory in the path
	export PATH=$PATH:$GEANT4_FQ_DIR/bin

	# shut up ROOT include errors
	export ROOT_INCLUDE_PATH=$ROOT_INCLUDE_PATH:$GENIE_INC/GENIE
	
	# Add root path
	export LD_LIBRARY_PATH=$(root-config --libdir):$LD_LIBRARY_PATH

	# Add pyGeoEff to pythonpath
	export PYTHONPATH=${PYTHONPATH}:${PWD}/DUNE_ND_GeoEff/lib/

	# Add nusystematics paths
	export NUSYST=${PWD}/nusystematics
	export LD_LIBRARY_PATH=${NUSYST}/build/Linux/lib:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=${NUSYST}/build/nusystematics/artless:$LD_LIBRARY_PATH
	export FHICL_FILE_PATH=${NUSYST}/nusystematics/fcl:$FHICL_FILE_PATH

	# duneananobj needs to be in the libs too
	export LD_LIBRARY_PATH=${DUNEANAOBJ_LIB}:$LD_LIBRARY_PATH

	# finally, add our lib & bin to the paths
	mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
	export LD_LIBRARY_PATH=$mydir/lib:$LD_LIBRARY_PATH
	export PATH=$mydir/bin:$PATH
	
	# export boost
	export LD_LIBRARY_PATH=/cvmfs/larsoft.opensciencegrid.org/products/boost/v1_75_0/Linux64bit+3.10-2.17-e20-prof/lib:$LD_LIBRARY_PATH

# Step 5: Source Nusystematics
	source /exp/dune/app/users/mazam/production/event_generators/BuildEventGenerators/nusystematics/build/Linux/bin/setup.nusystematics.sh


# Step 6: Build Nuisance (if it complains any error about NuWro/GiBUU etc, just set them to oFF
	./build_nuisance.sh
	
# Step 7: Confirm Nuisance executables
#You should see executables like: nuis, nuis-comp, nuis-flat/nuisflat, nuis-prep, nuis-plot
	ls /exp/dune/app/users/mazam/production/event_generators/BuildEventGenerators/nuisance/build/Linux/bin
