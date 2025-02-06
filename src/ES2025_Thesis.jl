# using Pkg
# Pkg.add("DataFrames")
# Pkg.add("CSV")
# Pkg.add("StatFiles")
# Pkg.add("FixedEffectModels")
# Pkg.add("ShiftedArrays")
# Pkg.add("LocalProjections")
# Pkg.add("StatsBase")
# # ] add https://github.com/sdBrinkmann/HPFilter.jl
# Pkg.add("PanelDataTools")
# Pkg.add("LocalProjections")
# Pkg.add("Plots")
# Pkg.add("RegressionTables")
# Pkg.add("PrettyTables")
# Pkg.add("Plots")
# Pkg.add("DataFrames")
# Pkg.add("Statistics")
# Pkg.add("PrettyTables")
# Pkg.add("Measures")
# Pkg.add("CategoricalArrays")

module ES2025_Thesis

using StatFiles
using LocalProjections
using Plots
using XLSX
using DataFrames
using CSV
using StatFiles
using FixedEffectModels
using ShiftedArrays
using StatsBase
using HPFilter
using PanelDataTools
using TexTables
using Measures
using Statistics
using PrettyTables
using CategoricalArrays
using GLM
using Econometrics

# Exported function to execute the replication
export run

# Main entry point to run the replication
function run()

    println("Running the program...")

    # Section 1 Austerity and Private Debt
    println("Running section 1 programs")
    include("./src/section_1/1_data_preparation.jl")
    include("./src/section_1/2_descriptive_stats.jl")
    include("./src/section_1/3_lp_regressors.jl")
    include("./src/section_1/4_lp_decomposed.jl") 
    include("./src/section_1/5_lp_sd.jl")
    include("./src/section_1/6_lp_strat.jl")
    # include("./src/section_1/robustness_checks.jl")

    println("Generated Figures and Tables for Section 1")

    # Section 2 Mechanism of Austerity Impact
    println("Running section 2 programs")
    include("./src/section_2/1_data_preparation_2.jl")
    include("./src/section_2/2_usa_debt_service_payments.jl")
    include("./src/section_2/3_usa_delinquency_rates.jl")
    include("./src/section_2/4_usa_lending_standards.jl")
    # include("./src/section_2/5_supply_panel_lp.jl")
    # include("./src/section_2/6_demand_panel_lp.jl")
    println("Generated Figures and Tables for Section 2")

    # Section 3 Modelling Austerity and Private Debt

    println("Replication complete.")
end

end  # End of module
