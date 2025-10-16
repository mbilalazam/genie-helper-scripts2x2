# Installing HepMC3 (user-level, no root access needed)

```
# Create a build area
cd ~
mkdir -p software && cd software

# Clone HepMC3
git clone https://gitlab.cern.ch/hepmc/HepMC3.git
cd HepMC3

# Make build directory
mkdir build && cd build

# Configure with CMake (no Python bindings, lightweight)
cmake .. \
  -DCMAKE_INSTALL_PREFIX=$HOME/software/HepMC3/install \
  -DHEPMC3_ENABLE_ROOTIO=ON \
  -DHEPMC3_ENABLE_PYTHON=OFF

# Compile and install
make -j$(nproc)
make install
```
