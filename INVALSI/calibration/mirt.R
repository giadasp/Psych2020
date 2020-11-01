library(mirt)
responses<-read.csv("responses2PL.csv",sep="\t",na.strings = "missing",header = FALSE)
m <- matrix(0, ncol = nrow(responses), nrow = ncol(responses))
for(item in 1:ncol(responses)){m[item,]<-responses[,item]}
m<-data.frame(m)
s<-'F = 1-250
      UBOUND = (1-250, a1, 5), (1-250,d,6)
      LBOUND = (1-250, a1, 0), (1-250,d,-6)'
model<-mirt.model(s)
mirtmod<-mirt(m,model=model,itemtype = "2PL", TOL=1e-4, optimizer="nlminb")
Pars<-coef(mirtmod, simplify=TRUE, IRTPars=F)
Theta <- fscores(mirtmod, full.scores = TRUE, scores.only = TRUE)
write.csv(Pars,"R_mirt_pars.csv")
write.csv(Theta,"R_mirt_theta.csv")
write.csv(mirtmod@OptimInfo$iter,"iter_mirt.csv")
write.csv(mirtmod@time[1],"time_mirt.csv")
