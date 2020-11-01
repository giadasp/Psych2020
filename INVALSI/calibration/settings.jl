folder="INVALSI"
##pool settings
nItems=39#I conflicts with LinearAlgebra.I
IRTmodel="2PL"
nPar=2
nLatent=1

#for pretest:
parsDist=[Normal(0,1),LogNormal(0,0.25)]
nDifficulty=3 #levels of guessed difficulty (low, medium, high)
alphas=[0.25,0.5,0.75] #difficulty cuts
N=24781 #test takers
n_pt=39 #test length
T_pt=1 #number of tests
# opMatrix=[0 10 0 0 0 0;
# 10 0 10 0 0 0;
# 0 10 0 10 0 0;
# 0 0 10 0 10 0;
# 0 0 0 10 0 10;
# 0 0 0 0 10 0]
opMatrix=ones(1,1).*39
J_t_pt=N/T_pt

#generate responses

latentDist=[Normal(0,1)] #simulated latent variables, must be Vector{Distributions}
latentMetric=[[zero(Float64),one(Float64)]] #ability metric [mean, std], must be Vector{Float64[]}


genRespMethod="classicUniform" # can be: ["classicUniform","cumulatedItems","cumulatedPersons"]


#external opt
method="MMLE"# =optima weighted sum #can be: ["OWS" , "WLE" , "JML" , "MMLE" , "SEM" , "MC"]
K=61 #theta points
denType="EH" #can be a T:Distribution or "EH"=empirical histogram
intW=3 #every intW adapt the prior
minMaxW=[9,12] #minimum and maximum stage in which adapt the prior.
first="theta" #can be: ["theta" , "items"]
maxIter=500 #<==
maxTime=1000
lTolRel=1e-9
bTolRel=1e-4

#internal opt
solver="NLopt"
xTolRel=1e-5
fTolRel=1e-8
timeLimit=10.0

#bounds
minPars=[-5.0,1e-5] #must be Vector{Float64} lenght=nPar-1+nLatent
maxPars=[5.0,5.0] #must be Vector{Float64} lenght=nPar-1+nLatent
minLatent=[-6.0] #must be Vector{Float64}
maxLatent=[6.0] #must be Vector{Float64}
#starters for X and W
X=Matrix{Float64}(undef,K,1)
W=Matrix{Float64}(undef,K,1)

X=[]
W=[]

#mirt
mirtOpt="" # can be:["","L_BFG-S"]
#BOOTSTRAP
BS=true
R=500
boot=1
type="non parametric"
unbalanced=true # if it's unbalanced must be: [true,false], if it's balanced can be only [false]
KBS=21
nRepl=1
