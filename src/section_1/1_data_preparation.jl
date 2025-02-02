println("Beginning Data Preparation")

###################### Load Data #################

#Load and Merge Data
fiscal_df = DataFrame(load("./data/fiscal_consolidation_v032023.dta"))
jst_df = DataFrame(load("./data/JSTdatasetR6.dta"))
merged_df1 = innerjoin(fiscal_df, jst_df, on = [:ifs, :year], makeunique=true)
dcapb_df = DataFrame(load("./data/dcapb.dta"))
panel_df = innerjoin(merged_df1, dcapb_df, on = [:ifs, :year], makeunique=true)

#Drop years before 2008
# panel_df = filter(row -> row.year <= 2007, panel_df)

#Convert all columns to Float64
for col in names(panel_df)
    if eltype(panel_df[!, col]) <: AbstractFloat
        panel_df[!, col] = convert(Vector{Float64}, panel_df[!, col])
    end
end

#Set panel
paneldf!(panel_df,:iso,:year)

###################### Generate Variables #################

#Generate dCAPB (endogenous variable) as the same as dnlgxqa
panel_df.dCAPB = panel_df.dnlgxqa

#Generate variables
panel_df.lpop = log.(panel_df.pop) #Log Population
panel_df.lcpi = log.(panel_df.cpi) #Log CPI

#Generate Los of Outcome Variables
panel_df.rprv = log.(panel_df.tloans).- panel_df.lcpi .- panel_df.lpop #Real Total Private Debt Per Capita
panel_df.rhh = log.(panel_df.thh) .- panel_df.lcpi .- panel_df.lpop #Real Household Debt Per Capita
panel_df.rmort = log.(panel_df.tmort) .- panel_df.lcpi .- panel_df.lpop #Real Mortgage Debt Per Capita
panel_df.rbus = log.(panel_df.tbus) .- panel_df.lcpi .- panel_df.lpop #Real Business Debt Per Capita
panel_df.rhouse = log.(panel_df.hpnom) .- panel_df.lcpi .- panel_df.lpop #Real Housing Prices Per Capita
panel_df.lrgdpmad = log.(panel_df.rgdpmad) #Real GDP Per Capita
panel_df.lriy = log.(panel_df.iy) - panel_df.lcpi - panel_df.lpop  #Real Investment Per Capita
panel_df.lbdebt = log.(panel_df.bdebt) - panel_df.lcpi - panel_df.lpop #Real Business Debt

#First difference of the outcomes
lagdiff(x) = x - lag(x)
panel_df.drprv = 100 .* lagdiff(panel_df.rprv)
panel_df.drhh = 100 .* lagdiff(panel_df.rhh)
panel_df.drmort = 100 .* lagdiff(panel_df.rmort)
panel_df.drbus = 100 .* lagdiff(panel_df.rbus)
panel_df.drhouse = 100 .* lagdiff(panel_df.rhouse)
panel_df.dlrgdpmad = 100 .* lagdiff(panel_df.lrgdpmad)
panel_df.diy = 100 .* lagdiff(panel_df.iy)
panel_df.dlbdebt = 100 .* lagdiff(panel_df.lbdebt)
panel_df.dstir .= lagdiff(panel_df.stir)
panel_df.ldebtgdp = lagdiff(panel_df.debtgdp)

#Drop values for 1978 for these first difference variables
variables = [:drprv, :drhh, :drmort, :drbus, :drhouse, :dlrgdpmad, :diy, :dlbdebt, :dstir, :ldebtgdp]
for v in variables
    panel_df[panel_df.year .== 1978, v] .= missing
end

#Additional Controls
panel_df.ldCAPB = lag(panel_df.dCAPB)
panel_df.ldlrgdpmad = lag(panel_df.dlrgdpmad)
panel_df.lldCAPB = lag(panel_df.ldCAPB)
panel_df.lldlrgdpmad = lag(panel_df.ldlrgdpmad)
panel_df.lldebtgdp = lag(panel_df.ldebtgdp)

#Generate Output Gap
panel_df.y = log.(panel_df.rgdpmad) .* 100
y_hp = HPFilter.HP(panel_df.y, 100)
panel_df.y_gap = panel_df.y .- y_hp 

#Generate Large and Small Size Variables
panel_df.size = allowmissing(panel_df.size)
non_zero_size = ifelse.(panel_df.size .> 0, panel_df.size, missing)
average_size = mean(skipmissing(non_zero_size))
panel_df.size_large = ifelse.(panel_df.size .> average_size, panel_df.size, 0)
panel_df.size_small = ifelse.(panel_df.size .<= average_size, panel_df.size, 0)

###################### Generate States #################

panel_df[!, :exp] = map(x -> ismissing(x) ? missing : (x > 1.5 ? 1 : 0), panel_df.dlrgdpmad) #Expansion
panel_df[!, :rec] = map(x -> ismissing(x) ? missing : (x <= 1.5 ? 1 : 0), panel_df.dlrgdpmad) #Recession
panel_df[!, :boom] = map(x -> ismissing(x) ? missing : (x > 0 ? 1 : 0), panel_df.y_gap) #Boom
panel_df[!, :slump] = map(x -> ismissing(x) ? missing : (x <= 0 ? 1 : 0), panel_df.y_gap) #Slump
# panel_df[!, :large] = map(x -> ismissing(x) ? missing : (x >= 0.75 ? 1 : 0), panel_df.size) #High Public Debt
# panel_df[!, :small] = map(x -> ismissing(x) ? missing : (x < 0.25 ? 1 : 0), panel_df.size) #low Public Debt

####################### Save Dataframe #################

#Write to CSV
CSV.write("./data/panel_df.csv", panel_df)
CSV.write("./output/panel_df.csv", panel_df)

println("Data Preparation Completed")

vars_df = names(panel_df)
println(vars_df) 