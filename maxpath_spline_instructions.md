## Generating MaxPath File for GENIE

GENIE requires a *geometry-dependent* **maxpath file** in addition to the tune’s cross-section splines.  
The maxpath file defines the maximum path-lengths for each nuclear target in the geometry.

### Example: G18_10a_02_11a with `Merged2x2MINERvA_v4_noRock.gdml`

```bash
# From your run-genie directory
cd /global/homes/m/mazam/2x2_sim/run-genie

# Set container information
export ARCUBE_RUNTIME=SHIFTER
export ARCUBE_CONTAINER=mjkramer/sim2x2:genie_edep.3_04_00.20230912

# Run the maxpath generator script
./GENIE_max_path_length_gen.sh \
  /global/homes/m/mazam/2x2_sim/geometry/Merged2x2MINERvA_v4/Merged2x2MINERvA_v4_noRock.gdml \
  G18_10a_02_11a
