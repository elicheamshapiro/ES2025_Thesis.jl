println("Beginning Section 2 Panel Savings IRFs")

################################### Load Data ###################################
panel_df = CSV.read("./output/panel_df.csv", DataFrame)

################################### Deposit Rate ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:ddep_rate), xnames=Cum(:dCAPB), wnames=(:ddep_rate, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:ddep_rate), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4
irf_values = f1.B
lower_bound_1 = f1.B - 1.64 .* f1.SE
upper_bound_1 = f1.B + 1.64 .* f1.SE
lower_bound_2 = f1.B - 1.96 .* f1.SE
upper_bound_2 = f1.B + 1.96 .* f1.SE
y_min = min(minimum(lower_bound_2).-1 , 0.0) 
y_max = max(maximum(upper_bound_2).+1 , 0.0)

# Plotting with adjusted y-axis
p2_26 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response (Base Points)", 
     title="Deposit Interest Rate", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Gross Savings (% of GDP) ###################################
r1 = lp(panel_df, Cum(:dgs_gdp), xnames=Cum(:dCAPB), wnames=(:dgs_gdp, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dgs_gdp), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4
irf_values = f1.B
lower_bound_1 = f1.B - 1.64 .* f1.SE
upper_bound_1 = f1.B + 1.64 .* f1.SE
lower_bound_2 = f1.B - 1.96 .* f1.SE
upper_bound_2 = f1.B + 1.96 .* f1.SE
y_min = min(minimum(lower_bound_2).-1 , 0.0) 
y_max = max(maximum(upper_bound_2).+1 , 0.0)

# Plotting with adjusted y-axis
p2_27 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response (Base Points)", 
     title="Gross Savings (% of GDP)", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Real Gross Savings (LCU) ###################################
r1 = lp(panel_df, Cum(:dgs_lcu), xnames=Cum(:dCAPB), wnames=(:dgs_lcu, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dgs_lcu), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4
irf_values = f1.B
lower_bound_1 = f1.B - 1.64 .* f1.SE
upper_bound_1 = f1.B + 1.64 .* f1.SE
lower_bound_2 = f1.B - 1.96 .* f1.SE
upper_bound_2 = f1.B + 1.96 .* f1.SE
y_min = min(minimum(lower_bound_2).-1 , 0.0) 
y_max = max(maximum(upper_bound_2).+1 , 0.0)

# Plotting with adjusted y-axis
p2_28 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response (Percentage)", 
     title="Gross Savings (LCU)", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Combine Plots ###################################
panel_section2 = plot( p2_26, p2_27, p2_28, layout=(1, 3), size=(1500, 300),bottom_margin=10mm, legend = false)
    savefig(panel_section2, "./output/figure_R.png")

println("Section 2 Panel Savings IRFs Completed")