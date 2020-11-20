using Distributions
using StatsBase
using DataFrames
using CSV
I = 300
sim_pool = DataFrame(ID = collect(1:I))
a = rand(TruncatedNormal(1.10, 0.2, 0, Inf),I)
sim_pool.a = a

b = rand(Normal(-0.60,1), I)
sim_pool.b = b

Domain= sample(["Space and Figures", "Data and Forecasting", "Numbers", "Relations and Functions"], ProbabilityWeights([0.28, 0.28, 0.26, 0.18]), I)
Dimension = sample(["Arguing", "Problem Solving", "Knowing"], ProbabilityWeights([0.10,0.31,1.0-sum([0.10,0.31])]), I)
Unit = fill("", I)
Unit[sample(1:I, 3)] .= "U1"
Unit[sample(1:I, 3)] .= "U2"
Unit[sample(1:I, 3)] .= "U3"
Unit[sample(1:I, 3)] .= "U4"
Unit[sample(1:I, 3)] .= "U5"
Unit[sample(1:I, 3)] .= "U6"
Unit[sample(1:I, 3)] .= "U7"
Unit[sample(1:I, 3)] .= "U8"
Unit[sample(1:I, 3)] .= "U9"
Unit[sample(1:I, 3)] .= "U10"
Unit[sample(1:I, 3)] .= "U11"
Unit[sample(1:I, 3)] .= "U12"
Answer_type = sample(["Multiple-Choice", "Open-Ended", "Matching"], ProbabilityWeights([0.70,0.15,0.15]), I)
sim_pool.Domain = Domain
sim_pool.Dimension = Dimension
sim_pool.Unit = Unit
sim_pool.Answer_type = Answer_type
CSV.write("sim_pool.csv", sim_pool)