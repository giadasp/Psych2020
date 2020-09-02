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
@info load_settings!(ATAmodel; settings_file="settingsATA.jl", bank_file="item_bank_3PL_SCI.csv", bank_delim=";")[2]

# 2. Add friend set variables (Optional)
@info add_friends!(ATAmodel)[2]

# 3. Add enemy set variables (Optional)
# @info add_enemies!(ATAmodel)[2]

# 4. Add categorical constraints (Optional)
# @info add_constraints!(ATAmodel; constraints_file="Constraints.csv", constraints_delim=";")[2]

# 5. Add overlap maxima (Optional)
# @info add_overlap!(ATAmodel; overlap_file="Overlap Matrix.csv", overlap_delim=";")[2]

# 6. Add expected score constraints (Optional)
# @info add_exp_score!(ATAmodel)[2]

# 7. Add overlap maxima (Optional, Needed if add_friends!(model) hase been run)
@info group_by_friends!(ATAmodel)[2]

# 8. Add objective function (Optional)
@info add_obj_fun!(ATAmodel)[2] 

# Assembly settings

# Set the solver, "siman" for simulated annealing, "jumpATA" for MILP solver.
solver = "jumpATA"

# MILP (Not suggested for large scale ATA)
# Select the solver, Cbc as open-source is a good option.
optimizer_constructor = "Cbc"
# #Optimizer attributes
optimizer_attributes = [("seconds", 1_000), ("logLevel", 1)]

# 9. assemble
assemble!(ATAmodel;
    solver=solver,
    optimizer_attributes=optimizer_attributes,
    optimizer_constructor=optimizer_constructor
    )

# All the settings and outputs from optimization are in ATAmodel object.
# See the struct in ATA.jl to understand how to retrieve all the information.
# A summary of the resulting tests is available in results_folder/Results.txt
# If siman is chosen, the optimality and feasibility of the best neighbourhood
# is reported in "RESULTS/ResultsATA.jl"
print_results!(ATAmodel;
group_by_fs=true,
plots_out=true,
results_folder="RESULTS")


# cd("where your input files are")
# using ATAjl
# If you prefere to use Julia code:

# for resetting the ATA process (Needed)
ATAmodel = StartATA()

# Each of the following commands returns a string vector, the second element is a message describing the result.
# 1. Add file with custom settings (Needed)
println(LoadSettings!(ATAmodel; settings_file="settingsATA.jl", bank_file="item_bank_3PL_SCI.csv", bank_delim=";")[2])

# 2. Add friend set variables (Optional)
println(AddFriendSets!(ATAmodel)[2])

# 3. Add enemy set variables (Optional)
# println(AddEnemySets!(ATAmodel)[2])

# 4. Add categorical constraints (Optional)
# println(AddConstr!(ATAmodel; constraints_file = "Constraints.csv", constraints_delim=";")[2])

# 5. Add overlap maxima (Optional)
# println(AddOverlaps!(ATAmodel; overlap_file = "Overlap Matrix.csv", overlap_delim=";")[2])

# 6. Add expected score constraints (Optional)
# println(AddExpScore!(ATAmodel)[2])

# 7. Add overlap maxima (Optional, Needed if AddFriendSets!(model) hase been run)
println(GroupByFriendSet!(ATAmodel)[2])

# 8. Add objective function (Optional)
println(AddObjFun!(ATAmodel)[2])

# Assembly settings

# Set the solver, "siman" for simulated annealing, "jumpATA" for MILP solver.
solver = "jumpATA"

# MILP (Not suggested for large-scale ATA)
# Select the solver, Cbc as open-source is a good option.
# add Cbc by running import Pkg; Pkg.add("Cbc")
using GLPK
optimizer_constructor = "Cbc"
# Optimizer attributes
# optimizer_attributes = [("tm_lim", 1_000_000), ("msg_lev", 3)]
optimizer_attributes = [("seconds", 1_000), ("logLevel", 1)]
# optimizer_attributes = [("CPX_PARAM_TILIM", 1_000)]

# 9. Assemble
Assemble!(ATAmodel;
    solver=solver,
    optimizer_attributes=optimizer_attributes,
    optimizer_constructor=optimizer_constructor
    )
# All the settings and outputs from optimization are in ATAmodel object.
# See the struct in ATA.jl to understand how to retrieve all the information.
# A summary of the resulting tests is available in results_folder/Results.txt
# If siman is chosen, the optimality and feasibility of the best neighbourhood
# is reported in "RESULTS/ResultsATA.jl"

# To print the plots you need an implementation of TeX/LaTeX (such as MikTex) 
# installed in your pc. Otherwise set plots_out = false
# ] add Plots
using Plots
# ] add PGFPlotsX
using PGFPlotsX

print_results!(ATAmodel;
group_by_fs=true,
plots_out=false,
results_folder="RESULTS")
