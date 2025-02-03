println("Beginning USA Lending Standards IRFs")

################################### Net Percentage of Domestic Banks Tightening Standards Across Loan Categories, 
################################### Weighted by Banks' Outstanding Loan Balances by Category 

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:dls_all_categories), xnames=Cum(:dCAPB), wnames=(:dls_all_categories, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dls_all_categories), Cum(:dCAPB))

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
p2_10 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="dls_all", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Net Percentage of Domestic Banks Tightening Standards for Credit Card Loans ################################### 

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:dls_credit_card), xnames=Cum(:dCAPB), wnames=(:dls_credit_card, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dls_credit_card), Cum(:dCAPB))

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
p2_11 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="dls_credit_cards", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Net Percentage of Large Domestic Banks Tightening Standards for Credit Card Loans  #########

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:dls_large_credit_card), xnames=Cum(:dCAPB), wnames=(:dls_large_credit_card, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dls_large_credit_card), Cum(:dCAPB))

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
p2_13 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="dls_large_cc", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Net Percentage of Domestic Banks Tightening Standards for Large Firms ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:dls_large_firm), xnames=Cum(:dCAPB), wnames=(:dls_large_firm, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dls_large_firm), Cum(:dCAPB))

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
p2_14 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="dls_large_firm", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")


################################### Net Percentage of Domestic Banks Tightening Standards for Small Firms ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:dls_small_firm), xnames=Cum(:dCAPB), wnames=(:dls_small_firm, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dls_small_firm), Cum(:dCAPB))

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
p2_15 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="dls_small_firm", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Net Percentage of Domestic Banks Tightening Standards for Households ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(usa_df, Cum(:dls_hh), xnames=Cum(:dCAPB), wnames=(:dls_hh, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dls_hh), Cum(:dCAPB))

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
p2_16 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="dls_hh", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Combine Plots ###################################
lending_standards = plot(p2_10, p2_11, p2_13, p2_14, p2_15, p2_16, layout=(2, 3), size=(1000, 600),bottom_margin=10mm, legend = false)
    savefig(lending_standards, "./output/figure_H.png")

    println("USA Lending Standards IRFs Completed")


