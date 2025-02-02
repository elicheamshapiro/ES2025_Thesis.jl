println("Beginning Local Projection and Impulse Response Function Estimation with Different Regressors")

###################### Load Data ################ 

panel_df = DataFrame(CSV.File("./data/panel_df.csv"))
paneldf!(panel_df,:iso,:year)

###################### Baseline w/ Real Private Sector Debt 2L, 2C ######################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB),
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
p0_0 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="2L, 2C", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

######################## Baseline w/ Real Private Sector Debt 2L, 4C ######################

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
p0_1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="2L, 4C", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

######################## Baseline w/ Real Private Sector Debt 3L.[Size, DRPRV, DCAPB, DLrgdpmad, DY_GAP] ######################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=3, nhorz=5, addylag=false, firststagebyhorz=true,
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
p0_2 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="3L, 4C", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

######################## Baseline w/ Real Private Sector Debt 4L.[Size, DRPRV, DCAPB, DLrgdpmad, DY_GAP] ######################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=4, nhorz=5, addylag=false, firststagebyhorz=true,
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
p0_3 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="4L, 4C", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

######## Combine Plots ########
p0 = plot(p0_0, p0_1, p0_2, p0_3, layout=(2, 2), size=(1000, 800),bottom_margin=10mm, legend = false)
savefig(p0, "./output/figure_N.png")

println("Local Projection and Impulse Response Function Estimation with Different Regressors Completed")