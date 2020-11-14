using Distributions
I = 350
a = rand(LogNormal(0, 0.25), I)
b = rand(Normal(0,1), I)
c = rand(LogitNormal(-2.5,1.0), I)
sim_pool = DataFrame(ID = collect(1:I))
sim_pool=DataFrame(a=a, b=b, c=c)
Domain= sample(["Space and Figures", "Data and Forecasting", "Relations and Functions", "Numbers"], ProbabilityWeights([0.28,0.28,0.28,1.0-(0.28*3)]), I)
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
CSV.write("SIMULATION/sim_pool.csv", sim_pool)