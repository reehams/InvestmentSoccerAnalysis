
# Header ------------------------------------------------------------------
#install.packages("ggplot2")
#install.packages("lpSolveAPI")
#install.packages("ggplot2")
#install.packages("stargazer")
rm(list = ls())
library (ggplot2)
library(lpSolveAPI)
library(stargazer)


# Final Data Cleaning  ----------------------------------------------------

df<-read.csv("df9.csv")
df[,11]<-as.numeric(df[,11])
df[,12]<-as.numeric(df[,12])
write.csv(df,"dfx.csv")
df[,49]

#create categorial column for Position prefernce
df[,49]<-0

for (i in 1:8){
  n=i+49
  df[,49]<-df[,49]+(i*df[,n])
}

#create variable difference Potenial-Overall
df[,6]<-df[,8]-df[,7]


#from factor to numeric
df[,49]<-as.character(df[,49])
df[,11]<-as.character(df[,11])
df[,11]<-as.numeric(gsub(",", "", df[,11]))

df[,12]<-as.character(df[,12])
df[,12]<-as.numeric(gsub(",", "", df[,12]))
df[,6]<-as.numeric(df[,6])


#delete some rows that are obvious mistakes in the dataset
df<- df[df[,11]>0, ]






#Plotting 
ggplot(data = df, mapping = aes(x = Overall, y = Value)) + 
  geom_point(mapping = aes(color = Preference))+
  geom_smooth(mapping = aes(x = Overall, y = Value, linetype = Preference))

ggplot(data = df, mapping = aes(x = Age, y = Value)) + 
  geom_point(mapping = aes(color = Preference))

df[,3]<-(40-df[,3])

df[,5]<-(df[,7])^2
colnames(df)[5] <- "Overall2"

#nomral
summary<-lm(Value~ Potential+ Age+ Overall+ST_Preference+GK_Preference+CB_Preference+CM_Preference+LM_Preference+RM_Preference+LB_Preference+RB_Preference, data=df )
summary(summary)


#qudratic 
summary<-lm(Value~ Flag*Overall+Age +GK_Preference*Overall+CB_Preference*Overall+CM_Preference*Overall+ST_Preference*Overall+LM_Preference*Overall+RM_Preference*Overall+LB_Preference*Overall+RB_Preference*Overall+GK_Preference*Overall2+CB_Preference*Overall2+CM_Preference*Overall2+ST_Preference*Overall2+LM_Preference*Overall2+RM_Preference*Overall2+LB_Preference*Overall2+RB_Preference*Overall2, data=df )
summary(summary)
coef<-coef(summary)
stargazer(summary)

df<-df[,-c(4,10)]
write.csv(df,"df.csv")
write.csv(coef,"coef.csv")



# Solver----------------------------------------------------------------------




# Just how the solver works in R ------------------------------------------




f.Bin<-as.vector(seq(1,1981 , 1))



lprec <- make.lp(0,1981)

set.objfn(lprec, as.vector(df[,6]))
lp.control(lprec,sense='max')
add.constraint(lprec, as.vector(df[,48]), "=",1 )   
add.constraint(lprec, as.vector(df[,49]), "=",2 )  
add.constraint(lprec, as.vector(df[,50]), "=",3 ) 
add.constraint(lprec, as.vector(df[,51]), "=",1 ) 
add.constraint(lprec, as.vector(df[,52]), "=",1 ) 
add.constraint(lprec, as.vector(df[,53]), "=",1 ) 
add.constraint(lprec, as.vector(df[,54]), "=",1 ) 
add.constraint(lprec, as.vector(df[,55]), "=",1) 
set.type(lprec, f.Bin,"binary")
solve(lprec)

get.objective(lprec)
get.variables(lprec)



# Getting feasiable solutions ---------------------------------------------



# Overall -----------------------------------------------------------------



new_constrain<-1100
solution_1<- as.data.frame(matrix(0, ncol = 111, nrow = 1981))
x <- 0

repeat {
  lprec <- make.lp(0,1981)
  
  set.objfn(lprec, as.vector(df[,6]))
  lp.control(lprec,sense='max')
  add.constraint(lprec, as.vector(df[,6]), ">=",880 )  
  add.constraint(lprec, as.vector(df[,48]), "=",1 )   
  add.constraint(lprec, as.vector(df[,49]), "=",2 )  
  add.constraint(lprec, as.vector(df[,50]), "=",3 ) 
  add.constraint(lprec, as.vector(df[,51]), "=",1 ) 
  add.constraint(lprec, as.vector(df[,52]), "=",1 ) 
  add.constraint(lprec, as.vector(df[,53]), "=",1 ) 
  add.constraint(lprec, as.vector(df[,54]), "=",1 ) 
  add.constraint(lprec, as.vector(df[,55]), "=",1) 
  add.constraint(lprec, as.vector(df[,6]), "<=",new_constrain) 
  set.type(lprec, f.Bin,"binary")
  x = x+1
  print(x)
  if (solve(lprec)==2) {
    break
    }
  
  new_constrain<-as.numeric(get.objective(lprec))-1
  solution_1[,x]<-get.variables(lprec)

}

write.csv(solution_1, "S_Overall.csv")



# max (flag) No constrain ----------------------------------------------------------------------

df[,1]<-as.numeric(df[,1])




new_constrain<-(100)
solution_2<- as.data.frame(matrix(0, ncol = 100, nrow = 1981))
x <- 0

repeat {
  lprec <- make.lp(0,1981)
  
  set.objfn(lprec, as.vector(df[,5]))
  lp.control(lprec,sense='max')
  add.constraint(lprec, as.vector(df[,6]), ">=",0 )  
  add.constraint(lprec, as.vector(df[,48]), "=",1 )   
  add.constraint(lprec, as.vector(df[,49]), "=",2 )  
  add.constraint(lprec, as.vector(df[,50]), "=",3 ) 
  add.constraint(lprec, as.vector(df[,51]), "=",1 ) 
  add.constraint(lprec, as.vector(df[,52]), "=",1 ) 
  add.constraint(lprec, as.vector(df[,53]), "=",1 ) 
  add.constraint(lprec, as.vector(df[,54]), "=",1 ) 
  add.constraint(lprec, as.vector(df[,55]), "=",1) 
  add.constraint(lprec, as.vector(df[,1]), "<=",new_constrain) 
  set.type(lprec, f.Bin,"binary")
  x = x+1
  print(x)
  if (solve(lprec)==2) {
    break
  }
  
  new_constrain<-as.numeric(get.objective(lprec))-1
  solution_2[,x]<-get.variables(lprec)
  
}

write.csv(solution_2,"S_NO.csv")


