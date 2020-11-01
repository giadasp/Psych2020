using ATA
using DataFrames


ATAmodel=StartATA() #for resetting the ATA process (Needed)
ATAmodel=LoadSettings(ATAmodel;settingsFile="settingsATA.jl",BankFile="estPool.csv", BankDelim=",")  #add file with custom settings (Needed)
ATAmodel=AddCatConstr(ATAmodel;file="Categorical Constraints.csv", delim=";")
ATAmodel=AddOverlaps(ATAmodel; file="OverlapMatrix.csv") #add overlap maxima (Optional)
ATAmodel=AddFriendSets(ATAmodel)
AddObjFun(ATAmodel, folder="BS", AuxInt=500, AuxFloat=0.05) #add objective function (Needed)
ATAmodel=GroupByFriendSet(ATAmodel)
#Assemble!
ATAmodel=Optim(ATAmodel,Float64[],10000.0,0.9;max_evals=1e20,max_time=1000.0,nItemSample=1,nTestSample=1,verbosity=2,GroupByFS=false,OptFeas=0.9,nRand=1,feasNH=0,optNH=100)
ATAmodel.Settings.OptType="CC"

#All the settings and outputs from optimization are in ATAmodel. See the struct in ATA.jl to understand how to retrieve all the information.
PrintResults(ATAmodel; GroupByFS=true, BSfolder="BS") #BSfolder is for CCATA, save all the plots in RESULTS folder
