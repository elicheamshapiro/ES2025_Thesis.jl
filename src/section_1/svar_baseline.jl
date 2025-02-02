Pkg.add("AutoregressiveModels")
Pkg.add("ConfidenceBands")

###################### Load Data ################ 

panel_df = DataFrame(CSV.File("./data/panel_output.csv"))
paneldf!(panel_df,:iso,:year)

################## SVAR Baseline ################
