println("Beginning Descriptive Statistics")

######################### Load Data ############################
panel_df = CSV.read("./output/panel_df.csv", DataFrame)

###################### Descriptive Statistics: Frequency of Austerity Policies Time Series #####

panel_df.austerity = ifelse.(panel_df.size .!= 0, 1, 0)
grouped = groupby(panel_df, :year)
austerity_freq = combine(grouped, :austerity => sum => :austerity_freq)
time_series_austerity = plot(
    austerity_freq.year, austerity_freq.austerity_freq, 
    xlabel = "Year", 
    ylabel = "Global Frequency", 
    title = "Sample Frequency of Austerity Policies",
    lw = 2, 
    legend = false
)

savefig(time_series_austerity, "./output/figure_C.png")

###################### Descriptive Statistics: Size Histogram ######################

panel_df.nonzero_size = ifelse.(panel_df.size .!= 0, panel_df.size, missing)
panel_df.nonzero_spend = ifelse.(panel_df.spend .!= 0, panel_df.size, missing)
panel_df.nonzero_tax = ifelse.(panel_df.tax .!= 0, panel_df.size, missing)
size_hist = histogram(
    panel_df.nonzero_size, bins = -0.5:0.2:3.0, title="Fiscal Consolidation Size", xlabel="Percent of GDP", 
    ylabel="Frequency", color=:skyblue, legend = false)
spend_hist = histogram(
    panel_df.nonzero_spend, bins = -0.5:0.2:3.0, title="Spending-Based Size", xlabel="Percent of GDP", 
    ylabel="Frequency", color=:skyblue, legend = false)
tax_hist = histogram(
    panel_df.nonzero_tax, bins = -0.5:0.2:3.0, title="Tax-Based Size", xlabel="Percent of GDP", 
    ylabel="Frequency", color=:skyblue, legend = false)

size_hists = plot(size_hist, spend_hist, tax_hist, 
    layout=(1, 3), 
    size=(1000, 400), 
    bottom_margin=10mm)

savefig(size_hists, "./output/figure_A.png")

######################## Descriptive Statistics: Table of Average Size By Country ##########
# average_size.iso = categorical(average_size.iso)
# grouped = groupby(panel_df, :iso)
# average_size = combine(grouped, :size => mean => :average_size)
# average_size_by_country = bar(
#     average_size.iso,          # Categories (x-axis)
#     average_size.average_size, # Values (y-axis)
#     xlabel = "Country",
#     ylabel = "Average Size",
#     color = :skyblue,
#     legend = false,
#     xticks = (1:length(average_size.iso), average_size.iso),  # Explicitly set ticks for each name
#     xrotation = 90
# )

# savefig(average_size_by_country, "./output/figure_B.png")

######################### Descriptive Statistics: Private Debt Time Series for USA ################

# usa_data = filter(row -> row.iso == "USA", panel_df)
# deu_data = filter(row -> row.iso == "DEU", panel_df)
# uk_data = filter(row -> row.iso == "GBR", panel_df)
# data_clean = dropmissing(panel_df, [:dCAPB, :drprv])

# # Create the time series plot for var1 and var2
# time_series_private_debt = plot(
#     usa_data.year, usa_data.drprv, 
#     label = "USA", 
#     xlabel = "Year", 
#     ylabel = "Values", 
#     title = "Time Series for USA",
#     lw = 2
# )
# plot!(
#     deu_data.year, deu_data.drprv, 
#     label = "DEU", 
#     lw = 2
# )
# plot!(
#     uk_data.year, uk_data.drprv, 
#     label = "GBR", 
#     lw = 2
# )
# savefig(time_series_private_debt, "./output/figure_B.png")

println("Completed Descriptive Statistics")
