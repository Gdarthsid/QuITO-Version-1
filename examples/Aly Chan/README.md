## Formulate the Aly Chanproblem in QuITO 
In problem definition file **AlyChan.m**
First we provide the function handles for system dynamics with,
```matlab
% Set system dynamics
problem.dynamicsFunc = @dynamics;
```
and Cost definitions with, 
'''matlab
% Set Lagrange cost (Stagewise cost) to be minimized
problem.stageCost = @stageCost;

% Set Mayer cost (Terminal cost)
problem.terminalCost = @terminalCost;
'''
Next we define the time variables with,
'''matlab
% Initial time. t0<tf. NOTE: t_0 has to be zero.
problem.time.t0 = 0; 

% Final time. tf is fixed.
problem.time.tf = pi/2;
'''
