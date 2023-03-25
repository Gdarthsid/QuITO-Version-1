function postProcess(solution, problem, options)
% postProcess - Show all the the required plots and process the solution
%
% Syntax:  postProcess(solution, problem, options)
%
% Output:
%    returns none

%------------- BEGIN CODE --------------

opti = solution.output;
num_of_steps = options.nodes;
X = solution.X;
U_app = solution.U_app;

if options.print.time
    disp(newline+"Time taken to solve: "+num2str(solution.time_taken)+" secs")
end

if options.NLPsolver == "ipopt"
    disp("Total iterations performed by NLP solver is "+num2str(solution.output.stats.iter_count))
end

if options.print.cost
    disp(newline+"The objective cost is: "+num2str(solution.cost))
end

% Extract optimal values
X_out = zeros(problem.nx, num_of_steps + 1);
U_out = zeros(problem.nu, num_of_steps); % last value of control not useful
for i = 1 : num_of_steps + 1
    X_out(:, i) = opti.value(X(:, i));
end
for i = 1 : num_of_steps
    U_out(:, i) = opti.value(U_app(:, i));
end

% Figure
time_horizon = linspace(problem.time.t0, problem.time.tf, num_of_steps+1);

if options.plot
    % Plot action trajectories
    for ui = 1 : problem.nu
        figure
        % last value of control is not useful
        plot(time_horizon(1:end-1), U_out(ui,:),'b','LineWidth',0.8);
        ylabel("Action trajectory");
        xlabel('Time [s]');
        xlim([problem.time.t0, problem.time.tf])
        grid on
        legend("u"+num2str(ui));
    end
    
    % Plot state trajectories
    if options.plot == 2
        for xi = 1 : problem.nx
            figure
            plot(time_horizon, X_out(xi,:),'b','LineWidth',0.8);
            ylabel("State trajectory");
            xlabel('Time [s]');
            xlim([problem.time.t0, problem.time.tf])
            grid on
            legend("x"+num2str(xi));
        end
    end
end

%-------------- END CODE ---------------
end