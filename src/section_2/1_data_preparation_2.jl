println("Section 2 Data Preparation Beginning")
########################## Load Data ################

#Import data
panel_df = DataFrame(CSV.File("./data/panel_df.csv"))
usa_df = filter(row -> row.iso == "USA", panel_df)
dr_df = DataFrame(CSV.File("./data/delinquency_rates.csv"))
ds_df = DataFrame(CSV.File("./data/debt_service.csv"))
afg_df = DataFrame(XLSX.readtable("./data/afg.xlsx", "Macro"))
ls_df = DataFrame(CSV.File("./data/lending_standards.csv"))
lr_df = DataFrame(CSV.File("./data/lending_rates.csv"))
lrp_df = DataFrame(CSV.File("./data/lending_risk.csv"))
npl_df = DataFrame(CSV.File("./data/non_performing.csv"))

# Reshape the data from wide to long format for World Bank data
# variables = [:lending_rate, :risk_premium, :non_performing]

long_df = stack(lr_df, Not(["Country Name", "Country Code", "Indicator Name", "Indicator Code"]), 
                variable_name = :year, value_name = :lending_rate)
long_df.country = long_df."Country Name"
long_df.iso = long_df."Country Code"
long_df = long_df[:, [:year, :country, :lending_rate]]
years = 1960:2023
long_df.year = repeat(collect(years), inner = 266)
panel_df = innerjoin(panel_df, long_df, on = [:country, :year], makeunique=true)
panel_df = sort(panel_df, [:country, :year])

long_df = stack(lrp_df, Not(["Country Name", "Country Code", "Indicator Name", "Indicator Code"]), 
                variable_name = :year, value_name = :risk_premium)
long_df.country = long_df."Country Name"
long_df.iso = long_df."Country Code"
long_df = long_df[:, [:year, :country, :risk_premium]]
years = 1960:2023
long_df.year = repeat(collect(years), inner = 266)
panel_df = innerjoin(panel_df, long_df, on = [:country, :year], makeunique=true)
panel_df = sort(panel_df, [:country, :year])

long_df = stack(npl_df, Not(["Country Name", "Country Code", "Indicator Name", "Indicator Code"]), 
                variable_name = :year, value_name = :non_performing_loans)
long_df.country = long_df."Country Name"
long_df.iso = long_df."Country Code"
long_df = long_df[:, [:year, :country, :non_performing_loans]]
years = 1960:2023
long_df.year = repeat(collect(years), inner = 266)
panel_df = innerjoin(panel_df, long_df, on = [:country, :year], makeunique=true)
panel_df = sort(panel_df, [:country, :year])

#create USA dataframe
dr_df.year = 1985:2024
ds_df.year = 1980:2023
ls_df.year = 1991:2024
usa_df = innerjoin(usa_df, dr_df, on = [:year], makeunique=true)
usa_df = innerjoin(usa_df, ds_df, on = [:year], makeunique=true)
usa_df = innerjoin(usa_df, ls_df, on = [:year], makeunique=true)
# afg_df = afg_df[:, [:Country, :Year, :esi_con, :esi_ind]]

########################## Data Preparation ################

lagdiff(x) = x - lag(x)

# Generate first differences of delinquency rates
usa_df.ddrcclacbs = lagdiff(usa_df.DRCCLACBS) # Credit Card Delinquency Rate
usa_df.ddrclacbs = lagdiff(usa_df.DRCLACBS) # Consumer Loan Delinquency Rate
usa_df.ddralacbn = lagdiff(usa_df.DRALACBN) # Delinquency Rates on All Loans
usa_df.ddrsfrmacbs = lagdiff(usa_df.DRSFRMACBS) # Delinquency Rate on Single-Family Residential Mortgages
usa_df.ddrblacbs = lagdiff(usa_df.DRBLACBS) # Delinquency Rate on Business Loans

# Generate first differences of debt service payments to disposable income
usa_df.dtdsp = lagdiff(usa_df.TDSP) # household debt service payments / disposable income
usa_df.dmdsp = lagdiff(usa_df.MDSP) # mortgage debt service payments / disposable income
usa_df.dcdsp = lagdiff(usa_df.CDSP) # consumer debt service payments / disposable income
usa_df.dfodsp = lagdiff(usa_df.FODSP) # financial obligations debt service payments / disposable income

# Generate first net percentage of domestic banks tightening standards
usa_df.dls_all_categories = lagdiff(usa_df.SUBLPDMOSXWBNQ)  #Across Loan Categories, Weighted by Banks' Outstanding Loan Balances by Category
usa_df.dls_credit_card = lagdiff(usa_df.DRTSCLCC)  #Credit Card Loans
usa_df.dls_demand = lagdiff(usa_df.SUBLPDMODXWBNQ)  #Demand for loans
usa_df.dls_large_credit_card = lagdiff(usa_df.SUBLPDCLCSLGNQ)  #Large Bank Credit Card Loans
usa_df.dls_large_firm = lagdiff(usa_df.DRTSCILM)  #Bank Commercial and Industrial Loans to Large Firms
usa_df.dls_small_firm = lagdiff(usa_df.DRTSCIS)  #Bank Commercial and Industrial Loans to Small Firms
usa_df.dls_hh = lagdiff(usa_df.SUBLPDMHSXWBNQ)  #Bank Loans to Households

# Generate first difference lending_rates
panel_df.dlr = lagdiff(panel_df.lending_rate) # Bank lending rate
panel_df.dlrp = lagdiff(panel_df.risk_premium) # Bank risk premium
panel_df.dnpl = lagdiff(panel_df.non_performing_loans) # Non-performing loans

#Drop values for 1978 for these first difference variables
variables = [:dlr, :dlrp, :dnpl]
for v in variables
    panel_df[panel_df.year .== 1978, v] .= missing
end

#Write to CSV
CSV.write("./data/panel_df.csv", panel_df)
CSV.write("./output/panel_df.csv", panel_df)

# vars_df = names(panel_df)
# println(vars_df)

println("Section 2 Data Preparation Completed")