## Formulation of the Robot Path Planning problem in QuITO 
In the problem definition file [**RobotPathPlanning.m**](https://github.com/Gdarthsid/QuITO-Version-1/blob/main/examples/Robot%20Path%20Planning/RobotPathPlanning.m), we first encode the function handles for system dynamics:
```matlab
% Set system dynamics
problem.dynamicsFunc = @dynamics;
```
Function handles for the cost function:  
```matlab
% Set Lagrange cost (Stagewise cost) to be minimized
problem.stageCost = @stageCost;

% Set Mayer cost (Terminal cost)
problem.terminalCost = @terminalCost;
```
Specify the time variables:
```matlab
% Initial time. t0<tf. NOTE: t_0 has to be zero.
problem.time.t0 = 0; 

% Final time. tf is fixed.
problem.time.tf = 10;
```
Specify the state and control dimension:
```matlab
% Number of states.
problem.nx = 4;

% Number of inputs.
problem.nu = 2;
```
For **state variables** we specify initial conditions: 
```matlab
% Initial conditions for system. Bounds if x0 is free s.t. x0l=< x0 <=x0u
% If fixed, x0l == x0u
problem.states.x0l = [40 5 -inf -inf]; 
problem.states.x0u = [40 5 inf inf]; 
```
State bounds:
```matlab
% State bounds. xl=< x <=xu
problem.states.xl = [0 0 -10 -10];
problem.states.xu = [80 80 10 10];
```
Terminal state bounds:
```matlab
% Terminal state bounds. xfl=< xf <=xfu. If fixed: xfl == xfu
problem.states.xfl = [55 70 -inf -inf]; 
problem.states.xfu = [55 70 inf inf];
```
For **control variables** we specify bounds:
```matlab
% Input bounds
problem.inputs.ul = [-inf -inf];
problem.inputs.uu = [inf inf];
```
Next, we define the system dynamics by specifying the respective ODEs in the function **dynamics**: 
```matlab
dx1 = x(3);
dx2 = x(4);
dx3 = u(1);
dx4 = u(2);
```
The Lagrange cost is defined in the function **stageCost**:
```matlab
lag = (u(1)^2) + (u(2)^2);
```
The Mayer cost (terminal cost) is defined in the function **terminalCost**:
```matlab
mayer = 0;
```
In order to incorporate path constraints as required by problem formulation, a copy of [**src/problemTranscription/solveProblem.m**](https://github.com/Gdarthsid/QuITO-Version-1/blob/main/src/problemTranscription/solveProblem.m) file, named [**solveRobotPathPlanning.m**](https://github.com/Gdarthsid/QuITO-Version-1/blob/main/examples/Robot%20Path%20Planning/solveRobotPathPlanning.m)  is added in this directory, with the following additional lines , 
```matlab
% Nonlinear path constraints
a1 = 40; b1 = 20;
a2 = 55; b2 = 40;
a3 = 45; b3 = 65;
r1 = 10; r2 = 80;
for i = 1 : num_of_steps + 1
  opti.subject_to((X(1,i)-a1)^2 + (X(2,i)-b1)^2 >= r1^2);
  opti.subject_to((X(1,i)-a1)^2 + (X(2,i)-b1)^2 <= r2^2);
  opti.subject_to((X(1,i)-a2)^2 + (X(2,i)-b2)^2 >= r1^2);
  opti.subject_to((X(1,i)-a2)^2 + (X(2,i)-b2)^2 <= r2^2);
  opti.subject_to((X(1,i)-a3)^2 + (X(2,i)-b3)^2 >= r1^2);
  opti.subject_to((X(1,i)-a3)^2 + (X(2,i)-b3)^2 <= r2^2);
end
```

After defining the problem data i.e., the dynamics, the constraints, and the objective we move towards setting up the optimization problem and other parameters in the  [**options.m**](https://github.com/Gdarthsid/QuITO-Version-1/blob/main/examples/Robot%20Path%20Planning/options.m) file. 
We define the default quasi-interpolation parameters (if not passed as input to the **options** function):
```matlab
options.variance = 2; % D = 2 default
generating_function_flag = 1; % default
```
The desired generating function for the approximation is chosen as: 
```matlab
% Select a generating function as per flag
%---------------------------------------
% Gaussian order 2                 (1)
% Laguerre gaussian order 4        (2) 
% Laguerre gaussian order 6        (3) 
% Hermite polynomial order 10      (4)
% Trigonometric guassian order 4   (5)
% Hyperbolic secant order 2        (6) 
options.generating_function=generating_function_flag;
```
The desired discretization scheme is chosen as: 
```matlab
% Euler method              ('euler')
% Trapezoidal method        ('trapezoidal') 
% Hermite-Simpson method    ('hermite') 
% Runge-kutta 4 method      ('RK4')
options.discretization='euler';
```
For solving the optimization problem we choose the interior point solver **IPOPT**:
```matlab
options.NLPsolver = 'ipopt';
```
The associated IPOPT solver settings are:
```matlab
options.ipopt.tol=1e-9;
options.ipopt.print_level=5;
options.ipopt.max_iter=5000;
options.ipopt.mu_strategy ='adaptive';
options.ipopt.hessian_approximation='exact';
options.ipopt.limited_memory_max_history=6;
options.ipopt.limited_memory_max_skipping=1;
```
Meshing option is chosen as:
```matlab
options.meshstrategy='fixed';
```
We specify the following output and exit variables:
```matlab
% Display computation time
options.print.time = 1;

% Display cost (objective) values
options.print.cost = 1;
```
The plotting setting is specified as:
```matlab
% 0: Do not plot
% 1: Plot only action trajectory
% 2: Plot all figures (state and input trajectory)
options.plot = 2;
```
### Results
Finally, in order to solve the optimization problem and observe the results, we run the main file [**main.m**](https://github.com/Gdarthsid/QuITO-Version-1/blob/main/examples/Robot%20Path%20Planning/main.m).
We fetch the problem and options and consequently solve the resultant NLP:
```matlab
%% Set-up and solve problem


problem = RobotPathPlanning;          % Fetch the problem definition
opts = options(100, 2);        % Get options and solver settings (N,D),
                               %where step size h=(tf-t0)/N
% Emply custom solveproblem file to accomodate custom constraints
solution = solveRobotPathPlanning(problem, opts);
```
We plot the results by using the [**postProcess.m**](https://github.com/Gdarthsid/QuITO-Version-1/blob/main/examples/Robot%20Path%20Planning/postProcess.m) file:
```matlab
postProcess(solution, problem, opts)
```



