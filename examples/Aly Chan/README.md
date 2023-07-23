## Formulate the Aly Chan problem in QuITO 
In problem definition file **AlyChan.m**
First we provide the function handles for system dynamics with,
```matlab
% Set system dynamics
problem.dynamicsFunc = @dynamics;
```
and Cost definitions with, 
```matlab
% Set Lagrange cost (Stagewise cost) to be minimized
problem.stageCost = @stageCost;

% Set Mayer cost (Terminal cost)
problem.terminalCost = @terminalCost;
```
Next we define the time variables with,
```matlab
% Initial time. t0<tf. NOTE: t_0 has to be zero.
problem.time.t0 = 0; 

% Final time. tf is fixed.
problem.time.tf = pi/2;
```
We define state and control dimensions with
```matlab
% Number of states.
problem.nx = 3;

% Number of inputs.
problem.nu = 1;
```
For **state variables**, we specify initial conditions, 
```matlab
% Initial conditions for system. Bounds if x0 is free s.t. x0l=< x0 <=x0u
% If fixed, x0l == x0u
problem.states.x0l = [0 1 0]; 
problem.states.x0u = [0 1 0];
```
state bounds,
```matlab
% State bounds. xl=< x <=xu
problem.states.xl = [-inf -inf -inf];
problem.states.xu = [inf inf inf];
```
and terminal state bounds.
```matlab
% Terminal state bounds. xfl=< xf <=xfu. If fixed: xfl == xfu
problem.states.xfl = [-inf -inf -inf]; 
problem.states.xfu = [inf inf inf];
```
For **control variables**, we specify bounds,
```matlab
% Input bounds
problem.inputs.ul = -1;
problem.inputs.uu = 1;
```
We then define the system dynamics by specifying the respective ODEs in the function **dynamics** with, 
```matlab
dx1 = x(2);
dx2 = u(1);
dx3 = 0.5 * (x(2)^2 - x(1)^2);
```
The lagrange cost is defined in the function **stageCost** with,
```matlab
lag = 0;
```
and Mayer cost (terminal cost) is defined in the function **terminalCost** with,
```matlab
mayer = x(3);
```

After defining the dynamics, and the optimization problem, We now define the optimization and other QuITO parameters in the  **options.m** file.
