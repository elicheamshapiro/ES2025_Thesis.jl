println("Beginning Baseline Local Projection and Impulse Response Function Estimation")

###################### Load Data ######################

panel_df = CSV.read("./output/panel_df.csv", DataFrame)

###################### Baseline w/ Real Private Sector Debt ######################
# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), fes=(:iso), states= nothing)
f1 = irf(r1, Cum(:drprv), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4
irf_values = f1.B
lower_bound_1 = f1.B - 1.64 .* f1.SE
upper_bound_1 = f1.B + 1.64 .* f1.SE
lower_bound_2 = f1.B - 1.96 .* f1.SE
upper_bound_2 = f1.B + 1.96 .* f1.SE
y_min = -15 
y_max = max(maximum(upper_bound_2).+1 , 0.0)

# Plotting with adjusted y-axis
p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Private Sector", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Baseline w/ Real Household Debt ######################

# Perform the local projection with cumulative effects and IV estimation
r2 = lp(panel_df, Cum(:drhh), xnames=Cum(:dCAPB), wnames=(:drhh, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), fes=(:iso), states= nothing)
f2 = irf(r2, Cum(:drhh), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4 
irf_values = f2.B
lower_bound_1 = f2.B - 1.64 .* f2.SE
upper_bound_1 = f2.B + 1.64 .* f2.SE
lower_bound_2 = f2.B - 1.96 .* f2.SE
upper_bound_2 = f2.B + 1.96 .* f2.SE
y_min = -15 
y_max = max(maximum(upper_bound_2) .+1 , 0.0)

# Plotting with adjusted y-axis
p2 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Household", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Baseline w/ Real Mortgage Debt ######################

# Perform the local projection with cumulative effects and IV estimation
r3 = lp(panel_df, Cum(:drmort), xnames=Cum(:dCAPB), wnames=(:drmort, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), fes=(:iso), states= nothing)
f3 = irf(r3, Cum(:drmort), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4 
irf_values = f3.B
lower_bound_1 = f3.B - 1.64 .* f3.SE
upper_bound_1 = f3.B + 1.64 .* f3.SE
lower_bound_2 = f3.B - 1.96 .* f3.SE
upper_bound_2 = f3.B + 1.96 .* f3.SE
y_min = -15
y_max = max(maximum(upper_bound_2) .+1 , 0.0)

# Plotting with adjusted y-axis
p3 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Mortgage", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Baseline w/ Real Non-Financial Corporate Debt ######################

# Perform the local projection with cumulative effects and IV estimation
r4 = lp(panel_df, Cum(:drbus), xnames=Cum(:dCAPB), wnames=(:drbus, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), fes=(:iso), states= nothing)
f4 = irf(r4, Cum(:drbus), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4 
irf_values = f4.B
lower_bound_1 = f4.B - 1.64 .* f4.SE
upper_bound_1 = f4.B + 1.64 .* f4.SE
lower_bound_2 = f4.B - 1.96 .* f4.SE
upper_bound_2 = f4.B + 1.96 .* f4.SE
y_min = -15  
y_max = max(maximum(upper_bound_2) .+1 , 0.0)

# Plotting with adjusted y-axis
p4 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Non-Financial Corporate", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Combine Plots ######################

p = plot(p1, p2, p3, p4, layout=(2, 2), size=(1000, 800))
savefig(p, "./output/figure_X.png")

###################### Export Regression Table ######################

# # Extract relevant information from f1
# coefficients = f1.B
# standard_errors = f1.SE
# horizons = f1.minhorz:f1.minhorz + length(coefficients) - 1
# t_values = coefficients ./ standard_errors
# observations = f1.T
# degrees_of_freedom = f1.doftstat
# lower_bound = coefficients - 1.96 .* standard_errors
# upper_bound = coefficients + 1.96 .* standard_errors

# # Calculate p-values using the t-distribution
# p_values = [2 * (1 - cdf(TDist(df), abs(t))) for (t, df) in zip(t_values, degrees_of_freedom)]

# # Create a DataFrame
# regression_table = DataFrame(
#     Coefficient = round.(coefficients, digits=4),
#     StdError = round.(standard_errors, digits=4),
#     PValue = round.(p_values, digits=4),
#     Lower_95 = round.(lower_bound, digits=4),
#     Upper_95 = round.(upper_bound, digits=4)
# )

#####################################################################

println("Decomposed Baseline Local Projection and Impulse Response Function Estimation Completed")


