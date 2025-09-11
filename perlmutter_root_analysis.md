# ROOT / Python Analysis on Perlmutter (Login Node)

These steps allow you to inspect GENIE `.gst.root` or `.GHEP.root` files directly on the login node.  
No need to use `salloc` or `shifter` for this workflow.

---

## 1. Log in to Perlmutter
```bash
ssh mazam@perlmutter.nersc.gov
```

---

## 2. Load Python module
```bash
module load python
```

---

## 3. Create (first time only) and activate ROOT conda environment
```bash
conda create -n root-env -c conda-forge root -y   # only once
conda activate root-env
```

---

## 4. Check ROOT installation
```bash
which root
root --version
```

---

## 5. Open your GENIE output directory
```bash
cd /global/homes/m/mazam/2x2_sim/run-genie/BilalTest.genie.nu/GST/0000000
```

---

## 6. Inspect the ROOT file
```bash
root -l BilalTest.genie.nu.0000000.gst.root
```

Inside ROOT:
```cpp
gtree->GetEntries();   // check number of events
gtree->Show(0);        // display first event
```

---
