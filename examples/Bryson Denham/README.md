## Formulation of the Bryson Denham problem in QuITO 
In the problem definition file **BrysonDenham.m**, we first encode the function handles for system dynamics:
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
problem.time.tf = 1;
```
We define state and control dimensions with
```matlab
% Number of states.
problem.nx = 2;

% Number of inputs.
problem.nu = 1;
```
For **state variables**, we specify initial conditions, 
```matlab
% Initial conditions for system. Bounds if x0 is free s.t. x0l=< x0 <=x0u
% If fixed, x0l == x0u
problem.states.x0l = [0 1]; 
problem.states.x0u = [0 1]; 
```
state bounds,
```matlab
% State bounds. xl=< x <=xu
limit = 1/9;
problem.states.xl = [-inf -inf];
problem.states.xu = [limit inf];
```
and terminal state bounds.
```matlab
% Terminal state bounds. xfl=< xf <=xfu. If fixed: xfl == xfu
problem.states.xfl = [0 -1]; 
problem.states.xfu = [0 -1];
```
For **control variables**, we specify bounds,
```matlab
% Input bounds
problem.inputs.ul = -inf;
problem.inputs.uu = inf;
```
We then define the system dynamics by specifying the respective ODEs in the function **dynamics** with, 
```matlab
dx1 = x(2);
dx2 = u(1);
```
The lagrange cost is defined in the function **stageCost** with,
```matlab
u1 = u(1);
lag = 0.5 * (u1 ^ 2);
```
and Mayer cost (terminal cost) is defined in the function **terminalCost** with,
```matlab
mayer = 0;
```
After defining the dynamics, and the optimization problem, We now define the optimization and other QuITO parameters in the  **options.m** file.
We define the default approximate approximation parameters (if not passed as input to the **options** function), with
```matlab
options.variance = 2; % D = 2 default
generating_function_flag = 1; % default
```
The desired generating function for the approximation is chosen as, 
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
The desired discretization scheme is chosen as, 
```matlab
% Euler method              ('euler')
% Trapezoidal method        ('trapezoidal') 
% Hermite-Simpson method    ('hermite') 
% Runge-kutta 4 method      ('RK4')
options.discretization='euler';
```
For solving the NLP, the **IPOPT** solver is chosen with,
```matlab
options.NLPsolver = 'ipopt';
```
and the associated IPOPT solver settings are chosen with, 
```matlab
options.ipopt.tol=1e-9;
options.ipopt.print_level=5;
options.ipopt.max_iter=5000;
options.ipopt.mu_strategy ='adaptive';
options.ipopt.hessian_approximation='exact';
options.ipopt.limited_memory_max_history=6;
options.ipopt.limited_memory_max_skipping=1;
```
Meshing options are chosen with,
```matlab
options.meshstrategy='fixed';
```
Output setting are chosen with,
```matlab
% Display computation time
options.print.time = 1;

% Display cost (objective) values
options.print.cost = 1;
```
and the plotting settings are chosen with,
```matlab
% 0: Do not plot
% 1: Plot only action trajectory
% 2: Plot all figures (state and input trajectory)
options.plot = 2;
```
### Results
Now in order to solve the optimization problem and observe the results, we run the main file **main.m**.
First, we fetch the problem and options, solve the resultant NLP with,
```matlab
%% Set-up and solve problem

problem = BrysonDenham;          % Fetch the problem definition
options = options(100, 2);        % Get options and solver settings (N,D),
                               %where step size h=(tf-t0)/N
solution = solveProblem(problem, options);
```
and plot the results by using the **postprocess.m** file with,
```matlab
postProcess(solution, problem, opts)
```


