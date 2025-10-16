# Installing HepMC3 (User-Level, No Root Access Required)

## 1. Create a local build area
```bash
cd ~
mkdir -p software && cd software
```

---

## 2. Clone the HepMC3 repository
```bash
git clone https://gitlab.cern.ch/hepmc/HepMC3.git
cd HepMC3
```

---

## 3. Create a build directory
```bash
mkdir build && cd build
```

---

## 4. Configure with CMake
Lightweight build (no Python bindings, ROOT I/O enabled):
```bash
cmake ..   -DCMAKE_INSTALL_PREFIX=$HOME/software/HepMC3/install   -DHEPMC3_ENABLE_ROOTIO=ON   -DHEPMC3_ENABLE_PYTHON=OFF
```

---

## 5. Compile and install
```bash
make -j$(nproc)
make install
```

---

## 6. Add HepMC3 to your environment
Add these lines to your shell (or permanently to `~/.bashrc`):
```bash
export PATH=$HOME/software/HepMC3/install/bin:$PATH
export LD_LIBRARY_PATH=$HOME/software/HepMC3/install/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$HOME/software/HepMC3/install/include:$CPLUS_INCLUDE_PATH
```

Reload your environment:
```bash
source ~/.bashrc
```

---

## 7. Confirm installation
```bash
HepMC3-config --version
```

✅ If you see a version number (e.g., `3.2.6`), HepMC3 is successfully installed and ready to use with ROOT.
