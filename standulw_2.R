install.packages("lpsolveAPI")
library(lpSolveAPI)

### Weight Production Problem
shlp <- make.lp(6,6)

# set obj function
set.objfn(shlp, c(420, 360, 300, 420, 360, 300))

#set values for the rows
set.row(shlp, 1, c(1, 1, 1), indices = c(1, 2, 3))
set.row(shlp, 2, c(1, 1, 1), indices = c(4, 5, 6))
set.row(shlp, 3, c(1, 1, 1), indices = c(0, 0, 0))
set.row(shlp, 4, c(20, 15, 12), indices = c(1, 2, 3))
set.row(shlp, 5, c(20, 15, 12), indices = c(4, 5, 6))
set.row(shlp, 6, c(20, 15, 12), indices = c(0, 0, 0))

#set right hand side
rhs <- c(750, 900, 450, 13000, 12000, 5000)
set.rhs(shlp, rhs)

#set constraint type
set.constr.type(shlp, rep("<=", 6))

#finally name the decision variables (column) and constaints (rows)
lp.colnames <- c("X1a", "X1b", "X1c", "X2a", "X2b", "X2c")
lp.colnames <- c("a1 Capacity", "a2 Capacity", "a3 Capacity", "a1 Storage","a2 Storage", "a3 Storage")
dimnames(shlp) <- list(lp.rownames, lp.colnames)

#view the linear program object to make sure it's correct
shlp

#now solve the model 
solve(shlp)

#lool at the objective function value
get.objective(shlp)

#optimal decision variable values 
get.variables(shlp)

#constraints
get.constraints(shlp)

#surplus at each constraint
get.constraints(shlp) - rhs
