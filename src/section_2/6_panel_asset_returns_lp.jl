println("Beginning Section 2 Panel Asset Return IRFs")

################################### Load Data ###################################
panel_df = CSV.read("./output/panel_df.csv", DataFrame)

# Adjust for inflation
panel_df.dcpi = lagdiff(panel_df.lcpi)
variables = [:dcpi]
for v in variables
    panel_df[panel_df.year .== 1978, v] .= missing
end

panel_df.rrisky_tr = (panel_df.drisky_tr .- panel_df.dcpi)* 100
panel_df.rsafe_tr = (panel_df.dsafe_tr .- panel_df.dcpi) .* 100
panel_df.rcapital_tr = (panel_df.dcapital_tr .- panel_df.dcpi) .* 100
panel_df.req_tr = (panel_df.deq_tr .- panel_df.dcpi) .* 100
panel_df.rhousing_tr = (panel_df.dhousing_tr .- panel_df.dcpi).* 100



################################### Risky Asset Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:rrisky_tr), xnames=Cum(:dCAPB), wnames=(:rrisky_tr, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:rrisky_tr), Cum(:dCAPB))

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
p2_20 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Risky", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Safe Asset Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:rsafe_tr), xnames=Cum(:dCAPB), wnames=(:rsafe_tr, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:rsafe_tr), Cum(:dCAPB))

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
p2_21 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Safe", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Capital Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:rcapital_tr), xnames=Cum(:dCAPB), wnames=(:rcapital_tr, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:rcapital_tr), Cum(:dCAPB))

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
p2_22 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="Capital", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Equity Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:req_tr), xnames=Cum(:dCAPB), wnames=(:req_tr, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:req_tr), Cum(:dCAPB))

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
p2_23 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="Equity", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Housing Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:rhousing_tr), xnames=Cum(:dCAPB), wnames=(:rhousing_tr, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:rhousing_tr), Cum(:dCAPB))

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
p2_24 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="Housing", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Housing Prices ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:dhpnom), xnames=Cum(:dCAPB), wnames=(:dhpnom, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dhpnom), Cum(:dCAPB))

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
p2_25 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="Real Housing Price", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")


################################### Combine Plots ###################################
panel_section2 = plot( p2_20, p2_21, p2_22, p2_23, p2_24, p2_25, layout=(2, 3), size=(1000, 600),bottom_margin=10mm, legend = false)
    savefig(panel_section2, "./output/figure_L.png")

println("Section 2 Panel Asset Return IRFs Completed")

println("Beginning Section 2 Panel Asset Return Pre 2008 IRFs")

panel_df = filter(row -> row.year <= 2007, panel_df)

################################### Risky Asset Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:rrisky_tr), xnames=Cum(:dCAPB), wnames=(:rrisky_tr, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:rrisky_tr), Cum(:dCAPB))

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
p2_20 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Risky", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Safe Asset Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:rsafe_tr), xnames=Cum(:dCAPB), wnames=(:rsafe_tr, :dCAPB, :dlrgdpmad, :y_gap),
    iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:rsafe_tr), Cum(:dCAPB))

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
p2_21 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
     title="Safe", ylim=(y_min, y_max), legend = false)
    plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
    plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Capital Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:rcapital_tr), xnames=Cum(:dCAPB), wnames=(:rcapital_tr, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:rcapital_tr), Cum(:dCAPB))

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
p2_22 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="Capital", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Equity Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:req_tr), xnames=Cum(:dCAPB), wnames=(:req_tr, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:req_tr), Cum(:dCAPB))

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
p2_23 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="Equity", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Housing Returns ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:rhousing_tr), xnames=Cum(:dCAPB), wnames=(:rhousing_tr, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:rhousing_tr), Cum(:dCAPB))

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
p2_24 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="Housing", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")

################################### Housing Prices ###################################

# Perform the local projection with cumulative effects and IV estimation
r1 = lp(panel_df, Cum(:dhpnom), xnames=Cum(:dCAPB), wnames=(:dhpnom, :dCAPB, :dlrgdpmad, :y_gap),
iv=Cum(:dCAPB)=>:size, nlag=2, nhorz=5, addylag=false, firststagebyhorz=true, states= nothing)
f1 = irf(r1, Cum(:dhpnom), Cum(:dCAPB))

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
p2_25 = plot(horizon, irf_values, label="IRF", lw=2, color=:blue, xlabel="Horizon", ylabel="Response", 
 title="Real Housing Price", ylim=(y_min, y_max), legend = false)
plot!(horizon, lower_bound_2, fill_between=(lower_bound_2, upper_bound_2), color=:lightblue, alpha=0.3, label="95% CI")
plot!(horizon, lower_bound_1, fill_between=(lower_bound_1, upper_bound_1), color=:deepskyblue, alpha=0.2, label="90% CI")


################################### Combine Plots ###################################
panel_section2 = plot( p2_20, p2_21, p2_22, p2_23, p2_24, p2_25, layout=(2, 3), size=(1000, 600),bottom_margin=10mm, legend = false)
    savefig(panel_section2, "./output/figure_B.png")

println("Section 2 Panel Asset Return IRFs Completed")