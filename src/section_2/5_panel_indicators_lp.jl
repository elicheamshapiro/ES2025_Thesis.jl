println("Beginning Section 2 Panel Credit Market Inidcators IRFs")

################################### Load Data ###################################
panel_df = CSV.read("./output/panel_df.csv", DataFrame)

################################### Lending Risk Premium ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:dlrp), xnames=Cum(:dCAPB), wnames=(:dlrp, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dlrp), Cum(:dCAPB))

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
p2_18 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response (Base Points)", 
     title="Lending Risk Premium", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Non Performing Loans as a Percent of Gross Loans ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:dnpl), xnames=Cum(:dCAPB), wnames=(:dnpl, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dnpl), Cum(:dCAPB))

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
p2_19 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response (Base Points)", 
 title="Nonperforming Loans", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")
################################### Combine Plots ###################################
panel_section2 = plot( p2_18, p2_19, layout=(1, 2), size=(1000, 400),bottom_margin=10mm, legend = false)
    savefig(panel_section2, "./output/figure_K.png")

println("Section 2 Panel Credit Market Inidcators IRFs Completed")