# Pkg.add("StatsBase")
# Pkg.add("GLM")
# Pkg.add("StatsModels")
# Pkg.add("Distributions")
# Pkg.add("HypothesisTests")
# Pkg.add("RegressionTables")

using StatsBase, GLM, StatsModels, Distributions, HypothesisTests, RegressionTables

######################## Load Data ######################
panel_df = CSV.read("./output/panel_df.csv", DataFrame)

######################## Balancing Check ########################
# Regressors
# (:drprv, :dCAPB, :dlrgdpmad, :y_gap) 2 lags each

#Generate Lagged Variables
panel_df.dCAPB_lag1 = lag(panel_df.dCAPB, 1)
panel_df.dCAPB_lag2 = lag(panel_df.dCAPB, 2)
panel_df.drprv_lag1 = lag(panel_df.drprv, 1)
panel_df.drprv_lag2 = lag(panel_df.drprv, 2)
panel_df.dlrgdpmad_lag1 = lag(panel_df.dlrgdpmad, 1)
panel_df.dlrgdpmad_lag2 = lag(panel_df.dlrgdpmad, 2)
panel_df.y_gap_lag1 = lag(panel_df.y_gap, 1)
panel_df.y_gap_lag2 = lag(panel_df.y_gap, 2)

############################ Run OLS Regression ############################

using GLM, HypothesisTests, StatsModels

# Full model
fm = @formula(size ~ dCAPB_lag1 + dCAPB_lag2 + dlrgdpmad_lag1 + dlrgdpmad_lag2 +
              y_gap_lag1 + y_gap_lag2 + drprv_lag1 + drprv_lag2 + iso)
full_model = lm(fm, panel_df)

# Restricted model (intercept only)
restricted_model = lm(@formula(size ~ 1), panel_df)

# Residuals
residuals_full = residuals(full_model)
residuals_restricted = residuals(restricted_model)
ftest = VarianceFTest(residuals_restricted, residuals_full)

# Export Regression Table and Results
table_A = regtable(full_model; renderSettings = LatexTable(), 
    file = "./output/table_A.tex")

table_A = regtable(full_model; renderSettings = HtmlTable(), 
    file = "./output/table_A.html")

# The covariates (e.g., dCAPB_lag1, dlrgdpmad_lag1, etc.) display jointly significance for predicting treatment!

# Must do propensity score matching since treatment is predictable!!!