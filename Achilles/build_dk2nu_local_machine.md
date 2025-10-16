# 🧩 Building and Using `dk2nu` on a Local Machine (without GENIE)

This guide describes how to build and use the **NuSoftHEP `dk2nu`** package locally,  
so you can read and plot `.dk2nu` flux files (e.g. NuMI beam) directly in ROOT.

---

## 🧭 1. Clone the Official Repository
```bash
cd ~/software
git clone https://github.com/NuSoftHEP/dk2nu.git
cd dk2nu
```

This downloads the official code that defines the ROOT TTree format used by all DUNE and NuMI flux simulations.

---

## ⚙️ 2. Set Environment Variable
```bash
export DK2NU=$PWD
```
This variable tells ROOT and CMake where the dk2nu source lives.

---

## 🛠️ 3. Skip the GENIE Interface

By default, the build system expects a full GENIE environment.  
Since we only need the ROOT interface, modify the main CMake file:

```bash
nano ~/software/dk2nu/CMakeLists.txt
```

Find this block near the end:
```cmake
  add_subdirectory(tree)
  if ( NOT WITH_GENIE )
    MESSAGE("--DK2NU-- Disabled GENIE flux driver building")
  else()
    add_subdirectory(genie)
    MESSAGE("--DK2NU-- Both tree & GENIE flux driver building enabled")
  endif()
```

Change it to:
```cmake
  add_subdirectory(tree)
  if ( NOT WITH_GENIE )
    MESSAGE("--DK2NU-- Disabled GENIE flux driver building")
  else()
    # add_subdirectory(genie)
    MESSAGE("--DK2NU-- Skipped GENIE flux driver building (no GENIE installed)")
  endif()
```

Save and exit (`Ctrl+O`, `Enter`, `Ctrl+X`).

---

## 🧩 4. Disable Intel TBB (Optional Threading Library)

If ROOT was compiled with TBB but you don’t have it locally, turn it off during configuration:

```bash
mkdir build && cd build
cmake -DWITH_TBB=OFF ..
```

---

## 🏗️ 5. Build the Library
```bash
make -j$(nproc)
```

✅ Expected output:
```
[100%] Built target dk2nuTree
```

The compiled files are located at:
```
lib/libdk2nuTree.so
```

---

## 📚 6. Environment Setup

Before using ROOT, make the library discoverable:
```bash
export DK2NU=~/software/dk2nu
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DK2NU/lib
```

(You can add these lines to your `~/.bashrc` for persistence.)

---

## 📄 7. Optional: Convert a `.dk2nu` File to ROOT
If you built the utility `dk2nu_dumper`, you can convert binary `.dk2nu` to a standard ROOT file:
```bash
$DK2NU/bin/dk2nu_dumper   -i g4numiv6_minervame_me000z-200i_0_0001.dk2nu   -o flux_from_dk2nu_all.root
```

This produces:
```
TTree "dk2nuTree" with branch "dk2nu"
```

---

## 📊 8. Visualize in ROOT

Create a macro **`plot_flux_from_dk2nu.C`**:

```cpp
void plot_flux_from_dk2nu(const char* filename = "g4numiv6_minervame_me000z-200i_0_0001.dk2nu") {

	gSystem->Load("libdk2nuTree.so");

	TFile *f = TFile::Open(filename);
	if (!f || f->IsZombie()) { std::cerr << "Cannot open file " << filename << std::endl; return; }

	TTree *t = (TTree*)f->Get("dk2nuTree");
	if (!t) { std::cerr << "No dk2nuTree found in file " << filename << std::endl; return; }

	t->Draw("dk2nu.decay.nenergy>>hEnu(200,0,10)","","goff");
	TH1D *hEnu = (TH1D*)gDirectory->Get("hEnu");

	hEnu->SetTitle("NuMI Flux (from dk2nu file)");
	hEnu->GetXaxis()->SetTitle("Neutrino Energy E_{#nu} [GeV]");
	hEnu->GetYaxis()->SetTitle("Counts per 0.05 GeV");
	hEnu->SetLineColor(kBlue+1);
	hEnu->SetLineWidth(2);
	hEnu->GetXaxis()->SetRangeUser(0, 2);

	std::cout << "----------------------------------------------------------" << std::endl;
	std::cout << "File: " << filename << std::endl;
	std::cout << "Entries: " << hEnu->GetEntries() << std::endl;
	std::cout << "Mean: " << hEnu->GetMean() << " GeV" << std::endl;
	std::cout << "RMS: " << hEnu->GetRMS() << " GeV" << std::endl;
	std::cout << "Integral: " << hEnu->Integral() << std::endl;
	std::cout << "Bin width: " << hEnu->GetBinWidth(1) << " GeV" << std::endl;
	std::cout << "Range: [" << hEnu->GetXaxis()->GetXmin()
	          << ", " << hEnu->GetXaxis()->GetXmax() << "] GeV" << std::endl;
	std::cout << "----------------------------------------------------------" << std::endl;

	TCanvas *c1 = new TCanvas("c1","NuMI Flux Plot",800,600);
	c1->SetGrid();
	hEnu->Draw("hist");
	c1->SaveAs("numi_flux_from_dk2nu.png");
	std::cout << "Saved plot as numi_flux_from_dk2nu.png" << std::endl;
}
```

Run it in ROOT:
```bash
root -l
root [0] .x plot_flux_from_dk2nu.C("g4numiv6_minervame_me000z-200i_0_0001.dk2nu")
```

---

## ✅ Final Outcome

You now have a fully working local setup:
- **dk2nu library** (`libdk2nuTree.so`) built without GENIE or TBB  
- **ROOT macro** to visualize neutrino flux energy spectrum  
- **Environment ready** for reading any `.dk2nu` file from NuMI or DUNE flux productions

---

**Maintainer note:**  
Built and tested on Ubuntu 24.04 under WSL2 with  
`ROOT v6.30.04`, `gcc 13.3.0`, and no external GENIE or TBB dependencies.
