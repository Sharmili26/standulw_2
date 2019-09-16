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
lp.colnames <- c("P1L", "P1M", "P1S", "P2L", "P2M", "P2S")
lp.colnames <- c("P1 Capacity", "P2 Capacity", "P3 Capacity", "P1 Storage","P2 Storage", "P3 Storage")
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
