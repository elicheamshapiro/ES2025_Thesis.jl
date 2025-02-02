println("Beginning USA Loan Delinquency Rate IRFs")

################################### Credit Card Delinquency Rates ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:ddrcclacbs), xnames=Cum(:dCAPB), wnames=(:ddrcclacbs, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:ddrcclacbs), Cum(:dCAPB))

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
p2_0 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Credit Cards", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Consumer Loan Delinquency Rates ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:ddrclacbs), xnames=Cum(:dCAPB), wnames=(:ddrclacbs, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:ddrclacbs), Cum(:dCAPB))

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
p2_1 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Consumer Loans", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")


################################### Delinquency Rates on All Loans ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:ddralacbn), xnames=Cum(:dCAPB), wnames=(:ddralacbn, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:ddralacbn), Cum(:dCAPB))

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
p2_2 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="All Loans", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")


################################### Delinquency Rate on Single-Family Residential Mortgages ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:ddrsfrmacbs), xnames=Cum(:dCAPB), wnames=(:ddrsfrmacbs, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:ddrsfrmacbs), Cum(:dCAPB))

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
p2_3 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Single-Family Mortgages", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Delinquency Rate on Business Loans ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:ddrblacbs), xnames=Cum(:dCAPB), wnames=(:ddrblacbs, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:ddrblacbs), Cum(:dCAPB))

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
p2_4 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Business Loans", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")


################################### Combine Plots ###################################
delinquency_rates = plot(p2_2, p2_1, p2_0, p2_3, p2_4, layout=(2, 3), size=(1000, 800),bottom_margin=10mm, legend = false)
    savefig(delinquency_rates, "./output/figure_V.png")

println("USA Delinquency Rates IRFs Completed")


