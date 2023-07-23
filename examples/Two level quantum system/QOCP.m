%% Problem formulation
function [problem] = QOCP
% Bryson Denham problem
%
% Syntax:  [problem] = BrysonDenham
%
% Outputs:
%    problem - Structure with information on the optimal control problem

%------------- BEGIN CODE --------------
% Set system dynamics
problem.dynamicsFunc = @dynamics;

% Set Lagrange cost (Stagewise cost) to be minimized
problem.stageCost = @stageCost;

% Set Mayer cost (Terminal cost)
problem.terminalCost = @terminalCost;

% Initial time. t0<tf. NOTE: t_0 has to be zero.
problem.time.t0 = 0; 

% Final time. tf is fixed.
problem.time.tf = 5;

% Number of states.
problem.nx = 4;

% Number of inputs.
problem.nu = 1;

% Initial conditions for system. Bounds if x0 is free s.t. x0l=< x0 <=x0u
% If fixed, x0l == x0u
problem.states.x0l = [1 0 0 0]; 
problem.states.x0u = [1 0 0 0]; 

% State bounds. xl=< x <=xu
problem.states.xl = [-inf -inf -inf -inf];
problem.states.xu = [inf inf inf inf];

% Terminal state bounds. xfl=< xf <=xfu. If fixed: xfl == xfu
problem.states.xfl = [-inf -inf -inf -inf]; 
problem.states.xfu = [inf inf inf inf];

% Input bounds
problem.inputs.ul = -inf;
problem.inputs.uu = inf;

%-------------- END CODE ---------------
end


%% System dynamics
function [dx] = dynamics(x,u,t)
% Problem dynamics
%
% Syntax:  
%          [dx] = Dynamics(x,u,t)	(Dynamics Only)
% 
% Inputs:
%    x  - state vector
%    u  - input vector
%    t  - time
%
% Output:
%    dx - time derivative of x
%
%------------- BEGIN CODE --------------
dx1 =   2*x(2) + (2*x(4)+3*x(3))*u;
dx2 =   -2*x(1) - (2*x(3)-3*x(4))*u;
dx3= -2*x(4) + (2*x(2)-3*x(1))*u;
dx4= 2*x(3) - (2*x(1)+3*x(2))*u;
dx = [dx1; dx2 ; dx3; dx4];

%-------------- END CODE ---------------
end


%% Cost functions

function lag = stageCost(x,u,t)
% Lagrange cost to be minimized
%
% Syntax:  
%          [lag] = stageCost(x,u,t)	(stageCost Only)
% 
% Inputs:
%    x  - state vector
%    u  - input
%    t  - time
%
% Output:
%    lag - stage wise cost (lagrange cost)
%
%------------- BEGIN CODE --------------

u1 = u(1);
lag = (u1 ^ 2);

%-------------- END CODE ---------------
end


function mayer = terminalCost(x,u,t)
% Mayer cost to be minimized
%
% Syntax:  
%          [mayer] = terminalCost(x,u,t)
% 
% Inputs:
%    x  - state vector
%    u  - input
%    t  - time
%
% Output:
%    mayer - terminal cost (mayer cost)
%
%------------- BEGIN CODE --------------

mayer = 0;

%-------------- END CODE ---------------
end
