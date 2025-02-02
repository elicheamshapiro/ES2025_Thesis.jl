using LocalProjections, Plots, Measures

println("Beginning Stratified Local Projection and Impulse Response Function Estimation")

######################## Load Data ######################
panel_df = CSV.read("./output/panel_df.csv", DataFrame)

######################## Real Private Debt Full Sample ########################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), fes=(:iso), states= nothing,  testweakiv=true)
f1 = irf(r1, Cum(:drprv), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4
irf_values = f1.B
lower_bound_1 = f1.B - 1.64 .* f1.SE
upper_bound_1 = f1.B + 1.64 .* f1.SE
lower_bound_2 = f1.B - 1.96 .* f1.SE
upper_bound_2 = f1.B + 1.96 .* f1.SE
y_min = -15  
y_max = max(maximum(upper_bound_2) .+1 , 0.0)

# Plotting with adjusted y-axis
p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Full Sample Private Sector", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

######################## Real Private Debt w/ Spending-Based Fiscal Contractions ########################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:spend, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
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
y_max = max(maximum(upper_bound_2) .+1 , 0.0)

# Plotting with adjusted y-axis
spend_p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Spending-Based", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

######################## Real Private Debt w/ Tax-Based Fiscal Contractions ########################
# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:tax, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
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
y_max = max(maximum(upper_bound_2) .+1 , 0.0)

# Plotting with adjusted y-axis
tax_p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Tax-Based", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Real Private Debt w/ Large Fiscal Contractions ########################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size_large, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), states= nothing)
f1 = irf(r1, Cum(:drprv), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4 
irf_values = f1.B
lower_bound_1 = f1.B - 1.64 .* f1.SE
upper_bound_1 = f1.B + 1.64 .* f1.SE
lower_bound_2 = f1.B - 1.96 .* f1.SE
upper_bound_2 = f1.B + 1.96 .* f1.SE
y_min = -15  
y_max = max(maximum(upper_bound_2) .+1 , 0.0)

# Plotting with adjusted y-axis
large_p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Large Fiscal Consolidation", ylim=(y_min, y_max), legend = false)
     plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
     plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Real Private Debt w/ Small Fiscal Contractions ########################
# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size_small, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), states= nothing)
f1 = irf(r1, Cum(:drprv), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4 
irf_values = f1.B
lower_bound_1 = f1.B - 1.64 .* f1.SE
upper_bound_1 = f1.B + 1.64 .* f1.SE
lower_bound_2 = f1.B - 1.96 .* f1.SE
upper_bound_2 = f1.B + 1.96 .* f1.SE
y_min = -15  
y_max = max(maximum(upper_bound_2) .+1 , 0.0)

# Plotting with adjusted y-axis
small_p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Small Fiscal Consolidation", ylim=(y_min, y_max), legend = false)
     plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
     plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

######################## Combine Plots ########################

p_strat = plot(p1, spend_p1, tax_p1, large_p1, small_p1, layout=(2, 3), size=(1000, 600))
savefig(p_strat, "./output/figure_W.png")