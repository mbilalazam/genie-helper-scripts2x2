# Achilles FlatTree_VARS Documentation

This document summarizes the branches available in the flat ROOT tree
(`FlatTree_VARS`) produced from Achilles HepMC files using **nuisflat**.

> **Note:** The exact meaning of the `Mode` codes (e.g. `200`) is not yet confirmed.
Once this mapping is known, it should be added here.

---

## Branch Reference

| Variable              | Type        | Description |
|------------------------|------------|-------------|
| **Event / Process identifiers** |||
| Mode                  | int        | Generator-specific process code (mapping TBD) |
| cc                    | int        | Charged-current flag: 1 = CC, 0 = NC |
| PDGnu                 | int        | Incoming neutrino PDG code (14 = νμ, -14 = \barνμ) |
| Enu_true              | float      | True incoming neutrino energy (GeV) |
| tgt                   | int        | Target code (internal use) |
| tgta                  | int        | Target atomic mass number A |
| tgtz                  | int        | Target atomic number Z |
| **Lepton (final state lepton)** |||
| PDGLep                | int        | Outgoing charged lepton PDG code (13 = μ⁻, -13 = μ⁺) |
| ELep                  | float      | Outgoing lepton energy (GeV) |
| CosLep                | float      | Cosine of lepton scattering angle |
| **Momentum transfer** |||
| Q2                    | float      | Four-momentum transfer squared, Q² (GeV²) |
| q0                    | float      | Energy transfer (GeV) |
| q3                    | float      | Three-momentum transfer magnitude (GeV) |
| **QE estimators** |||
| Enu_QE                | float      | Neutrino energy reconstructed under QE hypothesis (GeV) |
| Q2_QE                 | float      | Q² reconstructed under QE hypothesis (GeV²) |
| **Hadronic invariant mass** |||
| W_nuc_rest            | float      | Invariant mass in nuclear rest frame (GeV) |
| W                     | float      | Hadronic invariant mass (GeV) |
| W_genie               | float      | GENIE-style invariant mass placeholder |
| **DIS variables** |||
| x                     | float      | Bjorken-x |
| y                     | float      | Inelasticity |
| **Recoil energies** |||
| Erecoil_minerva       | float      | Recoil energy definition used in MINERvA analyses (GeV) |
| Erecoil_charged       | float      | Visible charged recoil energy (GeV) |
| **Missing energy / momentum** |||
| EavAlt                | float      | Alternate available energy (GeV) |
| Emiss                 | float      | Missing energy after FSI (GeV) |
| pmiss                 | TVector3   | Missing momentum after FSI (GeV) |
| Emiss_preFSI          | float      | Missing energy before FSI (GeV) |
| pmiss_preFSI          | TVector3   | Missing momentum before FSI (GeV) |
| **Event shape variables** |||
| CosThetaAdler         | float      | Adler angle cosθ* |
| PhiAdler              | float      | Adler angle φ* |
| dalphat               | float      | Transverse imbalance angle Δα_T (rad) |
| dpt                   | float      | Transverse momentum imbalance (MeV/c) |
| dphit                 | float      | Azimuthal imbalance Δφ_T (rad) |
| pnreco_C              | float      | Reconstructed component of nucleon momentum (GeV/c) |
| **Final-state particles (FSP)** |||
| nfsp                  | int        | Number of final state particles |
| px[nfsp]              | float[]    | Momentum x-component of FSPs (GeV) |
| py[nfsp]              | float[]    | Momentum y-component of FSPs (GeV) |
| pz[nfsp]              | float[]    | Momentum z-component of FSPs (GeV) |
| E[nfsp]               | float[]    | Energy of each FSP (GeV) |
| pdg[nfsp]             | int[]      | PDG codes of FSPs (e.g. 13=μ⁻, 2212=proton) |
| pdg_rank[nfsp]        | int[]      | Rank/classification of FSPs |
| **Initial state particles** |||
| ninitp                | int        | Number of initial state particles |
| px_init[ninitp]       | float[]    | x-momentum of initial particle(s) (GeV) |
| py_init[ninitp]       | float[]    | y-momentum of initial particle(s) (GeV) |
| pz_init[ninitp]       | float[]    | z-momentum of initial particle(s) (GeV) |
| E_init[ninitp]        | float[]    | Energy of initial particle(s) (GeV) |
| pdg_init[ninitp]      | int[]      | PDG code of initial particle(s) |
| **Vertex particles** |||
| nvertp                | int        | Number of vertex particles |
| px_vert[nvertp]       | float[]    | x-momentum of vertex particles (GeV) |
| py_vert[nvertp]       | float[]    | y-momentum of vertex particles (GeV) |
| pz_vert[nvertp]       | float[]    | z-momentum of vertex particles (GeV) |
| E_vert[nvertp]        | float[]    | Energy of vertex particles (GeV) |
| pdg_vert[nvertp]      | int[]      | PDG code of vertex particles |
| **Event weights** |||
| Weight                | float      | Nominal event weight |
| InputWeight           | float      | Generator-provided input weight |
| RWWeight              | float      | Applied reweight factor |
| fScaleFactor          | double     | Overall normalization factor |
| CustomWeight          | float      | User-defined additional weight |
| CustomWeightArray[6]  | float[]    | Array of custom systematic weights |
| **Topology / process flags (booleans)** |||
| flagCCINC             | bool       | CC inclusive |
| flagNCINC             | bool       | NC inclusive |
| flagCCQE              | bool       | CC quasi-elastic |
| flagCC0pi             | bool       | CC zero pion |
| flagCCQELike          | bool       | CCQE-like (pion absorbed included) |
| flagNCEL              | bool       | NC elastic |
| flagNC0pi             | bool       | NC zero pion |
| flagCCcoh             | bool       | CC coherent pion |
| flagNCcoh             | bool       | NC coherent pion |
| flagCC1pip            | bool       | CC single π⁺ |
| flagNC1pip            | bool       | NC single π⁺ |
| flagCC1pim            | bool       | CC single π⁻ |
| flagNC1pim            | bool       | NC single π⁻ |
| flagCC1pi0            | bool       | CC single π⁰ |
| flagNC1pi0            | bool       | NC single π⁰ |
| flagCC0piMINERvA      | bool       | MINERvA-style CC0π definition |
| flagCC0Pi_T2K_AnaI    | bool       | T2K analysis I CC0π definition |
| flagCC0Pi_T2K_AnaII   | bool       | T2K analysis II CC0π definition |

---

## Example Event
- νμ (`PDGnu = 14`), `Enu_true ≈ 0.0068 GeV`
- Target: argon (Z=18, A=40)
- Outgoing μ⁻, `ELep ≈ 0.68 GeV`, `cosθ ≈ 0.87`
- Final state: μ⁻, proton, neutron (`nfsp = 3`)
- Classified as `CC0π` (`flagCC0pi = 1`)
- `Mode = 200` (mapping TBD)
