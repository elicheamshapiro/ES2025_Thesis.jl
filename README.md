# ES2025_Thesis

[![Build Status](https://github.com/elicheamshapiro/ES2025_Thesis.jl/workflows/CI/badge.svg)](https://github.com/elicheamshapiro/ES2025_Thesis.jl/actions)
[![Coverage](https://codecov.io/gh/elicheamshapiro/ES2025_Thesis.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/elicheamshapiro/ES2025_Thesis.jl)

# Austerity, Private Debt, and The Credit Supply
## Sciences Po (MRes in Economics)
## By Eli Cheam Shapiro (Supervised by Dr. Moritz Schularick, Supported by Dr. Axelle Ferriere)

### Summary

This thesis investigates the effect of fiscal consolidation policy shocks on private debt accumulation. The first section utilizes instrumental variable local projections on a panel dataset of 16 OECD countries from 1978 to 2007. The second section investigates, using the United States as a case study, these fiscal consolidations affect the performance of these loans and the risks that the private sector and banking sector face. The third presents a macroeconomic model to explain these dynamics.

### Running time of reproducing all the results: [INSERT] seconds.

CPU: Apple M2,

RAM: 16 GB,

OS: Sonoma 14.5

---
## How to run the code

### Prerequisites
Ensure you have Julia installed on your system. This code has been tested with Julia version `1.11.2`. If Julia is not installed, follow instructions at this link to install: 'https://julialang.org/downloads/'.

### IN TERMINAL: Clone your GitHub repository, navigate to the project directory, and open Julia
```bash
git clone https://github.com/elicheamshapiro/ES2025_Thesis.jl

cd ES2025_Thesis.jl

julia
```

### IN JULIA: Run the following code
```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
using ES2025_Thesis
ES2025_Thesis.run()
```

For questions or issues, please reach out to Eli Cheam Shapiro. Contributions and suggestions for improving this replication in Julia are welcome!
