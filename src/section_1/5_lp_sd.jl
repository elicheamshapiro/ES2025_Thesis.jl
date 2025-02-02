println("Beginning State Dependent Local Projection and Impulse Response Function Estimation")

###################### Load Data ######################

panel_df = CSV.read("./output/panel_df.csv", DataFrame)

###################### Real Private Debt During Expansion ########################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), fes=(:iso), states= :exp)
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
exp_p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
    title="Expansion", ylim=(y_min, y_max), legend = false)
     plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
     plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Real Private Debt During Recession ########################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), states= :rec)
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
rec_p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Recession", ylim=(y_min, y_max), legend = false)
     plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
     plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Real Private Debt During Boom ########################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), states= :boom)
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
boom_p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Boom", ylim=(y_min, y_max), legend = false)
     plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
     plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Real Private Debt During Slump ########################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), states= :slump)
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
slump_p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Slump", ylim=(y_min, y_max), legend = false)
     plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
     plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

###################### Combine Plots ########################

p1_states = plot(exp_p1, rec_p1, boom_p1, slump_p1, layout=(2, 2), size=(1000, 800),bottom_margin=10mm)
savefig(p1_states, "./output/figure_Z.png")

###################### Real Private Debt During Growing Public Debt ########################

###################### Real Private Debt During Falling Public Debt ########################

###################### Combine Plots ########################


println("State Dependent Local Projection and Impulse Response Function Estimation Completed")