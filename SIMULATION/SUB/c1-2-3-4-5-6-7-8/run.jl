# cd("where your input files are")
# ] add https://github.com/giadasp/ATA.jl
using ATA
# ] add JuMP@0.21.3
using JuMP
# ] add Cbc
using Cbc

# Each of the following commands returns a string vector, the second element is a message describing the result.
# 1. Add file with custom settings (Needed)
# for resetting the ATA process (Needed)
ATAmodel = start_ATA()

# Each of the following commands returns a string vector, the second element is a message describing the result.
# 1. Add file with custom settings (Needed)
load_settings!(ATAmodel; settings_file="settingsATA.jl", bank_file="../../sim_pool_fixed.csv", bank_delim=",")
print_last_info(ATAmodel)

# 2. Add friend set variables (Optional)
add_friends!(ATAmodel)
print_last_info(ATAmodel)

# 3. Add enemy set variables (Optional)
# add_enemies!(ATAmodel)
# print_last_info(ATAmodel)

# 4. Add categorical constraints (Optional)
add_constraints!(ATAmodel; constraints_file="Constraints.csv", constraints_delim=";")
print_last_info(ATAmodel)


# 5. Add overlap maxima (Optional)
# add_overlap!(ATAmodel; overlap_file="Overlap Matrix.csv", overlap_delim=";")
# ATAmodel.output.infos[end]

# 6. Add expected score constraints (Optional)
# add_exp_score!(ATAmodel)
# print_last_info(ATAmodel)

# 7. Add overlap maxima (Optional, Needed if add_friends!(model) hase been run)
group_by_friends!(ATAmodel)
print_last_info(ATAmodel)

# 8. Add objective function (Optional)
add_obj_fun!(ATAmodel)
print_last_info(ATAmodel)

# Assembly settings

# Set the solver, "siman" for simulated annealing, "jumpATA" for MILP solver.
solver = "jumpATA"

# MILP (Not suggested for large scale ATA)
# Select the solver, Cbc as open-source is a good option.
optimizer_constructor = "Cbc"
# #Optimizer attributes
optimizer_attributes = [("seconds", 500), ("logLevel", 1)]

# 9. assemble
assemble!(ATAmodel;
    solver=solver,
    optimizer_attributes=optimizer_attributes,
    optimizer_constructor=optimizer_constructor
    )
print_last_info(ATAmodel)

# All the settings and outputs from optimization are in ATAmodel object.
# See the struct in ATA.jl to understand how to retrieve all the information.
# If siman is chosen, the optimality and feasibility of the best neighbourhood
# is reported in "RESULTS/ResultsATA.jl"

using ATAPlot
# A summary of the resulting tests is available in RESULTS/Results.txt after running:
print_results(ATAmodel; group_by_fs = true, results_folder = "RESULTS")

plot_results(ATAmodel, group_by_fs=true, results_folder = "PLOTS")