# Genie Helper Scripts for 2x2 on NERSC

This is a personal overlay of modifications built on top of the DUNE `2x2_sim` simulation framework. It contains **only** the files I have altered, added, or used specially for GENIE runs, analysis, and plotting.

## What This Is & Why It Exists

- Not a complete standalone repo — just the extra tools, scripts, and notes I need.  
- Makes it easier to port or share only my custom work (e.g. building, running, submitting GENIE jobs, analyzing and plotting results).

## How to Use / Integrate These Modifications

1. Have the base `2x2_sim` repository checked out or cloned.  
2. Copy or merge the folders / files from this repo (such as `2x2_sim/run-genie/`, `2x2_sim/util/`, `Achilles/`, `plotting_scripts/`, etc.) into the matching structure inside your `2x2_sim` working directory.  
3. Ensure your software environment (GENIE version, ROOT, shell, etc.) aligns with what `2x2_sim` expects.  
4. Use the scripts, instruction `.md` files, and job submission files included here to build, run, analyze, and plot.  
5. Refer to the instruction `.md` files (e.g. `instructions_*`, `matching_tunes_and_splines.md`) whenever you want step-by-step commands or reminders.

## Contents (Overview)

Here is a rough layout of what this overlay includes:

- `2x2_sim/run-genie/run_genie.sh` – script to initiate GENIE event generation  
- `2x2_sim/util/init.inc.sh` – shell include / initialization helpers  
- `Achilles/` – instructions, variable files, build/run scripts for “Achilles” analysis  
- Instruction & notes files:  
  - `instructions_genie_v3_04_00_nu_noRock_AR23.md` — how to run GENIE v3.04.00 with “noRock” & AR23 tuning  
  - `instructions_genie_v3_04_00_nu_noRock_G18_10a_02_11a.md` — guidance for GENIE v3.04.00 “noRock” with G18_10a → 02_11a tuning  
  - `matching_tunes_and_splines.md` — matching GENIE tunes to splines and interpolation notes  
  - `maxpath_spline_instructions.md` — instructions for generating/using “maxpath” spline files  
  - `perlmutter_root_analysis.md` — tips & instructions for running ROOT analysis on Perlmutter (NERSC)  
  - `genie_gst_variables.md` — mapping and explanations of GENIE “gst” variables in event files  
- `plotting_scripts/` – ROOT macros / C++ scripts for plotting (e.g. true energy distributions)  
- SLURM & job submission support:  
  - `slurm_commands.md` – list of SLURM commands I use  
  - `submit_genie_v3_04_00_nu_noRock_AR23_1E19POT.slurm` – example job submission script  
