function options = options(varargin)
% Options - General and solver-specific settings are selected here
%
% Syntax:  options = options(varargin)
%          When giving one input with varargin, e.g. with settings(20),will
%          use D (variance of kernel) = 2 as default
%          When giving two inputs with varargin, e.g. with settings(20, 2),
%          number of steps will be 10 and D (variance of kernel) = 2
%
% Output:
%    options - Structure containing the settings

%------------- BEGIN CODE --------------

%% Transcription Method

% Select a transcription method
%---------------------------------------
% - Quasi-Interpolation based collocation method ('quito_collocation')
options.transcription='quito_collocation';

%% Discretization Method

% Select a discretization method (integration scheme)
%---------------------------------------
% Euler method              ('euler')
% Trapezoidal method        ('trapezoidal') 
% Hermite-Simpson method    ('hermite') 
% Runge-kutta 4 method      ('RK4')
options.discretization='euler';

%% NLP solver

% Select a NLP solver
%---------------------------------------
% IPOPT: recommended                            ('ipopt')
% fmincon                                       ('fmincon')
options.NLPsolver = 'ipopt';

% IPOPT settings (if required)
%---------------------------------------
options.ipopt.tol=1e-9;                        % Desired convergence tolerance (relative). The default value is  1e-8. 
options.ipopt.print_level=5;                   % Print level. The valid range for this integer option is [0,12] and its default value is 5.
options.ipopt.max_iter=5000;                   % Maximum number of iterations. The default value is 3000.
 
options.ipopt.mu_strategy ='adaptive';         % Determines which barrier parameter update strategy is to be used. 
                                               % The default value for this string option is "monotone".
                                               % Possible values:
                                               %   'monotone': use the monotone (Fiacco-McCormick) strategy
                                               %   'adaptive': use the adaptive update strategy

options.ipopt.hessian_approximation='exact';   %  Indicates what information for the Hessian of the Lagrangian function is                                                    
                                               %  used by the algorithm. The default value is 'exact'.
                                               %  Possible values:
                                               %   'exact': Use second derivatives provided by ICLOCS.
                                               %   'limited-memory': Perform a limited-memory quasi-Newton approximation
					                           %		             implemented inside IPOPT

options.ipopt.limited_memory_max_history=6;   % Maximum size of the history for the limited quasi-Newton Hessian approximation. The valid range for this integer option is [0, +inf) 
                                               % and its default value is 6. 
options.ipopt.limited_memory_max_skipping=1;  % Threshold for successive iterations where update is skipped for the quasi-Newton approximation.
                                               % The valid range for this integer option is [1,+inf) and its default value is 2. 

% fmincon settings (NOT RECOMMENDED!)
%---------------------------------------
% See website for detailed info

%% Meshing Strategy

% Type of meshing
% - fixed mesh ('fixed')
options.meshstrategy='fixed';

%% Approximate approximations settings
if nargin == 2
    options.nodes = varargin{1};
    options.variance = varargin{2};   
elseif nargin == 1
    options.nodes = varargin{1};
    options.variance = 2; % D = 2 default
else
    error("Takes in atmost 2 arguments (nodes [, variance])")
end

%% Output settings

% Display computation time
%---------------------------------------
options.print.time = 1;


% Display cost (objective) values
%---------------------------------------
options.print.cost = 1;


% Plot figures
%---------------------------------------
% 0: Do not plot
% 1: Plot only action trajectory
% 2: Plot all figures (state and input trajectory)
options.plot = 2;

%-------------- END CODE ---------------
end
