println("Section 2 Data Preparation Beginning")
########################## Load Data ################

panel_df = DataFrame(CSV.File("./data/panel_df.csv"))
usa_df = filter(row -> row.iso == "USA", panel_df)
dr_df = DataFrame(CSV.File("./data/delinquency_rates.csv"))
ds_df = DataFrame(CSV.File("./data/debt_service.csv"))
afg_df = DataFrame(XLSX.readtable("./data/afg.xlsx", "Macro"))
dr_df.year = 1985:2024
ds_df.year = 1980:2023
usa_df = innerjoin(usa_df, dr_df, on = [:year], makeunique=true)
usa_df = innerjoin(usa_df, ds_df, on = [:year], makeunique=true)
# afg_df = afg_df[:, [:Country, :Year, :esi_con, :esi_ind]]
vars_df = names(afg_df)
println(vars_df) 

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

println("Section 2 Data Preparation Completed")