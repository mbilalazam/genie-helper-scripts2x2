# GENIE `gst` Tree Variables

| Branch        | Type      | Description |
|---------------|-----------|-------------|
| **Event & Beam Info** |||
| `iev`         | int       | Event index (unique ID in file). |
| `neu`         | int       | Neutrino PDG code (14 = νμ, –14 = ν̄μ, 12 = νe, etc.). |
| `fspl`        | int       | Final-state primary lepton PDG. |
| **Target & Hit Info** |||
| `tgt`         | int       | Target nucleus PDG (1000180400 = Ar40). |
| `Z`, `A`      | int       | Proton number and mass number of target. |
| `hitnuc`      | int       | Struck nucleon PDG. |
| `hitqrk`      | int       | Struck quark PDG. |
| `resid`       | int       | Residual nuclear system PDG. |
| **Process Classification (flags)** |||
| `sea`         | bool      | Sea quark scattering. |
| `qel`         | bool      | Quasi-elastic scattering. |
| `mec`         | bool      | 2p2h (meson exchange currents). |
| `res`         | bool      | Resonance production. |
| `dis`         | bool      | Deep inelastic scattering. |
| `coh`         | bool      | Coherent scattering. |
| `dfr`         | bool      | Diffractive scattering. |
| `imd`, `imdanh` | bool    | Inverse muon decay / annihilation. |
| `singlek`     | bool      | Single kaon production. |
| `nuel`        | bool      | ν–e scattering. |
| `em`          | bool      | Electromagnetic scattering. |
| `cc`, `nc`    | bool      | Charged-current / Neutral-current interaction. |
| `charm`       | bool      | Charm production. |
| `amnugamma`   | bool      | Anomalous νγ interactions. |
| `hnl`         | bool      | Heavy neutral lepton interactions. |
| **Interaction Codes** |||
| `neut_code`   | int       | NEUT-style interaction code. |
| `nuance_code` | int       | NUANCE-style interaction code. |
| **Weights & Cross Sections** |||
| `wght`        | double    | Event weight. |
| `xs`          | double    | Cross section at event kinematics. |
| `ys`, `ts`    | double    | Alternative inelasticity variables. |
| `Q2s`, `Ws`   | double    | Q² and W (GENIE internal calc). |
| `x`, `y`, `t` | double    | Standard DIS variables. |
| `Q2`, `W`     | double    | Standard kinematics (Q², hadronic invariant mass). |
| `EvRF`        | double    | Neutrino energy in target rest frame. |
| `Ev`          | double    | Neutrino energy in lab frame. |
| **4-Momenta** |||
| `pxv, pyv, pzv, En` | double | Incoming neutrino 4-momentum. |
| `pxn, pyn, pzn`     | double | Struck nucleon momentum components. |
| `El, pxl, pyl, pzl` | double | Outgoing lepton energy and momentum. |
| `pl`          | double    | Outgoing lepton momentum magnitude. |
| `cthl`        | double    | cosθ of outgoing lepton. |
| **Final-State Multiplicities** |||
| `nfp`, `nfn`  | int       | Number of protons, neutrons. |
| `nfpip`, `nfpim`, `nfpi0` | int | Number of π+, π–, π0. |
| `nfkp`, `nfkm`, `nfk0`   | int | Number of K+, K–, K0. |
| `nfem`        | int       | Number of final-state e±. |
| `nfother`     | int       | Other final-state particles. |
| **Initial-State Multiplicities** |||
| `nip`, `nin`  | int       | Initial protons, neutrons. |
| `nipip`, `nipim`, `nipi0` | int | Initial-state pions. |
| `nikp`, `nikm`, `nik0`   | int | Initial-state kaons. |
| `niem`        | int       | Initial-state e±. |
| `niother`     | int       | Other initial-state particles. |
| `ni`          | int       | Total initial particles. |
| **Initial-State Arrays** |||
| `pdgi[ni]`    | int[]     | Initial particle IDs. |
| `resc[ni]`    | int[]     | Re-scattering codes. |
| `Ei[ni]`      | double[]  | Energies of initial particles. |
| `pxi, pyi, pzi` | double[] | Momenta of initial particles. |
| **Final-State Arrays** |||
| `pdgf[nf]`    | int[]     | Final particle IDs. |
| `Ef[nf]`      | double[]  | Energies of final particles. |
| `pxf, pyf, pzf` | double[] | Momenta of final particles. |
| `pf[nf]`      | double[]  | Momentum magnitude. |
| `cthf[nf]`    | double[]  | cosθ of final-state particles. |
| **Vertex** |||
| `vtxx, vtxy, vtxz` | double | Vertex position (meters). |
| `vtxt`        | double    | Vertex time (ns). |
| **Other** |||
| `sumKEf`      | double    | Sum of kinetic energies of final particles. |
| `calresp0`    | double    | Calorimetric response (GENIE test var). |
| `XSec`        | double    | Cross section (event). |
| `DXSec`       | double    | Differential cross section. |
| `KPS`         | int       | GENIE internal status code. |
