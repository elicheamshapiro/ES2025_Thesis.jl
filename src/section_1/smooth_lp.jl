
using LocalProjections, Plots

############### Smooth Local Projection w/ Real Private Debt ################
# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:drprv), xnames=Cum(:dCAPB), wnames=(:drprv, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true,
    panelid=:iso, vce=cluster(:iso), fes=(:iso), states= nothing)
f1 = irf(r1, Cum(:drprv), Cum(:dCAPB))

# For smooth local projections, specify the estimator
est = SmoothLP(Cum(:dCAPB), 2, 2, criterion = LOOCV())
r_sm = lp(est, panel_df, Cum(:drprv), xnames=Cum(:dCAPB), 
    wnames=(:size, :drprv, :dCAPB), nlag=2, nhorz=5,
    addylag=true, firststagebyhorz=true, panelid=:iso)
f_sm = irf(r_sm, :Cum(:drprv), Cum(:dCAPB))

# Extract the IRF results
horizon = 0:4 
irf_values = f1.B
lower_bound_1 = f1.B - 1.64 .* f1.SE
upper_bound_1 = f1.B + 1.64 .* f1.SE
lower_bound_2 = f1.B - 1.96 .* f1.SE
upper_bound_2 = f1.B + 1.96 .* f1.SE
y_min = min(minimum(lower_bound_2), 0.0) 
y_max = max(maximum(upper_bound_2), 0.0)

# Plotting with adjusted y-axis
p1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Private Sector", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")
display(p1)
savefig("./output/irf_full_rprv_baseline.png")